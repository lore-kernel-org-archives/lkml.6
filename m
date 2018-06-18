Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A64C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDA720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pklmfrK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDA720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935681AbeFRWCE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:02:04 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44339 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeFRWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:02:01 -0400
Received: by mail-vk0-f65.google.com with SMTP id x4-v6so10487767vkx.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kpt0o7lp2bnnKXKuQkrzYMfcBC1U5owj3U82ZrVQRrk=;
        b=pklmfrK4hIw8L0oxyRndz+x4SurknIV+gZ3/UZ9dib2J9asPJv328bWq/GzMj5zLB2
         nXs83nAQcNFTihEnRT054T9cFogR8D3uZOJ6ymORB7y/vlB9PkjC3V1TumADGJnbDRRI
         Q9YdISCBTySYxEhpHLJJFruG3d4iu9y5bfIuObGqjO6ePsKwoL7FhygFn0TO7zmHtcRc
         eVgcyvZq6Z1caNO0PZFvLFvg8ZVr8Ai4Cs1e462y48jW0F1CYs8ktVyldm33uMy8Kvjw
         iYHydpQMQPrDfDrPSWcRlA642/Z5Y46iTA1yYViBxfT6ZZxdQ+gnGbWx/SGn4SHhoht5
         HY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kpt0o7lp2bnnKXKuQkrzYMfcBC1U5owj3U82ZrVQRrk=;
        b=uaM+nRU+pW5L/mdONNPPW1Rw8p87R5t0/atF+X6Q16k1VvGWk9sig5jz5Z7r8UWSuT
         J5sjVm/V8r9tSnAsYwmX6AYpzy1TpRYF4ZowP2BMpfhbxV7LCmdHFDfQcebJbgcWL6t/
         cKcxBg4CciKBVKwcdvRk1RlPQDonNJonnagw67oTSa04VrEJqCnZ8Tb+g5ehoYA7wHSQ
         3wp9oSrCs0v+tGFdB350a4S1KZKjMMZ1dOFtGyKVdjGdrhKxVxZ+AMoHAJZtAXXFRysa
         ig5ArqP+/4Ra1L+eaqNsRYz12PqQcYsA5ozIfJg1Cb7yvLb2Hr2rGJnkV9s2EtADnAHa
         uDmQ==
X-Gm-Message-State: APt69E0i7gnS1VoDFj3pUAhE+TF67p784VuxbshxpZSziLZHCzhP9rNh
        Mn5XhRIt2OZ7A7ylaHiby35B+8xwVhPqyq61dPs=
X-Google-Smtp-Source: ADUXVKKMZWIz+BQY1CBW5RzAtytYMHJ6LW6slR25GBi0+ViMjd0niqap5uRZRM/ztgQg+cTFuHP3IS2cikecWd0+Q4Q=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr8154342vkd.15.1529359320164;
 Mon, 18 Jun 2018 15:02:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 15:01:59
 -0700 (PDT)
In-Reply-To: <20180617190706.14614-5-nicolas.pitre@linaro.org>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180617190706.14614-5-nicolas.pitre@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 01:01:59 +0300
Message-ID: <CAHp75VfG_4zw+NPuHTUyH-gzdktiCKVcnWcwo0D_fAgfPbdk+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vt: coherence validation code for the unicode
 screen buffer
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 10:07 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> Make sure the unicode screen buffer matches the video screen content.
> This is provided for debugging convenience and disabled by default.

> +#define VC_UNI_SCREEN_DEBUG 0

> +       if (!VC_UNI_SCREEN_DEBUG || !uniscr)
> +               return;

Hmm... Interesting. I would rather go with
#ifdef ..._DEBUG
...
#else
return;
#endif

It will relax requirement on how to define _DEBUG. I don't recall I
see something like you proposing in the kernel for the same purpose.

> +
> +       WARN_CONSOLE_UNLOCKED();
> +
> +       /*
> +        * Make sure our unicode screen translates into the same glyphs
> +        * as the actual screen. This is brutal indeed.
> +        */
> +       p = (unsigned short *)vc->vc_origin;
> +       mask = vc->vc_hi_font_mask | 0xff;
> +       for (y = 0; y < vc->vc_rows; y++) {
> +               char32_t *line = uniscr->lines[y];
> +               for (x = 0; x < vc->vc_cols; x++) {
> +                       u16 glyph = scr_readw(p++) & mask;
> +                       char32_t uc = line[x];
> +                       int tc = conv_uni_to_pc(vc, uc);
> +                       if (tc == -4)
> +                               tc = conv_uni_to_pc(vc, 0xfffd);
> +                       if (tc == -4)
> +                               tc = conv_uni_to_pc(vc, '?');
> +                       if (tc != glyph)

> +                               pr_notice("%s: mismatch at %d,%d: "
> +                                         "glyph=%#x tc=%#x\n", __func__,
> +                                         x, y, glyph, tc);

Don't split format string in printk(). checkpatch will not warn on longer lines.

> +               }
> +       }

-- 
With Best Regards,
Andy Shevchenko
