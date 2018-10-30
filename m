Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5320657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA5320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJaDrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:47:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeJaDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:47:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so5583641wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uSJZDchg3STA2ei1ezY/bwG1hzGRPLQxANLFffduMeU=;
        b=qhdId1cZz1nyi8YbgPzs+yRrazYcUfCQhFLIv77LUkFXYfmFBetF0osKcT1GqMn7Sh
         IQAP64lXQpLUUbAJ6NZ/LQyShLy/0cpJqP6hkCkw7wA8pTfB1raItQqYZuBsismDBN6G
         zmbMbFhsEqMDzSGPNzGG1K6oVfzwzIaRYrwhR0m2FdEP2sNkgrnzExt2n76bvm4RWiYb
         Y/RRnPId/0cA4WmARBlHE7PZ+OJDuSyPAB2FY+N4/1uNAUM1N3KkqFe/0G4auPFZtE2B
         yrd7k+jjNTJeZurLFDMhkFy1BsY+6amlv7usWo7n7jZ3epxC49fBy0keRbEUEoSg8kKO
         /mBg==
X-Gm-Message-State: AGRZ1gKxqiJCq1ao3rPpXQ6oqj40eJkGrfIdhm1AWt+UILRl7IuM/P0d
        KiM4xVoDPouvbuxS75SdXNVGFA==
X-Google-Smtp-Source: AJdET5f16QsTMU3XexgJazxQdQWxs/ivanefl3q3kCN1OIUbOeWE67KtMY4fJ3YPkQB/58bpl8osbQ==
X-Received: by 2002:adf:e7cd:: with SMTP id e13-v6mr59870wrn.115.1540925553922;
        Tue, 30 Oct 2018 11:52:33 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m2-v6sm21623890wrj.80.2018.10.30.11.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:52:33 -0700 (PDT)
Subject: Re: [RFC][PATCH v1] ACPI / scan: Create platform device for BOSC0200
 ACPI nodes
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Steven Presser <steve@pressers.name>,
        Bastien Nocera <hadess@hadess.net>
References: <20181030144706.6737-1-andriy.shevchenko@linux.intel.com>
 <3e34f7c0-e747-7393-4b79-317b8483f0a6@redhat.com>
Message-ID: <93b9b138-2e58-8fcc-f86d-688afc3a59c1@redhat.com>
Date:   Tue, 30 Oct 2018 19:52:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3e34f7c0-e747-7393-4b79-317b8483f0a6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-10-18 16:27, Hans de Goede wrote:
> Hi,
> 
> On 30-10-18 15:47, Andy Shevchenko wrote:
>> On some laptops the ACPI device with BOSC0200 _HID is representing
>> two accelerometers under one node.
>>
>> We add an ID to the I2C multi instantiate list to enumerate
>> all I2C slaves correctly.
> 
> I believe that overall the approach here is correct, but I've
> several (at least 4 different models) devices which use the
> BOSC0200 _HID but with only 1 accelerometer / 1 I2cSerialBus
> resource in the _CRS table.
> 
> So I believe that you need to add a new optional bool to
> struct i2c_inst_data and ignore i2c_acpi_new_device()
> returning NULL when this is set (and set it for the second
> accelerometer).
> 
> i2c_unregister_device can handle NULL, so some entries
> of the multi->clients[i] array ending up as NULL is not
> a problem.
> 
> Hmm, I have just realized that there is another issue
> which is a real problem, we have stuff like this:
> 
> [hans@shalem linux]$ ack BOSC0200 /lib/udev/hwdb.d/60-sensor.hwdb
> sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnD2D3_Vi8A1:*
> sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnX1D3_C806N:*
> sensor:modalias:acpi:BOSC0200*:dmi:*:svn*CHUWIINNOVATIONANDTECHNOLOGY*:pnHi10protablet:*
> sensor:modalias:acpi:BOSC0200*:dmi:*:svnHampoo:pnP02BD6_HI-122LP:*
> # match the entire dmi-alias, assuming that the use of a BOSC0200 +
> sensor:modalias:acpi:BOSC0200*:dmi:bvnAmericanMegatrendsInc.:bvr5.11:bd05/07/2016:svnDefaultstring:pnDefaultstring:pvrDefaultstring:rvnHampoo:rnCherryTrailCR:rvrDefaultstring:cvnDefaultstring:ct3:cvrDefaultstring:
> sensor:modalias:acpi:BOSC0200*:dmi:bvnAmericanMegatrendsInc.:bvr5.11:bd05/28/2016:svnDefaultstring:pnDefaultstring:pvrDefaultstring:rvnHampoo:rnCherryTrailCR:rvrDefaultstring:cvnDefaultstring:ct3:cvrDefaultstring:
> sensor:modalias:acpi:BOSC0200*:dmi:bvnINSYDECorp.:bvrjumperx.T87.KFBNEE*
> sensor:modalias:acpi:BOSC0200*:dmi:*:svnJumper:pnEZpad:*:rvr.A006:*
> sensor:modalias:acpi:BOSC0200:BOSC0200:dmi:*ThinkPadYoga11e3rdGen*
> sensor:modalias:acpi:*BOSC0200*:dmi:*:svnLENOVO*:pn80XF:*
> sensor:modalias:acpi:*BOSC0200*:dmi:*:svnLENOVO*:pn80XE:*
> sensor:modalias:acpi:BOSC0200*:dmi:*:svnLINX*:pnLINX1010B:*
> 
> And using i2c-multi-instantiate will change the modalias from
> acpi:BOSC0200 to i2c:bmc150_accel breaking this.
> 
> One way to fix this would be making sure we only use an
> i2c:bmc150_accel modalias for the second device. This will
> also allow differentiating between the 2 in hwdb quirks for
> devices with 2 accelerometers. But the way we currently
> generate modalias-es does not allow doing this in an
> easy way. Making this possible will require some changes to
> show_modalias() and i2c_device_uevent() in
> drivers/i2c/i2c-core-base.c

Ok, new idea how about we modify the code in acpi_device_enumeration_by_parent
to instead of looking at a HID list, to simply count if there is more then
1 I2cSerialBus resource and if that is the case enumerate the device as
a platform device for i2c-multi-instantiate.c to handle. This means that
we will only change the way how the BOSC0200 is enumerated on the
Yoga 11e and not elsewhere.

This is somewhat likely to trigger a regression somewhere, but we should
be able to fix those regressions by adding the necessary info to
i2c-multi-instantiate.c.  Then it could still be a problem because of
the modalias changing for an i2c device from some other DSDT which we
are not aware of yet, but that only is a problem if the modalias is
used in hwdb. The actual driver for the hardware should bind to the
new modalias too and if not we can fix that.

I believe the amount of devices which turn out to have more then 1
I2cSerialBus resource will be small and the set of devices which are already
working somehow (because the 1st resource is the one we care about) and also
have a hwdb entry will likely be very small and we can help users who
hit this combo by providing hwdb patches.

...

Hmm, a quick random spot check of a few of the too many DSTDs I have
turns out that at least the INT34D3 (Intel Whiskey Cove PMIC) will
be bitten by this. This is trivial to fix though.

And another one is the "CPLM3218" ambient light sensor, which does
not have an in tree driver, but there is an out of tree one which
is on my list to upstream...

This will also cause us to stop generating i2c-clients for some of
the camera sensors on BYT/CHT since some list multiple (some up to 10 ???)
addresses I guess this is for some sorta auto-probe function in
the windows drivers.

TL;DR: the idea of just checking for multiple I2cSerialBus resources
in a single acpi_fwnode is interesting, but might cause more problems
then I would hope.

Regards,

Hans


