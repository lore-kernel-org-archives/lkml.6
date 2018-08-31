Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D22C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037320661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHDBzV1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B037320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHaIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:10:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43991 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeHaIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:10:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so4795855plv.10;
        Thu, 30 Aug 2018 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Jd4/cFxNvFa3tlt9n2HzdqOuiwq15PnoKWPmIkVbVU=;
        b=FHDBzV1xK/Hvm0APr2BuAMae4teueKhs9c0D+O57Sf+ycn4kxu927m8TldGi7GK1pl
         vQZRXWtM9W9idBwaU9k0t9pM4/yGe7Qc/NP2txr7badWU+kivRnd+Feh0rsimOPHE7FV
         oB7ZOpncbyDa6UBaYc7i+PljFdGx64r3LIYYeAsTZgYbJpniycZaBG3QXbJCIyaiEBmR
         dpOrHkK3SNM09m6DGgdkxLQFe04EInt/GhXfN/jIGf8kfF9DWE4wreJ1kqbk+rFeVQ2e
         Nv7qY44IL5cfQH+dNNZI5GXo7ClYs5J8w0LY3HVVGInUx2ogtSZvtyAbcFMXVZujCBIP
         nbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Jd4/cFxNvFa3tlt9n2HzdqOuiwq15PnoKWPmIkVbVU=;
        b=RQCoOWuJJbqjFjKZ3l507GGi5z3csOCn6VF9HohvPUmqsL7FCOyN8JknDe3zmp2hoZ
         LcsxFeD8E+xfPeS2GN2JJKlzMQE+LNxPfSG2w3MIbGRPfQbv/3AGiplwpzaOA5IedEpb
         6uM6tk6zCaZfiqKJnYjYuhoBcr8PX1eB9HCPMBjIJynujpSzGDDiIZbnMfMt1wVMPgyk
         PGeSZ7ALRius7eRWDXD7Bb+DVpFhGU7Tx3DFvtIdUq8kYpqJkSK4LShz/L93Yp2Mqbe8
         07CnI3lqKg/wJwGJhWwWUto1Arx/Q8FF7Lmg8+eCetI6GT+kwWjlvkVRAfo1aYwG36+A
         3U7g==
X-Gm-Message-State: APzg51AdeD1nzCAPU0i3efpVMRe/iDrkrrTq/o7sZYilwr1bgrdgrQXz
        8KP3SI+i67Lvddc30QMXT8k=
X-Google-Smtp-Source: ANB0VdY302XZQ7ktLHHfOhTqggozr//RrO5YhU1Uk/RGcDxVwUw62ZyZj+BMph4uiOmo9miXK/UqpQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4-v6mr12915320plo.124.1535688295086;
        Thu, 30 Aug 2018 21:04:55 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d19-v6sm14409044pfe.42.2018.08.30.21.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 21:04:54 -0700 (PDT)
Subject: Re: [PATCH v3] rpmsg: qcom_smd: Access APCS through mailbox framework
From:   Frank Rowand <frowand.list@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20180420011757.22389-1-bjorn.andersson@linaro.org>
 <c6e2e87c-e2fd-c0ea-dbb9-5246b8694272@gmail.com>
Message-ID: <dba700cb-70a7-095e-82a4-0fabf8aab7ea@gmail.com>
Date:   Thu, 30 Aug 2018 21:04:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c6e2e87c-e2fd-c0ea-dbb9-5246b8694272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 20:57, Frank Rowand wrote:
> Hi Bjorn,
> 
> 
> On 04/19/18 18:17, Bjorn Andersson wrote:
>> Attempt to acquire the APCS IPC through the mailbox framework and fall
>> back to the old syscon based approach, to allow us to move away from
>> using the syscon.
>>
>> Reviewed-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>
>> Changes since v2:
>> - Added comment about mbox_send_message() return value.
>>
>>  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 ++-
>>  drivers/rpmsg/Kconfig                              |  1 +
>>  drivers/rpmsg/qcom_smd.c                           | 67 ++++++++++++++++------
>>  3 files changed, 56 insertions(+), 20 deletions(-)
> 
> This patch in the mainline Linux kernel as commit ab460a2e72dabecfdabd45eb7e3ee2d73fc876d4
> causes a problem with the APQ8074 Dragonboard.  The mmc device is not set up
> with the patch applied, thus I do not have the block device my root file system
> is located on.
> 
> Testing on v4.18, if I revert this commit the mmc device is available.
> 
> I'll reply to this email with the console messages for 4.18 and for 4.18 with
> this commit reverted.

< snip >

Note that I have commented out the WARN_ON() in gic_irq_domain_translate()
at drivers/irqchip/irq-gic.c:1016 to remove a lot of noise from the boot
messages.

Here are the console messages for 4.18:

Android Bootloader - UART_DM Initialized!!!
[0] welcome to lk

