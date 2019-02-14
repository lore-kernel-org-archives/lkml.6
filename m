Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8720823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439171AbfBNPFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:05:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46311 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbfBNPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:05:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so5235941edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgC5wxtUFnsU6ZsQzgP5OIPESwXBrDNLWHcm6mEH0mQ=;
        b=bgGHiEBFFsZHtQc5GwjVTFzx+lW3QUovmimP9UlDCmCwxWmYGez/jK3tCXoQyAfPlu
         ihdXrM5lwtXJeckXjOFoHzxqQMSOzMPykxGESLijw2heUWDquhhzp8VktA+W3wf8kDrT
         IQL2ytOt1oTQ3D8Bt4niDjuX04grJISINW3G1hyjja+UwryU+u+K77uMy9LOiNeZFdQz
         51CGFmY84n5jMek3U1S6T4+hl6bWlr0Iv0lhHUaEtam562nasOb+UUx4RGRFoYPXiOOa
         G09m/cwu6JTVhKUXKqEPliI6m0p4+MMA7krvJ6o9Xj57SGkKJkKi/ryIBilJPE56aO2k
         NCQw==
X-Gm-Message-State: AHQUAuaVF/IIi+65hg/5267eiUjPjddnPfEI9uC9YXsthbaJEzFUvLIY
        zj6DXHJ/X6TqwOdUzCIRi3qTdQ==
X-Google-Smtp-Source: AHgI3IYpnE0wnPkxqjFm92MYU/Vm6fChX5QldxDeevdlTZo52QHRWttB/K3XxF3itgVje9rjfGFjyQ==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr3468561edb.141.1550156728521;
        Thu, 14 Feb 2019 07:05:28 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o20sm149210eja.19.2019.02.14.07.05.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 07:05:27 -0800 (PST)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
 <20190214124744.GT9224@smile.fi.intel.com>
 <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
Date:   Thu, 14 Feb 2019 16:05:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-02-19 15:15, Yauhen Kharuzhy wrote:
> 
> 
> чц, 14 лют 2019, 15.47: карыстальнік Andy Shevchenko <andriy.shevchenko@linux.intel.com <mailto:andriy.shevchenko@linux.intel.com>> напісаў:
> 
>     On Thu, Feb 14, 2019 at 12:00:44AM +0100, Hans de Goede wrote:
>      > On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> 
>      > A kind request to the platform-x86 driver maintainers (hi Andy): Please
>      > do not apply these patches until I've been able to test they don't cause
>      > issues elsewhere.
> 
>     Yes, that's my plan from the day one.
> 
>     I also asked Yauhen to keep you in Cc list for all patches regarding the
>     platform he is enabling. On his GH page you may find, btw, a pile of patches.
>     I hope we will not get a patch bomb at once.
> 
> 
> 
> Yes, I plan to propose remained patches only after discussing and accepting already sent series and some reworking.
> 
> 
> The charger-related part will be very discussable.

Yes I just took a look at the patches from your kernel-tree at github,
it seems this is another quite "interesting" Cherry Trail device.

Oh if only the engineers who designed these had just use ACPI as intended
instead of doing a bunch of spaghetti code and duck-taping it all together
with proprietary / vendor-specific ACPI opregions. Ah well.

Note I see that your DSDT does not have any *valid* ACPI battery device
(PNP0C0A dev), so we need to directly talk to the fuel-gauge. I also see
that you already have some WIP code for this, good.

Taking a quick peek I also noticed the changes you did for the
drivers/i2c/busses/i2c-cht-wc.c code instantiating the charger device.

I think it would be better to instead of using DMI matching, to
actually probe which device is there, you can create a dummy
client on the adapter after the i2c_add_adapter call using:
i2c_new_dummy() and then you can do an smbus byte read from
register 0x14, on the bq24292i which the other devices with a wcove
pmic have you will get 0xff then since the addresses on the
bq24292i only go up to 0x0a and on the bq2589x your device has
you should then actually be able to check the device id you expect.

If you do this, please also read and check the 0x0a device-id register
of the bq24292i if the 0x14 check fails, I can test this. For the
bq24292i the expectation is for bits 3-5 to encode the value 3 (011).

If you go this route, I would also advice to change the:

if (acpi_dev_present("INT33FE", NULL, -1)) {
	....
}

To:

if (!acpi_dev_present("INT33FE", NULL, -1))
	goto done;

So that you don't get a too deep indentation level, making
the end result look something like this:


if (!acpi_dev_present("INT33FE", NULL, -1))
	goto done;

test_client = i2c_new_dummy(&adap->adapter, 0x14);
// test for bq25892 or bq24292i
i2c_unregister_device(test_client);
// register correct device, this must be done after
// unregister-ing the dummy to avoid an EBUSY error on the address

done:
platform_set_drvdata(pdev, adap);
return 0;

###

I would do something similar with the fuel-gauge in
drivers/platform/x86/intel_cht_int33fe.c, one option would
be to simply count the number of resources in the ACPI
resource table for the INT33FE device, versions with
the Type-C port have 7 resources, where as your INT33FE
device has only 3.

I'm even thinking that it might be best to rename
intel_cht_int33fe.c to intel_cht_int33fe_typec.c and add
a check for the resource table having 7 entries there, then
you can make a intel_cht_int33fe_micro_usb.c copy and strip
that mostly empty. Both would bind to the same "INT33FE"
id and they would both silently bail with -ENODEV if the
resource-count (or the PTYP value) don't match.

The reason I'm thinking of having 2 drivers is because
the current intel_cht_int33fe.c is quite special / ugly and
already has enough ifs.

If you do a stand-alone intel_cht_int33fe_micro_usb.c that can
hopefully be much simpler.

Andy what is your take on having separate intel_cht_int33fe_typec.c
and intel_cht_int33fe_micro_usb.c drivers, both binding to
the "INT33FE" ACPI-ID (with its totally !@#%$#-ed up "API") ?

Having 2 drivers bind to the same id and exit silently with -ENODEV
is somewhat normal for USB ids where we also sometimes have these
kinda ID clashes with different devices hiding behind the same id.

Regards,

Hans
