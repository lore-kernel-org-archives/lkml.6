Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9EEC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB431218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550092692;
	bh=Fni606/RlPFND3rm4e0Ihk57F8h4Tia4x+idE0DnIV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t5kARH103LWlWrntX7yJARMWEsBkj59xxX7W7EhT2PGsYoq+36DV4YQZmadVQrrug
	 fL4UqpY00fZPONnfFYRC3PEv0YGxLm7yfs2G3XSoxGEwSiXxmDMLXwlw2H5oOfSOoy
	 +l4ZHjhwkKab2RaLLbF7lZp/4VK8WHEvtwNU4FeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394760AbfBMVSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:18:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43153 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfBMVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:18:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id n71so6811868ota.10;
        Wed, 13 Feb 2019 13:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQrVYHsBR1uaKP5KKxxDUsandP0CwxMnW0PWdLyJsDs=;
        b=FjoZsokx6LkMR8x3BCZZpIebosqvwLoUVpisZNXDb2aN3XsCv57JgS12vqlz9c3ApN
         bxKvm7v1iH0uGp7Kd7cO9Ij3dS/K/7mU7th7Mtd+hBF9g4tXXEljcO//KHbu+vtQWz1w
         YDpYn+BLf3pmBVAo4hjS7/SoXuq23zh3+yBDRPV/YepvKPBIwnqjij5PnXod9uUcnBJB
         9hAgBVlE7yuT7pKUPUNQIjsswlUtfvEOxNwLYw+01HwNhsCrqC9A5VnLcU7W0HkOCKRI
         AG7lblKatmtQ/kC48hNUY+l+aVrauButrU8p+ArEr0Yxso/KsaW3PmJUx/0ZdAP/zgq7
         Oybw==
X-Gm-Message-State: AHQUAubQiifJO4UdFdJpIcX/Um4z3d49abuY+U/szG9HKvtjKHLDIgJM
        xYgRzLTFv79flH81xPCiLA==
X-Google-Smtp-Source: AHgI3Iacg9lirau8paMoz/IhHP1zO45ukS41Z/dLIGCv1CQKNrlz+lsqYwlXnI/nLxLNKAUVWg78YQ==
X-Received: by 2002:a54:459a:: with SMTP id z26mr134495oib.69.1550092689607;
        Wed, 13 Feb 2019 13:18:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm320929otj.6.2019.02.13.13.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:18:08 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:18:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Message-ID: <20190213211807.GA20560@bogus>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204231554.87666-7-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> index d3a3620b1f06..02e82d20239e 100644
> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>  Required properties:
>  
>  - compatible:
> -    Must be "brcm,iproc-i2c"
> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>  
>  - reg:
>      Define the base and range of the I/O address space that contain the iProc
> @@ -24,6 +24,9 @@ Optional properties:
>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>      polling mode
>  
> +- brcm,ape-hsls-addr-mask:
> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
> +    'APE' co-processor

What's the data type and size? What are valid values?

>  
>  Example:
>  	i2c0: i2c@18008000 {
> -- 
> 2.17.1
> 
