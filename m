Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D971C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7502087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="TGrFiAaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfARISe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:18:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38391 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfARISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:18:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so10900384lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 00:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IvVPDY9Dhhic8xmJkgBkDUufVkXKkhvA16uSmsDo93c=;
        b=TGrFiAaSxI1kctS5W8CXd+FCo0tbhGm96Fjw0fZb2u+WF8lj1/tXMuaPOvzLtScrJL
         qu8PhwC9CmbTqNeGGRIUFpTOOm17QfTx2dyqNXjosYyLiHN18pd36V96qrXn7iNL+IBM
         7Nqxj3dFp/CpLFFi/yvn0VnSSigneQJbvkv879uFmgTDqq94Fgqdm1dJmd+JC6laK4F2
         bbhJH4mSTiKQj5+cBWJl7DdP6Z4YDPBr8+UUtImwc3GC19fCrSQHQWKq0Ty9H16N52+H
         C7yLwRMtb9B3D7AO6JNwHtmtAyv4ZQekccRDqQ1bJKyr9frT0EIgMSC6xe6o64qr80bE
         jlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvVPDY9Dhhic8xmJkgBkDUufVkXKkhvA16uSmsDo93c=;
        b=hclKNFFnzK6USYdZ+GDNXDVjqTA4Mt8jusRZlY6gWJb5qt+CRvd4NQgk6z3C39hmtm
         wicUOr3t5nUW0JAV/9gFF8JCAS1RfOBdy8Mo4qdHdw3WGJ1osdR3QdYUSEaSea9YktUA
         PRhlC4THpD8+YC5AYwu4hwkncwBwtE6vRytUOUxTz1eSHDuz5NAoARuDVwDc3d4nj5ow
         wyoxx+3/cQ+ADxun89mnIPDRhGCEFEmbI96FU6dGVvrGzgGDHDr8AEz1/YcHeNtC4Xzs
         c2TeU0utM7LnLqZ5zQf3S70IwVWqmnKYWenyiFmKzW7muKSQ65sm4qu5gvX1CR6IuqPy
         Xe9g==
X-Gm-Message-State: AJcUukejSLRRkOdJMKkrI5LM1J7TtKJ7a7KHA2itpzFbfyGE7pvfTJj3
        MsEsifKAI8m6p6nEwAAtsyZsxw==
X-Google-Smtp-Source: ALg8bN5yxl9FF8e8CDyGyTVdgIkQqyeiYI/+5tEkHkZ3MWxc32GfuKUXTUdeawd5lGmmcBq7YE/z0g==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr12324551ljj.158.1547799511419;
        Fri, 18 Jan 2019 00:18:31 -0800 (PST)
Received: from [192.168.0.199] ([31.173.87.239])
        by smtp.gmail.com with ESMTPSA id q3sm663867lff.42.2019.01.18.00.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 00:18:30 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <784eb633-138a-b30f-6899-5e0d3cbe6f44@cogentembedded.com>
Date:   Fri, 18 Jan 2019 11:18:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 18.01.2019 8:54, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>   .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..9b5001e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rcar-gen3-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +
> +Example:
> +
> +	rpc: rpc@ee200000 {
> +		compatible = "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,

    s/0x7fff/0x8000/. -- that's size, not limit. But in reality, 0x200 would 
be enough.

> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "<wbuf>;

    Why <>?

MBR, Sergei
