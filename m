Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65843C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0332147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ra0d1m4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfBTIxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:53:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfBTIxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:53:49 -0500
Received: from zn.tnic (p200300EC2BCB850030ABB3F32F386BA9.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:8500:30ab:b3f3:2f38:6ba9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD1FE1EC0245;
        Wed, 20 Feb 2019 09:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550652826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xy6BHbxNVmztT1aRgQqfil8A4rf58ApfmKTElBuTA6o=;
        b=ra0d1m4XxyiqeOF8gLuE70+IYD7A7vnRtGxHWGYJGah1bm0ZjN8pI05QV0dVWvxBZ6yDfo
        WU1xOyjNgNZ0yhCjTMmis+DkBBHI1Esu5YgLfJW1TVPu+XoFe/aPtYVS/tUL7hBSddAA80
        OQdayAZmqO0uNTm5XaM6UWmlIeOegLM=
Date:   Wed, 20 Feb 2019 09:53:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     stable <stable@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, suravee.suthikulpanit@amd.com,
        jiaxun.yang@flygoat.com, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, sherry.hurwitz@amd.com,
        mingo@redhat.com, mingo@kernel.org, thomas.lendacky@amd.com,
        hpa@zytor.com, Erwan Velu <e.velu@criteo.com>
Subject: Re: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Message-ID: <20190220085334.GA5177@zn.tnic>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
 <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 07:48:59AM -0800, tip-bot for Jiaxun Yang wrote:
> Commit-ID:  0237199186e7a4aa5310741f0a6498a20c820fd7
> Gitweb:     https://git.kernel.org/tip/0237199186e7a4aa5310741f0a6498a20c820fd7
> Author:     Jiaxun Yang <jiaxun.yang@flygoat.com>
> AuthorDate: Tue, 20 Nov 2018 11:00:18 +0800
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Fri, 18 Jan 2019 16:44:03 +0100
> 
> x86/CPU/AMD: Set the CPB bit unconditionally on F17h
> 
> Some F17h models do not have CPB set in CPUID even though the CPU
> supports it. Set the feature bit unconditionally on all F17h.
> 
>  [ bp: Rewrite commit message and patch. ]
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20181120030018.5185-1-jiaxun.yang@flygoat.com
> ---
>  arch/x86/kernel/cpu/amd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 69f6bbb41be0..01004bfb1a1b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -819,11 +819,9 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
>  static void init_amd_zn(struct cpuinfo_x86 *c)
>  {
>  	set_cpu_cap(c, X86_FEATURE_ZEN);
> -	/*
> -	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
> -	 * all up to and including B1.
> -	 */
> -	if (c->x86_model <= 1 && c->x86_stepping <= 1)
> +
> +	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
> +	if (!cpu_has(c, X86_FEATURE_CPB))
>  		set_cpu_cap(c, X86_FEATURE_CPB);

Stable folks, please take this one above into those stable trees which
have backported

f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)")

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
