Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28991C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CC20877
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAI/3x+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0CC20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeG0NFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:05:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37176 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeG0NFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:05:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so3110521pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SHvt2nRo0vCTaEFnymhPEyi+ziLqDdq0wZ8DjqZdMHo=;
        b=LAI/3x+ndSvVSvr1ekAM6tgMAm+rWvvM9iB78iRSeWW9XaN/LINEUGAk6EptlMLMnU
         3yB/QEi/Y1osu31Ldv++X45MThXWAjrTFeKV7atlQRSt22LI7hYxHXhfC7Cs03+gtJlL
         5I3pN8DpS8a9m5yfiW0OstjCq1tv7k8rkkQjYsAu2532zFPDm2Wn1oFB7W9PGWCIjQGn
         I43t2pt9Ij0w67iWXUKVONjmHoOxGnbTZPCzOv7OTQw7Cx6j9npptyAIvwalhDXG26mq
         +ucAx+rBGhn6gUbdsgf0K2Lgava83ztn+JSq53KKjNmmrLy0I2HUR+uJy4YIWIFvtZdy
         9y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SHvt2nRo0vCTaEFnymhPEyi+ziLqDdq0wZ8DjqZdMHo=;
        b=SEj9Y6aIsUVjYW0xYU+CRLDh9iQBoDremXu7YwO5G5f58IC387YkVm04EbcU9x9m2c
         W7G2t+ch6ODuhRYKD5vG0MtwAMAXD97jmGYS9GR0wYcS2ar4OVsKIPngklj3jxMoUiAr
         tA39PsVCzLhDkWDwzn98el7d9RBQ4NXC3FfSnJJWmQMpD7mF/1ykJCmaTamollzLB4+U
         qc3XrMo5RFRML13iMFJ1q9U3rMTpQwUsNNhehsYOSVxn2L3XqI7UFp731AfgRlR+HeRB
         aEwyOyt2bhN1kMlpb7sVMD2VrUdAHE8+9yptBa6UfqVIn2scC/zB5krmpeDU2nHfnPxU
         oNsg==
X-Gm-Message-State: AOUpUlF7+uF9UYGDwWX/QKlhr71OoKZ10bd8Zm3/s8b5mxC7Myc5qCQI
        hkKPtq56rm0UDD3U+vuM6XXeva6OixI=
X-Google-Smtp-Source: AAOMgpdul3Od7OlusqqVXYUlbYUxqyABmTvhyHkPW1HqnLgcS6ikyplh8OJYxg03nWonz5+vQEAhEw==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr5942627pgs.203.1532691815070;
        Fri, 27 Jul 2018 04:43:35 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7153531pfk.96.2018.07.27.04.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:43:34 -0700 (PDT)
Subject: Re: [PATCH] staging: fbtft: Replace mdelay() with msleep() and
 usleep_range()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180727092111.7218-1-baijiaju1990@gmail.com>
 <CAHp75VdMQ2Cx+0cH8PuM8t8i2NgphxEqU4g86y5Hgwi1_CQ9zQ@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <6ed64d7e-2899-ac18-78ed-508d14abf845@gmail.com>
Date:   Fri, 27 Jul 2018 19:43:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdMQ2Cx+0cH8PuM8t8i2NgphxEqU4g86y5Hgwi1_CQ9zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/27 18:34, Andy Shevchenko wrote:
> On Fri, Jul 27, 2018 at 12:21 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> reset() and init_display() are never called in atomic context.
>> They call mdelay() to busily wait, which is not necessary.
>> mdelay() can be replaced with msleep().
>>          gpio_set_value(par->gpio.reset, 0);
>>          udelay(20);
>>          gpio_set_value(par->gpio.reset, 1);
>> -       mdelay(120);
>> +       msleep(120);
> I didn't look to the rest, but this one will be inconsistent after your patch.
>
> The question here is why udelay() is needed, while mdelay() changed?
>

I thought udelay() is used for short delay, so it is not very necessary 
to change udelay() to usleep_range().
mdelay() is used for longer delay, so I changed it to msleep().

If you think udelay() should be also changed, I can send a new patch :)


Best wishes,
Jia-Ju Bai
