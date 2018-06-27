Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D610EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD2D26679
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PGb92QmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD2D26679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeF0KDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:03:33 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39654 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbeF0KDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:03:31 -0400
Received: by mail-ot0-f193.google.com with SMTP id l15-v6so1560320oth.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0srfwN0HjukSUuQQOq7n28id9RMApexOKHgq6lGANuc=;
        b=PGb92QmSz5LTlxaxW9LWccF33gUhuEGWxB2xDNLI7u2ax5KfxZlPHvKksWXHiiGgpl
         auLMKYGSdChkc4yId7r3xUZV9SQ/FLnQfSD4t0uEvLvaLKyjSJkSaK6w+ktK8IBOt5uS
         fniofcEMDCkBHsZdhlhZZdsqA56yTKFRmUTThMbzvSLbzpT0cseh+1ILRmF7sd2RMfnE
         lkwVnTRcwZBTlHiIAj71pPilss3XedNnWwAvNMrmB+Ho49APZjcyuL1UwvqYRgLk9vzL
         rVHRQRe0DppnPHioTncxd6O7bCM0+9GVZt9n3fpKTQfbBb68h/K1B8r0CKhzVuOXEicr
         jvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0srfwN0HjukSUuQQOq7n28id9RMApexOKHgq6lGANuc=;
        b=tetpjNEPIHynG40+2yv6LpQEqLqSymkAUyjikKFAH3x/xUUy+Y2WuHvKorfCjrlnv3
         2h9YXCt0A9sqVHzz3av3n/k8uH+6s92hWAW0PmXaKpX/Xps++28GIQEGPv4RNV1KNm2w
         Fip5bXq9mrAUqqwO6qXdzB5nWCZf6d0lhuaATHtJBEvRTAFCx/ZtnGQ4/PzOnq34+4DI
         IO3ONw2Kvstz3C2tTMcyQ59/bA7821403GCPPDh0VxFqM2MkR8MVbKnM3bfCowxjzdG4
         bF/bbdEcd5fs+X2BNGEIXqv9t9N/9Lw7TCeH1DU78C7PyqZqNFvfSU8jkK/2Zb3UyRIp
         ZxZg==
X-Gm-Message-State: APt69E2qH0xv5YY5F9AyzQy2xAK/6uWUjgswOJ2qzK1VHq7mVSzqCR56
        63gGd4sl6QBIDwtDXFngj+6w8zUCqNsbFqYArQq6nw==
X-Google-Smtp-Source: AAOMgpeh/AXyRS1FLSNwpYR4ifOk3pEusb45W+zMv+dlCgwjTk58mqnbVqI3hB0yZyhVUMVysYCt1E6QPei144saSl0=
X-Received: by 2002:a9d:458d:: with SMTP id x13-v6mr3172013ote.66.1530093811351;
 Wed, 27 Jun 2018 03:03:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 03:03:30
 -0700 (PDT)
In-Reply-To: <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
References: <20180626092537.6737-1-brgl@bgdev.pl> <20180626092537.6737-5-brgl@bgdev.pl>
 <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Jun 2018 12:03:30 +0200
Message-ID: <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-27 12:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want to be able to get the clock both from the board file by its
>> con_id and from the aemif driver by dev_id.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I see the DM365 and DM644x EVM board files getting reference to aemif
> clock using just the con_id, but don't see that for DM646x. Am I
> overlooking something?
>
> Thanks,
> Sekhar

It's being done indirectly from mach-davinci/aemif.c. I guess we can
remove it again after last patch.

Bart
