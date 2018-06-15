Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C598C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1DC20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN6t3Vbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1DC20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965644AbeFOKk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965577AbeFOKk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:40:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BD320896;
        Fri, 15 Jun 2018 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529059227;
        bh=qOz0CApSOq69Tw93DGRvx4GXB7Sk+1cOA2noBSl6U4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sN6t3Vbn8eePUkHjNDkR7Kxqqzp0TurUqLy0iuxngyzv6T4eRotWL8gz+5gKXJGgg
         nu8pHQ0EAooDvEBH85V0Ritsxno/VS945NPtsXcN1Y6aIzNAFxTJ8rz6Tscp6XeRuU
         RCuEgiK/Iqtq4YivDooUmp1AZY56zRCBrQomgKKw=
Date:   Fri, 15 Jun 2018 12:40:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mathias.nyman@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: remove the code build warning
Message-ID: <20180615104004.GA2993@kroah.com>
References: <20180606143659.1476-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606143659.1476-1-gengdongjiu@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:36:59PM +0800, Dongjiu Geng wrote:
> Initialize the 'err' variate to remove the build warning,
> the warning is shown as below:
> 
> drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
> drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
> drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> How to reproduce:
> 1. make defconfig ARCH=arm
> 2. make -j100 CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm
> 
> Then you can see below warnings:
> drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
> drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
> drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here

What changed from v1?  Always put that below the --- line.

Please fix up and resend a v3.

thanks,

greg k-h
