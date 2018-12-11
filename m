Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BAC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="u5kN6xfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BAC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeLKO7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:59:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33594 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:59:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so13268983ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1AO66jJhSY8/evsRYM/xVdgBN8qsSLYY7v4QBGE5+8g=;
        b=u5kN6xfNUnAQzEN+auFhyI+Ou8JVB32aqhDqm1+HsMhKPYrTcfGlZceEboL07m4K88
         ZiyzoJJAFK+LhoLf09KOOmxQQypTPk0R+mIAK/sYse0yQj9nmKdGo9Ty6tN9MQHWUwPq
         SbRleckMwpRpOo1v9RpFqZKMzcegGcTErfZNS/wgxG+C46Esf+k/sYUy6UZcR5XGPX/R
         q+2fDtHutFSnrPrFDpHyI0t/q3ze1e5CtZmgrdqvlWhApAWVFlMydtYv55fj97Ooi3dw
         MOimZqd8Qw9FL2uGYSUGKVnasodIacw1fELeQCuTl7+9G9cGMIyYsdinU//cju2U5C2E
         WYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1AO66jJhSY8/evsRYM/xVdgBN8qsSLYY7v4QBGE5+8g=;
        b=KSEglMIoAMGoO02gShJKpFPFJhaXCNXXYqGx8P6nQR/G5q74oYzrGft6SjobjH9arr
         cF8suvX2uC8f+wFstgg32uJy9vnJwly1IJB9kwCZREeZ0L0g1Rt9mIx9wCk/aK/qWpTV
         XUSmluNkmuZBn5HauKi75aibBRJDYLB7YjAtOhDrpda5EzOKJgR5MCXUNCBpAPImpabD
         gAq+nm/IS3EWFP4eMKLqrEaB6+U303Q2246ihPWhu0JMfEJWScFfXLl7dCKzUma4t5+2
         OSL8bmFaScQc9rcdWDFJmLma3SE3WS2X+ehK4QMZ1waC4h92gcxfZxm3sW6Q+K23Va7F
         fpGA==
X-Gm-Message-State: AA+aEWa0RGlQ/NCCFApnwGbFuE0e697cBcSVUhaxWUBwTpEmjYpo9MKF
        WtWvLo/nYVLqfUSkQOnXtFIhTw==
X-Google-Smtp-Source: AFSGD/UI+rLcfmf6OGZrrojkBk6+1ILjSOSu90d1AcmWKfI5ceStjck2rYQCyxC+NdUcaniyd4CUkA==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr9897024lja.24.1544540375561;
        Tue, 11 Dec 2018 06:59:35 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.85.248])
        by smtp.gmail.com with ESMTPSA id b25sm2628573lfa.96.2018.12.11.06.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:59:34 -0800 (PST)
Subject: Re: [PATCH 1/6] driver core: Introduce device_iommu_mapped() function
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, jroedel@suse.de,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-2-joro@8bytes.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b1344a34-cd5f-f080-fddf-c1548f85af6a@cogentembedded.com>
Date:   Tue, 11 Dec 2018 17:59:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181211134343.10664-2-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/11/2018 04:43 PM, Joerg Roedel wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> Some places in the kernel check the iommu_group pointer in
> 'struct device' in order to find ot whether a device is
> mapped by an IOMMU.
> 
> This is not good way to make this check, as the pointer will
> be moved to 'struct dev_iommu_data'. This way to make the
> check is also not very readable.
> 
> Introduce an explicit function to perform this check.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/device.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1b25c7a43f4c..6cb4640b6160 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1058,6 +1058,16 @@ static inline struct device *kobj_to_dev(struct kobject *kobj)
>  	return container_of(kobj, struct device, kobj);
>  }
>  
> +/**
> + * device_iommu_mapped - Returns true when the device DMA is translated
> + *			 by an IOMMU
> + * @dev: Device to perform the check on
> + */
> +static inline bool device_iommu_mapped(struct device *dev)
> +{
> +	return (dev->iommu_group != NULL);

   You know that parens are unnecessary here, right? :-)

> +}
> +
>  /* Get the wakeup routines, which depend on struct device */
>  #include <linux/pm_wakeup.h>
>  

MBR, Sergei

