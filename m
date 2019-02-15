Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE93C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E0A21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392855AbfBOJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:33:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33184 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:33:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id a2so7436100edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I3Mag6lulcw2eZON4r3dF5CSubHa/UMW0Xw4Y36qCKw=;
        b=G9x6ps+Ab0c0gPT7hlM5ejOrfJFIw9JdaVlf7ROHWdOxzg+epX0RO1vBSfVtCSzxaV
         tyw1KJ480nwnpg7uvY2NCGnxg/78iYjNhV/pJaNhvbpZpxy3CYdds5AE7iTkTJGh/hcc
         vqJHN2MY/nNrV5nu+87ESGNaVhce4ZPeq5+769ePPduNVVb4otEzWKsXrE/i7xh+kZSl
         L93qbdNyH2CA64YnWziDXYDLWTZSmB1azT+sngJF6GJ5ozwirEyyDdYvBGBwLidMW2g9
         GZJkQKSWmjuwPy3ePGRICxVxZs4f84uGgngELAjG+Vl6z6QJf09aboF3G6QxKtc/1VT1
         xrFw==
X-Gm-Message-State: AHQUAuaH9JfhlScGy6k8KGkhJscAijmh867MTH53X1SGtrWPULbwH0tl
        e9+k/VA9PFAB8NAVWk3qgA1Xug==
X-Google-Smtp-Source: AHgI3IbulHWJX8X36g4Bzzv1Ln6RKUpW1Cl7ppsAt3OwCDREAn+LVI6/GBLpdVq2N4m4BCG67ss/Ig==
X-Received: by 2002:a17:906:7805:: with SMTP id u5-v6mr6036322ejm.213.1550223222834;
        Fri, 15 Feb 2019 01:33:42 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a8sm1130102eju.52.2019.02.15.01.33.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:33:42 -0800 (PST)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
 <20190214124744.GT9224@smile.fi.intel.com>
 <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
 <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
 <CAHp75VfB3PMBH8qAyHJPfptd0POGq4pey3TkjzU6dZqZ_Vqt+Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4069f988-dda7-4e97-031d-ad494617ab4a@redhat.com>
Date:   Fri, 15 Feb 2019 10:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfB3PMBH8qAyHJPfptd0POGq4pey3TkjzU6dZqZ_Vqt+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-02-19 10:29, Andy Shevchenko wrote:
> On Fri, Feb 15, 2019 at 10:31 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 14-02-19 15:15, Yauhen Kharuzhy wrote:
> 
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
> 
> Depends on how code would look better,

Well the existing drivers/platform/x86/intel_cht_int33fe.c file,
which already is full of kludges would not get even more code-paths
added; and the new file which Yauhen will wrote should be nice and
clean with only 1 straight code-path pretty much.

> though I care about users that
> they will not get additional Kconfig option and broken their
> configurations when new piece of code landed up. So, from mine, as
> user, prospective, we may split driver as we wish, but we should get
> it working as previously for the existing cases.

That is a valid point, I'm not a fan of having even more Kconfig
options either, so we can simply enable/disable both modules through
the same Kconfig option.

Regards,

Hans
