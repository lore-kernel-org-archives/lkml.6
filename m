Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E247208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAH1G2xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E247208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH0SAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:00:39 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35823 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0SAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:00:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so27530930oic.2;
        Mon, 27 Aug 2018 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bLiT3JWXGScGRa/j2FY2OUM3NDdNzooJQKU3UE/9mAM=;
        b=uAH1G2xAYnhf1V4PbEAwrUbcrhm/6aSUssOdnhGlP4MrpKHwiribj7r2SWciodeZcu
         Ho0wZw0xkwxoPId6qIGOv0hPK0xGHXK4pOA8kdB04fxv7VKZAfv4R1imd0iPixrEkrXI
         QfRGfzcfyolvJvH1rz+8r7/h+rkF4diuiZLcYEdofp0KuD7lnnyDPoGfuMTMiVR+yVFj
         vAhF1VPPU5Av6SEk6jD+ztm9Zdk+77GOiyleiXCstBn05g39ktZ+cXgUewcnzz+5ZjJV
         SLZneyIC/Kg6ARlNyYGpLmM/ZEocA4QaTbncK0jEROEmR+BNQL7VHi8iUjOFNj4yNoAn
         6Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bLiT3JWXGScGRa/j2FY2OUM3NDdNzooJQKU3UE/9mAM=;
        b=mmdbjeQWwtvUEFSOm9XlBw1RRqA6SFMmJs7jZb2CgygCXIk7fK3L8BhfDpAJlbDzdJ
         qOojuQL3VCPn1PCP/COn816ucebffI9eVhn5HDcZ2c4nDjHiqPp0AHFPPx7UpP3tJafk
         vb3YfD0D8Nt15wTOk1Vt4LNVbUKMqBVHZvNaCkeuPOcN7Fai17yFdKn3k6VCx0gYGX0T
         xFQHWZs40YK7fdKvTQTR08qqOEqk/RTV9kLSYyK2RDrSpuitANwcFBLrI7ExlgWVDLhA
         C1Hf5PSna85IjXwV/67MCrzgoWJc5lq26Uixjy9bVRmHkns8byFhFQ7QX6vG4JeACcN9
         lp5w==
X-Gm-Message-State: APzg51DYmJYzgEIRDezFsSAufpVQIrMgZqbDHzRJABHUFFrK9rEy8fGD
        Ha+UBZ721AYkSQKK+GbhyDIFFaP8ZT2dK8KbDc0=
X-Google-Smtp-Source: ANB0VdYX9V6cpeN9yP5cB8U0WW5tcpy7mmDasu1GZrqUipDOaN1/RikjDtveQ5RoaQ+t+0im3yNx6CRE4yXSaHC3qkY=
X-Received: by 2002:a54:4017:: with SMTP id x23-v6mr11676540oie.25.1535379230449;
 Mon, 27 Aug 2018 07:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 07:13:49
 -0700 (PDT)
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
References: <20180821095303.27664-1-geert+renesas@glider.be>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 27 Aug 2018 11:13:49 -0300
Message-ID: <CAOMZO5B43Cm+xtAMc5tLHAMzoVO0JJR+T+G0MPtC9oGAmjrP2w@mail.gmail.com>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        linux-spi@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Aug 21, 2018 at 6:53 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If the SPI bus number is provided by a DT alias, idr_alloc() is called
> twice, leading to:
>
>     WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
>     couldn't get idr
>
> Fix this by moving the handling of fixed SPI bus numbers up, before the
> DT handling code fills in ctlr->bus_num.
>
> Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This fixes SPI on imx51-babbage, thanks.

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
