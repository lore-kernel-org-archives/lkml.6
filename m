Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF42175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwsK/w1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfBESR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:17:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36737 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfBESR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:17:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1860873plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kco+xcGu73PTRICKyl+pGPTy6nGRb5ArTXJ7AjDUODc=;
        b=gwsK/w1JTyp8tA6Zuoxappn/Y9YhRa1lDmP5HTH78703zRBkX9QufN1euySV52JG0r
         UOUHopAABtXV3Pb/xZrD220mMizKDFvnDuH08A7CIkncL5d43PEouHMsI/VrI6mclRyx
         Cy/tAQ4w8h6X/1EhS4v7GCc/OyvlrZr7hR6QeyLIQ6b6K5Pzvdor9F+HDyh2uNjReCoT
         ZSo/RZMovhBMwb/ddXJbPDuVp4EicDEcRpEGJ2Y4ykoZDZZhgLizZOYU6Vmwt97kuheh
         mMRyPQ77LAoPX75cyp92JngSwXAUcG91I9slekpJOUpfn/nhO5bPyHmejsuittHd3uUm
         hiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kco+xcGu73PTRICKyl+pGPTy6nGRb5ArTXJ7AjDUODc=;
        b=UygxlNcXl50uyJBvugla4oV6ZqbzNwfwK7gJLYYugBXplOtZ8jxMBw4rT+5NOiAM/d
         2tmeBNiojmqk6lva7c3XAio+JDLCY8w1PgrpY+DKaCwoDc5I8fl3jAK1Rsh6F41iWmsF
         cBgtL9k+0lEN/hh3LXyANYdMta9e1e5ibGPluMcpas6TmAhMphUhxEc6NJYZD78tSToZ
         Z+O3pz7LeF3ZW0buvbLiAdzdizD7oe0wcXEyJBiN8zJZJQ4GLvZu8e+sgEvZrX9WC8Yp
         JF7c8t2gP9OAb/U8QNi7MSxsi8uAF+YymlkQ1we4U77qjmGCajC/KvddEI0QNdOvKWZg
         Ppow==
X-Gm-Message-State: AHQUAuaFPddSNOu1bg8JcRxiJUYI9AZQz+Fv2o3RagKv9ngdb0RI9iR/
        RcQUuWEHhmdktmp3zqQJpTTzVUtvTZ0=
X-Google-Smtp-Source: AHgI3IZTs4aUTDqlGYVA5msVCjInZP7HQSY2A2RvCjlDv6aOYskvsxQLSpy+Tkcq9mXZnNVI0ZLgwA==
X-Received: by 2002:a17:902:6683:: with SMTP id e3mr6159932plk.93.1549390677646;
        Tue, 05 Feb 2019 10:17:57 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g70sm8218546pfg.98.2019.02.05.10.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:17:56 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:17:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: hammerhead_defconfig: new defconfig for LG Nexus 5
 phone
Message-ID: <20190205181752.GB23363@builder>
References: <20190124161621.24185-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124161621.24185-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jan 08:16 PST 2019, Brian Masney wrote:

> Introduce hammerhead_defconfig for the LG Nexus 5 phone. Includes
> options for USG OTG, WiFi, charger, serial console, gyroscope,
> accelerometer, magnetometer, temperature, and pressure sensors.
> 
> The necessary options for the display are also included, however the
> necessary device tree changes, plus a minor driver change have not been
> submitted upstream yet.
> 

Please update qcom_defconfig (and if you can run multi_v7_defconfig)
instead of introducing additional defconfigs; and keep things that
aren't necessary during boot the kernel as kernel modules.

