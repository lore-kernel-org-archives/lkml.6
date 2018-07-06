Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC2C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29E322545
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29E322545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeGFTjM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:39:12 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39837 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934548AbeGFTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:38:53 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so8208701uad.6;
        Fri, 06 Jul 2018 12:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOBjE9ay8eu7E1bZDA+vCsVIbntLghqIwzo/G/XXhLo=;
        b=hMhZFboc/js89TqhL16J9h7hwHXnT5ThTpc7nVkAAyeraOOgeFiru7ygqILM4jYKwn
         eX85/G3JsikjKUcCbkkHJoPeHtGyM0L6jjqeBq5H576rlPp6ZKvv6lOrAhEqm2VxBpd+
         STD7KnJcf4+mgo99LGS80vOGp1Q6dzxWUpKqlJKTVk8qJMT6Iuzq/C/LF1ccLRJAQW23
         BvKwc7Wf5S7vrGyzs7thnWrewFNOvOD768eYZBeH6z53TZNG5xKYDrb9k82H99QZnmtf
         uW7mUGmRs+QM1DdClZ1rH8mHWLhfTQycFJ7zw4cZJn/o6gAjbASprx6qBfYIIcD/qUUU
         6+aw==
X-Gm-Message-State: APt69E1thfscxJfQ4WOnWhPJ6bGYgEI11llrwq0Ejh4xBHaGxXGm+Oi9
        LMJ2+VLpvivZViBdiUWocyb0BNlz1Tnfo+Se2Ys=
X-Google-Smtp-Source: AAOMgpf2wwk8H+disFsmrbiH7/skVcnY6ixpBATPH7qr4i5AjrS46AdOnYugLatIDoJ30dLcwTh6DyP3v/UTggCzGbg=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr4012361uad.12.1530905932492;
 Fri, 06 Jul 2018 12:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180706130220.21957-1-benjamin.gaignard@st.com>
In-Reply-To: <20180706130220.21957-1-benjamin.gaignard@st.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 21:38:40 +0200
Message-ID: <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
Subject: Re: [PATCH] dma: stm32: replace "%p" with "%pK"
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Jul 6, 2018 at 3:03 PM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

Still? Isn't the value randomized these days?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
