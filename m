Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CC12192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4T9VnUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfBOHBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:01:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36213 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfBOHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:01:08 -0500
Received: by mail-yw1-f65.google.com with SMTP id 189so3349109ywi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DxrEJRnVeD1XMZONp0s8zMWw6hgP/1QxLyDlLOJ/tQM=;
        b=t4T9VnUkKHp05Q5iqH98ggqao1htyrRqrN6e5eCEPdGxC+5gdp59fLNiAAaOm3zim6
         9tRTXp814knmJ9uMN0qq1mPo2OFUbOGh5pzb4FUkO4tQKIdf4hHt2ev2ALTTy0F0Umpk
         omQ5UMPgsx3xGd8hrBIzoYdtnqLGcu8GACrv6vcpAVl92U0spCI6Hmb+yUe4uv3upMbM
         E+38J8lfWTEy6ZUdfzpk0vcPMBghol9KBQuIRaGJHjk+HVFAFbmGEg48rPucJovUfzNT
         zmrGeQWJddM/WzePegSEaeVQ8IkpTDSsunLnkUe6JBTPk3Qn+IM7qALJ/WZLaD5G1LoT
         M1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DxrEJRnVeD1XMZONp0s8zMWw6hgP/1QxLyDlLOJ/tQM=;
        b=QMCc2lrrU24EeJyZJxAKQLmKuYYfUQ2lwVdMOOI5fQarUj2f6i0/7NmeAh0Rxg0o0i
         UlrKHWc6H07n+s4hLUA5ALzJYGLz8EedxpqfTragI13kO0QojHkQhFPHoXLynY4Yonct
         2NNfAjgoIH8Hakl8CcseC/pXiRR0y3I2vRh2EEJSKbQB6ouuqx03+n/LDhyntt5FekL1
         CkqnJtUERfBiUuv1kOgByjfXJA24gbVKw30Jpl11KUX4jpAfhFjEkyMMvOhiXVO0TKP4
         fXDD0PUDBVAfLAk6rqM6kyGed6WljH4vk/fNcYLQ4jO9oyOqDJmRTS6w5YN7bbGHAUWL
         Dv5g==
X-Gm-Message-State: AHQUAuYRGvqCw6ukciexH/NPvPoNBAv82r9rWbztm6S3YQLzfSqjB6Cy
        cgWJzsBwV7RqsyblXk/0kzb5JCbP
X-Google-Smtp-Source: AHgI3IZv/UTmdTK8NbMf2xdxNzJBxWD477DE1bz05e/6XDUnLp+EFIErwN4Iktwh3+pqgx1YrDyuuw==
X-Received: by 2002:a0d:c644:: with SMTP id i65mr6730032ywd.68.1550214067063;
        Thu, 14 Feb 2019 23:01:07 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.99])
        by smtp.gmail.com with ESMTPSA id y67sm1759487ywf.89.2019.02.14.23.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 23:01:05 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guXUd-0002Jj-EX; Fri, 15 Feb 2019 10:01:03 +0300
Date:   Fri, 15 Feb 2019 10:01:03 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
Message-ID: <20190215070103.GC30250@jeknote.loshitsa1.net>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
 <20190214124744.GT9224@smile.fi.intel.com>
 <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
 <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 04:05:26PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 14-02-19 15:15, Yauhen Kharuzhy wrote:
