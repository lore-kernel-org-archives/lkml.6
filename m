Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_75_100,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07652C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A521208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBQVNNmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A521208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeIYUbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:31:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44600 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIYUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:31:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id t11-v6so3914070edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijZrrseN8N+Y5IuM8kceO5cKQG6Vedh63+M1yXf+dGI=;
        b=QBQVNNmLuzxW3Ou9hHPtnH2TtFj0w6djErDXOD3F9zUn+AtBFnnz+vi+fChmUStLkb
         7t6q8qjBLdVW6rzPMcPQeAXDWQVzJ+WIQio6BxnunpCBX8T417IjJYdi4j1Ij4PWtxc/
         7bw0EewjwEv1QDgK7DpauOLnt+8u0OwJ3MZGvRFLGbsZr8A4Mt5HrBf07QkHtkyAvBpr
         4v97GWwf3UpK6yt9WsXKD6m5nOUKYs/gB98v2+/OmKsGJBKiRT0NrESMb59iqKjaM/gr
         EUDM3mxvYlvb4jQMvUDAmiGsth+rz2DAu8mTRqYhxrKRjnzqOvESJbvVWZts/BhZc05d
         QqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ijZrrseN8N+Y5IuM8kceO5cKQG6Vedh63+M1yXf+dGI=;
        b=V59LVVrt48hDk4u5iKRs9TBKSn8uGCV0He8rGAakoX2NFhaPSMZHEow3rYML35gF15
         5zCou2zuP99hS6H4J81XG8Jk9OWyQk+69xD11nOXlEHRe7zoJ26Q530rJFuhO56nvGa9
         RobgLrddMEMt9O5VKJJVHe9yeC5bvOtF9wfaqyrOHri2X4tH0YrWz5ibvGy306w1uHEJ
         BP+wtA5nIHAAjV1x8v8Y/V7qGxKCFbeDmRCMthfBmuzhZO0zmnJM50pbnEbOYUiBTGKO
         u8eCSZmBgcCFJHLi6GA6c+HsWeu+AYCRt5pE60rd+2e+1dzXjpv+bfPLjYLvAq37ZWPH
         +lEg==
X-Gm-Message-State: ABuFfohv/ewM3z7fq3imDGsImWh3QuAmib+Y/HWAnGHVH1C71wOuPulL
        +/V5Osvmlpj1Q/+S0FL80ezXDHWU
X-Google-Smtp-Source: ACcGV62yBJEUTV9ufwmnK356wJGkV29hfrM7llmWL2sUovr8g/5OK+7HQVGiUrT7OysbO7zM71u1YQ==
X-Received: by 2002:a05:6402:786:: with SMTP id d6mr1689204edy.81.1537885408906;
        Tue, 25 Sep 2018 07:23:28 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id g38-v6sm7620358edc.40.2018.09.25.07.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 07:23:24 -0700 (PDT)
Subject: Re: [PATCH] ARM: defconfig: add mediatek_v7_defconfig
To:     sean.wang@mediatek.com, linux@armlinux.org.uk
Cc:     khilman@baylibre.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <507c4d569cb8493d10d0ae0f6bd34b8c1dc551e8.1532017154.git.sean.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <1dcb9014-ca9d-6f63-7447-19bf0d0e7b1a@gmail.com>
Date:   Tue, 25 Sep 2018 16:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <507c4d569cb8493d10d0ae0f6bd34b8c1dc551e8.1532017154.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2018 18:25, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Adding one defconfig of our own for the MediaTek ARMv7 SoCs to have one a
> bit more tailor-made and stripped-down version of defconfig that just
> supports the superset of existing DT based MediaTek platform and drivers.
> Which also can help to extend new MediaTek plaforms and drivers
> afterwards.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

pushed to v4.19-next/defconfig now.

Sorry for the dealy.
Matthias

