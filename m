Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484CAC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4B720663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O2Vjty5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4B720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392434AbeKWIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:47:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35226 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:47:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so9154419otj.2;
        Thu, 22 Nov 2018 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87dZb+9jEcoiev0n2CALEMFgjSHtgBJlbdWqSwTcOxA=;
        b=O2Vjty5uGDQGeuR+y4citPzMCzHq8veUhIZgR0KfUSA2KJcm0imFBi9MuMzQQrKYiZ
         QGCVSlNkaD+Wrfbm03HrzBMIp384tOknQRkLwbsq8OeUUSx5NJonl5AOd4cK1wYvzJ15
         8XNe18JqvyLBZDgfskCdW8SAybbsMlJvyyHw/PqxRRxngYn8rdiiRImDDNhZSTS2feS0
         zv06UQwbfeG3hfH3094RCLDAZR77yQr0V5POcHocEej/3b5AS/OQyBBGNEUODwkEIS8U
         PQJQOg6QjqCNi50KNjffmUtCM7miC6cAcb5MAsC/KRHww6HstOLhEqJsC7yM7cd6nq21
         TUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87dZb+9jEcoiev0n2CALEMFgjSHtgBJlbdWqSwTcOxA=;
        b=VS7CjX8i2DeqINOsY7Fl5GwWDZAkgSbbK3Hyuj2JbE+kSsschIhrOvkS5gcp9dL9dF
         lYASt+iLkwAaryVqUMKh9TTQAAx7zByK5c2JQQKgAJfhP/dXLO+zq/0VzExXg2lfiYzO
         QEm0lAdhUWWhLgsKebfwl7WQKEJe8OminlZy02bwPt6Bs7rI8hf0ST48y7muOAJA4QYS
         AS23RhgxCJ9JSgEJFOpgWFo+xEfuDSxCg76BB+m/8Fud8m0ly8NFbM/CvOL5f8l1oIP+
         K2+H6rjuJoczh1mnCN6zTDbzhj6a34AvZRX9D1WHpDSa1ms+pMKYQc2QuzjHDg1n8r0t
         gBkA==
X-Gm-Message-State: AA+aEWbZT37BuMsDInaD95A9d4FmXGP2Jk36U7SjWPE4/Zpm514p7Rj0
        D2OmzYoKUvLVfcxSWrmeQ80ADnmA2bplmcrq0Zk=
X-Google-Smtp-Source: AFSGD/WmZUcTsdUv7ZP6DaVIZVGALQ9vIW38y1sqpu+UyALDphimwAxUAQzR4ecP7V+1n/OV7pnKCPR6fUomKxnCUB0=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr7561869otj.148.1542924359389;
 Thu, 22 Nov 2018 14:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20181121111922.1277-1-narmstrong@baylibre.com>
 <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com> <5e87ffda-4a38-f45b-00c4-6b73dc721656@baylibre.com>
In-Reply-To: <5e87ffda-4a38-f45b-00c4-6b73dc721656@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Nov 2018 23:05:48 +0100
Message-ID: <CAFBinCCjmw=8ESk0tztWszXnuA4aqWqC8_wdpvMtSYfwZ-KT=A@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Nov 22, 2018 at 9:26 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Martin,
>
> On 21/11/2018 22:53, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Wed, Nov 21, 2018 at 12:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> The GXL Documentation specifies 12 bits for the Fractional bit field,
> >> bit the last bits have a different purpose that we cannot handle right
> >> now, so update the bitwidth to have correct fractional calculations.
> > I assume you have more accurate documentation than what's available publicly:
> > - the S805 datasheet doesn't have any documentation for this register at all
> > - the S905 datasheet states that HHI_HDMI_PLL_CNTL2[11:0] are DIV_FRAC
> > - the S905X and S912 datasheets state that SDMNC_POWER is at
> > HHI_HDMI_PLL_CNTL2[6:0], SDMNC_ULMS is at HHI_HDMI_PLL_CNTL2[9:7] and
> > SSC_DEP_SEL is at HHI_HDMI_PLL_CNTL2[13:10]
> > - the S905X and S912 datasheets state that HHI_HDMI_PLL_CNTL1[11:0] are DIV_FRAC
>
> On S905, the HHI_HDMI_PLL_CNTL2 is at address 0xc9 << 2, but on S905X/S905D/S912 the
> equivalent register at same address is named HHI_HDMI_PLL_CNTL1.
>
> They changed the numbering of registers between these 2 SoCs, but the register
> content and addresses are similar for m/n/frac/reset.
I totally missed that - thanks for the explanation!

> >
> > can you confirm that the public S905X and S912 documentation is wrong
> > and that the .frac field is really part of HHI_HDMI_PLL_CNTL2 instead
> > of HHI_HDMI_PLL_CNTL1?
>
> Is is part of HHI_HDMI_PLL_CNTL1 but at address of S905 HHI_HDMI_PLL_CNTL2.
>
> When jerome pushed the PLL support earlier, he added a comment.
> I simply forgot to put it back when I added back the GXL HDMI PLL DCO.
I'm curious: do you know whether the fractional divider field on
Meson8b is 10 or 12 bits wide?

if you can add a short note about the naming confusion to the patch
description when applying the patch:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