Regards,
Bjorn

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> See https://masneyb.github.io/nexus-5-upstream/ for more details about
> the work that I've done so far porting the upstream kernel to this phone.
> 
>  arch/arm/configs/hammerhead_defconfig | 263 ++++++++++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 arch/arm/configs/hammerhead_defconfig
> 
> diff --git a/arch/arm/configs/hammerhead_defconfig b/arch/arm/configs/hammerhead_defconfig
> new file mode 100644
> index 000000000000..46681e1e8aba
> --- /dev/null
> +++ b/arch/arm/configs/hammerhead_defconfig
> @@ -0,0 +1,263 @@
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_GENERIC_IRQ_DEBUGFS=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_TASKSTATS=y
> +CONFIG_TASK_DELAY_ACCT=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_CGROUPS=y
> +CONFIG_MEMCG=y
> +CONFIG_BLK_CGROUP=y
> +CONFIG_DEBUG_BLK_CGROUP=y
> +CONFIG_CGROUP_SCHED=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_CGROUP_DEBUG=y
> +CONFIG_NAMESPACES=y
> +CONFIG_USER_NS=y
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_RD_BZIP2 is not set
> +# CONFIG_RD_LZMA is not set
> +# CONFIG_RD_XZ is not set
> +# CONFIG_RD_LZO is not set
> +# CONFIG_RD_LZ4 is not set
> +CONFIG_SYSCTL_SYSCALL=y
> +CONFIG_EMBEDDED=y
> +CONFIG_ARCH_QCOM=y
> +CONFIG_ARCH_MSM8974=y
> +CONFIG_SMP=y
> +# CONFIG_SMP_ON_UP is not set
> +CONFIG_SCHED_MC=y
> +CONFIG_HIGHMEM=y
> +# CONFIG_ARM_MODULE_PLTS is not set
> +CONFIG_SECCOMP=y
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPUFREQ_DT=y
> +CONFIG_VFP=y
> +CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
> +CONFIG_MODULES=y
> +CONFIG_CMA=y
> +CONFIG_CMA_DEBUG=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_NET_KEY=y
> +CONFIG_INET=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_DIAG is not set
> +# CONFIG_IPV6 is not set
> +CONFIG_NETFILTER=y
> +CONFIG_BRIDGE_NETFILTER=y
> +CONFIG_NF_CONNTRACK=y
> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> +CONFIG_IP_NF_IPTABLES=y
> +CONFIG_IP_NF_FILTER=y
> +CONFIG_IP_NF_NAT=y
> +CONFIG_IP_NF_TARGET_MASQUERADE=y
> +CONFIG_BRIDGE=y
> +CONFIG_QRTR=y
> +CONFIG_QRTR_SMD=y
> +CONFIG_BT=m
> +CONFIG_BT_HCIUART=m
> +CONFIG_BT_HCIUART_BCM=y
> +CONFIG_CFG80211=y
> +CONFIG_CFG80211_WEXT=y
> +CONFIG_MAC80211=y
> +CONFIG_RFKILL=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=256
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=2
> +CONFIG_SCSI=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_MD=y
> +CONFIG_BLK_DEV_DM=y
> +CONFIG_DM_CRYPT=y
> +CONFIG_DM_THIN_PROVISIONING=y
> +CONFIG_NETDEVICES=y
> +CONFIG_MACVLAN=y
> +CONFIG_IPVLAN=y
> +CONFIG_VXLAN=y
> +CONFIG_VETH=y
> +# CONFIG_ETHERNET is not set
> +CONFIG_USB_USBNET=y
> +CONFIG_USB_NET_RNDIS_HOST=y
> +# CONFIG_WLAN_VENDOR_ADMTEK is not set
> +CONFIG_WCN36XX=m
> +# CONFIG_WLAN_VENDOR_ATMEL is not set
> +CONFIG_BRCMFMAC=m
> +# CONFIG_WLAN_VENDOR_CISCO is not set
> +# CONFIG_WLAN_VENDOR_INTEL is not set
> +# CONFIG_WLAN_VENDOR_INTERSIL is not set
> +# CONFIG_WLAN_VENDOR_MARVELL is not set
> +# CONFIG_WLAN_VENDOR_MEDIATEK is not set
> +# CONFIG_WLAN_VENDOR_RALINK is not set
> +# CONFIG_WLAN_VENDOR_REALTEK is not set
> +# CONFIG_WLAN_VENDOR_RSI is not set
> +# CONFIG_WLAN_VENDOR_ST is not set
> +# CONFIG_WLAN_VENDOR_TI is not set
> +# CONFIG_WLAN_VENDOR_ZYDAS is not set
> +# CONFIG_WLAN_VENDOR_QUANTENNA is not set
> +CONFIG_INPUT_EVDEV=y
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO=y
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_PM8941_PWRKEY=y
> +CONFIG_INPUT_UINPUT=y
> +CONFIG_RMI4_CORE=y
> +CONFIG_RMI4_I2C=y
> +CONFIG_RMI4_F12=y
> +CONFIG_SERIO_LIBPS2=y
> +CONFIG_SERIAL_MSM=y
> +CONFIG_SERIAL_MSM_CONSOLE=y
> +CONFIG_SERIAL_DEV_BUS=y
> +CONFIG_HW_RANDOM=y
> +# CONFIG_I2C_COMPAT is not set
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_QUP=y
> +CONFIG_SPI=y
> +CONFIG_SPI_QUP=y
> +CONFIG_SPI_SPIDEV=y
> +CONFIG_SPMI=y
> +CONFIG_PINCTRL_MSM8X74=y
> +CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_POWER_RESET=y
> +CONFIG_POWER_RESET_MSM=y
> +CONFIG_POWER_SUPPLY=y
> +CONFIG_CHARGER_QCOM_SMBB=y
> +CONFIG_CHARGER_BQ24190=y
> +CONFIG_THERMAL=y
> +CONFIG_QCOM_TSENS=y
> +CONFIG_QCOM_SPMI_TEMP_ALARM=y
> +CONFIG_MFD_SPMI_PMIC=y
> +CONFIG_REGULATOR_DEBUG=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_GPIO=y
> +CONFIG_REGULATOR_QCOM_SMD_RPM=y
> +CONFIG_REGULATOR_QCOM_SPMI=y
> +CONFIG_REGULATOR_VCTRL=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_CONTROLLER=y
> +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_V4L_MEM2MEM_DRIVERS=y
> +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> +CONFIG_VIDEO_MT9T112=y
> +CONFIG_DRM=y
> +# CONFIG_DRM_MSM_DSI_14NM_PHY is not set
> +# CONFIG_DRM_MSM_DSI_10NM_PHY is not set
> +CONFIG_DRM_PANEL_SIMPLE=y
> +CONFIG_DRM_ANALOGIX_ANX78XX=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> +# CONFIG_LCD_CLASS_DEVICE is not set
> +CONFIG_BACKLIGHT_CLASS_DEVICE=y
> +# CONFIG_BACKLIGHT_GENERIC is not set
> +CONFIG_BACKLIGHT_PM8941_WLED=y
> +CONFIG_BACKLIGHT_LM3630A=y
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +# CONFIG_SND_SUPPORT_OLD_API is not set
> +# CONFIG_SND_DRIVERS is not set
> +# CONFIG_SND_ARM is not set
> +# CONFIG_SND_SPI is not set
> +# CONFIG_SND_USB is not set
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_QCOM=y
> +CONFIG_SND_SOC_PCM1789_I2C=y
> +CONFIG_SND_SOC_TDA7419=y
> +CONFIG_HID_A4TECH=y
> +CONFIG_USB=y
> +CONFIG_USB_OTG=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_CHIPIDEA=y
> +CONFIG_USB_CHIPIDEA_UDC=y
> +CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_GADGET=y
> +CONFIG_U_SERIAL_CONSOLE=y
> +CONFIG_USB_CONFIGFS=y
> +CONFIG_USB_CONFIGFS_SERIAL=y
> +CONFIG_USB_CONFIGFS_ECM=y
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> +CONFIG_USB_CONFIGFS_RNDIS=y
> +CONFIG_USB_CONFIGFS_F_FS=y
> +CONFIG_USB_ETH=y
> +CONFIG_MMC=y
> +CONFIG_MMC_ARMMMCI=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_PM8XXX=y
> +CONFIG_DMADEVICES=y
> +CONFIG_QCOM_BAM_DMA=y
> +CONFIG_COMMON_CLK_QCOM=y
> +CONFIG_QCOM_CLK_SMD_RPM=y
> +CONFIG_MSM_MMCC_8974=y
> +CONFIG_SPMI_PMIC_CLKDIV=y
> +CONFIG_HWSPINLOCK=y
> +CONFIG_HWSPINLOCK_QCOM=y
> +CONFIG_MAILBOX=y
> +CONFIG_QCOM_APCS_IPC=y
> +CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
> +CONFIG_QCOM_IOMMU=y
> +CONFIG_REMOTEPROC=y
> +CONFIG_QCOM_SYSMON=y
> +CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_QCOM_GLINK_RPM=y
> +CONFIG_RPMSG_QCOM_GLINK_SMEM=y
> +CONFIG_RPMSG_QCOM_SMD=y
> +CONFIG_QCOM_PM=y
> +CONFIG_QCOM_RMTFS_MEM=y
> +CONFIG_QCOM_SMEM=y
> +CONFIG_QCOM_SMD_RPM=y
> +CONFIG_QCOM_SMP2P=y
> +CONFIG_QCOM_SMSM=y
> +CONFIG_EXTCON_QCOM_SPMI_MISC=y
> +CONFIG_IIO=y
> +CONFIG_QCOM_SPMI_IADC=y
> +CONFIG_QCOM_SPMI_VADC=y
> +CONFIG_INV_MPU6050_I2C=y
> +CONFIG_TSL2772=y
> +CONFIG_AK8975=y
> +CONFIG_BMP280=y
> +CONFIG_PWM=y
> +CONFIG_PHY_QCOM_USB_HS=y
> +CONFIG_DAX=y
> +CONFIG_QCOM_QFPROM=y
> +CONFIG_SLIMBUS=y
> +CONFIG_SLIM_QCOM_CTRL=y
> +CONFIG_EXT4_FS=y
> +CONFIG_OVERLAY_FS=y
> +# CONFIG_MISC_FILESYSTEMS is not set
> +CONFIG_CRYPTO_AUTHENC=y
> +CONFIG_CRYPTO_ECHAINIV=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_MAGIC_SYSRQ=y
> +# CONFIG_FTRACE is not set
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> -- 
> 2.17.2
> 
