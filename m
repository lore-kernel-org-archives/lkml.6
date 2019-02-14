Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C859E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502149AbfBNPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:32:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45082 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502158AbfBNPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:32:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id d9so5322163edh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkOf4AXprBcZmK6IkpkA8L6T1j3cs6bJ6JoAmzTYlbo=;
        b=Q1Q5jaq11huQcszhIaCbLq/mdV5E18PhGyHyeA1mOc88Bs5zXONfQRXytVkgOh/WNR
         dREdnHVkD6/bcaZaRh7LoSc4ddiCNPzR9o2/xrRZrn6a6crC0by8usrXFZLKiSUAVdif
         NKuowFVE5Krx7zuVv4CXK4444WTcr3dgARtbeSTwaMa6LSSJW2+j3O34NPtYyvCEFfmB
         h+aQ6bl51F9ai/dvnukCH5S4/eCgbpm07DkfqlrCc6i9jkeQvPNmgIglWw3VjX8+j8gJ
         1XE3q1bexbQ4jLPDYNMHyrQSisQnJ+mjKOiI4mgzV4V+mXBNPvFnwrViiBFhforrb+9c
         E5KA==
X-Gm-Message-State: AHQUAuYu0CE0jmcqj6loP89rHxWsRgqK3M3zKIqsEGx3DZiZBAtFa5iE
        +w0WD7+1hE+eIF1JvYB0IBqpLQ==
X-Google-Smtp-Source: AHgI3IYeM1FXUTfHeaqeu/isE3D7Hp1WQh0LHPnESgXH7Pm3AX0WyzFWgPY/yNKQi/WOu/H03weYyg==
X-Received: by 2002:a17:906:50a:: with SMTP id j10mr3217030eja.236.1550158358856;
        Thu, 14 Feb 2019 07:32:38 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z15sm607007eju.7.2019.02.14.07.32.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 07:32:37 -0800 (PST)
Subject: Re: [PATCH 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-2-jekhor@gmail.com>
 <767c3d5e-f521-4d59-3922-a322b4124126@redhat.com>
 <20190214070943.GB16597@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4bda8c03-5517-3627-f82e-d6bce0c4f340@redhat.com>
Date:   Thu, 14 Feb 2019 16:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214070943.GB16597@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-02-19 08:09, Yauhen Kharuzhy wrote:
> On Thu, Feb 14, 2019 at 12:15:00AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
>>> Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
>>> of charger detection procedure. Do this by manipulationg of CHGRCTRL1
>>> register.
>>>
>>> Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
>>> Intel's drivers.
>>
>> Hmm, of the ACPI code is updating the otg-mode, then there should be
>> no reason for us to do this, can you provide an acpidump of your
>> device please?
> 
> sure: https://github.com/jekhor/yogabook-linux/blob/master/yoga/acpi/yoga.acpidump.log
> 
> Yes, there is ACPI routine for switching this but it is not called at
> IRQ handling because it is handled by extcon driver. See my notes here:
> https://github.com/jekhor/yogabook-linux/blob/master/yoga/acpi/investigate.txt#L364

The reason the _E12 and/or _E1F methods are not called is because
they are GPIO interrupt handlers for virtual GPIOs on the PMIC,
this is another abomination on these devices, that the ACPI GPIO
interface is abused to make it look like the PMIC has more GPIOs
then it really does and a bunch if them are used either to create
event handlers for no-one knows which events exactly, where as
the 0x20 - 0x55 ones are write-only virtual GPIOs where writing
them is supposed to do no-one knows what.  For some reason the
people who engineered this decided it was not a good idea to have
the AML code actually just directly talk to the hardware (except
that in other cases it does of course) and it goes through these
fake GPIOs which presumably are implemented by the Windows GPIO
driver for the PMIC

Note that we do implement the custom opregion 0x8F for the INT34D3
/ PMI5 device, so the GET/SET calls could work, except that we
have the following bug:

  -drivers/acpi/pmic/intel_pmic.c intel_pmic_regs_handler is wrong,
   assumes everything is a write, read of address 3 should return last value
   read on writing 0 to address 4, see the GET method on INT34D3 / PMI5

Even if we fix that bug though, there still is the issues that we:

1) Do not know when to execute the _E12 and/or _E1F methods
2) Do not know what to do of any of the "virtual" GPIOs are written
3) There is no valid ACPI battery interface for querying battery status

So we are better of just not executing the _E12 and/or _E1F methods
ever and directly talking to the hardware.

<grumble mode on>
If only the engineers who did the firmware interface for these
devices had actually known what they were doing.
</grumble mode>

Regards,

Hans

