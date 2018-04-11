Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2734638-1523461096-2-13537457188383933992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523461091; b=aXPyljT0qLyRMbEPytGQBZz40N2VI9AMyC1KoX9SCDpr7+wFt1
    gHqqpvhrwLC0xSSx75yTOXqKVSocPUEac9qL6GFIKE1eN9SeltoBRQAflbo6174N
    0y1Re8OUaWWES9HzHOtReJmZ0zHNsmpwxLr7B25icvj+W26M7UE7Mk0SZEhWLnnE
    THjrPWAPb8F2+XQIDa5oznVi6ZYnNXMKrmkv6RY3Nbxz2LuCbZp28NmM/gZVxSYm
    ZaeNOHu3qGEBQMf8GCdMdOi2h9X4gAev9dlY0I+HuR4GZG3gxfBmFeYZdo9978qf
    Z9BH3RbD633NgWU4FMp4XTJ5s0U667aJVZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523461091; bh=J0WyEm/YqT5jKEP8xlmNaR2VvX0Z41OMN2eG+/H8fm
    0=; b=mEfyLAWCO1uSme0AybotTUOvpQywAWboV3Ubii3PZEv77uINXN/DnjVmc9
    PWANHN2nliReekt0ieF2qSkDVT0WkP7Y0KljRG/1zoqbB9Mrpzu9ddm44mMcljzJ
    zOvSL2L/UmauleNt+O0nvoFVmm4Latu8K/3oIeTUf1hJ0rpOunTqlM/L+9oXGfyc
    OO5SmO+PlssJM1uFGwRrPmMPttDAfE7V0HamPlbb/nYwstk6jY/XFZg0SXDpLWx8
    9uYy8OQGMat49Z2SjWFmKg4b4RWOWX7koxl5G0pOdMdGTAv9bpHUSJTMcsHWj8PI
    CjmjZkyDfDwy3Ga5n/xaMMY1oYXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ES5vWODf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hh39cLxK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ES5vWODf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hh39cLxK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDQ9kPqlwqI+KhF5yWtLTdcePt+SZygMlJF+wcty798AtvY5AtClTiUTpfGDEgXPBHrQ9rdER0+noXSLvkz7uAegoaMJM3tYKGJbh1+ltEyM+sAL/Zwl
    uqO/AVj4tTBcFAG2BAeryjibgJPUo4tEMYjPX3ByMY/LXOSjAn+wBDVmcKJtoOVHMaPpYN7A7VhwPpmSQsr0jb5gzPa0wBpdXKGGsZa306RPOJHw7jjcBcNh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8
    a=C2WAnJVigUwZBbY4CHoA:9 a=1KRFtBuVJzmwWWIy:21 a=2Fm9Ge7KU_mdgQJQ:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDKPiJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 11:38:09 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42400 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeDKPiH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 11:38:07 -0400
X-Google-Smtp-Source: AIpwx4/9c7L104ayP99Fu2eJWVVL0wDMic+YtpPS6jEPyNce0MPkr8qs6X4A7zEdDOJ5sT1wyEl8Q6RB00TyilpS18U=
MIME-Version: 1.0
In-Reply-To: <20180411120452.1736-1-mhocko@kernel.org>
References: <20180411120452.1736-1-mhocko@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Apr 2018 17:37:46 +0200
Message-ID: <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 2:04 PM,  <mhocko@kernel.org> wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
> atomicaly probe for a given address range.
>
> [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> Hi,
> Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
> window. So here we go with the man page update.
>
>  man2/mmap.2 | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index ea64eb8f0dcc..f702f3e4eba2 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -261,6 +261,27 @@ Examples include
>  and the PAM libraries
>  .UR http://www.linux-pam.org
>  .UE .
> +Newer kernels
> +(Linux 4.17 and later) have a
> +.B MAP_FIXED_NOREPLACE
> +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
> +should be preferred over MAP_FIXED.

This still looks wrong to me. There are legitimate uses for MAP_FIXED,
and for most users of MAP_FIXED that I'm aware of, MAP_FIXED_NOREPLACE
wouldn't work while MAP_FIXED works perfectly well.

MAP_FIXED is for when you have already reserved the targeted memory
area using another VMA; MAP_FIXED_NOREPLACE is for when you haven't.
Please don't make it sound as if MAP_FIXED is always wrong.

> +.TP
> +.BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
> +Similar to MAP_FIXED with respect to the
> +.I
> +addr
> +enforcement, but different in that MAP_FIXED_NOREPLACE never clobbers a pre-existing
> +mapped range. If the requested range would collide with an existing
> +mapping, then this call fails with
> +.B EEXIST.
> +This flag can therefore be used as a way to atomically (with respect to other
> +threads) attempt to map an address range: one thread will succeed; all others
> +will report failure. Please note that older kernels which do not recognize this
> +flag will typically (upon detecting a collision with a pre-existing mapping)
> +fall back to a "non-MAP_FIXED" type of behavior: they will return an address that
> +is different than the requested one. Therefore, backward-compatible software
> +should check the returned address against the requested address.
>  .TP
>  .B MAP_GROWSDOWN
>  This flag is used for stacks.
> @@ -487,6 +508,12 @@ is not a valid file descriptor (and
>  .B MAP_ANONYMOUS
>  was not set).
>  .TP
> +.B EEXIST
> +range covered by
> +.IR addr ,
> +.IR length
> +is clashing with an existing mapping.

Maybe add something like ", and MAP_FIXED_NOREPLACE was specified"? I
think most manpages explicitly document which error conditions can be
triggered by which flags.
