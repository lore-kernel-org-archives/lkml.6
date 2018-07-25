Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3281C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9CA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Piu3GNEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9CA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeGYOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:52:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44124 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeGYOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:52:28 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so6335493ioh.11;
        Wed, 25 Jul 2018 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z2N16S69SiSlUm0+ZD/M1KU5SFa7ViYac+7ouvPi47Q=;
        b=Piu3GNEq0WoEMLK/2jgA6d+RphezkWo/FoCzwLNkrS7ku3s0NHgeV0TOtGfx+yR4JG
         14KmXBsfjg7h2PIP3ZrYAmjz4uhtnvYk181QNuCg8vRnOD3/e/bSpRks71FBZmqc9sp7
         1w5W3KoOo9YH4f50kH7cuUgUzw0gyBCEj/httkqEZXtfpIJiLmYycZ2JsaNAOaHSZFro
         2FjfH/z7oYMO3BaVA0S7tm9zo8CmSFYyt5nkndHnTuzbiyp3pXIguo2Y4H7ERirK2x68
         dWUEpeYEVLM35Hh1ZYuMimN99w0vLdfPv6Tb2HQDcByfnOgMZSTa4175F+dZlCzE1KSA
         wMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z2N16S69SiSlUm0+ZD/M1KU5SFa7ViYac+7ouvPi47Q=;
        b=lve6j4aQZZ6/S7CPSzrUwrWYcE1OsHxBHowaPSVYkbeN48LWk649BLEMPyWMlWcLnW
         aPdOWGpjWTMaK+wztNGmyNVyCKmYEE4kWkFErj6p/U8x6nr9u9uTMyPwnGaBgQPVpf5m
         iZy50x9RYyKZ2YtFhgxEsXepRaA7a2ka6zEf1Km79wwGGxF4wlzIg+7U2VCmCEZlIlIA
         pRHoyBsxw+PpLOCjk+l28OEXXbp9tUSOxHuBr9nXDosPsopzvrseY3bXd9t08N2Ir87W
         +PRwzhfsFqTVcfiEwSVQJoesJT97D3zuxIFf5Lrg35GZbJAo7GS/4VgVEuFg9RqqYBER
         ESXg==
X-Gm-Message-State: AOUpUlErOz5h+lC05F42LAYlYXNnPgWtets8Xh3acKuq+IJs5U/A6p2C
        mp6DkwRM0khUAvEGUDvDbVIP9K+MNQf3DCd8jF0=
X-Google-Smtp-Source: AAOMgpfEzCl+Sm4YTsVDnPN8pJQRbz0SVlqCo3UO4/4KEbL0Sapxhb+BTA06ZwdJvvJ+9ipoD+QFZLhgoVVH0UuAMWI=
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr16819247iof.295.1532526044563;
 Wed, 25 Jul 2018 06:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 06:40:04
 -0700 (PDT)
In-Reply-To: <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com> <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 25 Jul 2018 21:40:04 +0800
Message-ID: <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 9:33 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/25/2018 06:06 AM, Yafang Shao wrote:
>> LINUX_MIB_OFOPRUNED is used to count how many times ofo queue is pruned,
>> but sometimes we want to know how many packets are pruned from this queue,
>> that could help us to track the dropped packets.
>>
>> As LINUX_MIB_OFOPRUNED is a useful event for us, so I introduce a new
>> SNMP counter LINUX_MIB_OFOPRUNEDROP, which could be showed in netstat as
>> OfoPruneDrop.
>
>
> Okay, but why tracking number of skbs that are removed ?
>

Because we want to know why packets were dropped.
If that could be show in netstat, we could easily find that it is
dropped due to ofo prune.


> Skb can contain many segments (because of GRO and TCP coalescing)
>
> So your claim of tracking dropped packets is ill defined.
>
> Also I prefer having net tree being merged into net-next, since your patch would
> add a merge conflict.
>
>
