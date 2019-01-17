Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB5AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n9kUkzEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfAQQhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:37:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbfAQQha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:37:30 -0500
Received: from zn.tnic (p200300EC2BCAA900D1C41FD2C17621F7.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:d1c4:1fd2:c176:21f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 870F41EC014B;
        Thu, 17 Jan 2019 17:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547743048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JhsFqAmcfSl4XxISmW2aE/lNgBtmGfNdWg3Bhoa0n+o=;
        b=n9kUkzEXjh1+oTb+rwf42Jl3Zo2Eatm1gzX2LiHGR1/jB8DbOW3jOCAQKa9M6tMa3z5G5T
        GvyvlmXIcNVc5MqnHDtbqdprxW9+WSgheNBIpHbK4JZXKFLMuUf7naIQxUdXfcWXkTHK7x
        Iw/wiu8OOJWzzEnQugjn20UPYoyJb98=
Date:   Thu, 17 Jan 2019 17:37:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Message-ID: <20190117163722.GE5023@zn.tnic>
References: <20190117161722.3945-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117161722.3945-1-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:17:22PM +0000, Sinan Kaya wrote:
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.
> 
> PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
> mentioned in the Kconfig.
> 
> Add an explicit dependency here.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 568f339595ed..0519da6f8ee4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -199,7 +199,7 @@ config X86
>  	select IRQ_FORCED_THREADING
>  	select NEED_SG_DMA_LENGTH
>  	select PCI_DOMAINS			if PCI
> -	select PCI_LOCKLESS_CONFIG
> +	select PCI_LOCKLESS_CONFIG		if PCI
>  	select PERF_EVENTS
>  	select RTC_LIB
>  	select RTC_MC146818_LIB
> -- 

Are there any more arch/x86/ fixes for the 5d32a66541c4 fallout floating
around?

If so, pls merge them all together into a single patch so that we're
done with this once and for all.

Also, I see a lot of build failures when doing randconfig builds for the
stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?

If not, I'd take 'em too in a single patch, if Darren and Andy are fine
with it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
