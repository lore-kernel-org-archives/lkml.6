Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550F220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXtdIJUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550F220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFTNPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:15:48 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39032 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754055AbeFTNPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:15:34 -0400
Received: by mail-vk0-f68.google.com with SMTP id r83-v6so1907212vkf.6;
        Wed, 20 Jun 2018 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SdzhVU+/385edT4mLOyG72TpiSFn2kiuXxwKCUjXTNo=;
        b=AXtdIJUar/Fa/LyTjWXiOCFy0yWYpPi1qgSM3MUU++Bwr0UIhj/0Bbfsl20YpTjBxC
         +vfntv4X0v5UcYAYp011rqWr5PHjAAR50h03dvBCOwixcU0yvUwQgv2c4xuhUk1TXnqu
         X6+oIymnLPkDR0a2ncTSEI8DzbtXRs/1uAOAcyQhnmD735jjKNnXbugr366iRY5jrzfb
         KZWavfo6yhtg+TkxHcjsRBZ6oCo+ekfEndQMNg00GiCdZOwe/hBu9GtCzROM0qW+CjLS
         k3dUkZVnHvCuuVUvMF2qaOG674uxuLNOb91Is9X0tjCqBQhKLFzOHAYgTz19zwSe8CYb
         s5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SdzhVU+/385edT4mLOyG72TpiSFn2kiuXxwKCUjXTNo=;
        b=sL2GhkNYBosVHfl9DnyxKggzQNnb8NpIKLkGlN2YYbFELsEFkeaPHR5xMrLcYbJ5ff
         Se5pmTOcNm89r4MKNfzisL94bKbeVE/xoYMN1jH8CDf+NGUaNhbDbA3sS/sytuPfzZ9c
         lQu5EwEvnbeTyDxpgNgUCsdXBfPQQRkBeig1NWU7FHwvORogYRgMZB676evQrgp0Fjgh
         ZlFdyvH01Q4SXDetKR0MKwQtQVbnYAjEPVMZR6cZ+mcH2W/vYrkIhTHYrhpuQ1dQbuLO
         wzetg08dHO4twNzorkq3ZWgp44KM8flJk3gi855TV3FOc87/T70enp4VzSGFtdhngP2t
         tJIw==
X-Gm-Message-State: APt69E3eVZV4qd2CqQXURoa7O4EJX41ZY+SskeAuRX1ZXhxtdxv+2++d
        ekzJpt9tNguOSr+DloiCNBkQ7zRUWRlXnhR3vOUrx71e9Pc=
X-Google-Smtp-Source: ADUXVKK8f/rzBqb0qyTAvJNi6bL9cjX7+bhhJQdowvludnyF4G9bM8y+R3CAR9O5UoWKDkmtCOwGoRqdw04o5VGpqQY=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr12440406vke.176.1529500533343;
 Wed, 20 Jun 2018 06:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 06:15:32
 -0700 (PDT)
In-Reply-To: <20180530090633.GA15390@panicking>
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
 <5B0D1C9E.4000800@broadcom.com> <20180530090633.GA15390@panicking>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jun 2018 16:15:32 +0300
