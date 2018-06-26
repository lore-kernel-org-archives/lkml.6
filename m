Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CBE26EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBA3OAfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CBE26EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeFZRdC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:33:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46632 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933725AbeFZRdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:33:00 -0400
Received: by mail-vk0-f66.google.com with SMTP id b134-v6so10507626vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UdDRwFmMDUOnDwaupmQenmlv8uEaGiogNe4SN/eVWyE=;
        b=YBA3OAfQFDxSfhUNR1P0gKWT+msBlYBA/FGjSsNRY0OkOqAfNPfX0FvP5ln4YG6jew
         Q36/baqqE1Uv8asaUTU4o78iMFGB5pOMs7yPXy9KoH596jDQYEM/k5pUUCUwoGhRVrPY
         RZLdITQ3DoP0hJi9AAn0X+rbRqg+xaqzZ0YgYeLkTaEndtORh5Uj5f0Sp5S/TfmEeBFG
         GD6BkP1YGxq2l/2ioIZiSyDfSBp/3APAFUBuB9GmX6aL5rPi1vff7TX7xQZFWmSVOyvK
         33DBbXJ1vLJfoKADv2NAeAz3/O8fa/IRyP1UsyygmhLx4ZRpTUqPd+e8dz9YsTPvb+mB
         CY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UdDRwFmMDUOnDwaupmQenmlv8uEaGiogNe4SN/eVWyE=;
        b=FdJLFKFNl0AcbRceBYdiCYxRfO6sTnTa3OHZS1ALIRaJp4NyeLLI/oS04GQqTV23Nb
         kunVvedmnqvDNoZeW1xibv6M0C6GrlSPaOvRgFUcGb8Y/IJ4hfOOQuXUFcLHcAHNklB7
         lha5OB4k0q9h9RKYzeqAhTfKYbVsMM8XpzGKWtvU5IFDE+D+cFaR6yeGj/RV0fuuc7fk
         SII2tGvTo+X1iOL+Ulo7/XLu81E74DkCuJX1gqB4QPpEoD0efIuAepup/9KKbzDAuVt6
         tzKPxCoa7gVPCaCjdqcWNH1Fj30iOBqSSITTG4scK/6Upj2xsTavuXTYaqcRUOC+256x
         yeLw==
X-Gm-Message-State: APt69E3vdj7ihJUHJN3y7wGjOxeR4rKA231O0n2zzhm2GFzuxtTdnd2t
        Wx0dLw3GxysBcNQyD84BxhGU+grezYArIt4wgT8=
X-Google-Smtp-Source: AAOMgpfsX/nUIYnqpRsFdnv6/q6VEguOSmZ6ZCwS7R5cEHhfnWA87uus9d5QmS6ge9PAWHuJgyTSzSx/Z/kUsEV5aaQ=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr1554590vkd.187.1530034379864;
 Tue, 26 Jun 2018 10:32:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:32:59
 -0700 (PDT)
In-Reply-To: <20180626081409.9518-3-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com> <20180626081409.9518-3-straube.linux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:32:59 +0300
Message-ID: <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
<straube.linux@gmail.com> wrote:
> Use ether_addr_copy() instead of memcpy() to copy the mac address.
>

Suggested-by ?

Btw, ensure that the source and destination buffers are aligned to u16
as required by API.

(It applies to all changes to ether_*addr_*() replacements)

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 7aa00d1391f7..8af4a89e632f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1172,15 +1172,15 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>                 for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
>                         mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
>                 }
> -               memcpy(mac_addr, mac, ETH_ALEN);
> +               ether_addr_copy(mac_addr, mac);
>         } else{ /*      Use the mac address stored in the Efuse */
> -               memcpy(mac, mac_addr, ETH_ALEN);
> +               ether_addr_copy(mac, mac_addr);
>         }
>
>         if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
>                 if ((addr = of_get_property(np, "local-mac-address", &len)) &&
>                     len == ETH_ALEN) {
> -                       memcpy(mac_addr, addr, ETH_ALEN);
> +                       ether_addr_copy(mac_addr, addr);
>                 } else {
>                         eth_random_addr(mac_addr);
>                         DBG_871X("MAC Address from efuse error, assign random one !!!\n");
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
