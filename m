Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9472662D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iCFXAAMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9472662D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeFZHla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:41:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41807 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeFZHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:41:27 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so12274072ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+PZ/VIyDW9kSGErWjSZEkc0NeyH4rviw+qH9n+Vaj5s=;
        b=iCFXAAMRxan6IG4+btUgz4UO2tPftk5d+95nxhjg/0frtTtEYnAo+wZ0gE4qQSEO1A
         DCUJ68VzumoRXLwDM7l+DRhFygpgv7/2JgPW+oLzZ0fOa0MGFlKeShRfuiL8SrN29PnU
         U8C7O4sBrOkbSzT1hAgWMa9T+rqv5hwQxVNESD4S1tu407Z/KyoJ4uLPIkHrmtoBJrFr
         hYy8l1wWAvXbT1P1/shf4DHvhIcWtnHVG1LW61XnvEtC8Y1eY8Ra3S6ywRvvleqm7A8y
         s39S8LsH3Y/OTgXhGYUzZWmVO7Iowir12MbJDu5jwm6qt5UbA5tIfb0lcyYlOamPRb5+
         s7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+PZ/VIyDW9kSGErWjSZEkc0NeyH4rviw+qH9n+Vaj5s=;
        b=KGyFyeCxcx7vHaBEWNVvBOuP4LFSnhl2t1GGaNRww+LzalkDy5IjpLJOWJ2Th/89DF
         lsk7LLRhuoC1qwsdYxJcSLAuJVouX0C0P2+a/zxrbHocXHgsaaLtLWWk55c3vLIMBzFW
         6As3YCJbd0uoqRyL4gSBfyEDBcMcuVex/QZtEw18iK2TvUuOzJaL+RicxNvg5Z7lcYT7
         r5nBzT/4G2AB7bmMqYXGB6mkXcgaN0uWvM32jgff/YIWEFsUoEkkweeADD4fLYfnL86D
         wsiLKddnThJsEuMOoBB8v2FFkxUX7Nf8JAyebWV9lP1HwEtnyax0qdXtZW2dSQ73/Pys
         B6Jg==
X-Gm-Message-State: APt69E0L2zwrR9oNYafnCmRlCG7yS3vyAdG6ork3HeZe5Q8Njk8OxHjT
        VnETovCboxvoLeKEfTCdA23tAT97fxIlHjc3uAu8dQ==
X-Google-Smtp-Source: AAOMgpeLz+15Ov2GODt2SykgIjvZYfivR9TkaXX2avlqNtxO1H5gqM1ZINeXVzsE1kHQCGGb5V/732yMBN3S7ukdkuI=
X-Received: by 2002:a6b:c855:: with SMTP id y82-v6mr310241iof.187.1529998887180;
 Tue, 26 Jun 2018 00:41:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 00:41:26
 -0700 (PDT)
In-Reply-To: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 09:41:26 +0200
Message-ID: <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
To:     alanx.chiang@intel.com
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        andriy.shevchenko@intel.com, rajmohan.mani@intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 8:22 GMT+02:00  <alanx.chiang@intel.com>:
> From: "alanx.chiang" <alanx.chiang@intel.com>
>
> In at24.c, it uses 8-bit addressing by default. In this patch,
> add a property address-width that provides a flexible method to
> pass the information to the driver.
>
> alanx.chiang (2):
>   dt-bindings: at24: Add address-width property
>   eeprom: at24: Add support for address-width property
>
>  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
>  drivers/misc/eeprom/at24.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> --
> 2.7.4
>

What is your use case exactly? Do you have an EEPROM model that's not
yet supported explicitly in the driver? Why would you need this
option?

Best regards,
Bartosz Golaszewski