Message-ID: <CAHp75VfZoUV7u5JhquPrfE8qMWH8dv4WBaSvsy9H0DOS6vW6BA@mail.gmail.com>
Subject: Re: [PATCH V2] brcmfmac: stop watchdog before detach and free everything
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list@cypress.com, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:06 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Using built-in in kernel image without a firmware in filesystem
> or in the kernel image can lead to a kernel NULL pointer deference.
> Watchdog need to be stopped in brcmf_sdio_remove
>
> The system is going down NOW!
> [ 1348.110759] Unable to handle kernel NULL pointer dereference at virtual address 000002f8
> Sent SIGTERM to all processes
> [ 1348.121412] Mem abort info:
> [ 1348.126962]   ESR = 0x96000004
> [ 1348.130023]   Exception class = DABT (current EL), IL = 32 bits
> [ 1348.135948]   SET = 0, FnV = 0
> [ 1348.138997]   EA = 0, S1PTW = 0
> [ 1348.142154] Data abort info:
> [ 1348.145045]   ISV = 0, ISS = 0x00000004
> [ 1348.148884]   CM = 0, WnR = 0
> [ 1348.151861] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [ 1348.158475] [00000000000002f8] pgd=0000000000000000
> [ 1348.163364] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [ 1348.168927] Modules linked in: ipv6
> [ 1348.172421] CPU: 3 PID: 1421 Comm: brcmf_wdog/mmc0 Not tainted 4.17.0-rc5-next-20180517 #18
> [ 1348.180757] Hardware name: Amarula A64-Relic (DT)
> [ 1348.185455] pstate: 60000005 (nZCv daif -PAN -UAO)
> [ 1348.190251] pc : brcmf_sdiod_freezer_count+0x0/0x20
> [ 1348.195124] lr : brcmf_sdio_watchdog_thread+0x64/0x290
> [ 1348.200253] sp : ffff00000b85be30
> [ 1348.203561] x29: ffff00000b85be30 x28: 0000000000000000
> [ 1348.208868] x27: ffff00000b6cb918 x26: ffff80003b990638
> [ 1348.214176] x25: ffff0000087b1a20 x24: ffff80003b94f800
> [ 1348.219483] x23: ffff000008e620c8 x22: ffff000008f0b660
> [ 1348.224790] x21: ffff000008c6a858 x20: 00000000fffffe00
> [ 1348.230097] x19: ffff80003b94f800 x18: 0000000000000001
> [ 1348.235404] x17: 0000ffffab2e8a74 x16: ffff0000080d7de8
> [ 1348.240711] x15: 0000000000000000 x14: 0000000000000400
> [ 1348.246018] x13: 0000000000000400 x12: 0000000000000001
> [ 1348.251324] x11: 00000000000002c4 x10: 0000000000000a10
> [ 1348.256631] x9 : ffff00000b85bc40 x8 : ffff80003be11870
> [ 1348.261937] x7 : ffff80003dfc7308 x6 : 000000078ff08b55
> [ 1348.267243] x5 : 00000139e1058400 x4 : 0000000000000000
> [ 1348.272550] x3 : dead000000000100 x2 : 958f2788d6618100
> [ 1348.277856] x1 : 00000000fffffe00 x0 : 0000000000000000
>

It was a 100% (or so) reproducible on Intel Edison with vanilla kernel
and linux-firmware package, while calibration file (*.txt) is not in
distribution.

The system is going down NOW!
Sent SIGTERM to all processes
[  118.695900] PGD 800000003bc3f067 P4D 800000003bc3f067 PUD 3bc5b067 PMD 0
[  118.695935] Oops: 0002 [#1] SMP PTI
[  118.711905] CPU: 1 PID: 1255 Comm: brcmf_wdog/mmc2 Not tainted
4.18.0-rc1-next-20180618+ #59
[  118.720354] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
BIOS 542 2015.01.21:18.19.48
[  118.729181] RIP: 0010:brcmf_sdiod_freezer_count+0x7/0x10 [brcmfmac]

After this patch applied problem was gone

Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Sorry it took a bit longer.

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 412a05b..061f69d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4294,6 +4294,13 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
>         brcmf_dbg(TRACE, "Enter\n");
>
>         if (bus) {
> +               /* Stop watchdog task */
> +               if (bus->watchdog_tsk) {
> +                       send_sig(SIGTERM, bus->watchdog_tsk, 1);
> +                       kthread_stop(bus->watchdog_tsk);
> +                       bus->watchdog_tsk = NULL;
> +               }
> +
>                 /* De-register interrupt handler */
>                 brcmf_sdiod_intr_unregister(bus->sdiodev);
>
> --
> 2.7.4



-- 
With Best Regards,
Andy Shevchenko
