Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E3821855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Fbh5HX/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAXIQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:16:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34170 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfAXIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:16:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so4439015lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpcnCbqEbpv7hJsyDIWXbBuGcdOqeJLSZ3yg/+x8bqA=;
        b=Fbh5HX/XTd6IhaXoWUpDXWrqQsZiLppqP02Kqq7a1946IhtwH05lISjnz2tbcU3ghR
         WSU8wCvRZiG4K992CJm6LnM1f2u05TrEZqgFOTTu+dGOndK3ZesQDdwMLE6KZmvgGNgp
         I96q+j6E0IY21rG69ySXXD0NNmI4jX2Ha1CX1RvwULs/SMtTqB5eG5DaMg79PXXZspN9
         eOm6XrvH2bL0vHezgmFYplbcy8kKiH1Fc9UkTdDm8ksZTf4uAvMfLBqJ8C2hhtCVXRi7
         3nAdQ2CYMwBSXolcrZylJGzxw99LTTt8SjOB9HUolOWEpwutnILxskY1R/nA+7PzOmZl
         zj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpcnCbqEbpv7hJsyDIWXbBuGcdOqeJLSZ3yg/+x8bqA=;
        b=WrRAOeCcyp+QTCWOgWemIY407WG6oxpPcMRGh9UjSJ6Txh/RyB5qjocYLnw3KaLRWm
         hxSBW8nxCvIuE/pjze1jpRmSGmfM7Wlcw6zG8hczdcsWxgI/y0pHcCsnVXTYYI/hqWi2
         jcV3Rj7OlNfjq7iL7dlMDmjCeJJiJIOhTSEsP/3jFGjyrPlyzKG77hHS96Kdwith3A86
         Df1Ws79HdEaxVxOUlPvr2p1RUAptOQ/8EcZKV9224VAsqTOo13xJo50tEYer+lweAgc1
         pP4tTcSFjK1mIjrQNhYN5VpUms+yMwlfbUxtl+lUyUvIZpEZ8ZT5TEeC65RGBwm0Rrj3
         t2dw==
X-Gm-Message-State: AJcUukfkuHu5sppQSgJiFMOG030bGWvGvgw6nMGHRPS9g2+PwAezKX1L
        xo+BgWHlSsKUaq5teHxS52REVLUvDco=
X-Google-Smtp-Source: ALg8bN7/6G6GpXu4hvzruUS+Go3w2sB7Lz9Oc8OVTiQkCkeQUNTbxNZ21LB4qDKmBrUIbD0zkeZ9Mg==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr4354149ljd.168.1548317812024;
        Thu, 24 Jan 2019 00:16:52 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.179])
        by smtp.gmail.com with ESMTPSA id b81-v6sm897893ljb.7.2019.01.24.00.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:16:51 -0800 (PST)
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
 <7a2bf711-f51e-82b0-b0c0-5d67f2c1d043@cogentembedded.com>
 <OF87800430.BAF731CA-ON4825838C.0006CCEE-4825838C.00092BDE@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7cdecc93-fc7a-3602-25c2-23107dca2a5e@cogentembedded.com>
Date:   Thu, 24 Jan 2019 11:16:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF87800430.BAF731CA-ON4825838C.0006CCEE-4825838C.00092BDE@mxic.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2019 4:40, masonccyang@mxic.com.tw wrote:

>  > > @@ -0,0 +1,46 @@
>  > > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>  > > +--------------------------------------------------------------------
>  > > +
>  > > +Required properties:
>  > > +- compatible: should be an SoC-specific compatible value, followed by
>  > > +      "renesas,rcar-gen3-rpc" as a fallback, i.e.,
>  > > +      "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
>  > > +      "renesas,r8a7795-rpc" (R-Car H3)
>  > > +      "renesas,r8a7796-rpc" (R-Car M3-W)
>  > > +      "renesas,r8a77965-rpc" (R-Car M3-N)
>  > > +      "renesas,r8a77970-rpc" (R-Car V3M)
>  > > +      "renesas,r8a77980-rpc" (R-Car V3H)
>  > > +      "renesas,r8a77990-rpc" (R-Car E3)
>  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>  > > +- reg: should contain three register areas:
>  >
>  >    The driver now handles "dirmap" and "wbuf" resources as optional --
>  > you need to document that.
>  >
> 
> Why ?

    Because the driver treats "dirmap" and "wbuf" as optional resources.

[...]

> best regards,
> Mason

MBR, Sergei
