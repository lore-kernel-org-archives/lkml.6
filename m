Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeDZH0F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:26:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeDZH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:26:01 -0400
X-Google-Smtp-Source: AIpwx49qGoC2y1VR5KiHYbI/8V9KEaTgsEYpEF3pYMJfJfV1my3k6ClEQcuKPhCkuImqjpMzTX2i5g==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v4 1/3] dell-led: Change dell-led.h to dell-common.h
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hbme8lge5.wl-tiwai@suse.de>
Date: Thu, 26 Apr 2018 15:25:53 +0800
Cc: mario.limonciello@dell.com, pali.rohar@gmail.com, andy@infradead.org,
        dvhart@infradead.org, mjg59@srcf.ucam.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <45CFE5AD-EA91-47B4-BF4E-846D7135A5FD@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <s5hbme8lge5.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 25, 2018, at 12:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 20 Apr 2018 11:44:30 +0200,
> Kai-Heng Feng wrote:
>> This header will be used for more than just led. Change it to a more
>> generic name.
>>
>> Cc: Mario Limonciello <mario.limonciello@dell.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> BTW, wouldn't it be better postpone the rename?
> Renaming a file in a cross-tree patchset makes harder to apply in
> general.
>

You are right, I'll keep the original filename in next version.

Kai-Heng

>
> thanks,
>
> Takashi
>
>> ---
>> v4: Change the commit message to clarify there's no more runtime pm
>>     warning.
>>     Also skip the check for thunderbolt attached devices.
>>
>> v3: Simplify dell_switchable_gfx_is_enabled() by returning bool instead
>>     of error code.
>>     Use DMI_DEV_TYPE_OEM_STRING to match Dell System.
>>
>> v2: Mario suggested to squash the HDA part into the same series.
>>
>>  drivers/platform/x86/dell-laptop.c          | 2 +-
>>  include/linux/{dell-led.h => dell-common.h} | 4 ++--
>>  sound/pci/hda/dell_wmi_helper.c             | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>  rename include/linux/{dell-led.h => dell-common.h} (61%)
>>
>> diff --git a/drivers/platform/x86/dell-laptop.c  
>> b/drivers/platform/x86/dell-laptop.c
>> index c52c6723374b..8ba820e6c3d0 100644
>> --- a/drivers/platform/x86/dell-laptop.c
>> +++ b/drivers/platform/x86/dell-laptop.c
>> @@ -29,7 +29,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/i8042.h>
>>  #include <linux/debugfs.h>
>> -#include <linux/dell-led.h>
>> +#include <linux/dell-common.h>
>>  #include <linux/seq_file.h>
>>  #include <acpi/video.h>
>>  #include "dell-rbtn.h"
>> diff --git a/include/linux/dell-led.h b/include/linux/dell-common.h
>> similarity index 61%
>> rename from include/linux/dell-led.h
>> rename to include/linux/dell-common.h
>> index 92521471517f..37e4b614dd74 100644
>> --- a/include/linux/dell-led.h
>> +++ b/include/linux/dell-common.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __DELL_LED_H__
>> -#define __DELL_LED_H__
>> +#ifndef __DELL_COMMON_H__
>> +#define __DELL_COMMON_H__
>>
>>  int dell_micmute_led_set(int on);
>>
>> diff --git a/sound/pci/hda/dell_wmi_helper.c  
>> b/sound/pci/hda/dell_wmi_helper.c
>> index 1b48a8c19d28..56050cc3c0ee 100644
>> --- a/sound/pci/hda/dell_wmi_helper.c
>> +++ b/sound/pci/hda/dell_wmi_helper.c
>> @@ -4,7 +4,7 @@
>>   */
>>
>>  #if IS_ENABLED(CONFIG_DELL_LAPTOP)
>> -#include <linux/dell-led.h>
>> +#include <linux/dell-common.h>
>>
>>  enum {
>>  	MICMUTE_LED_ON,
>> -- 
>> 2.17.0
