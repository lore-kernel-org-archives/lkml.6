Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D579C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD76204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pmDc6lOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD76204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIJMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:51:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41558 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:51:35 -0400
Received: by mail-io1-f66.google.com with SMTP id q4-v6so6276222iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mudgGYqP8LqZ9x4Y1sGfRvAnBv4+WIk3H51rEOkU1Lo=;
        b=pmDc6lOU676xZlldcHYUG9YiZR104sNAgYTAS/rhSEbSXvL3V/sOiwCXAqaCoWXKzd
         O2lC/U8onET4ZpCppU6Ab+wBWTT/HhLOFkuul5jEmQe6RBnbBRoLTMaKBP3fibQixaQa
         LyYxw/WSPLEpZRVQh11s4M4CDSkoOrVIVX9tdd2UXjxDOv2VwJnq9JnB8DZ93P+qcq/X
         HiIazSSGnXYvueOmsUsK/P7LB/LOiUWHFiNBqjGVZLl8SuI1OUqjG8Z8bj53dRmQb+ej
         ZusMZI9ab6LwiyZ8F5lXJ2OiigjFeqHBe+fl+Xw0pCU7ns3z4louqA83Mq/ID+Nb58pj
         QjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mudgGYqP8LqZ9x4Y1sGfRvAnBv4+WIk3H51rEOkU1Lo=;
        b=JuUIhzltPjxJneDDfJ2S6JEZqCGw2Ea2jYiznWRUYkqEwIa/ZbdB68kpb9RDqDOdwq
         2srRZrIlVBzZBOgQQFGGFZ9tWa9kRTcZSd0AQh3UTwRruiLFHC8Mce9j8q0eIUrafQho
         htwXIM9ufEYadFHTfbPclDDHBLQ5exNW5g7L8Ta4494ZGpoRAYlF5oC6/xuvZ3/wGryc
         ClH81JCd/vcCO4tDEbbZ0Du1ofbnlEqHcg4n8QOTH8xM/5JaN+bEo/BkqDb/bapTNrr3
         3uASakZCHY+LsYmWD4uCo1G+662G+OKgbrzl7P66/BG7rhlxWpB+Sjam76E5b5ijjKka
         SJIw==
X-Gm-Message-State: APzg51CkFZ4kx6KdTt4ccPVNu+Uan/EU7Yn/2MVVaEOv3jZThIHILyV2
        BiJRSvWNLwIhKZMFnFkyU7YZ/v5bORt0RaGcDBiB4g==
X-Google-Smtp-Source: ANB0VdY7OCSYMec0N9d9FJc5hPjnz0pTQAc/g6Y/wR0UOZK+beKmWZETxPoorQvbCtsx+6QujgcYNjtSuz9J5NxkqDQ=
X-Received: by 2002:a6b:6401:: with SMTP id t1-v6mr16589703iog.111.1536566329774;
 Mon, 10 Sep 2018 00:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 00:58:49
 -0700 (PDT)
In-Reply-To: <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 09:58:49 +0200
Message-ID: <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 9:32 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Remove all APIs dealing with nvmem_cell_info. There are no users and
>> this part of the subsystem will be reworked.
>>
>> This patch temprarily disables support for non-DT users.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/nvmem/core.c           | 212 ++-------------------------------
>>   include/linux/nvmem-consumer.h |  26 ----
>>   include/linux/nvmem-provider.h |  13 --
>>   3 files changed, 12 insertions(+), 239 deletions(-)
>
>
> This looks totally un-necessary, Other patches in this series adds them
> back.. Consider updating these in those respective patches.!
>

While this may not be entirely necessary, it's very useful. There's
almost nothing common between this API and the new one added later in
this series. Later patches are MUCH cleaner thanks to this removal and
I believe it makes them easier for review.

Best regards,
Bart
