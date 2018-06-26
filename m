Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE707C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FBA26E44
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5Y2hNK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FBA26E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFZR34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:29:56 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44300 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeFZR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:53 -0400
Received: by mail-ua0-f194.google.com with SMTP id v15-v6so4563322ual.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1CZuU8RbFeWHEuMgaZMR1xv4kJ4NpmkusWoa3H/5Q9g=;
        b=W5Y2hNK5BgJiwu3VUKX6OnsWpKrFOaVCxEVBGxTyTxyWIID/7HNArA3+0HIzuLm5ig
         nO/45RZybHLtmufV1CFbIVVdBPWCZzeelYAV7oDAVNkN58KvaRFk17J7AQ+JCrgdEuFz
         ZVb2W/I9WyHbGRWg0jQzphJJ3CpzLj4dUl0vMvSVp1Ca87sU70jXLHsCR/SYq52nr4TD
         a+LXNe44jyDmhGXgG9UrcYZ3xBimkkhZeN9N8Nh8MFnZku0/Vl07dn8Jd6HA4bjzlMme
         bfHBtVEG9VRzRY1fQkJ70NRLC1BP0k/GWrz6c5sMiG5T94AoyR+Ii3O7ytMR45oUaBfi
         XVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1CZuU8RbFeWHEuMgaZMR1xv4kJ4NpmkusWoa3H/5Q9g=;
        b=LnDBVmvxs3ldI0Ua9X9A4VRZkLkqhJyaF+0JegJoHeXaZle5KzvrAZBF7PIUV91tGz
         DjSQNY3BPA55AiBqIbOicqYDXU3vqbn/aMMig3EqkAqhWo1IP72P4ZHxLYvb37FXdkz5
         Mh9i1qctcd5sNKOihK8agDHy9ZVfsCUg64WawjGoHkAeakuXL7UJ1i73XErPx/lcElQl
         2h+H1nF2Lav/Z6v9ZJ0mM5JG/H46C3iSfIJcCleLDb8qdZTnpeEs5dYB7tAMZ6Jx48ov
         XsgolSJBQGcTtd2APr4hK0LGEdZJoGwKDGt8ocnOt4M2D1rATNiuzBbnhCCezGXt21no
         koqw==
X-Gm-Message-State: APt69E2G6oi01eckFjW6awMUEtdKSd4L/Dn++LktoA49zeHvoH+vnfk5
        lElyg32Qhehzyqdw2r5qKVTmP/cESBTUOBXLu/I=
X-Google-Smtp-Source: AAOMgpczyZnO8y+umPffXFe4uLW1gaOQ7J7cJU9ztwva9irfOcwUuPW1wv2sOitqEnmTkC0tHPAcFmmhE2jwobATtKo=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1601732uae.12.1530034192653;
 Tue, 26 Jun 2018 10:29:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:29:52
 -0700 (PDT)
In-Reply-To: <20180626081409.9518-2-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com> <20180626081409.9518-2-straube.linux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:29:52 +0300
Message-ID: <CAHp75Ve7tKAQU9sfCUvWnwHaYkFXHiMS6PTbLdqh-AJOfYQpCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] staging: rtl8723bs: refactor rtw_macaddr_cfg()
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
> Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
> testing each byte of the mac[] array for 0xff and 0x00 shortens the
> code and improves readability.
>
> If np == NULL, of_get_property() returns NULL, hence the "np" check
> is not needed.
>
> Instead of a fixed default mac address use a random one to reduce the
> likelihood of mac address collision.
>

> Thanks to Joe Perches and Dan Carpenter.

I guess you may use Suggested-by tag as well.

>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  .../staging/rtl8723bs/core/rtw_ieee80211.c    | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index e55895632921..7aa00d1391f7 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1177,24 +1177,13 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>                 memcpy(mac, mac_addr, ETH_ALEN);
>         }
>
> -       if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
> -            (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> -           ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
> -            (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
> -               if (np &&
> -                   (addr = of_get_property(np, "local-mac-address", &len)) &&
> +       if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
> +               if ((addr = of_get_property(np, "local-mac-address", &len)) &&
>                     len == ETH_ALEN) {
>                         memcpy(mac_addr, addr, ETH_ALEN);
>                 } else {
> -                       mac[0] = 0x00;
> -                       mac[1] = 0xe0;
> -                       mac[2] = 0x4c;
> -                       mac[3] = 0x87;
> -                       mac[4] = 0x00;
> -                       mac[5] = 0x00;
> -                       /*  use default mac addresss */
> -                       memcpy(mac_addr, mac, ETH_ALEN);
> -                       DBG_871X("MAC Address from efuse error, assign default one !!!\n");
> +                       eth_random_addr(mac_addr);
> +                       DBG_871X("MAC Address from efuse error, assign random one !!!\n");
>                 }
>         }
>
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
