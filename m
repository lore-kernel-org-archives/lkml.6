Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37878C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F299D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfBRB07 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:26:59 -0500
Received: from [223.203.96.18] ([223.203.96.18]:30128 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727839AbfBRB06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:26:58 -0500
X-ASG-Debug-ID: 1550453210-107606139f25b4c0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id fbJZDZiSqdTMB3pW (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 18 Feb 2019 09:26:50 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Feb 2019 09:26:20 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Mon, 18 Feb 2019 09:26:20 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/5] Documentation/DMA-API-HOWTO: update dma_mask sections
Thread-Topic: [PATCH 5/5] Documentation/DMA-API-HOWTO: update dma_mask
 sections
X-ASG-Orig-Subj: Re: [PATCH 5/5] Documentation/DMA-API-HOWTO: update dma_mask sections
Thread-Index: AQHUxT0vl84D/LB4q0KmrCL7/VoV9Q==
Date:   Mon, 18 Feb 2019 01:26:20 +0000
Message-ID: <0c3d09d70e8245a2b9c87d1f71803258@HXTBJIDCEMVIW01.hxtcorp.net>
References: <20190215144559.8777-1-hch@lst.de>
 <20190215144559.8777-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1550453210
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 8294
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4716 1.0000 0.0000
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67505
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

On 2019/2/15 22:46, Christoph Hellwig wrote:
> We don't require drivers to guess a DMA mask that might actually
> match the system capabilities any more, so fix up the documentation
> to clear this up.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/DMA-API-HOWTO.txt | 121 +++++++++++---------------------
>  1 file changed, 41 insertions(+), 80 deletions(-)
> 
> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> index f0cc3f772265..8e948fae34af 100644
> --- a/Documentation/DMA-API-HOWTO.txt
> +++ b/Documentation/DMA-API-HOWTO.txt
> @@ -146,114 +146,75 @@ What about block I/O and networking buffers?  The block I/O and
>  networking subsystems make sure that the buffers they use are valid
>  for you to DMA from/to.
>  
> -DMA addressing limitations
> +DMA addressing capabilities
>  ==========================
>  
> -Does your device have any DMA addressing limitations?  For example, is
> -your device only capable of driving the low order 24-bits of address?
> -If so, you need to inform the kernel of this fact.
> +By default, the kernel assumes that your device can address 32-bits of DMA
> +addressing.  For a 64-bit capable device, this needs to be increased, and for
> +a device with limitations, it needs to be decreased.
>  
> -By default, the kernel assumes that your device can address the full
> -32-bits.  For a 64-bit capable device, this needs to be increased.
> -And for a device with limitations, as discussed in the previous
> -paragraph, it needs to be decreased.
> +Special note about PCI: PCI-X specification requires PCI-X devices to support
> +64-bit addressing (DAC) for all transactions.  And at least one platform (SGI
> +SN2) requires 64-bit consistent allocations to operate correctly when the IO
> +bus is in PCI-X mode.
>  
> -Special note about PCI: PCI-X specification requires PCI-X devices to
> -support 64-bit addressing (DAC) for all transactions.  And at least
> -one platform (SGI SN2) requires 64-bit consistent allocations to
> -operate correctly when the IO bus is in PCI-X mode.
> +For correct operation, you must set the DMA mask to inform the kernel about
> +your devices DMA addressing capabilities.
>  
> -For correct operation, you must interrogate the kernel in your device
> -probe routine to see if the DMA controller on the machine can properly
> -support the DMA addressing limitation your device has.  It is good
> -style to do this even if your device holds the default setting,
> -because this shows that you did think about these issues wrt. your
> -device.
> -
> -The query is performed via a call to dma_set_mask_and_coherent()::
> +This is performed via a call to dma_set_mask_and_coherent()::
>  
>  	int dma_set_mask_and_coherent(struct device *dev, u64 mask);
>  
> -which will query the mask for both streaming and coherent APIs together.
> -If you have some special requirements, then the following two separate
> -queries can be used instead:
> +which will set the mask for both streaming and coherent APIs together.  If you
> +have some special requirements, then the following two separate calls can be
> +used instead:
>  
> -	The query for streaming mappings is performed via a call to
> +	The setup for streaming mappings is performed via a call to
>  	dma_set_mask()::
>  
>  		int dma_set_mask(struct device *dev, u64 mask);
>  
> -	The query for consistent allocations is performed via a call
> +	The setup for consistent allocations is performed via a call
>  	to dma_set_coherent_mask()::
>  
>  		int dma_set_coherent_mask(struct device *dev, u64 mask);
>  
> -Here, dev is a pointer to the device struct of your device, and mask
> -is a bit mask describing which bits of an address your device
> -supports.  It returns zero if your card can perform DMA properly on
> -the machine given the address mask you provided.  In general, the
> -device struct of your device is embedded in the bus-specific device
> -struct of your device.  For example, &pdev->dev is a pointer to the
> -device struct of a PCI device (pdev is a pointer to the PCI device
> -struct of your device).
> +Here, dev is a pointer to the device struct of your device, and mask is a bit
> +mask describing which bits of an address your device supports.  Often the
> +device struct of your device is embedded in the bus-specific device struct of
> +your device.  For example, &pdev->dev is a pointer to the device struct of a
> +PCI device (pdev is a pointer to the PCI device struct of your device).
>  
> -If it returns non-zero, your device cannot perform DMA properly on
> -this platform, and attempting to do so will result in undefined
> -behavior.  You must either use a different mask, or not use DMA.
> +These calls usually return zero to indicated your device can perform DMA
> +properly on the machine given the address mask you provided, but they might
> +return an error if the mask is too small to be supportable on the given
> +system.  If it returns non-zero, your device cannot perform DMA properly on
> +this platform, and attempting to do so will result in undefined behavior.
> +You must not use DMA on this device unless the dma_set_mask family of
> +functions has returned success.
>  
> -This means that in the failure case, you have three options:
> +This means that in the failure case, you have two options:
>  
> -1) Use another DMA mask, if possible (see below).
> -2) Use some non-DMA mode for data transfer, if possible.
> -3) Ignore this device and do not initialize it.
> +1) Use some non-DMA mode for data transfer, if possible.
> +2) Ignore this device and do not initialize it.
>  
> -It is recommended that your driver print a kernel KERN_WARNING message
> -when you end up performing either #2 or #3.  In this manner, if a user
> -of your driver reports that performance is bad or that the device is not
> -even detected, you can ask them for the kernel messages to find out
> -exactly why.
> +It is recommended that your driver print a kernel KERN_WARNING message when
> +setting the DMA mask fails.  In this manner, if a user of your driver reports
> +that performance is bad or that the device is not even detected, you can ask
> +them for the kernel messages to find out exactly why.
>  
> -The standard 32-bit addressing device would do something like this::
> +The standard 64-bit addressing device would do something like this::
>  
> -	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))) {
> +	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
>  		dev_warn(dev, "mydev: No suitable DMA available\n");
>  		goto ignore_this_device;
>  	}
>  
> -Another common scenario is a 64-bit capable device.  The approach here
> -is to try for 64-bit addressing, but back down to a 32-bit mask that
> -should not fail.  The kernel may fail the 64-bit mask not because the
> -platform is not capable of 64-bit addressing.  Rather, it may fail in
> -this case simply because 32-bit addressing is done more efficiently
> -than 64-bit addressing.  For example, Sparc64 PCI SAC addressing is
> -more efficient than DAC addressing.
> -
> -Here is how you would handle a 64-bit capable device which can drive
> -all 64-bits when accessing streaming DMA::
> -
> -	int using_dac;
> +If the device only supports 32-bit addressing for descriptors in the
> +coherent allocations, but supports full 64-bits fro streaming mappings
                                                   ^^^
"for"

Thanks.
Shunyong.

> +it would look like this:
>  
> -	if (!dma_set_mask(dev, DMA_BIT_MASK(64))) {
> -		using_dac = 1;
> -	} else if (!dma_set_mask(dev, DMA_BIT_MASK(32))) {
> -		using_dac = 0;
> -	} else {
> -		dev_warn(dev, "mydev: No suitable DMA available\n");
> -		goto ignore_this_device;
> -	}
> -
> -If a card is capable of using 64-bit consistent allocations as well,
> -the case would look like this::
> -
> -	int using_dac, consistent_using_dac;
> -
> -	if (!dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
> -		using_dac = 1;
> -		consistent_using_dac = 1;
> -	} else if (!dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))) {
> -		using_dac = 0;
> -		consistent_using_dac = 0;
> -	} else {
> +	if (dma_set_mask(dev, DMA_BIT_MASK(64))) {
>  		dev_warn(dev, "mydev: No suitable DMA available\n");
>  		goto ignore_this_device;
>  	}
> 

