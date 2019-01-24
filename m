Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC06C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCB721855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YwC+gPeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfAXL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:27:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36273 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:27:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so4911701ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqsKNfj0zIZK0melRUAJR/+EvjCvXfGevQiQAproUKY=;
        b=YwC+gPeEMfWNjmADUF3CKdLXY58On46py1lQWDDBuOiCk8ltpQHxC3HfHKfh/x0tbf
         rJI6pXPraZBTSeyWPSaolI+AOwE5H0mYLXEiJfH60DZoiEz3P2tuq/O9sTFzct37bDoH
         vxCulieLIqFHUN3MLpm5eUXnT1b88BsLAu0JLMOLH3SGl5azSAIXlNaupES8T0cargDO
         nJjWB+pnqUtfm+O4/kpJQaTEr1pPrUer84OOFMJEzKtUtRo32r3dkBB1iQh6v53o1XkU
         6XRZ5in0yBZMEl0zLczxdisjzdC6LbGdzh7tjWazFUSmMud954nhpiDoZYeRPs062QHf
         9p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sqsKNfj0zIZK0melRUAJR/+EvjCvXfGevQiQAproUKY=;
        b=bGS1DQ2N3bu8r68KvSJJxO7wRbN7KB2A+2e2M1G7cWxLaw6PDTwasU0wOIK/JE5PMF
         X8V6hKppJbx6gzkaFfkBUv2PxsU+6PpsanXNehn0ST8piMRdySscuP4VwHZhUBpQBKht
         XjYocRZ/KgHnB7c2oIgD03IK7m1T3hC9w/+tQgqIASzM9MKSm7WgVrZdfbFRTGm2T3JW
         0c524PWnxmSXN0QG5/hp6oQ7jTWhNR1ca2nuwVc98cc2Wj3Iy5ekIA1p916XcfeIAL6J
         QRkM3tySuUUVvUQtvU9r+QqQHOEeXCdWcVmxndp1YgPxMgX2OtbfAmHFJER2lepX+W9m
         dpmw==
X-Gm-Message-State: AJcUukdcRy0KiUwqUPl5ZGe56HcMBa3MxzXsno24mPlSAzUuQr290hRi
        LTP4xcNnVBJfjqFS7mhFtxD3Sw==
X-Google-Smtp-Source: ALg8bN4cPKsXZqmnqldTf1UdquuCSvMZ4Azbo3rQxTkQInpAZUNDFdygX0VOvJx7f63MUicMgQCZcQ==
X-Received: by 2002:a2e:12d0:: with SMTP id 77-v6mr5156608ljs.132.1548329274317;
        Thu, 24 Jan 2019 03:27:54 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.179])
        by smtp.gmail.com with ESMTPSA id w202sm910470lff.31.2019.01.24.03.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:27:53 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <12af2632-491d-0e01-66c9-0ead4f9d985a@cogentembedded.com>
 <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <25ce4224-54fd-d52e-8512-a3845cfe7682@cogentembedded.com>
Date:   Thu, 24 Jan 2019 14:27:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/2019 05:06 AM, masonccyang@mxic.com.tw wrote:

>> > +// SPDX-License-Identifier: GPL-2.0
>> > +//
>> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
>> > +// Copyright (C) 2018 Macronix International Co., Ltd.
>> > +//
>> > +// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
>>
>>    Do we really support Octa?
> 
> yes and it needs to patch spi-nor layer and RPC driver for sure.

   It?

>> > +//
>> > +// Authors:
>> > +//   Mason Yang <masonccyang@mxic.com.tw>
>> > +//
>> [...]
>> > +#include <asm/unaligned.h>
>> [...]
>> > +   } else if (rx_buf) {
>> > +      //
>> > +      // RPC-IF spoils the data for the commands without an address
>> > +      // phase (like RDID) in the manual mode, so we'll have to work
>> > +      // around this issue by using the external address space read
>> > +      // mode instead.
>> > +      //
>> > +      if (!(smenr & RPC_SMENR_ADE(0xf))) {
>> > +         regmap_update_bits(rpc->regmap, RPC_CMNCR,
>> > +                  RPC_CMNCR_MD, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRCR,
>> > +                 RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);
>> > +         regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> > +         regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> > +         regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
>> > +         regmap_write(rpc->regmap, RPC_DROPR, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRENR, smenr);
>> > +         memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
>>
>>    Just noticed: if rpc->dirmap is NULL (which is now allowed), we
>> have a kernel oops
>> here. :-(
> 
> Do you patch your spi-mem.c ?

   What do you mean? The only extra patch I have to apply now to renesas.git repo's devel
branch is "mtd: devices: m25p80: Use the spi-mem dirmap API"...

> both dirmap_create() in your rpc driver and spi-mem layer should handle it well.

   I just saw that you don't fail the driver's probe() method if devm_ioremap_resource()
fails for the "dirmap" and "wbuf" resources...

>> [...]
>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,r8a77995-rpc", },
>>
>>    Why (if it has no differences with the generic gen3 value below)?
>> Please remove.
> 
> By Geert's comments in dts,
> 
>          rpc: rpc@ee200000 {
>                 compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                 reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                       <0 0xee208000 0 0x100>;
> 
> I modified it to "renesas,r8a77995-rpc" because this is Soc I developed and validated.

  Hopefully this matter is cleared up by Geert... :-)

> thanks,
> Mason

MBR, Sergei
