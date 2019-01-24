Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63021C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D74218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLdrGW+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfAXTQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:16:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35289 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAXTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:16:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so3335354plo.2;
        Thu, 24 Jan 2019 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxwC+65B2qmJhVIrdieQTegVpc1FeSZd/tKCnfS/pCw=;
        b=hLdrGW+2gw1Aataj2dGrTP4Tw5uewrQbNh2fpd6aeVWnY21t664aEiyqMG0UAeuwkH
         AizCJ2kJ/CwYAtQD0AMUjOfsTHMQggVuIXvfgjn0steQmdNNe1E6FDhfpZicAjEDtTHA
         RbB/MxKMR0kF1+CewUgieYU25guzfY3xoIxi5w2h8znPGwVb3DQRtBhltEdy/EpaZElg
         HMCM+3UedqKZYvwaZ8P2E2cRLa4oTSo0rMrWrJ7rCK07eVG5RtVNgboW5B/kr6ygaqLX
         VtRWW/kQ6b/dOC1E/A4P44sdsB4lEYr9GjagjCELM6g2pSP/ZvMn4+Pbw8N8uWL7K2mp
         E/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxwC+65B2qmJhVIrdieQTegVpc1FeSZd/tKCnfS/pCw=;
        b=mi1IJMGvt4XAOyD36WITikpJcfC/Sc/TMSBKrtx1FURlAZeL4MV4Uvf4u6tCY6H+TE
         2raBuORZ5WphKNaypAXjOf0KyjqJ6M2qheXA8/SR5pZVx6Hn/WYUEACO7pAIMoCt4FkH
         lfCesen+Cy0Ja7RXZ7BfZcRWHSot72Naj/padsqFHMK9+Z3eSS32S5UPkSfBjPDpp62p
         TrSrxelEBa4oHqYp6FJ91mtgme37IvxZrCUgCFtF4h5capvhdlQdrBqdSF00ziKZmW5N
         I6a0XADUOkod1HAba2XbX7m/06HWEISsSoovOV5LfxWiG2Jyhr4HoFegfhKtTdDwxDtI
         CVzQ==
X-Gm-Message-State: AJcUukfQNhfHTu+yvQAareZbpA2tqO374KoEqjJIBkG94xp8lyy7WX/5
        aG+TsyJWJke+ac1/LYFy4Ep9abbbD2GnofEQuivqnwVr
X-Google-Smtp-Source: ALg8bN4za75Aj+VwA5Dhy6+0IT59ANhaWnNj1SbhLR2txqN/lwKjgreFaq0aKzA0nxXrUiuPTCqEGiye1LULOLioLXk=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr7775097plg.314.1548357366159;
 Thu, 24 Jan 2019 11:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20190124175702.4801-1-okaya@kernel.org> <20190124175702.4801-2-okaya@kernel.org>
In-Reply-To: <20190124175702.4801-2-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 21:15:54 +0200
Message-ID: <CAHp75VdbEVUvf1+ySY=J02op-EbqSCkzegGfoO3RXmBRO-63hQ@mail.gmail.com>
Subject: Re: [for next][PATCH v2 2/2] platform/x86: Fix unmet dependency
 warning for SAMSUNG_Q10
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 7:57 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
> warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
>
> SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
> depends on BACKLIGHT_LCD_SUPPORT.
>
> Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:
>
> WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
>   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
>   Selected by [y]:
>   - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Thanks for the fix.
One comment below though.

>  config SAMSUNG_Q10
>         tristate "Samsung Q10 Extras"
> -       depends on ACPI

> +       depends on ACPI && BACKLIGHT_LCD_SUPPORT

I would like rather see it on a separate line in both patches.

Rafael, you may take it if it feels comfortable.

>         select BACKLIGHT_CLASS_DEVICE
>         ---help---
>           This driver provides support for backlight control on Samsung Q10
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
