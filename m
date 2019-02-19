Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5140C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866702183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfBSDPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:15:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:29749 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfBSDPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:15:15 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Feb 2019 12:15:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C6E95180C10;
        Tue, 19 Feb 2019 12:15:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 19 Feb 2019 12:15:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 765A31A15B7;
        Tue, 19 Feb 2019 12:15:13 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 64398120459;
        Tue, 19 Feb 2019 12:15:13 +0900 (JST)
Subject: Re: [PATCH v2 14/15] ARM: configs: Add Milbeaut M10V defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a1+w=VWkFWBRnzBEVb389Od25pwGANtZR0DLTF0NfV-NQ@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <7a608801-bf7f-2728-e26e-265e921728ea@socionext.com>
Date:   Tue, 19 Feb 2019 12:15:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1+w=VWkFWBRnzBEVb389Od25pwGANtZR0DLTF0NfV-NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for comments.

On 2019/02/18 21:06, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:30 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This patch adds the minimal defconfig for the Milbeaut M10V.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   arch/arm/configs/milbeaut_m10v_defconfig | 366 +++++++++++++++++++++++++++++++
>>   1 file changed, 366 insertions(+)
> 
> 
> I think it would be good to reduce this a little bit. Please also add any
> options you need for booting to multi_v7_defconfig. Device drivers you
> don't need for booting but for additional features should be loadable
> modules there.
> 

Yeah, I should have refined more.
OK, add aome options to multi_v7_defconfig also.

>> +CONFIG_KALLSYMS_ALL=y
>> +CONFIG_EMBEDDED=y
> 
> CONFIG_EMBEDDED should not normally be set on device
> configurations. Despite the name it's not something for general
> embedded computing, but it's rather an option that lets you
> turn other option that one should normally not have to change.
> 

OK, drop it.


>> +CONFIG_PROFILING=y
>> +CONFIG_OPROFILE=m
> 
> Oprofile is rarely used these days, maybe change the default to
> PERF_EVENTS=y?
> 

I see.
I try to use PERF_EVENTS instead.


>> +CONFIG_HAVE_ARM_ARCH_TIMER=y
>> +CONFIG_VMSPLIT_2G=y
>> +CONFIG_PREEMPT=y
>> +CONFIG_THUMB2_KERNEL=y
> 
> I think this will be the first armv8-a platform with thumb2 by default,
> and it's probably a good thing to start testing that more.
> 

I still leave it in the next patch.

>> +CONFIG_HIGHMEM=y
> 
> It's unusual to have both VMSPLIT_2G and HIGHMEM.
> 

OK. try to drop either.

>> +CONFIG_ARM_APPENDED_DTB=y
> 
> If you are able to fix the boot loaders, this should be turned off
> 

The boot loader is fixed, so I think it can be turned off.

>> +CONFIG_NL80211_TESTMODE=y
>> +CONFIG_CFG80211_DEVELOPER_WARNINGS=y
>> +CONFIG_CFG80211_REG_DEBUG=y
> 
> That seems like more debugging that you should need.
> 

Yes, drop entirely.

>> +# CONFIG_I2C is not set
>> +# CONFIG_I2C_BOARDINFO is not set
>> +# CONFIG_I2C_COMPAT is not set
>> +# CONFIG_I2C_CHARDEV is not set
>> +# CONFIG_I2C_MUX is not set
>> +# CONFIG_I2C_HELPER_AUTO is not set
>> +# CONFIG_I2C_ALGOBIT is not set
>> +# CONFIG_I2C_SNI_M10V is not set
> 
> If I2C is disabled, you shoulnd't need any of the later
> options here.
>

I2C is disable now... drop entirely.

>> +CONFIG_FB=y
>> +# CONFIG_VGA_ARB is not set
> 
> Since you don't have a framebuffer driver, and likely won't
> add one (new drivers should use drivers/gpu/drm), I'd drop
> this.
>

framebuffer is disable too... drop it.


>> +# CONFIG_USB is not set
>> +# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
>> +# CONFIG_USB_MON is not set
>> +# CONFIG_USB_XHCI_HCD is not set
>> +# CONFIG_USB_EHCI_HCD is not set
>> +# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> ...
>> +# CONFIG_MMC is not set
>> +# CONFIG_MMC_SDHCI is not set
>> +# CONFIG_MMC_SDHCI_PLTFM is not set
>> +# CONFIG_MMC_SDHCI_F_SDH30 is not set
>> +# CONFIG_MMC_SDHCI_F_EMMC50 is not set
> 
> Also for USB and MMC: if you don't have the subsystem, you
> should not need to list the other options.
> 

USB, MMC, and more peripherals are disable now.
I will drop them in the next patch.

>> +CONFIG_NEW_LEDS=y
>> +CONFIG_LEDS_CLASS=y
>> +CONFIG_LEDS_GPIO=y
>> +CONFIG_LEDS_TRIGGER_TIMER=y
>> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> +CONFIG_RTC_CLASS=y
>> +# CONFIG_RTC_HCTOSYS is not set
>> +# CONFIG_RTC_SYSTOHC is not set
>> +CONFIG_RTC_DEBUG=y
>> +CONFIG_RTC_DRV_RX8025=y
>> +CONFIG_DMADEVICES=y
>> +CONFIG_MB86S7X_HDMAC=y
>> +CONFIG_MB8AC0300_XDMAC=y
>> +CONFIG_UIO=y
>> +CONFIG_UIO_SNI=y
>> +# CONFIG_IOMMU_SUPPORT is not set
>> +#CONFIG_PWM=y is not set
>> +# CONFIG_PWM_SYSFS is not set
>> +#CONFIG_PWM_M10V=y is not set
>> +CONFIG_RESET_CONTROLLER=y
>> +CONFIG_EXFAT=y
> 
> CONFIG_EXFAT does not exist in mainline kernels.
> 
Yes. drop it.

>> +CONFIG_IPCU_FS=y
>> +# CONFIG_TEST_IPCU_FS is not set
> 
> same for IPCU_FS, and probably a lot of other options.
> 

Yes.
I will check again for unnecessary options.

Thanks,
Sugaya Taichi

>          Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

