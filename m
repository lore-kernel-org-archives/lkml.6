Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8324832
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C8324832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeGBOJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:09:54 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33080 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbeGBOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:09:52 -0400
Received: by mail-ua0-f196.google.com with SMTP id g18-v6so7412505uak.0;
        Mon, 02 Jul 2018 07:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFsFiUfEbRC88ucyi2zmEWvPPJY8J+COWuxLhXuD/V4=;
        b=ZVRt2BaviK72kwC/NLakDKe4dVK9HTsMByqch2zUPFPKrfjk9RsjiY2r3b3CC1ssYY
         iDJUMmuBEJa1ts8KIhGEx2tXpCRRM2OiFpU1wfiRgOzvs4HHqET0//I7azbEf69YOFWP
         6L9nLkO8Jjtu0PMF2o7LfW/9yFJiDAznJ001RUIh7FDnUxbiq8k2LYj2zSE58zmDZgLJ
         EMoDLsJpdCqKeWXZGiWJTMsyaHkA+b0i49YfGRa9HiM5M+bfVaBlHM4pL+gjvxMDSKTg
         0lfzUHeC7wJIJKwDhb8O8mCj480LDxJZgOFz0AF3C9gHsJuD0Tw7pn6Ca7MjfetNQhwS
         z9oQ==
X-Gm-Message-State: APt69E08V5AparmqOPxLBikALy/WA/6JcxooUlw3PuMqhcv4/g4QSA/C
        3fvLf6zPpYaij883iJYNBCp1B+3jLcp4JgY0ZZBteQ==
X-Google-Smtp-Source: AAOMgpdDPpPWW0ijziLIA/0q2IsoPoiJSMSKrpzy2Ys3DPROYV3Tz6FPUNzk90RoOzAzalXHt9QvvSgawi3AEArCxsQ=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr17001942uan.33.1530540591462;
 Mon, 02 Jul 2018 07:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180702140050.1660-1-geert@linux-m68k.org>
In-Reply-To: <20180702140050.1660-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 16:09:40 +0200
Message-ID: <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     sparclinux <sparclinux@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc3[1] to v4.18-rc2[3], the summaries are:
>   - build errors: +1/-7

  + /kisskb/src/include/linux/highmem.h: error: passing argument 1 of
'sparc_flush_page_to_ram' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 209:20, 233:36, 137:31

sparc64/sparc-allmodconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/021c91791a5e7e85c567452f1be3e4c2c6cb6063/ (231 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7daf201d7fe8334e2d2364d4e8ed3394ec9af819/ (231 out of 244 configs)

> *** WARNINGS ***
>
> [Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
> [Deleted 19308 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

Seems they're gone. Hopefully for good ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
