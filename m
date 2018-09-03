Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79766C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qGbdrW2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2733B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeICGnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:43:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eRINQaymomz9vcrz9I2QUGQcMnEX+PR4J0URSxBDkxY=; b=qGbdrW2bw21GNsPJRPDXS8P3sN
        HNEzKxSB5nzizR8ghHXwCcz7MVYqDUVAZJB86IyugGpwbMan7tPndCV16RFx3LjRgoqdhUNzwUxoa
        Y3YFOhzTCnbVJcYEm9cUgcHpQyTSzzsoGBm0YICouGd0TVTgJF+Fz8E7+elKYqzddbFpntvfhAJmY
        KgaHAnzifwDMpwAe7+STC2SvfIERnbgSYLNqG9X5j6lNy1GrxkebV2UzwfoiXJb+X/7H/SyD4YQ/p
        UfIjkZ0vFo8EfGDOBEIETkLv72LPPbXQcUSgjoo6TGa4RNGgR93351hN78sxk9+29l6t5z4A7yULm
        5NDNOYyA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fweYG-0005SR-7B; Mon, 03 Sep 2018 02:25:16 +0000
Subject: Re: [PATCH 7/7] vfio/sdmdev: add user sample
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
 <20180903005204.26041-8-nek.in.cn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff75ff6a-2cd8-b25e-8d19-52e8f57141da@infradead.org>
Date:   Sun, 2 Sep 2018 19:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-8-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> This is the sample code to demostrate how WrapDrive user application
> should be.
> 
> It contains:
> 
> 1. wd.[ch], the common library to provide WrapDrive interface.

                                            WarpDrive

> 2. drv/*, the user driver to access the hardware upon spimdev
> 3. test/*, the test application to use WrapDrive interface to access the

                                         WarpDrive

>    hardware queue(s) of the accelerator.
> 
> The Hisilicon HIP08 ZIP accelerator is used in this sample.
> 
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  samples/warpdrive/AUTHORS              |   2 +
>  samples/warpdrive/ChangeLog            |   1 +
>  samples/warpdrive/Makefile.am          |   9 +
>  samples/warpdrive/NEWS                 |   1 +
>  samples/warpdrive/README               |  32 +++
>  samples/warpdrive/autogen.sh           |   3 +
>  samples/warpdrive/cleanup.sh           |  13 ++
>  samples/warpdrive/configure.ac         |  52 +++++
>  samples/warpdrive/drv/hisi_qm_udrv.c   | 223 ++++++++++++++++++
>  samples/warpdrive/drv/hisi_qm_udrv.h   |  53 +++++
>  samples/warpdrive/test/Makefile.am     |   7 +
>  samples/warpdrive/test/comp_hw.h       |  23 ++
>  samples/warpdrive/test/test_hisi_zip.c | 206 +++++++++++++++++
>  samples/warpdrive/wd.c                 | 309 +++++++++++++++++++++++++
>  samples/warpdrive/wd.h                 | 154 ++++++++++++
>  samples/warpdrive/wd_adapter.c         |  74 ++++++
>  samples/warpdrive/wd_adapter.h         |  43 ++++
>  17 files changed, 1205 insertions(+)
>  create mode 100644 samples/warpdrive/AUTHORS
>  create mode 100644 samples/warpdrive/ChangeLog
>  create mode 100644 samples/warpdrive/Makefile.am
>  create mode 100644 samples/warpdrive/NEWS
>  create mode 100644 samples/warpdrive/README
>  create mode 100755 samples/warpdrive/autogen.sh
>  create mode 100755 samples/warpdrive/cleanup.sh
>  create mode 100644 samples/warpdrive/configure.ac
>  create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.c
>  create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.h
>  create mode 100644 samples/warpdrive/test/Makefile.am
>  create mode 100644 samples/warpdrive/test/comp_hw.h
>  create mode 100644 samples/warpdrive/test/test_hisi_zip.c
>  create mode 100644 samples/warpdrive/wd.c
>  create mode 100644 samples/warpdrive/wd.h
>  create mode 100644 samples/warpdrive/wd_adapter.c
>  create mode 100644 samples/warpdrive/wd_adapter.h

> diff --git a/samples/warpdrive/README b/samples/warpdrive/README
> new file mode 100644
> index 000000000000..3adf66b112fc
> --- /dev/null
> +++ b/samples/warpdrive/README
> @@ -0,0 +1,32 @@
> +WD User Land Demonstration
> +==========================
> +
> +This directory contains some applications and libraries to demonstrate how a
> +
> +WrapDrive application can be constructed.

   WarpDrive

> +
> +
> +As a demo, we try to make it simple and clear for understanding. It is not
> +
> +supposed to be used in business scenario.
> +
> +
> +The directory contains the following elements:
> +
> +wd.[ch]
> +	A demonstration WrapDrive fundamental library which wraps the basic

	                WarpDrive

> +	operations to the WrapDrive-ed device.

                          WarpDrive

> +
> +wd_adapter.[ch]
> +	User driver adaptor for wd.[ch]
> +
> +wd_utils.[ch]
> +	Some utitlities function used by WD and its drivers
> +
> +drv/*
> +	User drivers. It helps to fulfill the semantic of wd.[ch] for
> +	particular hardware
> +
> +test/*
> +	Test applications to use the wrapdrive library

	                             warpdrive

-- 
~Randy
