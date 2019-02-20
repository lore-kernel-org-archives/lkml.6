Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfBTIUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:20:25 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60954 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:20:24 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 03:20:23 EST
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 865722009A7;
        Wed, 20 Feb 2019 08:15:12 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 705CA20FBA; Wed, 20 Feb 2019 09:14:51 +0100 (CET)
Date:   Wed, 20 Feb 2019 09:14:51 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Pin sensitive CR4 bits
Message-ID: <20190220081451.GA2254@light.dominikbrodowski.net>
References: <20190220005449.GA25243@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220005449.GA25243@beast>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 04:54:49PM -0800, Kees Cook wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index cb28e98a0659..7e0ea4470f8e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -312,10 +312,16 @@ static __init int setup_disable_smep(char *arg)
>  }
>  __setup("nosmep", setup_disable_smep);
>  
> +volatile unsigned long cr4_pin __ro_after_init;
> +EXPORT_SYMBOL_GPL(cr4_pin);

Where is this export needed?

Thanks,
	Dominik
