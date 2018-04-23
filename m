Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeDWMon (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:44:43 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:13961
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754872AbeDWMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:44:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DMAQC/1N1a/2LzzssNThwBAQEEAQEKA?=
 =?us-ascii?q?QGEJIEig2qVPQEBAQEBAQaBI4EPjmmEFxSBXQcjC4RIAoMDNRcBAgEBAQEBAQK?=
 =?us-ascii?q?BCIUuAQEBAQIBIxUWHQ4FCwsNBQYCAiYCAjEYDgYBBwUGAgEBGQSEYQUXqFZtg?=
 =?us-ascii?q?hwahD6DZYIugQmEX4MwgQeBMoJogxEDgUeDGIJUApdzBwGFXIhegXWFboRxK4k?=
 =?us-ascii?q?LiBwdAYIIMxoIKAg7gkMJiweDGYI3XQGNZimCHQEB?=
X-IPAS-Result: =?us-ascii?q?A2DMAQC/1N1a/2LzzssNThwBAQEEAQEKAQGEJIEig2qVPQE?=
 =?us-ascii?q?BAQEBAQaBI4EPjmmEFxSBXQcjC4RIAoMDNRcBAgEBAQEBAQKBCIUuAQEBAQIBI?=
 =?us-ascii?q?xUWHQ4FCwsNBQYCAiYCAjEYDgYBBwUGAgEBGQSEYQUXqFZtghwahD6DZYIugQm?=
 =?us-ascii?q?EX4MwgQeBMoJogxEDgUeDGIJUApdzBwGFXIhegXWFboRxK4kLiBwdAYIIMxoIK?=
 =?us-ascii?q?Ag7gkMJiweDGYI3XQGNZimCHQEB?=
X-IronPort-AV: E=Sophos;i="5.49,318,1520870400";
   d="scan'208";a="99386526"
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
To: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Finn Thain <fthain@telegraphics.com.au>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com>
 <CAMuHMdVQea-tQ4vQF=SrkCCqaRCRyo=aBiAuyv7p0z0FEi3r2g@mail.gmail.com>
 <CAK8P3a2FNU2k=nzE=FCt=2GL2x=-UdhkFGUJQqFe-h8FfMZRdw@mail.gmail.com>
 <CAMuHMdXPnKGJYLPm-DrmtMiJ30z0f=+5EJMp3NuuibuP_3A-3w@mail.gmail.com>
 <CAK8P3a1doCAdW4-=C0rKAvm+LUwsZyJUTOqz_JafWrFWzADiyw@mail.gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <2fb70226-d0ef-0a90-3c88-9d8f1b1f3f24@linux-m68k.org>
Date: Mon, 23 Apr 2018 22:44:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1doCAdW4-=C0rKAvm+LUwsZyJUTOqz_JafWrFWzADiyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/18 21:47, Arnd Bergmann wrote:
> On Mon, Apr 23, 2018 at 11:47 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Hi Arnd,
>>
>> On Mon, Apr 23, 2018 at 11:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Mon, Apr 23, 2018 at 11:07 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Fri, Apr 20, 2018 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Thu, Apr 19, 2018 at 8:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>>>>>> on 32bit systems. Moreover on m68k architecture, we have implemented generic
>>>>>> RTC drivers that can be used to compensate the system suspend time. So
>>>>>> we can remove the obsolete read_persistent_clock().
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>
>>>>> I'm not sure about this one: it's still possible to turn off
>>>>> CONFIG_RTC_DRV_GENERIC
>>>>> on M68KCLASSIC, and in that case we still need a read_persistent_clock64()
>>>>> implementation. Or we use your patch but make CONFIG_RTC_DRV_GENERIC
>>>>> mandatory.
>>>>
>>>> Typically (in the defconfigs) CONFIG_RTC_DRV_GENERIC is either "m",
>>>> or not set.
>>>>
>>>> And in both cases, a platform-specific RTC class driver may or may not be
>>>> builtin or loaded. We have them for some Amigas (RTC_DRV_MSM6242 or
>>>> RTC_DRV_RP5C01).
>>>>
>>>> I've never been an expert of timekeeping code...
>>>
>>> Some extra background on this:
>>>
>>> read_persistent_clock64/read_persistent_clock is primarily needed when you
>>> have a real time source that is better than the one exposed in the RTC class
>>> driver.  For platforms doing suspend/resume, the timekeeping code will
>>> first try calling read_persistent_clock64() but fall back to the RTC
>>> if that fails.
>>> On only a few architectures like m68k, read_persistent_clock64() falls
>>> back to reading the RTC hardware, which means it will still work even if
>>> the RTC_DRV_GENERIC driver is not loaded. Removing that code will
>>> still work correctly as long as the generic RTC driver does get loaded
>>> before suspend. On platforms without suspend/resume, none of this matters.
>>
>> M68k-with-MMU[*] does not support suspend/resume.
>>
>> [*] Probably the PM dependency should be updated for Coldfire with MMU?
> 
> Ok, so for the suspend case on m68k, can can totally ignore
> read_persistent_clock64(): classic doesn't have suspend and
> coldfire doesn't implement mach_hwclock() callbacks, right?

Yep, that is right, no ColdFire platforms use it.

Regards
Greg


> For reference, this is the set of machines implementing mach_hwclk:
> 
> arch/m68k/68000/m68328.c:  mach_hwclk = m68328_hwclk;
> arch/m68k/68000/m68EZ328.c:  mach_hwclk = m68328_hwclk;
> arch/m68k/68000/m68VZ328.c:     mach_hwclk = m68328_hwclk;
> arch/m68k/apollo/config.c:      mach_hwclk           = dn_dummy_hwclk; /* */
> arch/m68k/atari/config.c:               mach_hwclk = atari_tt_hwclk;
> arch/m68k/atari/config.c:               mach_hwclk = atari_mste_hwclk;
> arch/m68k/bvme6000/config.c:    mach_hwclk           = bvme6000_hwclk;
> arch/m68k/hp300/config.c:       mach_hwclk           = hp300_hwclk;
> arch/m68k/mac/config.c: mach_hwclk = mac_hwclk;
> arch/m68k/mvme147/config.c:     mach_hwclk              = mvme147_hwclk;
> arch/m68k/mvme16x/config.c:    mach_hwclk           = mvme16x_hwclk;
> arch/m68k/q40/config.c: mach_hwclk = q40_hwclk;
> arch/m68k/sun3/config.c:        mach_hwclk           =  sun3_hwclk;
> arch/m68k/sun3x/config.c:       mach_hwclk           = sun3x_hwclk;
> 
>>> The other user of read_persistent_clock() is to set the initial time at boot.
>>> This again can be done by the RTC subsystem if the correct RTC driver
>>> is built-in and CONFIG_RTC_HCTOSYS is set. Alexandre is planning
>>> to remove that option and instead force early user space to load the
>>> RTC driver and then sync it manually using the sysfs knob for it.
>>>
>>> If you have ancient user space that doesn't do this, you might still
>>> rely on read_persistent_clock() to set the boot time.
>>
>> Yeah, we have some ancient userspace (old ramdisk from just after the
>> a.out to ELF switch ;-), which worked fine last time I tried ;-)
>>
>> But this should not be considered a dependency, as most people will
>> run e.g. Debian/ports, which I assume is a modern userspace.
> 
> Ok. In that case, a possible cleanup for the old time handling
> could be to move each of the hwclk implementations over to use
> their own RTC driver instead of a mach_hwclk function with
> generic_rtc.
> 
> It seems that the mach_set_ss and nach_set_mmss
> callbacks can simply get removed already, they are
> never called. Similarly, the mach_get_rtc_pll() and
> mach_get_rtc_pll() callbacks are only used on q40, and
> could be removed after changing the q40 over to using
> its own RTC driver, or registering the ioctl operation itself.
> 
>        Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
