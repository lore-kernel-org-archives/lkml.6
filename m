Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C569D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TR0xj5P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfBLIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:32:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39605 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfBLIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:32:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so3051547otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/MtKpa4761DXWQUhuz6Dd1LL8SOhaerQOxx15a6k3g=;
        b=TR0xj5P7yc2Csi1UPes3wPhR18oWs/tTD5xusancZlJtjcak9JrNv0A9kUXWXchV1m
         3o8i1HU5HLMd5QLkEF5kkQkS6CfLROEFBDp+7dCJutSOZsPPgR/aaXfLm/fn4vhClJXQ
         huUfRBaGKUZWKpgYbgJG0YvuxGroDDBZraRNO62iqepOt47Dx0fY7A5GJps/rK+5fwds
         0SGkuTXTMgOHkzTHEziOVy6H8LOL0u9yP8wwKxDrBkIgtCX2gT93T3/4MgRpMQow/kpe
         FjLYoyr3UPwws/C6NUz7Bv3jgicNjqHfSdQPS/oNm+tkrMwaHIFcqS+NAaajooPpEfdm
         AJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/MtKpa4761DXWQUhuz6Dd1LL8SOhaerQOxx15a6k3g=;
        b=IlaU/oW5QTkQ8mqnjC10Dc8ucKLp7egz4ZkyGW1qGrGTnpUi0yI4oQViDLEQYJ66c+
         w6jRi4+UjM0XC6Vkm2kEVcG775liQUnEHmlPZm71NEhFZcVOlaCZGtB3GEQIeG6yoS53
         ENX1KTdzMGSMzWzF3musy7HBhuErNMI3F8si1dSiyMiH3luzQq8gmqamVKPda5XhXc+H
         YCC9rA4lcK5kmboTej1YjaaM3LG/2AOPW0QLSYv7nxEtD8MG0dI+Mh7dyDyvZwgCwFXB
         xKO5EOWWP9WSYLcxG/bElsk4ISF4MdgKv2W8+1UgGJayk0SOQQb3xwW4kORz/vwLGDMQ
         K4nQ==
X-Gm-Message-State: AHQUAuZo/s64R4AGJaQEgHxWoaKM2qXjV4aaHvodpRHb3WKwVpjPaDPZ
        Iuf9gMfnYwezthKO5IzZOokAP76GEpxja89L/k97SQ==
X-Google-Smtp-Source: AHgI3Ia+dhS3kqkHVI512MvgSHV+MHbl80BetH5wNP878OMvJJ7YK/nA58fNKqSAcWSETd7fKODREoVbgxQP2Tg+cEE=
X-Received: by 2002:a9d:6191:: with SMTP id g17mr2680441otk.56.1549960326066;
 Tue, 12 Feb 2019 00:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20190211122606.8662-1-brgl@bgdev.pl> <a333fac0-955e-d04a-6076-42a5b6edda34@ti.com>
In-Reply-To: <a333fac0-955e-d04a-6076-42a5b6edda34@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 09:31:55 +0100
Message-ID: <CAMpxmJWZoPkM7LW8HvVi2SRP5097f9YTnbEZMAXpbM69JHG8fg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 00/33] ARM: davinci: modernize the irq support
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 09:24 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 11/02/19 5:55 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > NOTE: resending due to missing irqchip maintainers in Cc
> >
> > This series ports the davinci platform to using SPARSE_IRQ, cleans up
> > the irqchip drivers and moves them over to drivers/irqchip.
> >
> > The series can be logically split into four parts. The first (1-8) aims
> > at introducing support for SPARSE_IRQ. It contains a couple changes
> > required for that functionality and the final patch actually selecting
> > it.
> >
> > Second part (9-19) makes the aintc driver suitable for drivers/irqchip
> > and eventually moves it over there.
> >
> > Part 3 (20-32) does the same for the cp-intc driver.
> >
> > Last patch removes unnecessary code.
> >
> > The series has been tested on da850-lcdk (for cp-intc) and
> > dm365-evm (for aintc).
>
> There is build breakage in drivers/input/keyboard/davinci_keyscan.c
> after this series due to <mach/irqs.h> removal.
>
> Thanks,
> Sekhar

Thanks, I'll fix that.

Bart
