Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4041595-1521503579-2-5881128798729275945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521503578; b=jJlVF5p/PY2kpjiU63lgZ35/67PTPTkiG+eXqKJBfZPT8j8
    emX8usrKf1ulKg/mkPzRe6SV263JhxX2pnRSv2iuAIIc6s2mmvKyOW4y6XiKkaCh
    3V/5e6JaETeSrhNIOJ5sgGPAeKfDhk1CzkgmwSMC5drSki7/XyvH9c2qaxZsH5ZM
    tUT9wWEsnItGwn7RjmdfYbw+QJTxoPGYBVlUkjIF9AKSQviKTaw3C9qFNFKFtz8+
    08CC26rwa7rMTxe8dtElDNmkt8Xxg+leNhag46DtifM3UEhF2drG7enSd9Tm5Bi+
    NlAfugn/AaNEl4Egm4U79bZzaWCZoXOGJi8uq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521503578; bh=iER4cX5ttbEI+rJ6fQKb7lrkCv
    Oep2VuZbHOh51x0uc=; b=bWnasROjZOHk2O97CiqSRZVjiTRCRnVgwXoLk4r3Rq
    gKcLKjn+3N2yaN+IJT5APCnwaHpjkkiLxvhtOCMwYJghMa+X4pVqA/g8LyDfv37Q
    FbtFq86mkHPfczjN5h1tvpS/D5GQ+zI51SSOh4TzWy+I6rgxfYhER2/3jBy1SbmV
    D4VFHvmV6d6wTxV1wm094rPgLuBQtR+eOjXcusc/E84X0a2p4IEB2ooL4S7605dl
    ty5BmYoYjCvx0go2uL/EucAK3f8WLt1E/+745vGiqbCMhcfFDce9tDY6Bqd3vnrK
    kLrcdqMvHRV8/7hdtkfUwrd5x9riuBM4y//18A125ElQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LZ6nvWxy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdduheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeffrghnucftuhgvuceouggrnhdrrhhuvgeslhhinhgrrhhordhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdduieehrdekgedrudektddrvdefheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiheejieenucevlhhushhtvghrufhiiigvpeek;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K3Y5eGC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LZ6nvWxy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdduheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeffrghnucftuhgvuceouggrnhdrrhhuvgeslhhinhgrrhhordhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdduieehrdekgedrudektddrvdefheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiheejieenucevlhhushhtvghrufhiiigvpeek;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K3Y5eGC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755944AbeCSXwz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 19:52:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33529 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755426AbeCSXwy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 19:52:54 -0400
X-Google-Smtp-Source: AG47ELu1ugfYzkHtDCN63bkWCNy97h8SZlVrz2MGoQxVXg7aPBiKMxGbzDq/yYBIXtJvjNrxqF+iTw==
Date: Tue, 20 Mar 2018 07:52:51 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Message-ID: <20180319235251.ui2gf3nlg2icbbdx@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171854.858515505@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171854.858515505@linuxfoundation.org>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:05:21PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Roger Quadros <rogerq@ti.com>
> 
> 
> [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
> 
> It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
> is in use then there are random chances that the usb_otg_ss module
> will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
> 
> Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
> fixes this issue.
> 
> We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
> issue or not so don't add this flag for those instances.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This fails to build for me on arm32 with default config.

#
# make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
#
#
# make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
#
../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
  .flags  = HWMOD_CLKDM_NOAUTO,
            ^
../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
make[2]: Target '__build' not remade because of errors.
/home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
make[1]: *** [arch/arm/mach-omap2] Error 2
make[1]: Target '_all' not remade because of errors.
Makefile:152: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2
make: Target '_all' not remade because of errors.

Dan

> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2240,6 +2240,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>  	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>  	.clkdm_name	= "l3init_clkdm",
>  	.main_clk	= "dpll_core_h13x2_ck",
> +	.flags		= HWMOD_CLKDM_NOAUTO,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
> @@ -2261,6 +2262,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>  	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>  	.clkdm_name	= "l3init_clkdm",
>  	.main_clk	= "dpll_core_h13x2_ck",
> +	.flags		= HWMOD_CLKDM_NOAUTO,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
> 
> 
