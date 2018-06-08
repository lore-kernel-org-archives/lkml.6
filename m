Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uzxtGeWuGltzdQAAmS7hNA
	; Fri, 08 Jun 2018 16:29:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FCD06089E; Fri,  8 Jun 2018 16:29:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gaE6zQRE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLd54+0Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 50154602FC;
	Fri,  8 Jun 2018 16:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50154602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHQ3p (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:29:45 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39195 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeFHQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:29:43 -0400
Received: by mail-ua0-f196.google.com with SMTP id n4-v6so9279801uad.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dBPvpm4p9HX5uNhZdZUFQHtFRZG1/nRFT96EthPgtbM=;
        b=gaE6zQREY+XyJQvL9QUoevvyt5eCmY6UDHy+KHj5S8z4DdtvFPudGyq8po+3/1jOwz
         D9MnM+BnpKvAEfvcs2/vjc4APlyLKvo+J3fG0tnfD3KYwCoAIFvbtPaoXhKyJupEfIyR
         sCwHyqJEEA1hsyPr0vcQonflIkhTxKLcSB6+ntKynYU7+w2bdGZRkYL/m3X9/f4cAz5N
         VzTgHIRRBQ5GMSWaifHMTsi/tUu7rkWXZZwl2NBbvYHvBawsnHbzP+BuENgPBvEHpUYZ
         GQoi9J3EfX1MjurZtH6p2Dz9uiRQu7449fWl+tcBCihQeodl2QYVU74zJi2YO9lzuNHc
         3b2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dBPvpm4p9HX5uNhZdZUFQHtFRZG1/nRFT96EthPgtbM=;
        b=nLd54+0QUqzRmCx7hUgA/342cldn7P7lkyRmtf2bPtQer5ELhqq4hd1d3ZChozYYZB
         IaPLUE3RQw5uUQhL/Dh6lCEqW0EZgyYkB8BKwLfZlYUZe6TodX2n7P8o329rtA4CwwEo
         qujKDBVo5Jpw2lXKsIq4n7r7fE1HpSpLLDOEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dBPvpm4p9HX5uNhZdZUFQHtFRZG1/nRFT96EthPgtbM=;
        b=uUbkQCdhTMs0ZlCCN82C0EV4HWa4ZaXBHGEZaycolrqhYgrdgtGcj7bwzYzxDzKe1p
         alt4Pauu2d9Sr6q1e68/Q76qdC2dAhMkVyzgwhklGOm75yxI2jJB8uq9v3r1oLDjRzEW
         fLGPsLzWdWVW06/2Fga76bDZ3XbKcdVMEbyTTDnbeAFQx08rjGCCFLA97kYU6Hh2muxx
         WvhxZML30Sg6ry/NWSx43+PLGliwX1vXveNv1mXDg4VGXHkyg1U5Kb2KpBjbwNa0T8pT
         rK7i8j3VLIMYFRSZtqu3QswfCvUkr4bhAeXm/FhFJyV2Zoaj8S3cBv/wfQCmBcP4qwzZ
         3DPw==
X-Gm-Message-State: APt69E1fDiEpgNvivu5GpZbh6dJaSu114YFSqClYsUWE5ZfJZ3W6e/k7
        skLnXxUzxk3oAAaNnVl4H/7aulD+z0/5g3ujfO1heg==
X-Google-Smtp-Source: ADUXVKIJYvFK9s8ZPnY7JA3gqSuyq7ePt24ahy4t8GPeK1Fb8bsbgAMzaa7NljEfVwllI370a9jnaLDb6hT5xtRaD9M=
X-Received: by 2002:a9f:3751:: with SMTP id a17-v6mr4608541uae.83.1528475382781;
 Fri, 08 Jun 2018 09:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 09:29:42 -0700 (PDT)
In-Reply-To: <20180531144949.24995-1-tycho@tycho.ws>
References: <20180531144949.24995-1-tycho@tycho.ws>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 8 Jun 2018 09:29:42 -0700
X-Google-Sender-Auth: 2TtLY4BR1wzDdb8_vxKf_8paZpw
Message-ID: <CAGXu5jKsLDSBjB74SrvCvmGy_RTEjBsMtR5dk1CcRFrHEQfM_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] seccomp trap to userspace
To: Tycho Andersen <tycho@tycho.ws>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 7:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> Hi all,
>
> Here's a v3 of the seccomp trap to userspace, with all the nits from v2
> fixed. Open questions from v2 are still:
>
> 1. is it ok not to use netlink?

Yeah, I think there isn't a sensible way to reuse that API, which is
too bad. Let's just try to keep this interface future-proofed. :)

> 2. what should the fd passing API look like? (see patch notes on this
>    one for details of why the current one might (?) be a problem)

The only thing in my mind is avoiding the problems with other fd
passing API (e.g. when do rlimits get checked, etc).

> As an added bonus, I've also written some stress testing, with lots of
> tasks and listeners (1000 of each) sharing the same notification thread,
> and not found any issues so far. Code is here:
> https://github.com/tych0/kernel-utils/blob/master/seccomp/notify_stress.c
> although I haven't included it in the patchset.

That's excellent, thanks!

> v2: https://lkml.org/lkml/2018/5/17/627
>
> Tycho Andersen (4):
>   seccomp: add a return code to trap to userspace
>   seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
>   seccomp: add a way to get a listener fd from ptrace
>   seccomp: add support for passing fds via USER_NOTIF

I'm under a time crunch with the merge window, but after -rc2 I should
have time to give this some close review. FWIW, I expect this to enter
-next this cycle and get it into the 4.19 merge window: we need the
feature and the alternatives have been well explored and don't look
workable.

Thanks for the series!

-Kees

-- 
Kees Cook
Pixel Security