> > 
> > 
> > чц, 14 лют 2019, 15.47: карыстальнік Andy Shevchenko <andriy.shevchenko@linux.intel.com <mailto:andriy.shevchenko@linux.intel.com>> напісаў:
> > 
> >     On Thu, Feb 14, 2019 at 12:00:44AM +0100, Hans de Goede wrote:
> >      > On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> > 
> >      > A kind request to the platform-x86 driver maintainers (hi Andy): Please
> >      > do not apply these patches until I've been able to test they don't cause
> >      > issues elsewhere.
> > 
> >     Yes, that's my plan from the day one.
> > 
> >     I also asked Yauhen to keep you in Cc list for all patches regarding the
> >     platform he is enabling. On his GH page you may find, btw, a pile of patches.
> >     I hope we will not get a patch bomb at once.
> > 
> > 
> > 
> > Yes, I plan to propose remained patches only after discussing and accepting already sent series and some reworking.
> > 
> > 
> > The charger-related part will be very discussable.
> 
> Yes I just took a look at the patches from your kernel-tree at github,
> it seems this is another quite "interesting" Cherry Trail device.
> 
> Oh if only the engineers who designed these had just use ACPI as intended
> instead of doing a bunch of spaghetti code and duck-taping it all together
> with proprietary / vendor-specific ACPI opregions. Ah well.
> 
> Note I see that your DSDT does not have any *valid* ACPI battery device
> (PNP0C0A dev), so we need to directly talk to the fuel-gauge. I also see
> that you already have some WIP code for this, good.
> 
> Taking a quick peek I also noticed the changes you did for the
> drivers/i2c/busses/i2c-cht-wc.c code instantiating the charger device.
> 
> I think it would be better to instead of using DMI matching, to
> actually probe which device is there, you can create a dummy
> client on the adapter after the i2c_add_adapter call using:
> i2c_new_dummy() and then you can do an smbus byte read from
> register 0x14, on the bq24292i which the other devices with a wcove
> pmic have you will get 0xff then since the addresses on the
> bq24292i only go up to 0x0a and on the bq2589x your device has
> you should then actually be able to check the device id you expect.
> 
> If you do this, please also read and check the 0x0a device-id register
> of the bq24292i if the 0x14 check fails, I can test this. For the
> bq24292i the expectation is for bits 3-5 to encode the value 3 (011).

Sounds reasonable. I don't like approach when we store information about
I2C devices inside of I2C bus driver but this kind of autodetection
seems to be lesser evil than a DMI matching.

> 
> If you go this route, I would also advice to change the:
> 
> if (acpi_dev_present("INT33FE", NULL, -1)) {
> 	....
> }
> 
> To:
> 
> if (!acpi_dev_present("INT33FE", NULL, -1))
> 	goto done;
> 
> So that you don't get a too deep indentation level, making
> the end result look something like this:
> 
> 
> if (!acpi_dev_present("INT33FE", NULL, -1))
> 	goto done;
> 
> test_client = i2c_new_dummy(&adap->adapter, 0x14);
> // test for bq25892 or bq24292i
> i2c_unregister_device(test_client);
> // register correct device, this must be done after
> // unregister-ing the dummy to avoid an EBUSY error on the address
> 
> done:
> platform_set_drvdata(pdev, adap);
> return 0;
> 
> ###
> 
> I would do something similar with the fuel-gauge in
> drivers/platform/x86/intel_cht_int33fe.c, one option would
> be to simply count the number of resources in the ACPI
> resource table for the INT33FE device, versions with
> the Type-C port have 7 resources, where as your INT33FE
> device has only 3.
> 
> I'm even thinking that it might be best to rename
> intel_cht_int33fe.c to intel_cht_int33fe_typec.c and add
> a check for the resource table having 7 entries there, then
> you can make a intel_cht_int33fe_micro_usb.c copy and strip
> that mostly empty. Both would bind to the same "INT33FE"
> id and they would both silently bail with -ENODEV if the
> resource-count (or the PTYP value) don't match.
> 
> The reason I'm thinking of having 2 drivers is because
> the current intel_cht_int33fe.c is quite special / ugly and
> already has enough ifs.
> 
> If you do a stand-alone intel_cht_int33fe_micro_usb.c that can
> hopefully be much simpler.
> 
> Andy what is your take on having separate intel_cht_int33fe_typec.c
> and intel_cht_int33fe_micro_usb.c drivers, both binding to
> the "INT33FE" ACPI-ID (with its totally !@#%$#-ed up "API") ?
> 
> Having 2 drivers bind to the same id and exit silently with -ENODEV
> is somewhat normal for USB ids where we also sometimes have these
> kinda ID clashes with different devices hiding behind the same id.

Hmm... And we need to handle case when all three INT33FE devices are
enabled in the DSDT...

Instead of separating of driver to two (and more when we will find new
CHT device...) I think about some kind of configuration variants table
with selection by PTYP/resource count/etc. But typeC devices will
require to define interconnections for example and we will get yet
another hardly readable code with quirks, autodetection magic and big
constant tables...

OK, I plan to start to make some experiments with this at weekend.

-- 
Yauhen Kharuzhy
