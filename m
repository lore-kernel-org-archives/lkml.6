Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EF320652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aV4ViLZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EF320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeICGhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:37:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fWyWepqHQBvMnBljLMyt03pm2wSivxNxBmNAWmNz42E=; b=aV4ViLZu/PjIyJzP8EkEQE8YAo
        f88H5LdTJ93ZTuP0HZ0kGumyF68+hO5+XjvtvADz+Lx4eGF9PbpmVnq4XawPMO2ZHqXdzaVz/i6U4
        YqFjXluq3IUEfI1UqHMHlXiGCxpUJRIKpkTb+uWviKj1unQFD2HajjFUzkz06y8gFcmpalQiE7wfq
        eJ/YxVfVH7s3wTq26kdwYuOwU1QLwMBI1W0hHMnieHCoRem538zyoUWdNGiPfZ7Ou3YKebw905LmW
        UA/4MxBPAp16dvJkvh84YyNxUtzd1Gv6rBPUuAVG0Ux8cbWRTNwCXFgO/hPbYz5/kaNMk1EmcaAQG
        V8438kbw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fweSJ-0005Rl-0N; Mon, 03 Sep 2018 02:19:07 +0000
Subject: Re: [PATCH 6/7] crypto: add sdmdev support to Hisilicon QM
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
 <20180903005204.26041-7-nek.in.cn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46e57b2b-756e-e256-5b3c-30749d865512@infradead.org>
Date:   Sun, 2 Sep 2018 19:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-7-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 1d155708cd69..b85fab48fdab 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -17,6 +17,16 @@ config CRYPTO_DEV_HISI_SEC
>  	  To compile this as a module, choose M here: the module
>  	  will be called hisi_sec.
>  
> +config CRYPTO_DEV_HISI_SDMDEV
> +	bool "Enable SDMDEV interface"
> +	depends on CRYPTO_DEV_HISILICON
> +	select VFIO_SDMDEV
> +	help
> +	  Enable this enable the SDMDEV, "shared IOMMU Domain Mediated Device"

At a minimum:
	  Enable this to enable the SDMDEV,

although that could be done better.  Maybe just:
	  Enable the SDMDEV "shared IOMMU Domain Mediated Device"

	  
> +	  interface for all Hisilicon accelerators if they can. The SDMDEV

probably drop "if they can":          accelerators.  The SDMDEV interface

> +	  enable the WarpDrive user space accelerator driver to access the

	  enables

> +	  hardware function directly.
> +


-- 
~Randy
