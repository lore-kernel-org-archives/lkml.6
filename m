Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED22C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240720879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAMHuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:50:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39660 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfAMHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:50:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so16279373edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 23:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I025xpD241uaN55YFkuyFumeY2Z2PvMYvk37nophzBw=;
        b=pDnDFJ2FtLQ6msn2vzRvpSAHQfXRLhN7ahBNyEe11FVcSUzktuiFk03FOKZv9u8fgf
         cD8PRRC1ufGZl4AC9WEk9V+qEk2cKqxWrfxvNSSX7TyqKT1qXD/G9kXa+nIaMQyK3lKx
         qmkfOGo3ZpwY8v1GGVs/3bsDwwLQy1ZgwihJ0w6CF21J7utmiLFPOZgOfVjO+TiUmmiP
         9LdW3F/J8ghAaHm3VTj6Ml/B7aPl6CalX8NqZ7Iw09CC48n1Hk4uTynXmPEIWKDRb5yM
         znSyPimL+/VVRNFVcnuxw6JsCHc7qmGLutTuQCuMdFQKXP5u4NRtMPf9X1xoo+qYK4y4
         btoQ==
X-Gm-Message-State: AJcUukdsmsnRO3E5lkfQKBzMHu3cKq0g5NbCHJK7/dbv8XLq4cD4WNBN
        DIcnMBp3AYlU9h4sVKkeKNkX21AkBQc=
X-Google-Smtp-Source: ALg8bN42mdIOru5OQvKjXiVXDec5kxIdk6tbxl9lgt5kgvFA+/qVX1oaKgrmLfFeTTWVqyDCkDybHA==
X-Received: by 2002:a17:906:c9c4:: with SMTP id hk4-v6mr5250940ejb.249.1547365830122;
        Sat, 12 Jan 2019 23:50:30 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i46sm3373327ede.62.2019.01.12.23.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 23:50:29 -0800 (PST)
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
 <20190111194929.GW9170@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fbb55ce7-0ca3-a1ad-249e-764840c46804@redhat.com>
Date:   Sun, 13 Jan 2019 08:50:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190111194929.GW9170@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-01-19 20:49, Andy Shevchenko wrote:
> On Fri, Jan 11, 2019 at 03:21:39PM +0100, Linus Walleij wrote:
>> On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> New quirk enforces search for GPIO based on its type.
>>> Note, supplied index in the mapping table must be 0.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> (...)
>>
>>>   sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
>>
>> Do we have an ACK from the maintainer of this file?
>> It's Hans I think. Ideally also from Mark Brown.
> 
> I hope to get Hans' Tested-by on this.

Yes I've testing this on my TODO.

Regards,

Hans

