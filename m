Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DDFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85E2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KO2+bUoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B85E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIESa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:30:58 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38498 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeIESa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:30:58 -0400
Received: by mail-io0-f196.google.com with SMTP id y3-v6so6021710ioc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mKMw4JJIZP3eRbdElXE0ZPBNMxVlg14z/DMUzXgcO4I=;
        b=KO2+bUoH7S5G3mKnMJuP8XEGQ5HTDgQJDEj5AptcslLXo3ukJufO2jg/KMlJWDMWCv
         +WBXRfPQZfPy5PSI7k21e0frw4yocYxE53yGsd/LRaUOO/B6XCOe5xjR+HcNX2XhMbLJ
         7yFm01DiLgP1cIoicTVpnpqyoX18gKs7WHk9IHB/qktjcoF9utsf1NqjDqC3Y1HLMUN+
         Zof7F5x9OqrFzA7mjIRWx9qB92HDb2lQyVTsFg9wUJRHQSkssn1uavurnA6ekK3k4elR
         ZyKX8TmUplaiM9uA2YTNRhducuDs5uIICwGGrnjBNT6t4AGQakjB08jcvBTpYgvTINsa
         mKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mKMw4JJIZP3eRbdElXE0ZPBNMxVlg14z/DMUzXgcO4I=;
        b=HnT3ta5PwMBZlUfkqqyWN5L8RyMO149IIWOIURn/p6Bze/ivLs/53CTaLof9vxgRMn
         S3URE4PLSvO7jJkk/OevV63TV6FaNDfJFYSUkbLm+0YFH99cT+4udO4mgbfdWxKo556V
         4YIyQNgTFItuKnh8EPkYXRaYe6x/NTCLRTgkikagcY9xvawEV6+bMwFd+8wIY8WrgHvi
         3MxS2SVU4/lh1yW0OlJeF/HtTjmJg+1ywLBhsem/1XnWiOkxGqZS+222tmdC9dmGfQgo
         SEcBPA3jFEt5hyQX1Q8rMKPeERZBsl3BmWKwaaAobVqRKzV5xnGmew9LeiLQs7lRpQba
         cMbA==
X-Gm-Message-State: APzg51BdN154S4wPCEWUpTpa3V3t7Bj1Uj0R7wfyAUkszvla7p7eJjC4
        1xpCm0wikJQoLIJyfDDv36MYXfRTpv9+z2kHfyjIwx4D
X-Google-Smtp-Source: ANB0VdbwOwxFy9dnXJR5gAxWTsQI0AiPhEFI/alYL/Ij+0wDv1e2G9jmMzQzKVYaiFGILOM0B9jOmq15EuSJKMkrUII=
X-Received: by 2002:a6b:6401:: with SMTP id t1-v6mr27151688iog.111.1536156037132;
 Wed, 05 Sep 2018 07:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:238d:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 07:00:36 -0700 (PDT)
In-Reply-To: <20180905155741.22b7d0ef@bbrezillon>
References: <20180905095738.26406-1-brgl@bgdev.pl> <20180905095738.26406-12-brgl@bgdev.pl>
 <20180905155741.22b7d0ef@bbrezillon>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 5 Sep 2018 16:00:36 +0200
Message-ID: <CAMRc=Mco7Tbk5P_mgv49f+3j9DKYk5AL6EjPhwF7M=Hb7o5-Mw@mail.gmail.com>
Subject: Re: [PATCH 11/13] nvmem: add support for cell lookups from machine code
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-05 15:57 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Wed,  5 Sep 2018 11:57:36 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>>
>> +struct nvmem_cell_lookup {
>> +     const char              *nvmem_name;
>> +     const char              *dev_id;
>
> Shouldn't we have a con_id here?
>
>> +     const char              *cell_id;
>> +     struct list_head        node;
>> +};

I wanted to stay in line with the current API - nvmem_cell_get() takes
as argument a string called cell_id. I wanted to reflect that here.

Bart
