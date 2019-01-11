Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B920874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFlA+VWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfAKRor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:44:47 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45911 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733206AbfAKRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:44:45 -0500
Received: by mail-vk1-f195.google.com with SMTP id n126so3448935vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhPHEUfPUCrDKGrPGgzuqWfsLsIum47WxAHy3+MQ7SE=;
        b=eFlA+VWtVnh4Gsj4mq3qWk9KAzrQyRv23sng5IOUtcdsD8Ef1pv+Rojx3b3dUO5IXn
         kkFg7OV5dEVQHiFObAxG3+kS/5C61xM68bH6z2A3kQtf1dDgEDnLxaBrZuesrkaxaY4Y
         NhpmNc97CuWwJPdE02KXcNFj3h/61wxYHXGE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhPHEUfPUCrDKGrPGgzuqWfsLsIum47WxAHy3+MQ7SE=;
        b=b6+bveNQXGgSIRYnl99modPD7H+bJ6mJZycmrdjTzmEELPw6LUnqg4crbUdSsln2f8
         z5V/4jgbdaheW4U+dKzV4neG68dnmKLO8miFy/VSvavRyAgUDPthUZwTjMwR0z+D4r8E
         MOZN67/65EuebmYwdv4lQvJ+HYzEgFIRLeQ82sZzIXGT6QYuENYOaWfuU+ZG0yyNoCDj
         iopWqxhje0ZnOnYefjYasCdImLB+aEx/jP+oKpskEQihAtwcYNnFLcqU+9nfyO48AkRN
         jY1pnCMOuYZtw8T1YIJCATnwrmcc5R3Zz4nWk+n1s9e3ZxLF4E+YRKrnBPE0WQjIeEC/
         ZnrQ==
X-Gm-Message-State: AJcUukf7CjIFASaKDjYqA1bgx7dvg9TH/Ej/WkLHCltrUZU0KBhc3qH5
        y1jETOlXn4RmYrijA7/s9lL6tTBzl3I=
X-Google-Smtp-Source: ALg8bN7UXhACSDc6zsif/rm5wwL0BUZ+8kBNNWO1FizO2p73d6gDxE/HaTph9/mr5zU1/hXzSfIsmg==
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr6059453vkf.70.1547228683079;
        Fri, 11 Jan 2019 09:44:43 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id x20sm29809915uan.12.2019.01.11.09.44.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:44:42 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id x64so9701000vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:44:41 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr6372762vss.172.1547228681471;
 Fri, 11 Jan 2019 09:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20190108213504.GA32901@beast> <ce79cdd5-3020-8901-a5a4-ec42005734fd@I-love.SAKURA.ne.jp>
In-Reply-To: <ce79cdd5-3020-8901-a5a4-ec42005734fd@I-love.SAKURA.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Jan 2019 09:44:29 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLrdMVGKaR_mm+DCeTakypK2W9c2oeGqE8ch6CgK9i9bA@mail.gmail.com>
Message-ID: <CAGXu5jLrdMVGKaR_mm+DCeTakypK2W9c2oeGqE8ch6CgK9i9bA@mail.gmail.com>
Subject: Re: [GIT PULL] blob-stacking updates for security-next
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 2:38 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/09 6:35, Kees Cook wrote:
> > Hi James,
> >
> > Please pull these blob-stacking changes for security-next.
> >
> > Thanks!
> >
> > -Kees
> >
> > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> >
> >   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/blob-stacking-security-next
> >
> > for you to fetch changes up to a5e2fe7ede1268d2f80fe49ca1f717d0e3750995:
> >
> >   TOMOYO: Update LSM flags to no longer be exclusive (2019-01-08 13:18:45 -0800)
> >
>
> And syzbot already found a bug.
> This is occurring immediately after memory allocation failure for cred object.
> We need to be prepared for free() function being called when alloc() function failed.
>
> [   59.992498][ T8010] FAULT_INJECTION: forcing a failure.
> [   59.992498][ T8010] name failslab, interval 1, probability 0, space 0, times 1
> [   60.005214][ T8010] CPU: 0 PID: 8010 Comm: syz-executor178 Not tainted 5.0.0-rc1-next-20190111 #10
> [   60.014337][ T8010] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [   60.024383][ T8010] Call Trace:
> [   60.027657][ T8010]  dump_stack+0x1db/0x2d0
> [   60.063731][ T8010]  should_fail.cold+0xa/0x14
> [   60.089894][ T8010]  __should_failslab+0x121/0x190
> [   60.094810][ T8010]  should_failslab+0x9/0x14
> [   60.099411][ T8010]  __kmalloc+0x2dc/0x740
> [   60.124293][ T8010]  security_prepare_creds+0x123/0x190
> [   60.129644][ T8010]  prepare_creds+0x3c4/0x510
> [   60.149852][ T8010]  __x64_sys_capset+0x58c/0x9b0
> [   60.185347][ T8010]  do_syscall_64+0x1a3/0x800
> [   60.206747][ T8010]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Are there more details on this crash report?

-- 
Kees Cook
