Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239D2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBAWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:52:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33353 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:52:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so6837508eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=bQdLhpN9b3bi21+aKEeopJkAdFNl9hqpl/lCk9r5K/g=;
        b=GpI9yDHOucu0kXXrkNNW0to/8VB2AVgK5mgH2Il/kg/SFoKwxyAMMxjTxrgmnHu63h
         mhQZhAxub5q3GfmDfLzyDo5zArsvpH149PERRPbDEYaPHGEJHvp2ffPHKAYM7Fr1SIYY
         0ZGbQTlg/QGq423HOCet7VS1Wvq/ApC9NELL04RPDXbIYcQzI+ba1B1IHR71u8kvDD2k
         kAarPtAN45YbWvP8orzDkgecf6oUNn9aWHVT1PWoXFwr6NalvnAFZ5tD3PD9VUa2rxRE
         YrThkol5u8LA4ELBk8B/fkJwJXigvs1d1V5sDtNz8wk4ZEf+kHPgFZnL9IMblXmwr/EY
         xAmA==
X-Gm-Message-State: AJcUukeT2dQGqSiqqc7aSB7sx4FwuwsKl73Xhkf+JdI277kS5Wy/BWXP
        +IAVPXTQ7EBAvLcHfvPoYF8p+lE2sXg=
X-Google-Smtp-Source: ALg8bN5t3eNXPbGqdl6JFSKSGjpDDr8PK7T5cjJ8TfJicETGUyDJbqAqVodoquQHsMPY/ZUtIhaXbA==
X-Received: by 2002:a17:906:f212:: with SMTP id gt18mr36649420ejb.201.1549061537362;
        Fri, 01 Feb 2019 14:52:17 -0800 (PST)
Received: from localhost.localdomain ([212.76.254.34])
        by smtp.gmail.com with ESMTPSA id a38sm2340441edd.44.2019.02.01.14.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:52:16 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924143719.22191-1-hdegoede@redhat.com>
 <CAKErNvoeMs9cDDAvMfxaGLsKY3-q_JmrjCUB8VK4ZUXUVytwsQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <35cfd1f2-43eb-fc49-4777-a21413bb2d41@redhat.com>
Date:   Fri, 1 Feb 2019 23:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKErNvoeMs9cDDAvMfxaGLsKY3-q_JmrjCUB8VK4ZUXUVytwsQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F545A1209B021D6566821A37"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F545A1209B021D6566821A37
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/31/19 8:47 PM, Maxim Mikityanskiy wrote:
> Hi,
> 
> On Mon, Sep 24, 2018 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> We were relying on the interrupt being shared with the ACPI SCI and the
>> ACPI core calling irq_set_wake. But that does not always happen on
>> Bay Trail devices, so we should do it ourselves.
>>
>> This fixes wake from USB not working on various Bay Trail devices.
> 
> This patch breaks suspend on ASUS E202SA (bisecting pointed me to this
> patch, and if I revert it and build 4.20.5 without this patch,
> everything works flawlessly).

Thank you for the bug report, can you please test 4.20.5 with the attached
patch on top? That should fix it. Once I've confirmation that this fixes
things I will submit the patch upstream.

Regards,

Hans


