Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A3D218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545339708;
	bh=2gZ4MFrT5T714gJ4lcZfmKY8x/U8oBVHk15w8F1GKI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a/jEDrs7UsMza/N/xKMgnncu4d/eK2lilcVox31q3M6JI1fm2fT6nwfP7rOfhllE9
	 honTMI5n4Kv3Ri7JiyXYro3O2jX/D2/dBWvkvuR/PHanEGDr6nf0I0hKes5/h8xyc5
	 ZzI0PEbHbQNY9cGqZq/WhWzNDVffFoxeLLzFygw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbeLTVBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:01:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40562 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:01:46 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so3736346ita.5;
        Thu, 20 Dec 2018 13:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FObYT91NzUS2WehQuBefl/zjyrdR0UffG31UysubvZ4=;
        b=HZnmheSlLU4MYbPBzxEh0nI3HZ09gQhXuBm0uiNBue5Y8ps2jqrW++GO7aie0qdJsQ
         Ci1L8zeQmvBz7xukke3hxcvihYKv2PWWSv831GYDUzoF3+BwH/q6HTcjoQIQbNt/pxQp
         Ta0I3JIn5sTADSkFGBgjcLPrungfikevZ32xkdNaVjCoe2p5NxnIEiVVGr1oK/dOIGrr
         j1zl1u7ekkeJIB1M8KI2dOCeieELek6xWglcEM+DqqzWlxOaMhuROAAmaxO5j7WoTyv5
         MQp2s5VPZ4hb+qNy9PyG6O71dHJQOCS4CQzI5HIju5KDEeHZj5DZEQjwBG2zFJ5sLMdC
         im4A==
X-Gm-Message-State: AA+aEWZXzkN+kMUJV5zMHRil9pr/1OqiBo6p3jxzmag4QM6+6Jw6ZAMF
        eC7EilrOVllnsdPj9P6h2A==
X-Google-Smtp-Source: AFSGD/WXMsUFf9QoMoaypflxeeZ2eBoBzqQ4ysOkpjE/HDZD5e1hZ6hIapE5h/6us8EE3Tx8lkjKqw==
X-Received: by 2002:a24:94c9:: with SMTP id j192mr196707ite.125.1545339705915;
        Thu, 20 Dec 2018 13:01:45 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id y1sm37493ioj.45.2018.12.20.13.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:01:45 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:01:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/7] dt-bindings: riscv: cpus: add E51 cores to the list
 of documented CPUs
Message-ID: <20181220210141.GA17198@bogus>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
 <20181215052154.24347-4-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-4-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:21:50PM -0800, Paul Walmsley wrote:
> Add compatible strings for the SiFive E51 family of CPU cores to the
> RISC-V CPU compatible string documentation.  The E51 CPU core is
> described in:
> 
> https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
> index adf7b7af5dc3..fb9d4f86f41f 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
> @@ -68,8 +68,9 @@ described below.
>          - compatible:
>                  Usage: required
>                  Value type: <stringlist>
> -                Definition: must contain "riscv", may contain one of
> -                            "sifive,rocket0"
> +                Definition: must contain "riscv", may contain one or
> +			    more of "sifive,rocket0", "sifive,e51",
> +			    "sifive,e5"

I can't really tell what are valid combinations from this. It reads that 
I could list every string here and that would be valid. It is basically 
'riscv' plus any other combinations of strings.

Rob
