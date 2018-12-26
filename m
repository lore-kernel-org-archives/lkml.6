Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489E82171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoJn/rEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeLZSIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:08:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40094 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLZSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:08:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id z3so10041787vsf.7;
        Wed, 26 Dec 2018 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKTFa//wCjc7XatclXWOrhHW4XAoWiNw4tYt+0mr9n0=;
        b=DoJn/rEW3VgSqYrhoi+8MYIlazeKlLrgrI4rAshUGSy9r5O82WO1Zl62wEwwVbUcgg
         hxDx2AHQtPkYNKDl5/v++fahYXQC5M1Z8sDzudKl3n5vnR6LUT1b48pJ7QXirq//Ax72
         C0mv5qCzlDouUm8wZuZi4utD0IcsYBdiJThrolKiJpPrOF2LVanHmcW4PmqpkSPhReBl
         8YXVIRFMIW3KxoKUMFoGPSF7AzBI/avG/7BtNEK4HblSkVLik7gzudWefsBoObD4UrdQ
         skkhW4ARGbPLl2sbHYSsqjWKx9PdFLRjrBHN/MqHwrldLs8ffaF49NOy35ich8i0qRFL
         caLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKTFa//wCjc7XatclXWOrhHW4XAoWiNw4tYt+0mr9n0=;
        b=nKX6kUQ/fPXObwCE7PgQMB94NziwUrphxD0O57+0tDbkZzaVaYqms3GO5hvWLrorEH
         Dye/3pqiMoRrOdEJYRbRVWPyMY1U6zc4YDN/tY69dRircjlbb1/aIMVJMS+/KvbJfHgU
         LzkM4h+SBIs+XCnHD/8SZXGW8QLPu736lcUOmFDLWMu6ZgO8LdP4kF8b2Zi4TZQHSuLW
         bewMeKSkmt/EKIGJwlmIw3yaz8p0kK8FVvuSCevfFBu4kfcMfYxfukadHMsPTUhjONvU
         7327viktV5d0NPusgCkuF2T+Pwfe4JL0haM6SXt/+fr/vP9KKGPttNrAzcxPNckUsOOL
         N7kw==
X-Gm-Message-State: AA+aEWaTV6mMb2hR0E1kJoOhIYMT4ZT5ebDPkAVSMPrW660fdmJO9YvE
        RNrKUXqQ8cF+14e6e7ioVG2y1AbSL5xwS/bNX+0=
X-Google-Smtp-Source: AFSGD/Veuu1ekuR5hYxfLWpDtLmQbfexGDj+MJz+e8SNcXo6PzYNIS0u0P+AofxBh9JsYLtg6Win9BFEel4wL43KoiA=
X-Received: by 2002:a67:6346:: with SMTP id x67mr8136573vsb.114.1545847718974;
 Wed, 26 Dec 2018 10:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20181225075617.68058-1-kjlu@umn.edu>
In-Reply-To: <20181225075617.68058-1-kjlu@umn.edu>
From:   Shannon Nelson <shannon.lee.nelson@gmail.com>
Date:   Wed, 26 Dec 2018 10:08:28 -0800
Message-ID: <CAP-MU4NgXLbPZz3gqOUP--obi5Gfg2fJs3xn5CU6UMW1sJY8jw@mail.gmail.com>
Subject: Re: [PATCH] ethernet: (niu) fix missing checks of niu_pci_eeprom_read
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Rob Taglang <rob@taglang.io>, Joe Perches <joe@perches.com>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 11:58 PM Kangjie Lu <kjlu@umn.edu> wrote:
>
> niu_pci_eeprom_read() may fail, so we should check its return value
> before using the read data.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/sun/niu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index 9319d84bf49f..d84501441edd 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -8100,6 +8100,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
>                 start += 3;
>
>                 prop_len = niu_pci_eeprom_read(np, start + 4);
> +               if (prop_len < 0)
> +                       return prop_len;
>                 err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
>                 if (err < 0)
>                         return err;
> @@ -8144,8 +8146,12 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
>                         netif_printk(np, probe, KERN_DEBUG, np->dev,
>                                      "VPD_SCAN: Reading in property [%s] len[%d]\n",
>                                      namebuf, prop_len);
> -                       for (i = 0; i < prop_len; i++)
> -                               *prop_buf++ = niu_pci_eeprom_read(np, off + i);
> +                       for (i = 0; i < prop_len; i++) {
> +                               err = niu_pci_eeprom_read(np, off + i);
> +                               if (err >= 0)
> +                                       *prop_buf = err;
> +                               ++prop_buf;
> +                       }
>                 }
>
>                 start += len;
> --
> 2.17.2 (Apple Git-113)
>

Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>

-- 
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