> 
> This command fails with the following message:
> 
> # echo mem > /sys/power/state
> Error while writing to stdout
> write_loop: Device or resource busy
> 
> And here is dmesg output:
> 
> [  224.077275] PM: suspend entry (deep)
> [  224.077286] PM: Syncing filesystems ... done.
> [  225.495014] Freezing user space processes ... (elapsed 0.003 seconds) done.
> [  225.498540] OOM killer disabled.
> [  225.498543] Freezing remaining freezable tasks ... (elapsed 0.002
> seconds) done.
> [  225.500693] printk: Suspending console(s) (use no_console_suspend to debug)
> [  225.502793] wlp1s0: deauthenticating from 00:03:7f:12:34:56 by
> local choice (Reason: 3=DEAUTH_LEAVING)
> [  225.535333] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  225.535882] sd 0:0:0:0: [sda] Stopping disk
> [  226.969070] ACPI: EC: interrupt blocked
> [  227.002156] ACPI: Preparing to enter system sleep state S3
> [  227.007890] ACPI: EC: event blocked
> [  227.007895] ACPI: EC: EC stopped
> [  227.007900] PM: Saving platform NVS memory
> [  227.008264] Disabling non-boot CPUs ...
> [  227.034114] smpboot: CPU 1 is now offline
> [  227.088320] smpboot: CPU 2 is now offline
> [  227.141513] smpboot: CPU 3 is now offline
> [  227.147086] Enabling non-boot CPUs ...
> [  227.147187] x86: Booting SMP configuration:
> [  227.147190] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  227.147916]  cache: parent cpu1 should not be sleeping
> [  227.148354] CPU1 is up
> [  227.148424] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  227.149800]  cache: parent cpu2 should not be sleeping
> [  227.151143] CPU2 is up
> [  227.151187] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [  227.152399]  cache: parent cpu3 should not be sleeping
> [  227.153883] CPU3 is up
> [  227.154876] ACPI: EC: EC started
> [  227.155282] ACPI: Waking up from system sleep state S3
> [  227.159874] ACPI: button: The lid device is not compliant to SW_LID.
> [  227.169441] ACPI: EC: interrupt unblocked
> [  228.236790] ACPI: EC: event unblocked
> [  228.241950] rtlwifi: rtlwifi: wireless switch is on
> [  228.251865] sd 0:0:0:0: [sda] Starting disk
> [  228.476637] usb 1-4: reset full-speed USB device number 2 using xhci_hcd
> [  228.562879] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  228.563924] ata2: SATA link down (SStatus 4 SControl 300)
> [  228.564979] ata1.00: supports DRM functions and may not be fully accessible
> [  228.565493] ata1.00: NCQ Send/Recv Log not supported
> [  228.567649] ata1.00: supports DRM functions and may not be fully accessible
> [  228.568252] ata1.00: NCQ Send/Recv Log not supported
> [  228.570075] ata1.00: configured for UDMA/133
> [  228.580412] ahci 0000:00:13.0: port does not support device sleep
> [  228.639349] Bluetooth: hci0: RTL: rtl: examining hci_ver=06
> hci_rev=0e2f lmp_ver=06 lmp_subver=a041
> 
> [  228.639368] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver
> a041, hci rev 0e2f, hci ver 0006
> [  228.639742] acpi LNXPOWER:01: Turning OFF
> [  228.640033] OOM killer enabled.
> [  228.640040] Restarting tasks ... done.
> [  228.795406] PM: suspend exit
> [  228.800399] audit: type=1130 audit(1548962671.104:94): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [  229.067206] wlp1s0: authenticate with 12:34:56:78:90:12
> [  229.067823] wlp1s0: send auth to 12:34:56:78:90:12 (try 1/3)
> [  229.070955] wlp1s0: authenticated
> [  229.072395] wlp1s0: associate with 12:34:56:78:90:12 (try 1/3)
> [  229.074505] wlp1s0: RX AssocResp from 12:34:56:78:90:12 (capab=0x11
> status=0 aid=2)
> [  229.074819] wlp1s0: associated
> [  233.809200] audit: type=1131 audit(1548962676.106:95): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> 
> The laptop doesn't go to sleep, the screen turns off, and in a couple
> of seconds it turns on.
> 
> Please take a look at this regression. Feel free to ask me for any
> additional information you need.
> 
> Thanks,
> Max
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/intel_int0002_vgpio.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
>> index 987a3b03f225..33c3489f5bc1 100644
>> --- a/drivers/platform/x86/intel_int0002_vgpio.c
>> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
>> @@ -106,6 +106,21 @@ static void int0002_irq_mask(struct irq_data *data)
>>          outl(gpe_en_reg, GPE0A_EN_PORT);
>>   }
>>
>> +static int int0002_irq_set_wake(struct irq_data *data, unsigned int on)
>> +{
>> +       struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
>> +       struct platform_device *pdev = to_platform_device(chip->parent);
>> +       int irq = platform_get_irq(pdev, 0);
>> +
>> +       /* Propagate to parent irq */
>> +       if (on)
>> +               enable_irq_wake(irq);
>> +       else
>> +               disable_irq_wake(irq);
>> +
>> +       return 0;
>> +}
>> +
>>   static irqreturn_t int0002_irq(int irq, void *data)
>>   {
>>          struct gpio_chip *chip = data;
>> @@ -128,6 +143,7 @@ static struct irq_chip int0002_irqchip = {
>>          .irq_ack                = int0002_irq_ack,
>>          .irq_mask               = int0002_irq_mask,
>>          .irq_unmask             = int0002_irq_unmask,
>> +       .irq_set_wake           = int0002_irq_set_wake,
>>   };
>>
>>   static int int0002_probe(struct platform_device *pdev)

--------------F545A1209B021D6566821A37
Content-Type: text/x-patch;
 name="0001-platform-x86-intel_int0002_vgpio-Only-implement-irq_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-platform-x86-intel_int0002_vgpio-Only-implement-irq_.pa";
 filename*1="tch"

From 0ac08d4ec8dc741777fdb58b8359e0546baab6b6 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 1 Feb 2019 18:05:00 +0100
Subject: [PATCH] platform/x86: intel_int0002_vgpio: Only implement
 irq_set_wake on Bay Trail

Commit c3b8e884defa ("platform/x86: intel_int0002_vgpio: Implement
irq_set_wake"), was written to fix some wakeup issues on Bay Trail (BYT)
devices.

We've received a bug report that this causes a suspend regression on some
Cherry Trail (CHT) based devices.

To fix the issues this causes on CHT devices, this commit modifies the
irq_set_wake support so that we only implement irq_set_wake on BYT devices,

Fixes: c3b8e884defa ("platform/x86: intel_int0002_vgpio: ... irq_set_wake")
Reported-and-tested-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_int0002_vgpio.c | 32 ++++++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index 4b8f7305fc8a..78787934b572 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -51,11 +51,14 @@
 #define GPE0A_STS_PORT			0x420
 #define GPE0A_EN_PORT			0x428
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+#define BAYTRAIL			0x01
+#define CHERRYTRAIL			0x02
+
+#define ICPU(model, data) { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, data}
 
 static const struct x86_cpu_id int0002_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail  */
-	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT, BAYTRAIL), /* Valleyview, Bay Trail  */
+	ICPU(INTEL_FAM6_ATOM_AIRMONT, CHERRYTRAIL), /* Braswell, Cherry Trail */
 	{}
 };
 
