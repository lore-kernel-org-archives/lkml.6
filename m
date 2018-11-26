Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C85220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmaJhfwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C85220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeK0Ddz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:33:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38604 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeK0Ddz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:33:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so17218459lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAFteUHS0B38pSF0YNv4RCUBGKT6wANOIYTEZeKzrYU=;
        b=TmaJhfwIlZ8GQMcH0LCxKKE1Lfr9UFL7DgQNUg0y9xdAr+nfXsnMlrmx33/kIMiQxg
         1g2BHbbZZMUFIEVXiLWbc0mogTrnaEj28HbhHQXrgENldblj099kAWYYbePSp0cPZCtd
         Rw9/Fanc7LXwBjvKcFWeGBX88er5T9kPE9o6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAFteUHS0B38pSF0YNv4RCUBGKT6wANOIYTEZeKzrYU=;
        b=Q3SaEJhO8oKeQgG/aLDm4brOFUjPhzgEY8ZabWtWz9OOmo8EPjN3i40XkNEmSUHUqY
         LsBB9jIYCkO4yzYLWOwrCI93tKG2SPkThZq/SRYevzM2c2UwNSHAqiC2oujw3vPRGRvq
         hhfcYz4pND9To/vDqk0uX82F6Wm3XE52qM0lKUczZj36k+TDTxsIyt8/QusNVsNgCT9V
         oVirXHaFi/eoVxP0nIoX3R/AD/XFgtBym1OBrdZDctArnPvqwCzpViqOKAO2K9eh7qAT
         Nm36wMGdx6WMvQYCySJ6swgodQOF4CA1K3DS99EFv4wJPOvtAmm3PT5cpWOK9//Aoi57
         z44g==
X-Gm-Message-State: AA+aEWYS7m5j7cscDBl+oopkCihDLOCDIgZJglwHaOFrHzgpEDJ/SV42
        DuxNQtfv3pczkDseRKahcs90+lCYrLin/HR3xA4/gA==
X-Google-Smtp-Source: AFSGD/UBdSUARt8mrvlHK/LwHWRTQf3N0G3YaBkNUUMLSwAk47gv2eBF2XmMQQrXRJy73yDWrlDQDRveqVeMPqNx6Q0=
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr17067144ljf.129.1543250356226;
 Mon, 26 Nov 2018 08:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20181126105050.592727680@linuxfoundation.org> <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
 <20181126160840.1c702e87@bbrezillon> <20181126151601.GA100860@sasha-vm>
In-Reply-To: <20181126151601.GA100860@sasha-vm>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Mon, 26 Nov 2018 16:39:03 +0000
Message-ID: <CAH+k93GJjYB75Z+zkrzdkbabUaTSzWCfLGXuuVRuu8ML=6yY6g@mail.gmail.com>
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
To:     sashal@kernel.org
Cc:     boris.brezillon@bootlin.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, nicolas.ferre@microchip.com,
        rainyfeeling@outlook.com, johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 15:16, Sasha Levin <sashal@kernel.org> wrote:
>
<snip>

> >>
> >> /drivers/mtd/nand/atmel/nand-controller.c: In function
> >> 'atmel_hsmc_nand_controller_legacy_init':
> >> /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
> >> declaration of function 'of_get_compatible_child'; did you mean
> >> 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
> >>    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
> >
> >Looks like of_get_compatible_child() has been introduced in 4.18, hence
> >this error.
> >
> >Greg, can you drop this patch from 4.14.y?
>
> Interesting, none of the kernelci builds caught this? hmm

They did, a few arm defconfigs failed to build because of this error.
https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.83-64-gd81d0be7d560/

>
> --
> Thanks,
> Sasha
