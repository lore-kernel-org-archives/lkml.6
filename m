Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C51C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99DC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIYEr3Ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99DC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeHaUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:53:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44962 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:53:41 -0400
Received: by mail-qt0-f193.google.com with SMTP id k38-v6so15212992qtk.11;
        Fri, 31 Aug 2018 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNABGCfUpq+twrrudbVaR6VIWYKXET0UXf8W5VdDxdU=;
        b=sIYEr3HoNnKl476GyQSn3JsRhI0MZtnxg6vmQUehjF6Ug96BvAF0Bdhh3mb9nh8oeI
         UES2weUpSNhYxQ0pAZ5oWSo+mfW2nINkfoYN6tRIdnhT44fA5L8ZCSuWfk6UXlWBQUEy
         W0EJ5L8zor40oIUgixAsMg4NhOl/5D3YBjoZEZns0adAqeCakhrftHgxZnN2qGQRh3h2
         4fUiLEbaaI7OKoomtx4LSX/1G8N0yfDmLmbnbgTnOH78n6vHFURJhFRbX7DSoLyopWsK
         tQxfXsu0MT2qKF6eKozF1hgV73xteyfWSLMFleeGzLwuHf6eBDfKUgHHnMPIjBq3kj/Y
         cMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNABGCfUpq+twrrudbVaR6VIWYKXET0UXf8W5VdDxdU=;
        b=ghWguub+HLS/jEmFSd1GG4AGgVMPstMGv0pr5NxrtEEm7aldgjGSqfja7+BN+DsFQ9
         CCiJC0av2VHkwMjFNffNjw0NiprUZbvezd5Hsa2Cm1tkw7Pdm0SA4ys87wzSTfQol70b
         XutjFtnl5eZ1YE2nCFKgWuJifl3udAUNYoL8YPRbKU+7qYwPwT/zGeUjwy6ON/RUP1OH
         Q5u44HmeqBlKf/6pPgAplVsYboyJL+nSnDlANpNmLz8wKfzs8dRUi9agKn1LnKMoL6CI
         g6IEeBlV73xhh7biyQCgPsd2ZeKiEYLAnN2AMPBIn3xnVb6zhtyseRX1XkN9Haf0Z6PM
         SYeg==
X-Gm-Message-State: APzg51DFRRSl0uUToqhbiGtwjzFX7dK2hOWmZ5CgWjzseL2EaMgDllHw
        ak+lGQHUM+xERUZ0e2PUN6tPm2Z7keGuwx4/l29whE7/
X-Google-Smtp-Source: ANB0VdbRDf8W0OZvR8xOfLUoNG+T3sYSaAvKoymF4fGHurknFfmaQMieIepCRPHoTrnJBlp82w+bpcilVsENUlC/WN4=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr17002233qtd.101.1535733919498;
 Fri, 31 Aug 2018 09:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180831130356.6b0fd971@canb.auug.org.au> <fe65a78f-51fb-248a-565a-f21594caa957@infradead.org>
In-Reply-To: <fe65a78f-51fb-248a-565a-f21594caa957@infradead.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 31 Aug 2018 09:36:15 -0700
Message-ID: <CAJYdmeMYT_L841XsUOYYepen7WOSp-6zU40QbRy97G5GPzAygg@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 31 (nixge.c and phy)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy, Dave,

On Fri, Aug 31, 2018 at 8:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 08/30/2018 08:03 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20180830:
> >
>
> on i386:
>
> WARNING: unmet direct dependencies detected for OF_MDIO
>   Depends on [n]: OF [=n] && PHYLIB [=y]
>   Selected by [y]:
>   - NI_XGE_MANAGEMENT_ENET [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_NI [=y] && HAS_IOMEM [=y] && HAS_DMA [=y]
>
> WARNING: unmet direct dependencies detected for OF_MDIO
>   Depends on [n]: OF [=n] && PHYLIB [=y]
>   Selected by [y]:
>   - NI_XGE_MANAGEMENT_ENET [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_NI [=y] && HAS_IOMEM [=y] && HAS_DMA [=y]
>
> drivers/net/phy/mdio-gpio.o: In function `mdio_gpio_probe':
> mdio-gpio.c:(.text+0x294): undefined reference to `of_mdiobus_register'
> drivers/net/phy/mdio-hisi-femac.o: In function `hisi_femac_mdio_probe':
> mdio-hisi-femac.c:(.text+0x352): undefined reference to `of_mdiobus_register'
> drivers/net/ethernet/ni/nixge.o: In function `nixge_probe':
> nixge.c:(.text+0x1357): undefined reference to `of_mdiobus_register'
> drivers/net/ethernet/ni/nixge.o: In function `nixge_open':
> nixge.c:(.text+0x21e9): undefined reference to `of_phy_connect'
> drivers/net/usb/lan78xx.o: In function `lan78xx_probe':
> lan78xx.c:(.text+0x5e29): undefined reference to `of_mdiobus_register'
> /home/rdunlap/lnx/next/linux-next-20180831/Makefile:1035: recipe for target 'vmlinux' failed
>
>
> Full randconfig file is attached.
>
>
> --
> ~Randy

Would:

diff --git a/drivers/net/ethernet/ni/Kconfig b/drivers/net/ethernet/ni/Kconfig
index 04e315704f71..83b6922767af 100644
--- a/drivers/net/ethernet/ni/Kconfig
+++ b/drivers/net/ethernet/ni/Kconfig
@@ -20,7 +20,6 @@ config NI_XGE_MANAGEMENT_ENET
        tristate "National Instruments XGE management enet support"
        depends on HAS_IOMEM && HAS_DMA
        select PHYLIB
-       select OF_MDIO
        help
          Simple LAN device for debug or management purposes. Can
          support either 10G or 1G PHYs via SFP+ ports.


be the right solution? I did a quick build-test with the configuration
above and it seems to fix the issue.
Do I submit a follow-up patch to Dave?

Thanks,

Moritz
