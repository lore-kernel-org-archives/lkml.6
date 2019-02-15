Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD443C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A9821925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404003AbfBOJ0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:26:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41728 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfBOJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:26:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so7369591eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjDqxUzQ4iCx9u6GGJkH0PZ3NpZqIq6Io1QGiYt8yrM=;
        b=pI2O5Ht74PMUG83ndwqEbVvdxL9whnC70JxwHmrWWzd908YSaeMHxjIRTLbwwLkPir
         soIaDeljFrJHY9kx7mjX1XcC/BEtXVlfggyEAURmUfOetbKVmuzh0YrRqFmZeMNQ9BT1
         e+bUxfKTv9TnDAsoQLogFkqlfkbV7IwKYoRmuPJHt7RUFs7omCOZMKav92Qr+wkqK95t
         DRy3bC6lyjkWEkS07goWaHv53fKsFfwQ8Fu6ZMjfR0diOGMDLqeP2aojKwQUZXRYVdus
         IUsrj9QM0GA4mgWC+pOpV1uWAbFw5iostnuIaiZkvd7QmzSDQ23dNtblhL9ha9u+Vegi
         d9OA==
X-Gm-Message-State: AHQUAuabQj2HJvT9hMipaEsqzzUIeLFKMG88aaiUb2DP/9n6rEJnTh8g
        9gV76fzCiHOrAmvZeRtcw7wURw==
X-Google-Smtp-Source: AHgI3IaPXLqQTrjVB4HFbMZohcZDmKXqQMXYpENHnavuNtI9KkJIfC50p1cvdQJdd9JQbCCvbl9bTw==
X-Received: by 2002:a17:906:33c1:: with SMTP id w1-v6mr5947979eja.49.1550222792276;
        Fri, 15 Feb 2019 01:26:32 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s7sm850451edr.86.2019.02.15.01.26.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:26:31 -0800 (PST)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
 <20190214124744.GT9224@smile.fi.intel.com>
 <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
 <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
 <20190215070103.GC30250@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <952f3152-bf02-beff-7841-a414566912e9@redhat.com>
Date:   Fri, 15 Feb 2019 10:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215070103.GC30250@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-02-19 08:01, Yauhen Kharuzhy wrote:
> On Thu, Feb 14, 2019 at 04:05:26PM +0100, Hans de Goede wrote:

<snip>

>> I would do something similar with the fuel-gauge in
>> drivers/platform/x86/intel_cht_int33fe.c, one option would
>> be to simply count the number of resources in the ACPI
>> resource table for the INT33FE device, versions with
>> the Type-C port have 7 resources, where as your INT33FE
>> device has only 3.
>>
>> I'm even thinking that it might be best to rename
>> intel_cht_int33fe.c to intel_cht_int33fe_typec.c and add
>> a check for the resource table having 7 entries there, then
>> you can make a intel_cht_int33fe_micro_usb.c copy and strip
>> that mostly empty. Both would bind to the same "INT33FE"
>> id and they would both silently bail with -ENODEV if the
>> resource-count (or the PTYP value) don't match.
>>
>> The reason I'm thinking of having 2 drivers is because
>> the current intel_cht_int33fe.c is quite special / ugly and
>> already has enough ifs.
>>
>> If you do a stand-alone intel_cht_int33fe_micro_usb.c that can
>> hopefully be much simpler.
>>
>> Andy what is your take on having separate intel_cht_int33fe_typec.c
>> and intel_cht_int33fe_micro_usb.c drivers, both binding to
>> the "INT33FE" ACPI-ID (with its totally !@#%$#-ed up "API") ?
>>
>> Having 2 drivers bind to the same id and exit silently with -ENODEV
>> is somewhat normal for USB ids where we also sometimes have these
>> kinda ID clashes with different devices hiding behind the same id.
> 
> Hmm... And we need to handle case when all three INT33FE devices are
> enabled in the DSDT...

I would not worry about that, I've never seen that and even then
counting the resources + the PTYP check should catch this.

> Instead of separating of driver to two (and more when we will find new
> CHT device...) I think about some kind of configuration variants table
> with selection by PTYP/resource count/etc. But typeC devices will
> require to define interconnections for example and we will get yet
> another hardly readable code with quirks, autodetection magic and big
> constant tables...

Right, the issue is the code for the variant with the Type-C connector
is just quite ugly, also with the cht_int33fe_check_for_max17047 firmware
bug workaround, I would prefer to keep that isolated to a single
file for just the devices which need all these kludges.

The version for your device should be much cleaner and if we need
another variant we can maybe make your version be a generic version
for this with some config table, but adding more special casing to
the current code is not a good idea IMHO.

> OK, I plan to start to make some experiments with this at weekend.

Sounds good.

Regards,

Hans

