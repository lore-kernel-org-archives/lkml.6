Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32316C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEC420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="C4qhWCP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEC420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIMOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:33:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46897 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:33:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so4029144edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RFUipwiXQw9qlvlbS69iA6hbuQu0afZHQbYx5ZKEqbc=;
        b=C4qhWCP4jLmceTlck0z9dUM5/i3rJInHRY+kcz11xq3py9eNO1kRhYtMd92wZQKlOl
         r/wHCUKzAlQiaj57UDTPORtao638PaOXXqJ7SFO7XBQAiAtuFQWpLc1OZPxe5nthoSTf
         VCJlLzArYhmMzpe0SEOgs8V3P4NCNWf+HjmNJN2VEmVct4JjUUPeVNB+5+3Wxl7sAp0D
         JjSZNgvhvVHz/6dzIRKY7kEEKEB9FUbtuLa/aPZ3nGizxydeZaHFIdFwvTEMIMvkGjLP
         G4+Al3druKy5UlqfqUN0HKJXn2SyKoOo8BPYgEVQO1H7Q3PBJQ5Pl0cSaTw22VSqnEpo
         dM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RFUipwiXQw9qlvlbS69iA6hbuQu0afZHQbYx5ZKEqbc=;
        b=QXXdrojLk6lgf5ie8I64gQq0QYhuGXupr0oJEWl2HEJLm1dzST/XHA78rhQZSpsJyE
         EQPbVmyUmE2twh5BhGMMjhoRzHaGRwbHlrfG7W4517rlQpGa94Dl0IMhWS6S/wcy01wG
         gMdQ9BfpzarqA+eW3F1V9IRRjqEIxF53OuIqfhkAUzChHDVD2zMSe0YKldK0eHnj17wQ
         QOZy+QdrsjrbsR4BaNCT4jeaLwAtm870kAaEtRwXlyTNOpDNXAB+jDdi+/hHUEJ3W2iv
         q6MIdFvGCQunPaVKa6x683ND72tYBuBx7L1nUebw3pb/oyincg6PYRZILiRL+VJeIuwm
         H+Nw==
X-Gm-Message-State: APzg51AU5OnepjG6zCBYIAn/rKc7s466fkat1iKGjKp0mTMaprbIqzo7
        Ezm4kQrsTLuxkYfvxzzVotHzKw==
X-Google-Smtp-Source: ANB0Vda908V3H6fx9yh5bynAzL/S3qMouFXz+oBmlKFLF6f9qX9JPgJvY+noNrtb51NJw7tYvh7+SQ==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr9075267edb.237.1536830673548;
        Thu, 13 Sep 2018 02:24:33 -0700 (PDT)
Received: from cisco (85-220-54-220.dsl.dynamic.simnet.is. [85.220.54.220])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2529839edo.39.2018.09.13.02.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 02:24:32 -0700 (PDT)
Date:   Thu, 13 Sep 2018 03:24:30 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@amacapital.net>
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
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180913092430.GB4672@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:00:54PM -0700, Andy Lutomirski wrote:
> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> 
> Hmm.  I contemplated this a bit and looked at your example a bit, and
> I have a few thoughts:
> 
>  - What happens if you nest code like your sample?  That is, if you
> are already in some container that is seccomped and there's a
> listener, can you even run your sample?

You can attach a filter with SECCOMP_RET_USER_NOTIF, but you can't
attach a listener to any such filter as long as there is another
listener somewhere in the chain (I disallowed this based on some
feedback you sent earlier, it's an artificial restriction).

>  - Is there any association between the filter layer that uses the
> USER_NOTIF return and the listener?  How would this API express such a
> relationship?

Not sure exactly what you're asking here. There is the struct file*,
but there could be many threads listening to it.

> I realize that my dream of how this should all work requires eBPF and
> BPF_CALL, so it may not be viable right now, but I'd like a better
> understanding of how this all fits together.
> 
> Also, I think that it's not strictly true that a filter that blocks
> sendmsg() is problematic.  You could clone a thread, call seccomp() in
> that thread, then get a listener, then execve().  Or we could have a
> seccomp() mode that adds a filter but only kicks in after execve().
> The latter could be generally useful.

Yes, in fact some of the test code works this way. However, the case I
was thinking of is the way a typical container manager works: it does
some initial setup, clone()s the init task, does some final setup,
load the seccomp profile, and exec() the container's init binary.
There's no way for this container to get its seccomp fd back out of
the container to the host if sendmsg() is blocked.

Tycho
