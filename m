Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F21AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179B25701
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ+QIjm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3179B25701
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeFYJtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:49:52 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:32995 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755100AbeFYJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:49:50 -0400
Received: by mail-ua0-f194.google.com with SMTP id m21-v6so8213414uan.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1yiTon7OkrcPtHrx9w9MTV9mY5fK/yHm5ctTKtXAxPs=;
        b=VJ+QIjm7eglqUOb1znGoshQNxQwYYigwf4ix6epWeuVj53tsH72da8o9RX7XZsMlRr
         L0S7C9HjKmedk3c0hk2UYdEoyBXuBQnq41kpAXMjg9JNaTbnMopXJxEZsiP29YD+YZl4
         t8Zk0zPzcAQ5PyVDow5Yy+FNMDpjhlRk266zGEvHtCKb3YBBqeprLt3m12Aw6QMcA6df
         +t+UdbnB0NLGq4hJbUHV0yiQG2R9rgTjaCIBeUAseT9vJoklgsMQiVi/tHH8VV7KBtmj
         smHRowXlsTfkt+dLiu9Zs4iIuTzVGyQ2kPJ5z1M4ByyluqWyYEBfisW8CV4lcnL8q0Zk
         pOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1yiTon7OkrcPtHrx9w9MTV9mY5fK/yHm5ctTKtXAxPs=;
        b=PJDhBKy8mqplC2J8vclAjM0PVFg1jJikZnZFgZ+FiPxHuch8JirMWGwIGkfVY5f4UJ
         F/Y90ooBs6P6Q7oouwDkYoNyMWy+54KO2AQEPY3/A7RMd0jzeLGPvhQpXJtYHyvcbm8H
         hSoi/quPnTAcZvEu5hpvXLU0trvYhvrkVXmPQKtPXLYhQvm66E33zx6wNeL+AQd7CKMc
         7QH9alxwFgXVhS34UnHoDUgUNZ2r9RE1Ui5HOP8G38Mq80NaHl1p7wrJbMekf69Ncxvf
         gVJpTd81GUvmB01CBUdRq38gId4ucbY0B1K/dyN9MOkTAGwGo/NlMA4aVGsH/LnpQDQA
         8v/A==
X-Gm-Message-State: APt69E1lvj83W6E93+/2SfVzjDP+KYe1/KdwCi3OvT+MKKsiO5Jru4As
        uf3pX4e25mv8Py9p5d9hD8OjVWNyEtcaZ3EJGZQ=
X-Google-Smtp-Source: AAOMgpdv9IQMxiSvUE+erwF4UQZBrGysj8QaNhNJyiSw2eXIysusio0rZJHoWMWpDyoLrC5NATk103hKH4rvJk49S2w=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr7491877uae.12.1529920190202;
 Mon, 25 Jun 2018 02:49:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:49:49
 -0700 (PDT)
In-Reply-To: <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
References: <20180621182230.27823-1-michael.straube@posteo.de>
 <20180622104007.ob5nt2rip2fu436h@mwanda> <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
 <20180622105719.pt3lh6fqi2nziqsz@mwanda> <28dd699b-3013-c42c-07d5-1117d7ab3622@posteo.de>
 <36a7227189b8c7602dd9ffd21a5369b7029e61f1.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jun 2018 12:49:49 +0300
Message-ID: <CAHp75Ve_mokaJwSf2Qpd9mSvpKuBkJXyCC133zqEz5ujhXDncg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if condition
To:     Joe Perches <joe@perches.com>
Cc:     Michael Straube <michael.straube@posteo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 8:28 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-06-22 at 14:48 +0200, Michael Straube wrote:
>> On 06/22/18 12:57, Dan Carpenter wrote:

> Output from checkpatch is not gospel and can be ignored
> whenever appropriate.
>
> I think the below is ok:
>
>         if ((is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) &&
>             ((addr = of_get_property(np, "local-mac-address", &len)) &&
>              len == ETH_ALEN))
>                 memcpy(mac_addr, addr, ETH_ALEN);
>         else
>                 memcpy(mac_addr, ""\x00\xe0\x4c\x87\x00\x00", ETH_ALEN);
>
> Although the last memcpy of a fixed mac address could
> probably use eth_random_addr to reduce the likelihood
> of mac address collision

...and first one looks like ether_addr_copy().

> so maybe
>
>         if ((is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) &&
>             ((addr = of_get_property(np, "local-mac-address", &len)) &&
>
>      len == ETH_ALEN))
>                 memcpy(mac_addr, addr, ETH_ALEN);
>         else
>                 eth_random_addr(mac_addr);
>
>> If yes, I'm not sure how to proceed as these are the very first patches I send.
>> Should I send a v2 patch with both changes or just a v2 with "np" removed and
>> another one for adding 'is_broadcast_ether_addr' and 'is_zero_ether_addr' checks?



-- 
With Best Regards,
Andy Shevchenko
