Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8186C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FE2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfASKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:21:52 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:34454 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfASKVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:21:51 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 6A33919F4EA;
        Sat, 19 Jan 2019 11:21:21 +0100 (CET)
Subject: Re: kmemleak panic
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <5fe89adc-c95b-ca89-d043-c380e2ba8cb3@lca.pw>
 <8edcc205-0e55-7988-5729-7b75e47e9b32@free.fr>
 <fd0a8e39-b258-6281-ed5d-0e176971478f@lca.pw>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <d344a4f5-ba3c-6d9e-010f-0df43e81873f@free.fr>
Date:   Sat, 19 Jan 2019 11:21:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <fd0a8e39-b258-6281-ed5d-0e176971478f@lca.pw>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 18:38, Qian Cai wrote:

> On 1/18/19 12:05 PM, Marc Gonzalez wrote:
>
>> On 18/01/2019 17:14, Qian Cai wrote:
>>
>>> This looks like something different from the original "invalid PFNs from
>>> pfn_to_online_page()" issue. What's your .config ?
>>
>> Here's my defconfig:
>>
>> # CONFIG_SWAP is not set
>> CONFIG_NO_HZ_IDLE=y
>> CONFIG_HIGH_RES_TIMERS=y
>> CONFIG_PREEMPT=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> CONFIG_LOG_BUF_SHIFT=20
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_ARCH_QCOM=y
>> # CONFIG_EFI is not set
>> # CONFIG_SUSPEND is not set
>> CONFIG_PM=y
>> # CONFIG_MQ_IOSCHED_DEADLINE is not set
>> # CONFIG_MQ_IOSCHED_KYBER is not set
>> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>> CONFIG_DEVTMPFS=y
>> CONFIG_DEVTMPFS_MOUNT=y
>> # CONFIG_BLK_DEV is not set
>> # CONFIG_INPUT_KEYBOARD is not set
>> # CONFIG_INPUT_MOUSE is not set
>> # CONFIG_SERIO_SERPORT is not set
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_LEGACY_PTY_COUNT=16
>> CONFIG_SERIAL_8250=y
>> CONFIG_SERIAL_MSM=y
>> CONFIG_SERIAL_MSM_CONSOLE=y
>> CONFIG_SERIAL_DEV_BUS=y
>> # CONFIG_HW_RANDOM is not set
>> # CONFIG_HWMON is not set
>> CONFIG_REGULATOR=y
>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> CONFIG_REGULATOR_QCOM_SMD_RPM=y
>> # CONFIG_HID is not set
>> # CONFIG_USB_SUPPORT is not set
>> # CONFIG_COMMON_CLK_XGENE is not set
>> CONFIG_COMMON_CLK_QCOM=y
>> # CONFIG_QCOM_A53PLL is not set
>> # CONFIG_QCOM_CLK_APCS_MSM8916 is not set
>> CONFIG_QCOM_CLK_SMD_RPM=y
>> CONFIG_MSM_GCC_8998=y
>> CONFIG_HWSPINLOCK=y
>> CONFIG_HWSPINLOCK_QCOM=y
>> CONFIG_MAILBOX=y
>> CONFIG_QCOM_APCS_IPC=y
>> CONFIG_RPMSG_QCOM_GLINK_RPM=y
>> CONFIG_RPMSG_QCOM_GLINK_SMEM=y
>> CONFIG_RPMSG_QCOM_SMD=y
>> CONFIG_RPMSG_VIRTIO=y
>> CONFIG_QCOM_COMMAND_DB=y
>> CONFIG_QCOM_SMEM=y
>> CONFIG_QCOM_SMD_RPM=y
>> CONFIG_TMPFS=y
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=4000
>> CONFIG_FUNCTION_TRACER=y
> 
> This is truncated. I'll need your whole .config file, so I can try to reproduce
> it here on an arm64 ThunderX2 server.

Smirk. It's not truncated, it's condensed ;-)

It's a defconfig, as generated by make savedefconfig.

https://stackoverflow.com/questions/27899104/how-to-create-a-defconfig-file-from-a-config

Save it to e.g. arch/arm64/configs/marc_defconfig and then you can
just run 'make marc_defconfig' to generate the .config

Regards.
