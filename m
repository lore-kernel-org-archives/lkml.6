Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E3BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A920880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="FM3/PVnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6A920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeIYTA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:00:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45073 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbeIYTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:00:56 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so20301940iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gYLdhBhAaJlXCBbg11jVjqkjwe7x4jjbTOSMIPBI2GQ=;
        b=FM3/PVnPBu7/CErvQo0cznkqqqoOb502zjc+NzD4UhNF969wB4jIAVxiYHml69CQqC
         e+cfqXPuOAmDJV/SmFW5aMz92zm2Y/3KU3RL+D5ltw+sAnFN7jS/ZjwfAUrJRPlY0t8N
         /gixP3BTnygzPZ5Io77HVdUnb5/zBqVtbZLNl0p2aZzjC1gXWPdbziQ24ihyKThx7Q2h
         bf86lAW1caxVR3wR7MJBSqZsol5zOgI0jaU8YNUcMZGOFqW7yHCzQDxV9G4HoVYLpljp
         G2gSGtPTtt47S82ivnfPQk4kg3Zt0gFj0WUT6Zmb/AFJLBSKNDAH03IYKcU8nDcdg+LB
         Zvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gYLdhBhAaJlXCBbg11jVjqkjwe7x4jjbTOSMIPBI2GQ=;
        b=syX9dzcsL+Aamo4qMSw+yLbLjdzF9k+MC+NQtcxnAv14J+Psqrj0Gkw22efFKO4uBA
         FozmVs2QqDcoB9/nzT7+jxkTnQcmGeGLEjyQhn58ZDlMDEGfgq2tQoGSWu9kbI0e1J79
         vDhwAcntS/FD1PwRbV/gqpZvEdQSbVZglq9gSyHq/h/ck/xQTWTNoWp7KnzEE+Lkr2cv
         5DiVjbkafIPGwTogDxzpbLYuKrexknW4++7uk/RBKbKmpNfwWHtZzOZg2+Kpp9ZFPFv5
         +tFUial7jdaedkeImDeIVdtsTn5+TXqykF01aPDJfdAnZCGwlcO1FB5o5TtNI+yoIjK7
         kI6w==
X-Gm-Message-State: ABuFfojksJgFRSE0cAbe72mAKFNLHULmCo+AHAOkQN/ZYXJ6QXq+gvFW
        oT7NbZAt9uelgZQDn9kTMnQGodVd8M+YwSxA
X-Google-Smtp-Source: ACcGV63+Yhnq0NYsQw+Eqs1d/lMliAlmy62Z92s4BOjFauBzD2X6D1/6OxBvSx183Si4mrkny6eMMg==
X-Received: by 2002:a6b:c586:: with SMTP id v128-v6mr710554iof.7.1537880009490;
        Tue, 25 Sep 2018 05:53:29 -0700 (PDT)
Received: from cisco (71-218-141-49.hlrn.qwest.net. [71.218.141.49])
        by smtp.gmail.com with ESMTPSA id b195-v6sm930110itc.42.2018.09.25.05.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 05:53:28 -0700 (PDT)
Date:   Tue, 25 Sep 2018 06:53:27 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180925125327.GB9537@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco>
 <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
 <20180919143842.GN4672@cisco>
 <CALCETrVuP0nQ5B01-iWrcQ87hisz7=jA08-Uisqud_r+zc74NQ@mail.gmail.com>
 <20180920234240.GR4672@cisco>
 <CALCETrWEr_VAtJu1mm1akTigsRUXAA7_7RHb-WGHqnyNy=j17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWEr_VAtJu1mm1akTigsRUXAA7_7RHb-WGHqnyNy=j17Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 07:18:45PM -0700, Andy Lutomirski wrote:
> Hmm.  This does mean that we need a test case for a user notifier
> returning -ERESTARTSYS.  It should Just Work (tm), but those are
> famous last words.

Just to confirm, I've got a test case that works like this:

1. fork and install a SIGUSR1 handler
2. tracee does a syscall that gets trapped
3. send SIGUSR1
4. respond from the listener with -ERESTARTSYS
5. see another of the same syscall, even though the tracee still thinks
   its in the first one
6. respond with something reasonable, the tracee sees this response

I think that's the intended behavior. Note that when the listener
responds with -ERESTARTSYS and there is no signal pending, the task
just dies. That might be reasonable, I'm not sure.

Tycho