> ---
>  arch/arm/configs/mediatek_v7_defconfig | 319 +++++++++++++++++++++++++++++++++
>  1 file changed, 319 insertions(+)
>  create mode 100644 arch/arm/configs/mediatek_v7_defconfig
> 
> diff --git a/arch/arm/configs/mediatek_v7_defconfig b/arch/arm/configs/mediatek_v7_defconfig
> new file mode 100644
> index 0000000..e20720c
> --- /dev/null
> +++ b/arch/arm/configs/mediatek_v7_defconfig
> @@ -0,0 +1,319 @@
> +CONFIG_COMPILE_TEST=y
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_CGROUPS=y
> +CONFIG_NAMESPACES=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y
> +CONFIG_PERF_EVENTS=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_FORCE_LOAD=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_CMDLINE_PARTITION=y
> +CONFIG_ARCH_MEDIATEK=y
> +# CONFIG_MACH_MT2701 is not set
> +# CONFIG_MACH_MT6589 is not set
> +# CONFIG_MACH_MT6592 is not set
> +# CONFIG_MACH_MT8127 is not set
> +# CONFIG_MACH_MT8135 is not set
> +# CONFIG_ARM_THUMB is not set
> +CONFIG_ARM_THUMBEE=y
> +CONFIG_PL310_ERRATA_588369=y
> +CONFIG_PL310_ERRATA_727915=y
> +CONFIG_PL310_ERRATA_753970=y
> +CONFIG_PL310_ERRATA_769419=y
> +CONFIG_ARM_ERRATA_720789=y
> +CONFIG_ARM_ERRATA_754322=y
> +CONFIG_ARM_ERRATA_754327=y
> +CONFIG_ARM_ERRATA_764369=y
> +CONFIG_ARM_ERRATA_775420=y
> +CONFIG_ARM_ERRATA_798181=y
> +CONFIG_PCI=y
> +CONFIG_PCIE_MEDIATEK=y
> +CONFIG_SMP=y
> +CONFIG_HAVE_ARM_ARCH_TIMER=y
> +CONFIG_NR_CPUS=16
> +CONFIG_HIGHMEM=y
> +CONFIG_CMA=y
> +CONFIG_FORCE_MAX_ZONEORDER=12
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_KEXEC=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> +CONFIG_ARM_MEDIATEK_CPUFREQ=y
> +CONFIG_VFP=y
> +CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
> +CONFIG_PM_AUTOSLEEP=y
> +CONFIG_PM_DEBUG=y
> +CONFIG_PM_ADVANCED_DEBUG=y
> +CONFIG_APM_EMULATION=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +CONFIG_IP_PNP_RARP=y
> +CONFIG_IPV6_ROUTER_PREF=y
> +CONFIG_IPV6_OPTIMISTIC_DAD=y
> +CONFIG_INET6_AH=m
> +CONFIG_INET6_ESP=m
> +CONFIG_INET6_IPCOMP=m
> +CONFIG_IPV6_MIP6=m
> +CONFIG_IPV6_TUNNEL=m
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_BRIDGE=y
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +CONFIG_NET_DSA=y
> +CONFIG_VLAN_8021Q=y
> +CONFIG_NETLINK_DIAG=y
> +CONFIG_BT=y
> +CONFIG_BT_HCIBTUSB=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=64
> +CONFIG_ARM_CCI400_PMU=y
> +CONFIG_MTD=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_MTK=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_MT81xx_NOR=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_SRAM=y
> +CONFIG_EEPROM_93CX6=y
> +CONFIG_IDE=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_ATA=y
> +CONFIG_SATA_AHCI=y
> +CONFIG_NETDEVICES=y
> +CONFIG_NET_DSA_MT7530=y
> +# CONFIG_NET_VENDOR_3COM is not set
> +# CONFIG_NET_VENDOR_ADAPTEC is not set
> +# CONFIG_NET_VENDOR_AGERE is not set
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_ALTEON is not set
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_AMD is not set
> +# CONFIG_NET_VENDOR_AQUANTIA is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_VENDOR_ATHEROS is not set
> +# CONFIG_NET_CADENCE is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_BROCADE is not set
> +# CONFIG_NET_VENDOR_CAVIUM is not set
> +# CONFIG_NET_VENDOR_CHELSIO is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
> +# CONFIG_NET_VENDOR_CISCO is not set
> +# CONFIG_NET_VENDOR_DEC is not set
> +# CONFIG_NET_VENDOR_DLINK is not set
> +# CONFIG_NET_VENDOR_EMULEX is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_EXAR is not set
> +# CONFIG_NET_VENDOR_FARADAY is not set
> +# CONFIG_NET_VENDOR_HISILICON is not set
> +# CONFIG_NET_VENDOR_HP is not set
> +# CONFIG_NET_VENDOR_HUAWEI is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +CONFIG_NET_VENDOR_MEDIATEK=y
> +CONFIG_NET_MEDIATEK_SOC=y
> +# CONFIG_NET_VENDOR_MELLANOX is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_MICROCHIP is not set
> +# CONFIG_NET_VENDOR_MYRI is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_NVIDIA is not set
> +# CONFIG_NET_VENDOR_OKI is not set
> +# CONFIG_NET_PACKET_ENGINE is not set
> +# CONFIG_NET_VENDOR_QLOGIC is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_REALTEK is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_RDC is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SILAN is not set
> +# CONFIG_NET_VENDOR_SIS is not set
> +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_SUN is not set
> +# CONFIG_NET_VENDOR_TEHUTI is not set
> +# CONFIG_NET_VENDOR_TI is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_SYNOPSYS is not set
> +CONFIG_ICPLUS_PHY=y
> +CONFIG_USB_USBNET=y
> +# CONFIG_USB_NET_CDCETHER is not set
> +# CONFIG_USB_NET_CDC_NCM is not set
> +# CONFIG_USB_NET_NET1080 is not set
> +# CONFIG_USB_NET_CDC_SUBSET is not set
> +# CONFIG_USB_NET_ZAURUS is not set
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_INPUT_EVBUG=y
> +CONFIG_KEYBOARD_GPIO=y
> +CONFIG_KEYBOARD_GPIO_POLLED=y
> +CONFIG_KEYBOARD_MATRIX=y
> +CONFIG_KEYBOARD_SAMSUNG=y
> +CONFIG_MOUSE_PS2_ELANTECH=y
> +CONFIG_MOUSE_PS2_SENTELIC=y
> +CONFIG_INPUT_TOUCHSCREEN=y
> +# CONFIG_SERIO_SERPORT is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +# CONFIG_SERIAL_8250_PCI is not set
> +CONFIG_SERIAL_8250_NR_UARTS=5
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=5
> +CONFIG_SERIAL_8250_MT6577=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_HW_RANDOM=y
> +CONFIG_I2C=y
> +CONFIG_I2C_MT65XX=y
> +CONFIG_SPI=y
> +CONFIG_SPI_DEBUG=y
> +CONFIG_SPI_MT65XX=y
> +CONFIG_SPI_SPIDEV=y
> +CONFIG_PINCTRL_MT2701=y
> +CONFIG_PINCTRL_MT8135=y
> +CONFIG_PINCTRL_MT8127=y
> +CONFIG_PINCTRL_MT7622=y
> +CONFIG_PINCTRL_MT8173=y
> +CONFIG_DEBUG_GPIO=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_POWER_RESET=y
> +# CONFIG_HWMON is not set
> +CONFIG_THERMAL=y
> +CONFIG_THERMAL_WRITABLE_TRIPS=y
> +CONFIG_THERMAL_GOV_FAIR_SHARE=y
> +CONFIG_THERMAL_GOV_BANG_BANG=y
> +CONFIG_THERMAL_GOV_USER_SPACE=y
> +CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> +CONFIG_CPU_THERMAL=y
> +CONFIG_THERMAL_EMULATION=y
> +CONFIG_WATCHDOG=y
> +CONFIG_MEDIATEK_WATCHDOG=y
> +CONFIG_MFD_MT6397=y
> +# CONFIG_ABX500_CORE is not set
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_MT6323=y
> +CONFIG_RC_DEVICES=y
> +CONFIG_IR_MTK=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_MT2701=y
> +CONFIG_SND_SOC_MT2701_WM8960=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_MTK=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_NOP_USB_XCEIV=y
> +CONFIG_USB_GPIO_VBUS=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_CONFIGFS=y
> +CONFIG_USB_CONFIGFS_SERIAL=y
> +CONFIG_USB_CONFIGFS_ACM=y
> +CONFIG_USB_CONFIGFS_OBEX=y
> +CONFIG_USB_CONFIGFS_NCM=y
> +CONFIG_USB_CONFIGFS_ECM=y
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> +CONFIG_USB_CONFIGFS_RNDIS=y
> +CONFIG_USB_CONFIGFS_EEM=y
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +CONFIG_MMC=y
> +CONFIG_MMC_MTK=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_MT6323=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_PCA963X=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_ONESHOT=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_MT6397=y
> +CONFIG_DMADEVICES=y
> +CONFIG_MTK_HSDMA=y
> +CONFIG_DMATEST=y
> +CONFIG_COMMON_CLK_MT2701_MMSYS=y
> +CONFIG_COMMON_CLK_MT2701_IMGSYS=y
> +CONFIG_COMMON_CLK_MT2701_VDECSYS=y
> +CONFIG_COMMON_CLK_MT2701_HIFSYS=y
> +CONFIG_COMMON_CLK_MT2701_ETHSYS=y
> +CONFIG_COMMON_CLK_MT2701_BDPSYS=y
> +CONFIG_COMMON_CLK_MT7622_ETHSYS=y
> +CONFIG_COMMON_CLK_MT7622_HIFSYS=y
> +CONFIG_COMMON_CLK_MT7622_AUDSYS=y
> +CONFIG_ARM_TIMER_SP804=y
> +CONFIG_MTK_IOMMU_V1=y
> +CONFIG_MTK_PMIC_WRAP=y
> +CONFIG_PM_DEVFREQ=y
> +CONFIG_DEVFREQ_GOV_USERSPACE=y
> +CONFIG_IIO=y
> +CONFIG_MEDIATEK_MT6577_AUXADC=y
> +CONFIG_PWM=y
> +CONFIG_PWM_MEDIATEK=y
> +CONFIG_PHY_MTK_TPHY=y
> +CONFIG_MTK_EFUSE=y
> +CONFIG_EXT4_FS=y
> +CONFIG_AUTOFS4_FS=y
> +CONFIG_FUSE_FS=m
> +CONFIG_MSDOS_FS=m
> +CONFIG_VFAT_FS=m
> +CONFIG_NTFS_FS=m
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_PSTORE=y
> +CONFIG_PSTORE_CONSOLE=y
> +CONFIG_PSTORE_PMSG=y
> +CONFIG_PSTORE_RAM=y
> +CONFIG_NLS_CODEPAGE_437=m
> +CONFIG_NLS_ISO8859_1=m
> +CONFIG_NLS_UTF8=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
> +CONFIG_DEBUG_FS=y
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DETECT_HUNG_TASK=y
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_DEBUG_BUGVERBOSE is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_MEMTEST=y
> +CONFIG_DEBUG_LL=y
> +CONFIG_DEBUG_UART_PHYS=0x11004000
> +CONFIG_DEBUG_UART_VIRT=0xf1004000
> +CONFIG_EARLY_PRINTK=y
> +# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> +CONFIG_CRYPTO_AUTHENC=y
> +CONFIG_CRYPTO_CCM=y
> +CONFIG_CRYPTO_GCM=y
> +CONFIG_CRYPTO_ECHAINIV=y
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_MD5=y
> +CONFIG_CRYPTO_ARC4=y
> +CONFIG_CRYPTO_DES=y
> +CONFIG_CRYPTO_LZO=y
> +CONFIG_CRYPTO_DEV_MEDIATEK=y
> +CONFIG_CRC_CCITT=m
> +CONFIG_CRC_ITU_T=m
> 
