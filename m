Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0623221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545325968;
	bh=Lpz3p6/AQufqIGXrvka6OGNF94iO3k2EaYcQ+Z6SsVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PPPNFiodRkYMg7zm1DR5/KRu9SCZu5tED5GRiazsZqUtwYx72P9RhsQwebYEkvqx3
	 L4S6LP3WXt4dz0/UFNNTnLRS2ygfe1/+s5qH/GRhEOlZXuVmu+V/rd2iX+McQ3Novc
	 Wi81NGLinpYmv4jkIf1oY5JHUgrky0w0uWR0pYmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbeLTRMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:12:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45259 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbeLTRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:12:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so2568210ota.12;
        Thu, 20 Dec 2018 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTWNz/bdAjLOi56caOeWhwWjyxdwy/hu458gts3psvs=;
        b=E6vqx+PI+ScJ52m5uvsBDgoiW8VL5+7e+TIu2XIOm3mSKr/RdGFSuksv0X4eR/F/zy
         4XBMjUsJbRXs3Vi0acEWL6LJssZuf33eNq777vLO23By6A/hO7EFpAN0em8Mrr/5/8Sm
         LenoKRKZBEeXQG9DxfJgPldHtEaVS5gf0MJXzn7tZSPnkMZIbr7l9P9k0U7g1vXYG2yV
         bihA9W1zHhRJd81uypV8qxVHUS1ULyfg/+XY2wbxF4ZOaZki5nm4XI9AWT3AyU0ad7/U
         +qQHLlq23OyztTVPWguVz6I8go4GeBfvbHN3uNt+vlH7VMJbrQ8JgNIkNXTIm/Qexq8I
         /jlw==
X-Gm-Message-State: AA+aEWZNgrL8NN/4uH9x4ZlxpQBMYk283hhMzbvBqkHj7fXTZNsRgad5
        gvMxCPjCkSFu2ERIhtTXBA==
X-Google-Smtp-Source: AFSGD/X9Y7jiW3SqvSCeoxBjW97zigIndQolgvi3K7GXy7UovibIGVQj+bucvS+BzWvrup/m65Smcw==
X-Received: by 2002:a9d:225:: with SMTP id 34mr20115952otb.224.1545325965947;
        Thu, 20 Dec 2018 09:12:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm10216814oih.18.2018.12.20.09.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:12:44 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:12:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20181220171244.GA22403@bogus>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
 <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:21:49PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> similar to HI3660 SoC with almost same IPs. Only major difference interms

s/interms/in terms/

> of UFS is the PHY. HI3670 has 10nm PHY.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> index a48c44817367..a327c1e24365 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
>  Required properties:
>  - compatible        : compatible list, contains one of the following -
>  					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> -					host controller present on Hi36xx chipset.
> +					host controller present on Hi3660 chipset.
> +					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
> +					host controller present on Hi3670 chipset.

From the description, sounds like having "hisilicon,hi3660-ufs" as a 
fallback would be appropriate?

>  - reg               : should contain UFS register address space & UFS SYS CTRL register address,
>  - interrupt-parent  : interrupt device

Don't document interrupt-parent. It is implied.

>  - interrupts        : interrupt number
> -- 
> 2.17.1
> 
