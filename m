Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4960ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787E020867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="buykOIq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787E020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeITStj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:49:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50269 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbeITStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:49:39 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so13006872ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NqfDjTXnFvMoxdCWZ9A90hnG/iuvsTOkVe6/RjKjle4=;
        b=buykOIq5wLQi/IZN+Ay7nZVajdh3zFHJ8/FwYf1SQycJt/boLagy8ccx07Ww/TUmdr
         pWMEZ/g1CJ+GFPTm1ArGSRbth9nTmFjAIFWTxli+ynXMtiPy1ksJ8HNmkBEmD1g8kY8R
         jZ0Z2mZx7QhUzdf9IcrFj5xvZ6e9yj4/wBne7kpbnm9qWMy9EIcrS498/DDa1hOFwPw9
         uK8LAalMm9X9XJ0y/KSF9OXeoeI1Zy5n5p+UbYHnaEOJUzgsSAwBp9kvcqWjtKFPI633
         Ntfcdi0s9MCUxxkFjasQ88Dz84yc9YLKWs/TjOiNb4D6Dj/rD7QnXQTn9AJjHCQfedbc
         WCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NqfDjTXnFvMoxdCWZ9A90hnG/iuvsTOkVe6/RjKjle4=;
        b=ak1pFJYTbJdRvNjgsVCe9j3EC7mhDMImJjfhWA0qvbv4DoCPNvFKnLZ389tPJtO92c
         AN3hnvaIoV8jd6Enr0ocU5+4IP+0925ZIy9lE0tnH3M6cFY3jzBpZK40xk/TY3sEukTj
         C2Lukmk/8n4sEPkeJVwk0txRLdXqJON+uL26ZeFJZ0hJObjyK0/MzABNIZ/4nHtj/QoB
         8EnmRzsq7wR2L/WXLpsRtndoyAcodm43yz8j6NxLG4JN46ed2erQstwk1E1aiJiwKaxf
         r+oIDoj0CknYVf+XnH54O3XQwkyCpJFcqe24jDqdAVG8h/vYw03y2o+wtRd3p9NQ/RE3
         WllA==
X-Gm-Message-State: APzg51AgdtxHW/B8rcKfykdkI/NmIW+6B0KLhKXiWDT8mmzm8uOBvb1a
        PWhyBsZB0v2YdjhiSjZOUl98RPTU2DXi3udZ0i0iYiJ/
X-Google-Smtp-Source: ANB0Vdb+GZrWIAyrjlojajgbfe5aAjaL+BwqlN6MIYUWHrrWW0atbEsvwNMnxIe16fb6OoDryaW9pCrpTLdUSebxu6c=
X-Received: by 2002:a24:a20f:: with SMTP id j15-v6mr1880316itf.125.1537448773112;
 Thu, 20 Sep 2018 06:06:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 06:06:12
 -0700 (PDT)
In-Reply-To: <20180912080457.12238-1-brgl@bgdev.pl>
References: <20180912080457.12238-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Sep 2018 15:06:12 +0200
Message-ID: <CAMRc=Mf+WO8tvgWO-=kikh-1ZZD1tANK=QrZfAYndA6GE4ox3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] eeprom: use devres for nvmem providers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Devang Panchal <devang.panchal@softnautics.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 10:04 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> While working on the nvmem framework recently I noticed that there are
> many providers that don't use the devm variant of nvmem_register().
> This series contains relevant updates for eeprom drivers.
>
> Note that these patches are independent from my other nvmem series[1].
>
> [1] https://lkml.org/lkml/2018/9/12/265
>
> v1 -> v2:
> - fix an invalid devm_ free in patch 1
>
> Bartosz Golaszewski (2):
>   eeprom: eeprom_93xx46: use resource management
>   eeprom: at25: use devm_nvmem_register()
>
>  drivers/misc/eeprom/at25.c          |  3 +--
>  drivers/misc/eeprom/eeprom_93xx46.c | 19 +++++--------------
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> --
> 2.18.0
>

Srinivas,

Greg will probably be busy this cycle, so in case he misses those -
can you send them together with your nvmem pull request? They don't
depend on my other series in any way.

Bart
