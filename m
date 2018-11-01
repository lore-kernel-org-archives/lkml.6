Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262E1C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6BB20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6BB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeKAW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:59:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34208 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKAW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:59:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so16620861eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jtBHWjsOfJeGigaOTutCncOXz9WX65sCAtVadnxm58=;
        b=gcSr8CICu9LkHd3u2KH4vaWWHmQzlrdQ2sjxGHwY1wwx9nXWuSVr8ZmYowOMlcEMza
         Rzef9ezwFiyCDShDqCSghr/48KTgRMYvtN0T0XA6WgvnKfx6r/NTkjgfAohavnFu0J/I
         BNEHP1UcDGiG8eNlQoQJRqZT3vrYqFCF2J6kICp2HdU9Cd293d2W4Z7+/MiZ5AUf+kXV
         ahsCVX0OtvgqAdVy05w3RwYwfEzOqBlItXKZhGeQYgx7aGxjgZOBuBeWP19x6IvLuNR8
         8/p1uShbgoSBjn2BmbF8iRuY9ONUiuzLlCvk8xkphY3XIXTXwP9i1PLyw0cGTg8I0Lin
         2RRw==
X-Gm-Message-State: AGRZ1gIu0QbXRCUzCcZ+iUr8afkMxGMhW3y4O51xRo6n7lt1OcKt4Ydl
        1+UjTECBJl6eQCkmqhwwinMEBQ==
X-Google-Smtp-Source: AJdET5d3XQjW5TuHEoT7CgqW6GFW39ERbZGu3hzILkZVe8OxTMwGi8In+dwCks15c5vaTbamlfeDuQ==
X-Received: by 2002:a17:906:2d4a:: with SMTP id e10-v6mr4033911eji.105.1541080566033;
        Thu, 01 Nov 2018 06:56:06 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d23-v6sm730003ejk.21.2018.11.01.06.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:56:05 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a3720a0f-2d6b-f536-a306-df9676bc44a6@redhat.com>
Date:   Thu, 1 Nov 2018 14:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-10-18 23:27, Pierre-Louis Bossart wrote:
> 
>> Just thought it worth mentioning, this new patch that fixes sound
>> again, seems to have ressurected an old issue with PLL unlock.  I'm
>> seeing journal entries after fresh boot ......
>>
>> ```
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard systemd[462]: Started Sound Service.
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> picard kernel: max98090_pll_work: 141 callbacks suppressed
>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>> ```
>>
>> sound is ok, but sometimes plugging in headphones spams journal with
>> those PLL messages, and sound turns into "daleks", and I have to
>> remove/insert headphones few times or stop/start audio to fix it.
>> It's a very old issue, maybe you'd know more about it.
> 
> I noticed this error on my Orco device used for tests many moons ago, but I could never find out what led to this error case, it wasn't deterministic and didn't impact the audio quality. All I could do is rate_limit it... If we have an A vs. B situation it'd be really helpful to diagnose further.
> 
> Is there really a causality between the changes from Hans and this PLL unlock error?

That is actually not unlikely. We have the mclk as the source clk for the PLL
and if we enable/disable it and/or change the src-clk then the PLL will loose
its lock and it needs some time to re-lock.

So these errors indicate that we need to either:

1) Sleep a bit after enabling the mclk;
    (and/or after changing the PLL src clk I've not checked if this driver does this)
2) Or poll the PLL locked bit after enabling the mclk until it indicate it has locked
    (and/or after changing the PLL src clk)

I've had to do similar things in u-boot when turning on PLL-s for DRAM and
stuff, so this sounds familiar.

Dean since you have the hardware, this is probably easiest for you to fix
(since you can reproduce the issue) do you feel up to giving fixing this
a shot? I think it is fine if you just go with the simple solution of
adding a msleep(xx) at the right place. I would expect 10 (ms) to do
the trick. If that works you may also try to give 5ms a shot.

Regards,

Hans




