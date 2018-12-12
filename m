Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD34C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3912084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="nrSs59j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3912084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbeLLQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:29:55 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:49685 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:29:52 -0500
Date:   Wed, 12 Dec 2018 16:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1544632189;
        bh=awWrFloh4DrDSwCiHywdoy1L7wdWXOkQqJ6DbzyafBM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=nrSs59j4PnnEBNJWqyWArJvndNsbxWss4IV77OeveMSbKkodJylHD9PtT5RiwtdHj
         pqUZ8i2GdI9/mreEYfuRab9/Ayf3R2rhvFaIX0cUiaJdhfSEckpejCZBZZRK8b0gDj
         KQm7yVVJ4+fpfYVCYgRLa85e0/vKirkgxHbbLZ0M=
To:     =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
Message-ID: <ML-sxPRwNNExkZHkXghYN7e3VrhuZXYLjFv-aniX8qbjcde2GfHMBaI4B3A7IoUEfycQcWCPuxATkYHOz--FqMjH1KRwxMxBCb6Q-1IsKTM=@protonmail.ch>
In-Reply-To: <20181212081712.32347-1-mic@digikod.net>
References: <20181212081712.32347-1-mic@digikod.net>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 12, 2018 9:17 AM, Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:

> Hi,
>
> The goal of this patch series is to control script interpretation. A
> new O_MAYEXEC flag used by sys_open() is added to enable userland script
> interpreter to delegate to the kernel (and thus the system security
> policy) the permission to interpret scripts or other files containing
> what can be seen as commands.
>
> The security policy is the responsibility of an LSM. A basic
> system-wide policy is implemented with Yama and configurable through a
> sysctl.
>
> The initial idea come from CLIP OS and the original implementation has
> been used for more than 10 years:
> https://github.com/clipos-archive/clipos4_doc
>
> An introduction to O_MAYEXEC was given at the Linux Security Summit
> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> https://www.youtube.com/watch?v=3DchNjCRtPKQY&t=3D17m15s
> The "write xor execute" principle was explained at Kernel Recipes 2018 -
> CLIP OS: a defense-in-depth OS:
> https://www.youtube.com/watch?v=3DPjRE0uBtkHU&t=3D11m14s
>
> This patch series can be applied on top of v4.20-rc6. This can be
> tested with CONFIG_SECURITY_YAMA. I would really appreciate
> constructive comments on this RFC.
>
> Regards,
>

Are various interpreters upstreams interested in adding support
for O_MAYEXEC if it land in kernel? Did you contacted them about this?

Jordan

