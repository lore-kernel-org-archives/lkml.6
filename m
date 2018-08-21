Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA30C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBA2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlAUXlxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBA2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHURjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:39:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43785 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHURjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:39:32 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so15504423ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nrT0P/Nxj/nFQ+8iNZJqVo9MRAF/ffNgXKl/fcHmWbw=;
        b=IlAUXlxVLOrFAFQXHzct3vF68dwJvu7iDQZJNmxmP/TbegqHrdOm/WKLz5JJakSRGI
         xd7Sw60hs+vqaPqSUFzlejGEhAC/jU8ug/iqN/Eh9aTR+HwpeoFGBYA7sdpCFRLI/KPz
         QFgB8OeMF7rS5QW7jE/22+J/7kQd1kd85YlAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nrT0P/Nxj/nFQ+8iNZJqVo9MRAF/ffNgXKl/fcHmWbw=;
        b=l/sQF2oGmJ97y9tmRXV3OfmxIgTdDZ3vGg8ShEpuNEqNHMCGUTvVFrf4ou4kns0ZF/
         5/nvTOGwtK4LderbyIwgKpGkG3lxCdNoZ81LUVdXtfI3WJvNOxlkzPZ8fRL+gM6hNhuR
         1N+5Sgc/ESr5T6Bqr4Oz6zNxY1NbIDUH5WsHw88tQuuAI1Ezh4mrQgJ0b2N6s7EVfQOf
         PNaArmZJ4K6K/w4tgduLH6x2cF8h+wLsSa3Z1ITqPZAF30ZQBjT7CVi06S27c6Aig1/7
         YGu0U5Ys7i/XwTvYj80QcHUuZDmQUT/cyh7s7d3cYTBrUFK8sCdFnOne/tc+xcOJS/v4
         emSA==
X-Gm-Message-State: APzg51CZhDyuZc1YsaJA2GINce1oQc0TCQB40AbimtOJeFI6Q0YVFP0D
        Z7xBRJORjzd7DEUft7/7kiVnO2mTCKmSVJWHvm49Tw==
X-Google-Smtp-Source: ANB0Vda6ISlt9aaBoDBIrpDwOlYO9zxJLdT9Bb205uY+8iny68IRRXdXsXVuUf0Ibi5+775xG9rynH83SoUoSBWMfG8=
X-Received: by 2002:a6b:e410:: with SMTP id u16-v6mr2812302iog.131.1534861151920;
 Tue, 21 Aug 2018 07:19:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 07:19:11
 -0700 (PDT)
In-Reply-To: <20180820085445.14632-1-ludovic.desroches@microchip.com>
References: <20180820085445.14632-1-ludovic.desroches@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Aug 2018 16:19:11 +0200
Message-ID: <CAPDyKFpgRXDpQQKBGC-MieTMnG-v1wcjzAB9Jg3xhFjsdwXOYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] atmel-mci and maybe android-goldfish broken on 4.18
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        dgilbert@interlog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 August 2018 at 10:54, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> Hi,
>
> Dougas Gilbert noticed that atmel-mci was broken with the 4.18 release.
> He found the culprit commit which is 5b4277814e3fd
> ("[PATCH 2/7] mmc: atmel-mci: use sg_copy_{from,to}_buffer"). The from/to
> logic was inverted: sg_copy_to_buffer copies from an SG list to a linear
> buffer so it can't replace a memcpy where the destination is the virtual
> address of an SG buffer.
>
> This patch was part of "make more host drivers highmem safe v2". It seems
> there is the same logical error within the android-goldfish driver but I
> couldn't check it on real hardware.
>
> Ludovic Desroches (2):
>   mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
>   mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer
>     conversion
>
>  drivers/mmc/host/android-goldfish.c |  4 ++--
>  drivers/mmc/host/atmel-mci.c        | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

Thanks, applied for fixes!

Kind regards
Uffe
