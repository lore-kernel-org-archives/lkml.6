Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E933DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44E7217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XiE1A8wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfBEQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:16:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54281 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBEQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:16:41 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so9703592ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3YOiGZDXVeVb+PqdpffE1ymvFvsSY64s9CxiJy1tZz8=;
        b=XiE1A8wy6TEiht9WrFV9kb8WMiGpdFDp00lYY2SyumWmYnbBrT+fkTMXVbhARsWSlI
         VP4U8c+zLoLuQFA5+r+SgpyGatleRkReeTUgGbc5FfyZUVa+CH8MrSnKyLQ6P7DsnsOo
         7Ds4CTP0qNWx8wH9fpa8UgaV14AGJuYGivs4njJT9x1QZ49psj1fSF1bUPAQhsflz94Y
         RFtaQdF/+5RhPh7DfXxDAR07/bGPKT8SmzUO0kQMjXm4/SrG00L8APCSJ6qfppJH5Tw5
         AkteO4whyUp81HmbN9wEYdXRdYtjB7X1dbheMRkj5mzNc7cC4KmPbQrnXFF9sNiptiu4
         50WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3YOiGZDXVeVb+PqdpffE1ymvFvsSY64s9CxiJy1tZz8=;
        b=p3V3jKk4fBcq4Ei/zeXAxy3hWZ2+uXgQ3wjEyuD5erJ5cuGwrsZGR+jL9ifJ9tz2FR
         +JOND77TZHL1WcmgrJSxJ1OK06XAVeNI1rpx5rhmfCI5qOz1hx4WwlZFOHlfAB4cQQvb
         ja+2aP81dho7NgpSBobbsATzMjLo4ogc2wp57Us+Pdks5UeXe/oCOwVK/3AosKV18FlG
         pNpPgpgsAjrvsHaQG7x+juFGIIEy/NmgKQd0G5Nn0VzFFtqkwHAfE+1L5SGcEiWtcl5/
         MmgeNl6lXfm+cJK3V3F5FJF3GW3GBShVmBPJqHy/Djvjw8LZJY2UKmUrzWAxixkzoBxZ
         S3Qg==
X-Gm-Message-State: AHQUAuYe6mWNspzawfR7Yrqw43s58J0Z/BgC8KkRGDzfQykaI37oqNRW
        Q7P6v7rSrpMPn+nJ7KD9QtYb2pBm6bAcAQKoD5Y8JQ==
X-Google-Smtp-Source: AHgI3IbmLxZOfvE26SlMUeQFsubB+gvAQj2XcL9KrYdDDqdcr96PZNDTHR8Ix2bNwqOgSPGHg9maO3AeFxiZi3eTdHk=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr593456iop.258.1549383400360;
 Tue, 05 Feb 2019 08:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-6-brgl@bgdev.pl>
 <28694e1b-415a-d53f-f2e5-ba2a407fa88c@lechnology.com>
In-Reply-To: <28694e1b-415a-d53f-f2e5-ba2a407fa88c@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Feb 2019 17:16:29 +0100
Message-ID: <CAMRc=McRiemxKQTYJx1om21XrXcEmur1HJP=YSB5XocXRCbg2A@mail.gmail.com>
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from default_priorites
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 lut 2019 o 01:20 David Lechner <david@lechnology.com> napisa=C5=82(a=
):
>
> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > In order to select SPARSE_IRQ we need to make the interrupt numbers
> > dynamic (at least at build-time for the top-level controller). The
> > interrupt numbers are used as array indexes for irq priorities.
> >
> > Drop the defines and just initialize the arrays in a linear manner.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---

[snip!]

> >
>
> Technically, any holes in the array that are being deleted
> here have a default priority of 15 assigned in the cp_intc
> driver instead of 7. I don't think this is a problem, but it
> might be worth mentioning in the commit message. Same goes
> for DA850.
>

Actually the defaulting is only done if no priorities have been
defined at all. I'll double check though if there are no holes here.

Bart
