Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C59C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420F620870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="to5SNGx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfALIhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:37:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:37:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so7324892pgb.4;
        Sat, 12 Jan 2019 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5m+aNrUYSC4rSQdmuKQCdp7QvFw21AXRBfcsx1LdZ4=;
        b=to5SNGx9lwEg0Zp0kIO20cFqCM8ihVAoG6y7bjCYdQu8xpERXrY8vl85RMaH5V01Od
         PAI55YbbRT3c1WKOiEr6JXYDkHQbRFp+UhObYfsO/RVG6T3x49twY/nGODcn21x0ezMN
         5lUFY7Up/NZ4oKDTiEYMMgKY/xtXRNb2QlOkUvGeXPiGohCgKmMBVkGRn6x8+ROrCho6
         QYuZz5afKxu41H/1CyKqlgHwzOLcTe3FpLMZWI+C9O5Y4S/QLZokvG6rrRrMW/fjl/nM
         cJmnXLMvjFUqzfXMMLKF9dM3v098+cpTKdVSHfkGFWIsgH7QHuB2OKO8B8741kuJtQ+m
         iGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5m+aNrUYSC4rSQdmuKQCdp7QvFw21AXRBfcsx1LdZ4=;
        b=jFlbYQoAv9cKoFV48p/e3rgnE8V2wfjyCCLlGrvz559s+FRU3ohDkHmD3tbtwVyTA/
         QEeFEN98Wsrmsq4EOHEg5cBpDWO1eUe2Wyh/4dDcBoL7xoQ9eYrSuWX/aGL92Te5KxSG
         hkEmG+8IGwDgagyXwGd+/tolY6HTLOs9i/0jba4H5ggfVcbdSuZwdVN0ZCzRxmnw3N7s
         hOKpgLmH3vgVv2XBf1mxfAXlSdhUFk3mrNfqQHO39fPOth3y56ct8NPNl6by3a5+/LCn
         bTCRSyXCcWlCawspfWVSlnbN0hK6KszpzXL7axalilYghO3hHcAVLSTuDgggz7+9PeyY
         7pBQ==
X-Gm-Message-State: AJcUukdru80QaejJcZRuHU7W654/YSh2voS2hBDc4uQFK6S+MwWwC8+U
        xyYoeUo3qngaHkkCQHO4VvnqmNDAkIrygCfvM1w=
X-Google-Smtp-Source: ALg8bN4D1Zsd7+YSDzLLIaCWfnIyPxkuW+BaZp/6X6VpVPEb/iQvZ7jVWrk5jqygO5vaFqxLmFTt0GWGBZ9OrATOwDU=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr13904122pgh.265.1547282228557;
 Sat, 12 Jan 2019 00:37:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547257386.git.vilhelm.gray@gmail.com> <cca4dc59b4eb0a65fca8c6954059b71f305d28c9.1547257386.git.vilhelm.gray@gmail.com>
In-Reply-To: <cca4dc59b4eb0a65fca8c6954059b71f305d28c9.1547257386.git.vilhelm.gray@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Jan 2019 10:36:57 +0200
Message-ID: <CAHp75VftRq7ABe_0dABN=XjTSNjMTROgh2n0YNoGOai+C1xOjg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 3:47 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

> +unsigned int bitmap_get_value8(const unsigned long *const bitmap,
> +                              const unsigned int start);

Hmm... Shouldn't be returned value of type unsigned long for sake of
consistency?

> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region

> + * @value: the 8-bit value

Put the same warning here as you did in cover letter

> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap,
> +                      const unsigned long value,
> +                      const unsigned int start)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned int offset = start % BITS_PER_LONG;
> +       const unsigned long mask = GENMASK(7, offset);
> +
> +       bitmap[index] &= ~mask;
> +       bitmap[index] |= value << offset;
> +}


-- 
With Best Regards,
Andy Shevchenko
