Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DDBC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA5F25706
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLcG48dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA5F25706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeFYJvL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:51:11 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40717 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755034AbeFYJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:51:09 -0400
Received: by mail-vk0-f67.google.com with SMTP id o71-v6so7479280vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2TtAcicZiJky3WJSEK9dPu8qH1IjaXX1oZK5353zrQ0=;
        b=sLcG48dTzpWMun8/0rdQHFzSvtDGuYwdygyNIV/rj/ngOeKe+xOUphetixAzZhgK0f
         OAmoE8LFRu1dONQtfbEt+CvavQTHmjKJ0XAKRr1SrxWP/A3bQr0UaGMrp1sS2H1OqroZ
         7aqD2hQ8emEEpglyn+StURLcnMV/NbUQR0FeNH+QRYNexLqMtGEIDU/EsFygNhBzgyts
         balTEfO3F7dQ/dXfnce9xReB1th4ZN8mYWY9LbfBzy6uvLrdYZbarH1He7yfBczQh8Aa
         BYBw+j5xak/ZfLNoCoP3NcnRCpUDUrVXtObCW9/D0FQDXkgtLbwcrMRLb1vuQWfHzKXl
         TKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2TtAcicZiJky3WJSEK9dPu8qH1IjaXX1oZK5353zrQ0=;
        b=kr2ZBUgiANewsIoJbzaxn7+ML54WJZNnUlBapFlleugRW7KQOH+wOv9kkiAyd8P7x+
         dj0XzCagpITfypS3OgRcNNe59ISl/LI9Q78LEJF6gIGtVcQCUilExxm3v6YIZyfDofKa
         MAnLUKQt1x+50a2N8P7gtK6AbSc7wfBG+xf+AifwSaovzhE5DYTsT1wfS+NsOWiE1qLE
         iaaHpgesw9cV9q5rImjouFAsq6Vw8aLZ5YrFXP7nZ/nGx2CsWva2IIgZkESSxqSPHvGu
         qCHfZu+0fY5/oCNENhQjy5Vo+/IMEOX/72397RZOxgIjhGT8/jf2vgeYSteKTPt9Yb90
         OeMQ==
X-Gm-Message-State: APt69E1qTHCofuy3QRgHsrGFt4VYRHbQ6zqq/spKXl8IMZbCKxsu7WAe
        tRmu+aCszuf+5ARchjE2l5DeLO5x9X+35lFjJyE=
X-Google-Smtp-Source: ADUXVKJb5UISIP0+Oyw7HUjhpLuJXG0Yi8hUNldwh1zaNa001rT9J2a8s8VODahdNcbDlNGNUDZ93cn2CijQWv6LgG8=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr6994867vke.176.1529920268993;
 Mon, 25 Jun 2018 02:51:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:51:08
 -0700 (PDT)
In-Reply-To: <20180623094532.12316-1-michael.straube@posteo.de>
References: <20180623094532.12316-1-michael.straube@posteo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jun 2018 12:51:08 +0300
Message-ID: <CAHp75VcNxZie7-9YqUgtrE7BR88SLDSXuNCa5Nph4cKBrQxAWQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: refactor rtw_macaddr_cfg()
To:     Michael Straube <michael.straube@posteo.de>
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

On Sat, Jun 23, 2018 at 12:45 PM, Michael Straube
<michael.straube@posteo.de> wrote:
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

> +               if ((addr = of_get_property(np, "local-mac-address", &len)) &&
>                     len == ETH_ALEN) {
>                         memcpy(mac_addr, addr, ETH_ALEN);

ether_addr_copy()?

>                 } else {

> +                       eth_random_addr(mac_addr);
> +                       DBG_871X("MAC Address from efuse error, assign random one !!!\n");
>                 }

-- 
With Best Regards,
Andy Shevchenko