[10] platform_init()
[10] target_init()
[10] Display Init: Start
[10] display_init(),target_id=10.
[30] Config MIPI_VIDEO_PANEL.
[30] Turn on MIPI_VIDEO_PANEL.
[50] Video lane tested successfully
[50] Display Init: Done
[80] Loading keystore failed status 5 [80] ERROR: scm_protect_keystore Failed[200] USB init ept @ 0xf96b000
[220] fastboot_init()
[220] udc_start()
[350] -- reset --
[350] -- portchange --
[460] -- reset --
[460] -- portchange --
[650] fastboot: processing commands
[750] fastboot: download:00ece000
[1220] fastboot: boot
[1240] Found Appeneded Flattened Device tree
[1240] cmdline: console=ttyMSM0,115200,n8 androidboot.hardware=qcom user_debug=31 maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 kgdboc=ttyMSM0,115200 debug and
roidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
[1270] Updating device tree: start
[1270] Updating device tree: done
[1270] booting linux @ 0x8000, ramdisk @ 0x2000000 (9533134), tags/device tree @ 0x1e00000
[1280] Turn off MIPI_VIDEO_PANEL.
[1280] Continuous splash enabled, keeping panel alive.
Booting Linux on physical CPU 0x0
Linux version 4.18.0-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #3 SMP PREEMPT Thu Aug 30 20:32:21 PDT 2018
CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
CPU: div instructions available: patching division code
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
Memory policy: Data cache writealloc
On node 0 totalpages: 491776
  Normal zone: 1536 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 164096 pages, LIFO batch:31
  HighMem zone: 327680 pages, LIFO batch:31
random: get_random_bytes called from start_kernel+0x80/0x47c with crng_init=0
percpu: Embedded 17 pages/cpu @(ptrval) s39616 r8192 d21824 u69632
pcpu-alloc: s39616 r8192 d21824 u69632 alloc=17*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists, mobility grouping on.  Total pages: 490240
Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom user_debug=31 maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 kgdboc=ttyM
SM0,115200 debug androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1926844K/1967104K available (8192K kernel code, 782K rwdata, 3212K rodata, 1024K init, 267K bss, 40260K reserved, 0K cma-reserved, 13107
20K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
      .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 783 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   ( 268 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Preemptible hierarchical RCU implementation.
 Tasks RCU enabled.
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
Switching to timer-based delay loop, resolution 52ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x300000 - 0x300060
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (76.80 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 51 architecture 64 part 6f variant 2 rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor menu
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
reg-fixed-voltage vreg-boost: could not find pctldev for node /soc/spmi@fc4cf000/pm8941@0/gpios@c000/boost-bypass, deferring probe
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 9312K
hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=19 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) �© 2001-2006 Red Hat, Inc.
fuse init (API version 7.27)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
msm_serial f991e000.serial: msm_serial: detected port #0
msm_serial f991e000.serial: uartclk = 7372800
f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 27, base_baud = 460800) is a MSM
msm_serial: console setup on port #0
console [ttyMSM0] enabled
msm_serial: driver initialized
brd: module loaded
loop: module loaded
SCSI Media Changer driver v0.25 
spmi spmi-0: PMIC arbiter version v1 (0x20000002)
s1: supplied by regulator-dummy
s2: supplied by regulator-dummy
s3: supplied by regulator-dummy
s4: Bringing 5100000uV into 5000000-5000000uV
l1: supplied by regulator-dummy
l2: supplied by regulator-dummy
l3: supplied by regulator-dummy
l4: supplied by regulator-dummy
l5: supplied by regulator-dummy
l6: supplied by regulator-dummy
l7: supplied by regulator-dummy
l8: supplied by regulator-dummy
l9: supplied by regulator-dummy
l10: supplied by regulator-dummy
l11: supplied by regulator-dummy
l12: supplied by regulator-dummy
l13: supplied by regulator-dummy
l14: supplied by regulator-dummy
l15: supplied by regulator-dummy
l16: supplied by regulator-dummy
l17: supplied by regulator-dummy
l18: supplied by regulator-dummy
l19: supplied by regulator-dummy
l20: supplied by regulator-dummy
l21: supplied by regulator-dummy
l22: supplied by regulator-dummy
l23: supplied by regulator-dummy
l24: supplied by regulator-dummy
lvs1: supplied by regulator-dummy
lvs2: supplied by regulator-dummy
lvs3: supplied by regulator-dummy
5vs1: supplied by s4
5vs2: supplied by s4
libphy: Fixed MDIO Bus: probed
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: rtc core: registered pm8xxx_rtc as rtc0
i2c /dev entries driver
qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
otg-vbus: supplied by 5vs1
qcom-tsens fc4a8000.thermal-sensor: tsens calibration failed
cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci_msm f98a4900.sdhci: Got CD GPIO
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: using timer interrupt.
NET: Registered protocol family 17
Key type dns_resolver registered
Registering SWP/SWPB emulation handler
Loading compiled-in X.509 certificates
sdhci_msm f98a4900.sdhci: Got CD GPIO
rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-01-01 03:17:32 UTC (11852)
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
ALSA device list:
cfg80211: failed to load regul�[    2.013428] Freeing unused kernel memory: 1024K
mkdir: can't create directory '/bin': File exists
mkdir: can't create directory '/dev': File exists
mdev: unknown user/group 'root:uucp' on line 34
Attempt to mount partitions: /usr/system /usr/data
fdisk: can't open '/dev/mmcblk0': No such file or directory
fdisk: can't open '/dev/mmcblk1': No such file or directory

ERROR: did not find system partition on
       /dev/mmcblk0
       /dev/mmcblk1

/ # 
