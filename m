Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8932C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D520873
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0D520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeGLHdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:33:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43867 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeGLHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:33:45 -0400
Received: by mail-ua0-f193.google.com with SMTP id x24-v6so17815321ual.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 00:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wauO80yeKxnRA3t7vNBrIwdhOvfUL5sRZ6lDoLeRqOU=;
        b=l3qpBSLS/fjFg68B+IUFU+KV5fjHhiPn/Ca8nt43a0dKgep6BLQm6RYlpxuL0H9Ptx
         JvHM1zMdLryic5gLY4IbnO6qHPGW54zeU9CAFxTFTDzOMQQ6v+zNQL9NA6B9m5pls2A1
         2gQEzdzyGaX8V50Fqw47AOsSElrkdMVDZNdkKPHn6b/qGua/P1XGMRuoIB8rWGaM7nW6
         j3dJUXu3yhdY1ba0h2r/Fz1Th05VkcK+F5mh9yNUtrwu1ip6kFhhKlGOp6QNPtxD6f8V
         qIVudLu/AsQj1wwSMB+BarJ3ZSTU22KAjd9VIycayzhdC+J2HXOWHeskjg8gDQwDp8Ki
         t9VA==
X-Gm-Message-State: AOUpUlG52TGwjplQj4MwUGOWQxq05LSZVn7neXC/kG42OhuLT5WmtqWa
        yhWcgjYkQFBn8md6pZaC52sgv66jnE+9KARETsA=
X-Google-Smtp-Source: AAOMgpcHyC6m00uPseBUXaunz7/NRd3Dxm95XASHkSiThJgDtVdcgD/iFn3QVoeyNOJykm+xaKLi7JQvzSl9ns5vCfs=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr632160uae.72.1531380327534;
 Thu, 12 Jul 2018 00:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180711142649.4556-1-geert+renesas@glider.be> <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
In-Reply-To: <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Jul 2018 09:25:15 +0200
Message-ID: <CAMuHMdXZ8D2a-=z69US1=KEkqkrkbFqrR-zf-Suo5uaPYhSZSA@mail.gmail.com>
Subject: Re: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi
 v4t/v5/v7 defconfigs
To:     Olof Johansson <olof@lixom.net>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Wed, Jul 11, 2018 at 11:46 PM Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jul 11, 2018 at 7:26 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This allows to derive the kernel flavor from the kernel version at
> > runtime.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I prefer not to have this go in -- this is extremely likely to creep
> into derivative configs and as such it would have no value (you can't
> be sure it's still the same config).

Fair enough. Unfortunately we cannot prevent that from happening :-(

> /proc/config.gz is the way to keep track of exactly what config you're
> running anyway, right?

Yes, in some convoluted and hard to identify way ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
