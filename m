Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A44020823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UEedMoIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBHQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:41:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52038 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:41:41 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so3933736itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KQ/vZbTI2xvoNfErWMG1eOo/Dhk/zkEMJp2icouEFAI=;
        b=UEedMoIMo5olfWopXlhwmhXIlQJSjpVwH0OSEJmH47wcJPPuNoN4aQsozljAfJU6zj
         63kWwCtqPVc5nMcwES/QhRF84dHzHVDTjN39sdHtKqAu8RvGhpZc6mF62gzjpVmoW7pM
         cbeOF6/+eeCmTNJyu7DezIzByFTuccXFsinqVQadi8NVUJyDYG+hq2roIlarQ/9e8m1Z
         fmc/0jnPMytAHkKPfSOGLRUFBAwwEVVWwB+mUT2Y/61HpHiwse0L/WzNnUhaGf2SLfKe
         96Q2elI9Jing2Q1X2sim7BLrRH6Y5Cwo8NGY4/wEEXKlvRx0o5qrwhRQRV+Xsepy2kfW
         XTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KQ/vZbTI2xvoNfErWMG1eOo/Dhk/zkEMJp2icouEFAI=;
        b=ncwapuM+UkWPMar6VhPocfJ6h8LfF+hh7/8jsLQtFwclkiRo9RHvQGyvoi4sRbR91c
         Qgrnnfaim3qSuSA1FJhxbXdx0OBkeQbsaHLGjRI9+EWvi1NWkSkapIM7KdOM3Fuuk/DA
         m6J7AB43on4Cj/FPIsIKwUUqc1/lw+CHaWs45U7b0/TLMUkj0G/qyjlNbD03dtZOm2ap
         aG+Z4brGSEpBUaEMBuvj3jNopDALjCacYEOr+HnnrKl+/PLht7+CpX+gLoo7msaF1u5J
         EwXI187K8LT/Q6DVS0NZ55TtJrt7FsGG/IQuGBzwMQK8tW0kGQVTyhu5GXkOAMTpiud3
         OwvA==
X-Gm-Message-State: AHQUAuZCMZtSomdaWRvwukBn0WwMKJGkQn6G/W4LP5Ce0Fj7+I4TPdcn
        JYN4PebuVt8GZivZaHuetAel3xINlteqhamFO1X+Ug==
X-Google-Smtp-Source: AHgI3IZgoArtwL9xNz85ka5QvIvv5VH79nGCHRlysDd1ZcvIxjIe/xT2qEB6VsDjGAL5g7V1A8t7M/3lzyc5NWwPoUU=
X-Received: by 2002:a6b:440c:: with SMTP id r12mr7734256ioa.258.1549644100627;
 Fri, 08 Feb 2019 08:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-33-brgl@bgdev.pl>
 <7471c8db-52f1-4833-d3b7-c606133e7362@ti.com>
In-Reply-To: <7471c8db-52f1-4833-d3b7-c606133e7362@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Feb 2019 17:41:29 +0100
Message-ID: <CAMRc=Mdq7UmY8TFG3igz_X7Z_fhmWYFk66zNfuuNE9YktkrXtQ@mail.gmail.com>
Subject: Re: [PATCH 32/35] ARM: davinci: remove intc related fields from davinci_soc_info
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 7 lut 2019 o 15:04 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > These are no longer used. Remove them.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I assume you are going to drop this patch and keep the priority setting
> code around?
>
> Thanks,
> Sekhar

I'm still going to drop it from da8xx as it's no needed AFAICT. Both
SoCs use 7 as the priority for all interrupts. I'm just going to keep
the defines for offsets.

Bart
