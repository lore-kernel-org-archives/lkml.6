Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322ED2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+Lol2Ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322ED2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKOGnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:43:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VOWb00+zF3xadupdfV67M1xiYJ5OGMHPAL6EczbDwmM=; b=q+Lol2LnJHkxyJnDgNZxAeYnI
        3qAmXBWSLgXEwuOtHQ9/3fbo51M3SU6NjhZMpCZehSN+gQm2oFD0YGBFD8Jo/5VM8vBtNBq7IoKc7
        ByKi/ChC8GTpaOoQUThG4NWZ1HfJd/876Y+KeMTuew8II38yBaV9TWbmR1Hm962LBZHxG93JCBi/m
        JGIGS4Sk/uhLcTvzy+RlQ5gdIGHV6x+a0lzcOtxg0LiCOmFOhPjNl+hFnb49h6U2sRn+M+Rr2zu8h
        RhxcSjXhavemQfzkqfYJnTm4Iq0hfp/wfXWrkus2xkr9JUDtnTDmm0Wa+qWh6bQj2du34b4+jGGbF
        3rLjuaJWw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gN1vc-0000BL-38; Wed, 14 Nov 2018 20:38:24 +0000
Subject: Re: linux-next: Tree for Nov 14 (sound/soc/amd/raven/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maruthi.Bayyavarapu@amd.com,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20181114162632.615933dd@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <746f93fc-84ec-88db-4a77-b2493d36b377@infradead.org>
Date:   Wed, 14 Nov 2018 12:38:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114162632.615933dd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 9:26 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181113:
> 

on i386 or x86_64:
when CONFIG_PCI is not enabled.


../sound/soc/amd/raven/pci-acp3x.c: In function 'snd_acp3x_probe':
../sound/soc/amd/raven/pci-acp3x.c:59:2: error: implicit declaration of function 'pci_enable_msi' [-Werror=implicit-function-declaration]
  ret = pci_enable_msi(pci);
  ^
../sound/soc/amd/raven/pci-acp3x.c:124:2: error: implicit declaration of function 'pci_disable_msi' [-Werror=implicit-function-declaration]
  pci_disable_msi(pci);
  ^
../sound/soc/amd/raven/pci-acp3x.c: At top level:
../sound/soc/amd/raven/pci-acp3x.c:161:1: warning: data definition has no type or storage class [enabled by default]
 module_pci_driver(acp3x_driver);
 ^
../sound/soc/amd/raven/pci-acp3x.c:161:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
../sound/soc/amd/raven/pci-acp3x.c:161:1: warning: parameter names (without types) in function declaration [enabled by default]
../sound/soc/amd/raven/pci-acp3x.c:154:26: warning: 'acp3x_driver' defined but not used [-Wunused-variable]
 static struct pci_driver acp3x_driver  = {
                          ^

config SND_SOC_AMD_ACP3x
	tristate "AMD Audio Coprocessor-v3.x support"
	help
	 This option enables ACP v3.x I2S support on AMD platform

Needs "depends on PCI"??


-- 
~Randy
