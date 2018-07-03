Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC28C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ACE20849
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ACE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeGCSyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:54:46 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43498 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeGCSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:54:45 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so1064765ywb.10;
        Tue, 03 Jul 2018 11:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pfwRkadb2yI3rryc5Y+vRrLqZ3CeDfv+qCDPiGgN+fo=;
        b=hdXRMGVxgnWIVe3Clp9ZQK+1Z7jXccGi21Ey5RExMJJRdAj1FLz2fwOTnpFp+zz2vH
         ma9ZeniC0Aql1HSg8+vFQRwPjM/ngQnEXJ20DyXkjkFf2ZVdm9FVnzg85VtJ/+314Ae2
         47ws9XOb/lcFS+DJ7ZecIJHCjZF8i2weqt1+z9erev0Z9Je7SRLNMSEY/EXzzxMZXi1D
         JahWbG5VY4sM5YeaHpVWadSFz+NBPghrscAruDHEyPQ8mYOonUYkyWoVLE2GOeRYhvN9
         DydmPaoE8bkJvwiJ4I+iwy17erW3OnJgO9yCa6/zSWPiUxTd+zB/nvwEeRGJO86I8PVB
         yYFg==
X-Gm-Message-State: APt69E0hhgv5RWI+ozW/d6G0wQu+TtBTy4A4DxMG//eKR3OVDrtck1S2
        eWv1OVlkLOVuZypmg1GQkA==
X-Google-Smtp-Source: AAOMgpe+aNk90I7CDgQkpqT1QgDfLar/jiTsKmEWvOWBdE2E4uZ+9dktVLj7mmfU39mi9jAoEs7GAg==
X-Received: by 2002:a81:2d57:: with SMTP id t84-v6mr15874298ywt.152.1530644084312;
        Tue, 03 Jul 2018 11:54:44 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p186-v6sm583635ywd.93.2018.07.03.11.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:54:43 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:54:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guodong Xu <guodong.xu@linaro.org>
Cc:     vkoul@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: k3dma: add optional property
 dma_min_chan
Message-ID: <20180703185442.GA18008@rob-hp-laptop>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
 <20180622032416.20133-2-guodong.xu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622032416.20133-2-guodong.xu@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:24:14AM +0800, Guodong Xu wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> Add optional property dma_min_chan for k3dma.
> 
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aeac4dc4..2fa1370c3173 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -12,6 +12,11 @@ Required properties:
>  		have specific request line
>  - clocks: clock required
>  
> +Optional properties:
> +- dma_min_chan: the minimum number of DMA channel which begin to use
> +		the default value is 0, but in some platform is
> +		configured 1, like hi3660 platform

Can't this be implied by the compatible?

If not, needs vendor prefix and don't use '_' in property names.

Rob
