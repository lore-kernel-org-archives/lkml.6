Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E22C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58E92082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOC0Ew1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58E92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKCHYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:24:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42298 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:24:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id u68so5472394qkg.9;
        Fri, 02 Nov 2018 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+36MGkBJOIyLiqLmdqmm6g8gRAPLYxbbx/nV3fDTvsU=;
        b=ZOC0Ew1drWhpzkD5IdzBEMBakNKlmGP27BKtECZX/0IJ5QFqlI9em4YuSaNYAjumsb
         lM/38fo/vDCYDELKNWV5vi8K4ljBGgMLOHvM6gknydgSMVZkydC7tCVAFQuKFIgC8ZBT
         2dsBhog/+/WzUvpMUzy0SdS4zArVNQcnvISiK4DJCiMQ5J2IYGPHNujNhcokeZ54hIVV
         hiECMdjHtvm80q/q2We7lb7AA/KRbC3ibJXrUZxchUABKZdWWjbuWgE6AYBn4CqeCGIv
         GQ1neEBrnQtBLsFqbOj0cKQPvcBGFdm2XqmeDIN7KeOhlqBlDFGX5+ep+/JymWp+Q9zA
         jrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+36MGkBJOIyLiqLmdqmm6g8gRAPLYxbbx/nV3fDTvsU=;
        b=mEEpBPE/PxD0Q5Loci9VkUC4DUbEZUt869SJeHis30KYrR1r00Vl6gplR8gMRrPZg2
         HE3qxH5zx5dmozUiipCQZgcyEQJhLfHDkSkBcvU0gyy/ePeVC3S/OWcsJ6cehBR6fNJx
         wihwprwuooW1t/ED+ttT0RMyTjpnP82n5Vep8DKMO2Xv2XIAPAgjHVQTnyfTsCGeYzcM
         8aeTowYTMv5tYSOnrEkrAlFiCZlQfzn4v2mQTvORM+znB63in9kq1DYHz72+DFVZif8t
         MN0+KqJ4BBpWOcI+948VXnLiC3Anci4snGn+jgxj0vBvGs2+dQcCGbUiloHQS1whakAz
         FKEA==
X-Gm-Message-State: AGRZ1gKxDQGdfyMZ8D8aLOyxkHe9NBMCv4MhKzTPnGemceZVSFvAkUb+
        wQhjJFaxoE163qsI1H7XNngeH8B9ed1JOErbUP0=
X-Google-Smtp-Source: AJdET5fcNiXJvy13IeXlPYyV/30Y5yP1rVIhQYyrw2mvhIKrtMpRnXtIKd0rOTonYtLskbJu7SlUaia3TePYDQbyMY0=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr4878154qvk.40.1541196911540;
 Fri, 02 Nov 2018 15:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 15:15:11 -0700 (PDT)
In-Reply-To: <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
References: <20181102153316.1492515-1-arnd@arndb.de> <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
 <2727f37b-1742-5532-317e-3be8a984266b@gmail.com> <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 23:15:11 +0100
X-Google-Sender-Auth: 8a0crXQUdegwRGc5lDnLHjVseBw
Message-ID: <CAK8P3a0ybuiu_dBfUDfMYUtKZ=yGdB7An0_wx_ZGhnS5rrD3_w@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Saeed Mahameed <saeedm@mellanox.com> wrote:
> On Fri, 2018-11-02 at 14:39 -0700, Eric Dumazet wrote:
>>
>> On 11/02/2018 02:05 PM, Saeed Mahameed wrote:
>>
>> > temp will be mem copied to priv->stats.sw at the end,
>> > memcpy(&priv->stats.sw, &s, sizeof(s));
>> >
>> > one other way to solve this as suggested by Andrew, is to get rid
>> > of
>> > the temp var and make it point directly to priv->stats.sw
>> >
>>
>> What about concurrency ?
>>
>> This temp variable is there to make sure concurrent readers of stats
>> might
>> not see mangle data (because another 'reader' just did a memset() and
>> is doing the folding)
>>
>>
>> mlx5e_get_stats() can definitely be run at the same time by multiple
>> threads.
>>
>
> hmm, you are right, i was thinking that mlx5e_get_Stats will trigger a
> work to update stats and grab the state_lock, but for sw stats this is
> not the case it is done in place.
>
> BTW memcpy itself is not thread safe.

Before commit 6c63efe4cfab ("net/mlx5e: Remove redundant active_channels
indication"), there was a read_lock() in the function apparently intended to
made it thread safe. This got removed with the comment

commit 6c63efe4cfabf230a8ed4b1d880249875ffdac13
Author: Eran Ben Elisha <eranbe@mellanox.com>
Date:   Tue May 29 11:06:31 2018 +0300

    net/mlx5e: Remove redundant active_channels indication

    Now, when all channels stats are saved regardless of the channel's state
    {open, closed}, we can safely remove this indication and the stats spin
    lock which protects it.

    Fixes: 76c3810bade3 ("net/mlx5e: Avoid reset netdev stats on
configuration changes")

I don't really understand the reasoning, but maybe we can remove
the memcpy() if the code is thread safe, or we need the lock back if it's not.

         Arnd
