Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B118C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLKL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:26:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34668 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLKL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:26:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id y14so3299314vkd.1;
        Tue, 11 Dec 2018 03:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf/xfMLnPgwfdBxQ4RuQti2tz7jqx0xRV3g44stcn08=;
        b=EJYZ1PVCpb/bcqt0GC5MgORM44wzZIYIvbGKr5RMK0reiuK4C/hd4PE9nlkblCKjO3
         OXk/AwhV1FxSfRDdMTxP9a+TB8ikjNIW+8JlmB5YXA8owY5Y4o2HZjr+PzfM0VxIwtNA
         qN0o7Nm8EMki6Zpca/Pub4ht+s3mrPa9fTAdjTUYwIbYzJqEKaSqB3VH13BjzgBTKQt3
         9J+YfL+jcChdorKOIIeEc/pMdB7pQ1JGFYTEY0opI7Kub/HFJyNs4I39OSe0Ml0RrkWf
         OFxAuZ0zkm3KBh+L8hxAm/czU0ryIXZ6KvsvonByk0wYThRlApG3FSTLdF3WkLV0LkvR
         chvg==
X-Gm-Message-State: AA+aEWYEWUtntfil4fTEH4y3TYVPiIDdXavn5mWknj1WRFVa0VIL8E1u
        HHRrt3MKph+Evj6QG/9gBvSGfEMOUrWheRwO6+Q=
X-Google-Smtp-Source: AFSGD/UHQs1zy9VFoF1TIVb6Z7dyhfGZi6LYpYu5LTPfY1/qTJFcQc11Frd5/y5mXeFy+BQF/xypd2jY+AWsTvUAH30=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr6969031vkd.74.1544527571326;
 Tue, 11 Dec 2018 03:26:11 -0800 (PST)
MIME-Version: 1.0
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com> <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 12:25:59 +0100
Message-ID: <CAMuHMdUcyzoMkiu-XaD5hM3uxhh+G3wMWWkVrFRNBkv5GbDGmA@mail.gmail.com>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files with
 double quotes
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
>
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
>
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
>
> Make it treewide consistent now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

>  arch/m68k/Kconfig            |  6 +++---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