@@ -135,7 +138,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irq_chip int0002_irqchip = {
+static struct irq_chip int0002_byt_irqchip = {
 	.name			= DRV_NAME,
 	.irq_ack		= int0002_irq_ack,
 	.irq_mask		= int0002_irq_mask,
@@ -143,10 +146,22 @@ static struct irq_chip int0002_irqchip = {
 	.irq_set_wake		= int0002_irq_set_wake,
 };
 
+static struct irq_chip int0002_cht_irqchip = {
+	.name			= DRV_NAME,
+	.irq_ack		= int0002_irq_ack,
+	.irq_mask		= int0002_irq_mask,
+	.irq_unmask		= int0002_irq_unmask,
+	/*
+	 * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
+	 * and we don't want to mess with the ACPI SCI irq settings.
+	 */
+};
+
 static int int0002_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct x86_cpu_id *cpu_id;
+	struct irq_chip *irq_chip;
 	struct gpio_chip *chip;
 	int irq, ret;
 
@@ -195,14 +210,19 @@ static int int0002_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiochip_irqchip_add(chip, &int0002_irqchip, 0, handle_edge_irq,
+	if (cpu_id->driver_data == BAYTRAIL)
+		irq_chip = &int0002_byt_irqchip;
+	else
+		irq_chip = &int0002_cht_irqchip;
+
+	ret = gpiochip_irqchip_add(chip, irq_chip, 0, handle_edge_irq,
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(dev, "Error adding irqchip: %d\n", ret);
 		return ret;
 	}
 
-	gpiochip_set_chained_irqchip(chip, &int0002_irqchip, irq, NULL);
+	gpiochip_set_chained_irqchip(chip, irq_chip, irq, NULL);
 
 	return 0;
 }
-- 
2.20.1


--------------F545A1209B021D6566821A37--
