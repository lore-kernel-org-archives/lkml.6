Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E35C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40192081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40192081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeKAXA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:00:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42697 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeKAXA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:00:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so16604039edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AbmvnSevefuGWbvOSlgWrhQZiW3LEijmOU4xV1hJo2Y=;
        b=Rbvv9FSIIp3zugPVqDzJnh/rFS0pBMcJwmdL1GQhY57tPSUpv69lJpn3jove6ddoCn
         4MRGRMhV5MPlglGQwqngpMskF/0y2NfOzNdqRRTszVTqe5iD5FfTl0JeZu7kBZH4PDDd
         JoNm4CpXHmIYeGqEwIEFocgRi4NfKuyRB8tOpbWwu5cCGlNpucxEJYnDezay1fV2A3qJ
         YiN5UeAyUi+nrI2XfvC8h3g0Ua3F1dbFBD/MGKTzyBPiVY7y97P2sHCzHqsooBKgtf0/
         PvOQVQAQ4ZIKtb6eP11MhN+2hPiPy2lHP351H0GIxX0FA0NrMDxokbMROCTHebIyqdF9
         lGCw==
X-Gm-Message-State: AGRZ1gL8cJgWj2VD2FTkZZ6+y3EYrIKydIpQp4TPLtLsMohVyIzutfwV
        Rben+QtlVWZQd/137JJ7hUBetg==
X-Google-Smtp-Source: AJdET5fAM1g1wZlH9SioJtH3tB97gmiW/qZ+7DxEmZr6KQVB/Vgfxb1RkLTwjgUthxhLHNak5VrIAw==
X-Received: by 2002:a50:ca47:: with SMTP id e7-v6mr5274431edi.56.1541080672660;
        Thu, 01 Nov 2018 06:57:52 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u7-v6sm4113154edo.40.2018.11.01.06.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:57:51 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
Date:   Thu, 1 Nov 2018 14:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181101103705.ay36te4qr5pxtgop@picard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-11-18 11:37, Dean Wallace wrote:
> On 31-10-18, Pierre-Louis Bossart wrote:
>>
>>> Just thought it worth mentioning, this new patch that fixes sound
>>> again, seems to have ressurected an old issue with PLL unlock.  I'm
>>> seeing journal entries after fresh boot ......
>>>
>>> ```
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard systemd[462]: Started Sound Service.
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> picard kernel: max98090_pll_work: 141 callbacks suppressed
>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>> ```
>>>
>>> sound is ok, but sometimes plugging in headphones spams journal with
>>> those PLL messages, and sound turns into "daleks", and I have to
>>> remove/insert headphones few times or stop/start audio to fix it.
>>> It's a very old issue, maybe you'd know more about it.
>>
>> I noticed this error on my Orco device used for tests many moons ago, but I
>> could never find out what led to this error case, it wasn't deterministic
>> and didn't impact the audio quality. All I could do is rate_limit it... If
>> we have an A vs. B situation it'd be really helpful to diagnose further.
>>
>> Is there really a causality between the changes from Hans and this PLL
>> unlock error? Are you 100% sure this was not present in the previous install
>> you used (4.18.14 as mentioned earlier in the thread)?
>>
>> Thanks
>>
>> -Pierre
>>
> Well, numerous boots, kernels, headphone inserting - no PLL or
> 'Daleks'.  My laptop must have been haunted that day (halloween).
> I'll put it to bed.

So you can no longer reproduce. Bummer. Note this might be caused by
the temperature of the laptop when you were running the tests...

Anyways if you hit this again and you can reproduce it, please
give adding a msleep(10) after code mucking with the clk a try.

Regards,

Hans

