Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6661C208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6661C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbeGIHnQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:43:16 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34209 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754388AbeGIHnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:43:15 -0400
Received: by mail-vk0-f68.google.com with SMTP id l143-v6so2564156vke.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8KcOnk8z8iDcjJf5wJRgndUVSeiQ9gbTkIL3U/RT6M=;
        b=FuFrEIPkC9sGCzh2/kixh5u8EIORJlrpIEVj7RjhYdxfTWpXKNDJ46x/CunKFNm7M9
         kHYnRK6MbHtdvwdmdGubw3+hr0Kx8w4i1yo2MRPXCEI8vQBrNrPoUVvjZXEiS40sWnt+
         kmif10fXdNv2ARtOcTsJmhS4Dhn5JOGWejrvyN9hYRLGTthA79PRz6rN1Vpr43mQOdzO
         w6AhaxF7osYS26lvqPedv89ZYhKTuAStEwEERVP+gz9hOmPm8WnaSbintVQ0yLAA/h8L
         Jq89liahlsrK3M6c3RRkugMlzATauLBqbgMWdkCRLxhoqqMg6JgM9qrilp7CEI00LCdm
         Mxsw==
X-Gm-Message-State: APt69E0B9IYYTDIGZbaNpi0ri7wuX9Y4JoGok3hI5w7h8MnyGTI1Hc1X
        KnQd4L2bnQt6LwzTJ+betcImuKiNG6cYZg6+6Uwt4MIZ
X-Google-Smtp-Source: AAOMgpe/g6T7YeOFbH8bPgocKEC2Meef8Ak3MoRD7A9PeOfWCCeh41z1mKBWM4p+mVmIk7nJxlLylz1h0wRHpJDcAII=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr10814856vkh.125.1531122194163;
 Mon, 09 Jul 2018 00:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180709073454.12509-1-geert@linux-m68k.org>
In-Reply-To: <20180709073454.12509-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 09:43:03 +0200
Message-ID: <CAMuHMdUKxMYyqMDnBdeee_L2CKA0Jo=Z=Hs9mirMVYcfKF_WxQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 9:37 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc4[1] to v4.18-rc3[3], the summaries are:
>   - build errors: +17/-0

  + error: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko]
undefined!:  => N/A

arm64-allmodconfig (__sync_icache_dcache() needs an EXPORT_SYMBOL_GPL?)

  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
direct-io.c: undefined reference to `__ashldi3':  => .text+0x1858)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mballoc.c: undefined reference to `__ashrdi3':  => .text+0x1bc2)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
mmio.c: undefined reference to `__lshrdi3':  => .init.text+0x60)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
super.c: undefined reference to `__ashrdi3':  => .text+0x6504)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
tcp_ipv4.c: undefined reference to `__ashldi3':  => .text+0x25ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__ashldi3':  =>
.init.text+0x1ac)
  + error: /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/nds32le-linux/bin/nds32le-linux-ld:
timekeeping.c: undefined reference to `__lshrdi3':  =>
.init.text+0x1f0), .init.text+0x1ec)
  + error: direct-io.c: undefined reference to `__ashldi3':  =>
.text+0x16a0), .text+0x16a4), .text+0x185c)
  + error: mballoc.c: undefined reference to `__ashldi3':  =>
.text+0x1c46), .text+0x1c70), .text+0x1c4a), .text+0x1c6c)
  + error: mballoc.c: undefined reference to `__ashrdi3':  =>
.text+0x1c0e), .text+0x1c12), .text+0x1bbe)
  + error: mmio.c: undefined reference to `__lshrdi3':  => .init.text+0x5c)
  + error: super.c: undefined reference to `__ashldi3':  =>
.text+0x7fe0), .text+0x7fe4)
  + error: super.c: undefined reference to `__ashrdi3':  => .text+0x6500)
  + error: super.c: undefined reference to `__lshrdi3':  =>
.text+0x7e38), .text+0x7e34)
  + error: tcp_ipv4.c: undefined reference to `__ashldi3':  => .text+0x25a8)
  + error: timekeeping.c: undefined reference to `__ashldi3':  =>
.init.text+0x1a8)

  nds32le/nds32-defconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/1e4b044d22517cae7047c99038abb444423243ca/ (232 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/021c91791a5e7e85c567452f1be3e4c2c6cb6063/ (231 out of 244 configs)Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
