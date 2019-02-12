Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23552C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59002186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hvNL87km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfBLOMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:12:17 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55605 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfBLOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:12:16 -0500
Received: by mail-it1-f194.google.com with SMTP id o131so4138139itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oaz0kFE3Os1tiLxazqWfsLVT4Rb9wAlEr0UAKK3rcSE=;
        b=hvNL87kmSjZ7vAILvkHNH1+ZnkecIftVsL7hH3gWY0/n/CLOgjh+18/WnoJusmaCZ3
         9wgCeb1s0wr/bF7ttdxF5WKPeHLREbY6hlzLkbCpKVBBFWSwdemfcW63GCZ9Eq9DHJDC
         nWP0d1vAZ1XpRjQNCmGUFSo7RsXSP2NiFrN60eH7yBRCYvwv1frzQMu2ClZ6ZY1i5oSp
         TmCswKvtdonmBL88G1YF8yU6VdsDlQo60hnlF0sEiAsYQ6SB8ie2WhUseC5MFveXh9zz
         enOjQ+WIo/soofafSWK0pL6KkC0XTSB9pg2Q8n132mfCIYdO5xF/sbqszV/D65YHZSlR
         gDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oaz0kFE3Os1tiLxazqWfsLVT4Rb9wAlEr0UAKK3rcSE=;
        b=dirnhgk45S6a7ULAeS8x/TCEfxXeDzXOkt9gXQ7OWYZUjyWCoYi9O28+jd3kHsFjJJ
         PXUOw2qFWnn6pDtYjjOwc1xp/AxMbI2LdtB+WZIGux6M2hHT/FYIm9GAunvvYvR5SAIP
         QDwU1hVCsbF2uIWGzjufCuBXLIC1yZI9oM57KiYgm8yCCsNuZXU+Em47hN04+S3ywwkp
         2b8F9JzZwGaW4hWh1l9h3tOSvG+/9uRHXbOCPWesCLL4Y2xQR7bcuzgXomRO7TLGPzct
         Cwz7VYbtX8eX9xYqd3rXwZUb7GpY5tTfA0zkRm1MXLSmcTbIq+LRhYIkvY1Y9ks+1le4
         XyDw==
X-Gm-Message-State: AHQUAuZRPUonkoZGKtHobK1j2OF0BDK8wagm3UgS+KrT2MMoF1HvfOGD
        7bU3M/X2zBVCmVRZrYsbSJQSmd09Kyqm2VTmen8KAw==
X-Google-Smtp-Source: AHgI3IajqxOcEu0M1gCdMLYyupRpt2fIRWt7ael+Zr1UgLQrmRu+n+qOVM7UH1Hu0VaGPp3+xBD5F3ONvfYJc4gr4Ds=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1786666ite.74.1549980736116;
 Tue, 12 Feb 2019 06:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20190205135934.18841-1-brgl@bgdev.pl>
In-Reply-To: <20190205135934.18841-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 15:12:05 +0100
Message-ID: <CAMRc=MdRgmOwcaytv83pOHGYGwsskCVx3gRqaatg8sMDShmnLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] eeprom: at24: new property
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 lut 2019 o 15:00 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Microchip 24aa02t EEPROM is compatible with Atmel 24c02 except that
> it's visible on 8 i2c slave addresses. We already support such a
> use case with hard-coded config for 'atmel,24c00'. Let's add a more
> flexible device tree property - 'num-addresses' - to the binding
> document and support it in the driver.
>
> Bartosz Golaszewski (2):
>   dt-bindings: at24: add the 'num-addresses' property
>   eeprom: at24: implement support for 'num-addresses' property
>
>  Documentation/devicetree/bindings/eeprom/at24.txt |  3 +++
>  drivers/misc/eeprom/at24.c                        | 13 ++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

If there are no objections, I will apply these in 2 days and include
them in the PR for v5.1.

Bart
