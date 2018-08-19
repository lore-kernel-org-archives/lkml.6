Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B17C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5BF20C51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0pWmfzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5BF20C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHSUrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:47:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F4120C10;
        Sun, 19 Aug 2018 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534700105;
        bh=DAKc09A1GNFeKuHV4B0W3Ch47L86AwXyJtu2+ixliRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N0pWmfzjYHUbgCnoudYluLN/LaX6c3wvSVBuotSkbq50QWBi06UiVVsc/8f2LUvqA
         sniBqxN8xNIBOmwNBPp2t4aChs4AjCWrYqMgwCZttMOKBtbshC3z0pRe3RmY2qnGRT
         TEiOA2CZ1T+licm4BkRFsIWuwsk15uN0Cb3CD6M0=
Date:   Sun, 19 Aug 2018 18:35:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Parthiban Nallathambi <pn@denx.de>, kbuild-all@01.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v6 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180819183500.116733f8@archlinux>
In-Reply-To: <201808112324.Z16wUjWW%fengguang.wu@intel.com>
References: <20180807102704.1652656-1-pn@denx.de>
        <201808112324.Z16wUjWW%fengguang.wu@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 23:25:41 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Parthiban,
> 
> Thank you for the patch! Yet something to improve:

The issue here is I think that you should be simply calling hweight8 rather
than directly calling the fallback software version.

I 'might' fix that up if it is the only issue known to remain.

Thanks,

Jonathan

> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.18-rc8 next-20180810]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Parthiban-Nallathambi/iio-light-Add-support-for-vishay-vcnl4035/20180810-012903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>    ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
>    ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
> >> ERROR: "__sw_hweight8" [drivers/iio/light/vcnl4035.ko] undefined!  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

