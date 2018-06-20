Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LLwcwL7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBC320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeFTJCn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:02:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52098 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932602AbeFTJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:02:28 -0400
Received: by mail-it0-f65.google.com with SMTP id n7-v6so4394690itn.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0w+zoAkND/JYQJnb34jIgOhCerzzset+WBWIuLe62wM=;
        b=LLwcwL7CGN8eby2k78XQQSYNi0I8Wg0KN4nLMfLOUKC2oaBR3CwnolY1D1mpxeJHpy
         oVA2jCuAJ/M2l7Wxl1F+J4EDdTzBiCYd9cXkmdP+ScMlmJexpjcDu0tlRX4lavrJBv0/
         vG3RPVJTYkn7RLzeY+8NdVR63+pVIToZVB3umY6zGkTV5v2AckCKe2jy1SV7h3dXdj87
         NIbW+0pVJS1vgjLenAPiFLND6WL6vHbf/5zDLky2d3zvBUgbmr2BuXyykDOkwJaUtcmz
         TiOAhE/8LGesZ4EAwpaSGgPyyklL4pU38RxFPWDsXa3OWgtO77TPeuPFwxa/qaR1/Nfe
         VNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0w+zoAkND/JYQJnb34jIgOhCerzzset+WBWIuLe62wM=;
        b=LZKR4zxU17e9kdb4kHg0L1f9ztLxl+9WV1FSaqQNnTnBtSrBvVQRqeGtFh2CI6sKaG
         G/gx/mKEpfbODdMbMXwF5ObjjPDBi4AawBNFVlw755eongmuW8crQZqY2iJjmORLV6tD
         RL837rEolmdOyJuZto95vztrXvYCK6n5Jxp+3KfU0MXAa8ayc5JDFRhL80hHW9xGLIPa
         aB9D9wYBxdVcK2WVNKYA6z+Rx/g92QUVI+ZVHtS8LBUpNZqgs3zqhEhTeq8VMRrdsvMf
         JHwFnWK5fK+BzicPMS7ncFwwT5RIZ0nSVM9M5l9V5PDwJTdyB+OQ4+jOkDhsMX88Xo0E
         PZ3w==
X-Gm-Message-State: APt69E3CWdj1WLqf2ro9046Blh3RFffLPQ5Z9Jh8twhLMbWGRJhw/YXp
        HYL9lCOnlSsET51OQH2jwJo8f3figwuPX1RbdRbNbQ==
X-Google-Smtp-Source: ADUXVKL6hPBVOyYLtzVVKc665uksdjDVhnRArAU0V+t/PIO2YFCSEdrRkZNDa325hse8bggAefHDojS+IiwwNVCrujM=
X-Received: by 2002:a24:ddc5:: with SMTP id t188-v6mr730673itf.125.1529481418582;
 Wed, 20 Jun 2018 00:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:56:58
 -0700 (PDT)
In-Reply-To: <db1183b9-6ed0-ed74-c461-cdac5bfc7a60@gmail.com>
References: <20180619160950.6283-1-brgl@bgdev.pl> <20180619160950.6283-2-brgl@bgdev.pl>
 <db1183b9-6ed0-ed74-c461-cdac5bfc7a60@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Jun 2018 09:56:58 +0200
Message-ID: <CAMRc=MdUTV3ZgBA-5vBgsCWCGTKnq_7=ZEA7_9gEsJHRmXDfhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: ethernet: fix suspend/resume in davinci_emac
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-19 18:55 GMT+02:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 06/19/2018 09:09 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
>> Deduplicate bus_find_device() by name matching") and adds a comment
>> which should stop anyone from reintroducing the same "fix" in the future.
>>
>> We can't use bus_find_device_by_name() here because the device name is
>> not guaranteed to be 'davinci_mdio'. On some systems it can be
>> 'davinci_mdio.0' so we need to use strncmp() against the first part of
>> the string to correctly match it.
>>
>> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
>> index 06d7c9e4dcda..a1a6445b5a7e 100644
>> --- a/drivers/net/ethernet/ti/davinci_emac.c
>> +++ b/drivers/net/ethernet/ti/davinci_emac.c
>> @@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
>>               return -EOPNOTSUPP;
>>  }
>>
>> +static int match_first_device(struct device *dev, void *data)
>> +{
>> +     return !strncmp(dev_name(dev), "davinci_mdio", 12);
>
>         const char *bus_name = "davinci_mdio";
>
>         return !strncmp(dev_name(dev), bus_name, strlen(bus_name));
>
> Or even better yet, if you want to make sure this really is a PHY device
> that you are trying to match, you could try to use sscanf() with PHY_ID_FMT.
> --
> Florian

I don't think this is necessary. This simple function would get too
complicated with the additional buffer for the sscanf'ed phy name etc.

Thanks,
Bart
