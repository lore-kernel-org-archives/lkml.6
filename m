Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A348C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C0020841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvYjrnGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C0020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeICG3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:29:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeICG3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HHnRFUC0L8abTrCUjkGatbVXUgZ4Kz6CFvTAToAkmWc=; b=PvYjrnGQoUg6pTDEHowuBayMI6
        yUNXGPHcFEH7CJmTA1BWgW5L11fTh4A1L6itMjE3VKAIMXOozQVR+S5mJaJD1mGERNjifHVbQZvTF
        uy1+24OyI/opvfZySkUUfu0wh6spiuP0ELct3yBeqKioQL9hiOOf3QQ0gFEZU7xr5hL4quyAALuBD
        67N9VqmC/gpYfPZjjPXjzO1raekj/dksrUzV6dllCYKrV3r9ziQYnu6j+SZnbUzQjdzQ/SNWG+d85
        4t7ITcFiQdZ89JcezBqO3AI9QefyHNUtN1q0dspDYVYKW9MqYRcTZOHeOv2ZEY1toRztSAXGENWzI
        gnSS1WqQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fweKk-0005Pv-KH; Mon, 03 Sep 2018 02:11:19 +0000
Subject: Re: [PATCH 3/7] vfio: add sdmdev support
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-4-nek.in.cn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0574e7dc-bed2-d2d0-3aa6-93590d54ce81@infradead.org>
Date:   Sun, 2 Sep 2018 19:11:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-4-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> diff --git a/drivers/vfio/sdmdev/Kconfig b/drivers/vfio/sdmdev/Kconfig
> new file mode 100644
> index 000000000000..51474272870d
> --- /dev/null
> +++ b/drivers/vfio/sdmdev/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config VFIO_SDMDEV
> +	tristate "Support for Share Domain MDEV"
> +	depends on VFIO_MDEV_DEVICE
> +	help
> +	  Support for VFIO Share Domain MDEV, which enables the kernel to
> +	  support light weight hardware accelerator framework, WarpDrive.

	          lightweight

> +
> +	  To compile this as a module, choose M here: the module will be called
> +	  sdmdev.


thanks,
-- 
~Randy
