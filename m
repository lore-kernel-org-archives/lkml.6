Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513CC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E020882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="deY5RNY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728E020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIMFIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:08:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIMFIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:08:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so4219636wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NlHj7Vhh6eLuGkKS2Pxv9SAvayJlb7tdXTe2j2eEj1g=;
        b=deY5RNY7smrUkqQpRrVSmwY/jUDdGWb3BoWV6wnTurEXyeXbbxhg/l4qq5YMIqsC54
         EF7z7veA/ifornwFwrQaPrCGP3qcHua0PBMsh7T45xMIxCnTx7TbB7Rs29/JYw552Qg5
         9x9L1so5oWp84SHHsFppzjOtgrbdcj/BhNYxtMyA0xwaWuRwB0naJdEQSmPMf2xw/Irm
         te3clGfoG+b8qPlvz2K2AM1/PPO56Eif4pK1d1kc7GQ9uc/KriRIzMg4glwgst0FcdSg
         lYw4VkerMR3Kg8zFM0rU90JP0lYk7L6jKAgDWDd/nlH68wVeGH5NxotSEaD24h2gYBU1
         Jrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NlHj7Vhh6eLuGkKS2Pxv9SAvayJlb7tdXTe2j2eEj1g=;
        b=J8ACYJ85Od5IeAeL9bPWOjAv1tnami9lbP297+JZ6li2v5w7u8D7tocLe5g2IVEenW
         SBumkWDWTC1bqwHhhUDh3nvz6l+Z9MoJI8ZWBphoyLt43TIF2UCak7K9vFLtyAmZGjVX
         exho239EXqR/hdWEsgstERFpMnUu6Vy3J5FTJYo49bM4IzzBQCnYWi8fQKLHsAcYddZk
         gB8gQA1sz/l3CgS+G43zZSCa+oa1ihqaSc7uMVXw0GpNA/bI9BBXDoRSPHZ1pVkYTSkq
         Oppt0Pp3iOs7cz0AlKHnnIXOh/HJknfXo1/Bp+UYJLDCzUCU5xCqRo6rpfnPcIBW58C6
         GeZQ==
X-Gm-Message-State: APzg51AaXwVF6fHL1G357P451KT0+VFZvHS0+oKRQMRUro37JzD4FE17
        nVG2032dmmPrTfzAXvbPK12TarEfGo+wcpBm15j5Ww==
X-Google-Smtp-Source: ANB0VdYc77upy1//ts3hG5HNBL8eyS0p3V1RMMVx1GRI4xOLHfROxTXmZywOkTCtr92iCyyf/1vVhqppsvLrWp8sIZc=
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr3218255wmc.48.1536796875010;
 Wed, 12 Sep 2018 17:01:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 17:00:54
 -0700 (PDT)
In-Reply-To: <20180906152859.7810-4-tycho@tycho.ws>
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-4-tycho@tycho.ws>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 12 Sep 2018 17:00:54 -0700
Message-ID: <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.

Hmm.  I contemplated this a bit and looked at your example a bit, and
I have a few thoughts:

 - What happens if you nest code like your sample?  That is, if you
are already in some container that is seccomped and there's a
listener, can you even run your sample?

 - Is there any association between the filter layer that uses the
USER_NOTIF return and the listener?  How would this API express such a
relationship?

I realize that my dream of how this should all work requires eBPF and
BPF_CALL, so it may not be viable right now, but I'd like a better
understanding of how this all fits together.

Also, I think that it's not strictly true that a filter that blocks
sendmsg() is problematic.  You could clone a thread, call seccomp() in
that thread, then get a listener, then execve().  Or we could have a
seccomp() mode that adds a filter but only kicks in after execve().
The latter could be generally useful.

--Andy
