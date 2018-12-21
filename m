Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28285C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA262192D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jIj0oBqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbeLURf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:35:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbeLURf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MLNzFTcdIsNjM87lJArb4VwDvGqReOQihLjXMCe0teI=; b=jIj0oBqqrGx5s0bsp+L+90emH
        W5JXN9bgYM58yQbGN25h3YuSeCoH9K+SeoR7m+wstCUnAfgXAVgVkmlmOBbGFnBjqAUVpCDLwAWlq
        EIN3WKxSPVC0IsdhT0W4bprfk1oVCMCD92YCNM8B0ybHNuw5odmOZkEBJBAgE1s/yzC+aEdY9pnGI
        p+rQfQ+yCkEy+AkOnyXtK8eoepXbJz8E91+aE1/8jAaPjQVAIGPHwkLGKId5htubBsI8r8/jr/lL5
        td8itksCbZth7/g2K0sMpPb61AfvAGCvVgo/9GwZcYsOyBPjpo9SfQAixEgbTVCkomIVxGaytXoGt
        i69ex2RaA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaOiL-0001hk-8L; Fri, 21 Dec 2018 17:35:57 +0000
Subject: Re: linux-next: Tree for Dec 21 (mmc/host/sdhci-omap.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
References: <20181221193244.3a6ed685@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16ca363b-92a7-d1cd-8460-21514e0e964b@infradead.org>
Date:   Fri, 21 Dec 2018 09:35:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181221193244.3a6ed685@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 12:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release until Jan 2.  Have a good break.
> 
> Changes since 20181220:
> 

on x86_64:

This change to drivers/mmc/host/Kconfig:

 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
+	select THERMAL
+	select TI_SOC_THERMAL

causes a Kconfig warning:

WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
  Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
  Selected by [m]:
  - MMC_SDHCI_OMAP [=m] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]


because ARCH_HAS_BANDGAP is not set (nor is COMPILE_TEST).


-- 
~Randy
