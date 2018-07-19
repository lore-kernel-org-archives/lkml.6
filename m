Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbeGSPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:47:22 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38273 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:47:22 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so4533779vkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eGgboGyndLCLMaknkrN5sWw1Ff4hPy5x5eRlVHDl9k=;
        b=tXEu0snf/0zlbiFWxFmaVsGWis1twLrUzvcvRhUbbJkcGZCxtRjl45JsUQ71sNsXvU
         YkBBp+QzY4/2DKDiB/zfdqUAaC158LNftZpVm0A0aYSkWQDmmRXx2cg1Mev+fVXoGWsD
         R9Hnkrxlgwy7wj/qtYVwV7wV2aqUvb3/BZADVGzWQvicQfKu/bVLmwRmgpq8KWkuAPCH
         O4f1DPYnnANwGWW603oLRdukzdIz4ea1f3R4jQUOzch/Pqg3pBBUpDvvP+iWIShaN2j3
         YNIiwCKeYwfBf8vuxMpm4rMGl3sf8EtOInzEINGWyFtHYzyYatOzGCkWKIPyBNpzs6gO
         Rw3g==
X-Gm-Message-State: AOUpUlE4VDl2jyiICLmn8dAl6KWAq1mRarHbAPdibZgdwJYlXwSi2kD4
        CBRP7eRVbSVr0faFCJIRgX04mMaN4hdWt/1gdE4=
X-Google-Smtp-Source: AAOMgpe88/v6IkJA3f0VzQg25pT+E2qkrCU/zWcdQ7oHtslza0JFza+XhX9CJsc4gU5sFChNCuOiOJ0OHYRFpdMMoA0=
X-Received: by 2002:a1f:6b11:: with SMTP id g17-v6mr6069718vkc.82.1532012626364;
 Thu, 19 Jul 2018 08:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180718145254.4770-1-geert+renesas@glider.be> <CAK8P3a19tFrP7ymiMHcmQ9Jah4_zTwuoM3=KN+WQROiZ36ArPA@mail.gmail.com>
In-Reply-To: <CAK8P3a19tFrP7ymiMHcmQ9Jah4_zTwuoM3=KN+WQROiZ36ArPA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Jul 2018 17:03:34 +0200
Message-ID: <CAMuHMdWCjr__9QB-wSiuo7ZZnOc9PuCRLJU=cVTrfvywJh5eBg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jul 19, 2018 at 4:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On a related note, I've looked through all files in the kernel, and found
> that very file files in there are something other than 7-bit ASCII, UTF-8
> or non-text files (according to /usr/bin/file). These are the only ones I found:
>
> Documentation/devicetree/bindings/net/nfc/pn544.txt: ISO-8859 text
> arch/arm/boot/dts/sun4i-a10-inet97fv2.dts:           C source, ISO-8859 text
> arch/arm/crypto/sha256_glue.c:                       C source, ISO-8859 text
> arch/arm/crypto/sha256_neon_glue.c:                  C source, ISO-8859 text
> arch/m68k/hp300/hp300map.map:                        ISO-8859 text
> arch/s390/kernel/ebcdic.c:                           C source, Non-ISO
> extended-ASCII text
> drivers/crypto/vmx/ghashp8-ppc.pl:                   a /usr/bin/env
> perl script, ISO-8859 text executable
> drivers/iio/dac/ltc2632.c:                           C source, ISO-8859 text
> drivers/power/reset/ltc2952-poweroff.c:              C source, ISO-8859 text
> drivers/staging/rtl8188eu/include/odm.h:             C source, ISO-8859 text
> drivers/tty/vt/defkeymap.map:                        ISO-8859 text
> kernel/events/callchain.c:                           C source, ISO-8859 text
> lib/fonts/font_7x14.c:                               data
> lib/fonts/font_8x16.c:                               data
> lib/fonts/font_8x8.c:                                data
> lib/fonts/font_pearl_8x8.c:                          data
> net/netfilter/ipvs/Kconfig:                          ISO-8859 text
> net/netfilter/ipvs/ip_vs_mh.c:                       C source, ISO-8859 text
> tools/power/cpupower/po/de.po:                       GNU gettext
> message catalogue, ISO-8859 text
> tools/power/cpupower/po/fr.po:                       GNU gettext
> message catalogue, ISO-8859 text
>
> Almost all of those can be trivially converted using 'recode ISO-8859-1..UTF-8',
> which we should probably do. The four font files contain comments for each
> of the 256 characters, so that recode turns e.g. the <FF> character
> into <U+00FF>,
> which is probably still what we want here.
>
> The one exception seems to be arch/s390/kernel/ebcdic.c, which apparently
> uses 0x81 bytes as an excape before characters ISO-8859-1 characters with
> the high bit set. I don't know what that encoding is called, but I managed
> to manually convert it into something useful.

Yes, we should convert everything to UTF-8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
