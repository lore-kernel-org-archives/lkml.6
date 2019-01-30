Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDCC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756BA218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tqz4HJXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfA3Oph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:45:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37326 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfA3Oph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:45:37 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so10825995iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTgq/gpkAZ861ZJ4kcxYzp5OJM3h42ur1WRvrWRZXaU=;
        b=Tqz4HJXO6qD8RIXqpG2J04caIV7zshabOjPY9n4nRftFKmujdy9GcR0dXT0/TogJl7
         qstkSDJ4nbVPsMeRjRnSennpR6LseeVdvvOd52bu/YLxgRuYniP33eE1z0iu2DXtHnqv
         QvZBee0sz2sq9lQ0n8wH/XadEtLNrPyxyFutZ3DH+TLc8SYhVHs62SHISkJNL7RjKOHZ
         4aqRrFiGTpSXLtGAlSgG8qa44FKQLFQ0EMuEpag0uMLqQ/DS3Rf7YM73O6sjUntJiPbt
         89X3yFW/toEmxYnE6hmUO5fzjfGs+dW/QMKF3jDCwX/NE+ou+0CDm2X4WFN3p54Vw42y
         IyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTgq/gpkAZ861ZJ4kcxYzp5OJM3h42ur1WRvrWRZXaU=;
        b=i2y155KplmCSXa+nZ8GavlnXAcLTtaAlRf4lVT7ZzoUwCpRXG0YvbTfDU/3uU2BmFV
         AHFYKpx0h/F28v+LI/w2L3S3mKvWzAsmnuwBW6QZFPF1zBe+9NoBQqhpZBxZoAedSuB+
         IXpS2iJZw1tTHJ+bPcCEhdht7zlfxOA4ERGsRJcwJpxQFVQMDptDDRgmiKEIwfsr/lwz
         jvANzgbXiA5sI8yiv5ZLbN7xChqc9/vWvgivkZUC79qjBlnIYED6FZGVeGE8kcm0axO3
         TMvacNaWA/u+s70lKj9ux4xecJ3RnYW6dtFGoFncW+mRmGHSgorWBfaFNPIDR2MO0iQV
         nbUA==
X-Gm-Message-State: AJcUukc8bQlFFCEoMPKJ1IsfuzQU0+QvwALuPttJi1tA6Kkupd/rOW+Q
        tkpKLHHuSZ5c1fobPSoL1KtV99I5AsvgP1TIbu5lgQ==
X-Google-Smtp-Source: ALg8bN4pLCWkQ0QPN9+CJSYq7fqrl4gCMRYq/eeZdiXdORiz0RTKsIBR4Hzpr+8tYmr551nbx5wRe6Ap3EAF0XR0LOU=
X-Received: by 2002:a24:6511:: with SMTP id u17mr16181089itb.12.1548859535869;
 Wed, 30 Jan 2019 06:45:35 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com> <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
In-Reply-To: <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Jan 2019 15:45:24 +0100
Message-ID: <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:32 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/09/06 19:59, Dmitry Vyukov wrote:
> > On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
> >>> Thanks! I've re-enabled selinux on syzbot:
> >>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
> >>> Now we will have instances with apparmor and with selinux.
> >>
> >> Any chance we could get a Smack instance as well?
> >
> > Hi Casey,
> >
> > Sure!
> > Provided you want to fix bugs ;)
> > I've setup an instance with smack enabled:
> > https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee
> >
>
> Dmitry, is it possible to update configs for linux-next.git , for
> we want to test a big change in LSM which will go to Linux 5.1 ?
>
> TOMOYO security module (CONFIG_SECURITY_TOMOYO=y) can now coexist with
> SELinux/Smack/AppArmor security modules, and SafeSetID security module
> (CONFIG_SECURITY_SAFESETID=y) was added. Testing with these modules also
> enabled might find something...

Hi,

syzbot configs/cmdline args are stored here:
https://github.com/google/syzkaller/tree/master/dashboard/config

I've tried to update to the latest kernel, the diff is below.
Few questions:
1. How are modules enabled now?
We pass security=selinux of security=smack on command line. What do we
need to pass now to enable several modules at the same time?

2. What exactly does SECURITY_SAFESETID do?
syzkaller executor uses setuid/gid, and the config says "to only those
approved by a system-wide whitelist". What/where is that whitelist? If
we just enable it, but not whitelist will it break syzkaller?



diff --git a/dashboard/config/upstream-kasan.config
b/dashboard/config/upstream-kasan.config
index 475d84a3..ed026cd8 100644
--- a/dashboard/config/upstream-kasan.config
+++ b/dashboard/config/upstream-kasan.config
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86 4.20.0 Kernel Configuration
+# Linux/x86 5.0.0-rc4 Kernel Configuration
 #

 # The following configs are added manually, preserve them.
@@ -14,11 +14,12 @@ CONFIG_DEBUG_MEMORY=y
 CONFIG_DEBUG_AID_FOR_SYZBOT=y

 #
-# Compiler: gcc (GCC) 9.0.0 20181231 (experimental)
+# Compiler:
 #
 CONFIG_CC_IS_GCC=y
 CONFIG_GCC_VERSION=90000
 CONFIG_CLANG_VERSION=0
+CONFIG_CC_HAS_ASM_GOTO=y
 CONFIG_CONSTRUCTORS=y
 CONFIG_IRQ_WORK=y
 CONFIG_BUILDTIME_EXTABLE_SORT=y
@@ -295,7 +296,7 @@ CONFIG_X86_X2APIC=y
 CONFIG_X86_MPPARSE=y
 # CONFIG_GOLDFISH is not set
 CONFIG_RETPOLINE=y
-# CONFIG_RESCTRL is not set
+# CONFIG_X86_RESCTRL is not set
 CONFIG_X86_EXTENDED_PLATFORM=y
 # CONFIG_X86_NUMACHIP is not set
 # CONFIG_X86_VSMP is not set
@@ -571,6 +572,7 @@ CONFIG_X86_ACPI_CPUFREQ_CPB=y
 CONFIG_CPU_IDLE=y
 # CONFIG_CPU_IDLE_GOV_LADDER is not set
 CONFIG_CPU_IDLE_GOV_MENU=y
+# CONFIG_CPU_IDLE_GOV_TEO is not set
 CONFIG_INTEL_IDLE=y

 #
@@ -745,8 +747,9 @@ CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
 #
 # CONFIG_GCOV_KERNEL is not set
 CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
-CONFIG_PLUGIN_HOSTCC=""
+CONFIG_PLUGIN_HOSTCC="g++"
 CONFIG_HAVE_GCC_PLUGINS=y
+# CONFIG_GCC_PLUGINS is not set
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
@@ -932,6 +935,7 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_SMC=y
 CONFIG_SMC_DIAG=y
 CONFIG_XDP_SOCKETS=y
+CONFIG_XDP_SOCKETS_DIAG=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
@@ -3246,6 +3250,7 @@ CONFIG_SPI_MASTER=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_SPI_CADENCE is not set
 # CONFIG_SPI_DESIGNWARE is not set
+# CONFIG_SPI_NXP_FLEXSPI is not set
 CONFIG_SPI_PXA2XX=y
 CONFIG_SPI_PXA2XX_PCI=y
 # CONFIG_SPI_ROCKCHIP is not set
@@ -3896,6 +3901,10 @@ CONFIG_DRM_KMS_CMA_HELPER=y
 # CONFIG_DRM_I2C_SIL164 is not set
 # CONFIG_DRM_I2C_NXP_TDA998X is not set
 # CONFIG_DRM_I2C_NXP_TDA9950 is not set
+
+#
+# ARM devices
+#
 # CONFIG_DRM_RADEON is not set
 # CONFIG_DRM_AMDGPU is not set

@@ -3951,6 +3960,7 @@ CONFIG_DRM_PANEL_BRIDGE=y
 # Display Interface Bridges
 #
 # CONFIG_DRM_ANALOGIX_ANX78XX is not set
+# CONFIG_DRM_ETNAVIV is not set
 # CONFIG_DRM_HISI_HIBMC is not set
 CONFIG_DRM_TINYDRM=y
 # CONFIG_TINYDRM_HX8357D is not set
@@ -4060,7 +4070,6 @@ CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
 CONFIG_LOGO=y
-# CONFIG_FB_LOGO_CENTER is not set
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
@@ -4298,6 +4307,7 @@ CONFIG_LOGIRUMBLEPAD2_FF=y
 CONFIG_LOGIG940_FF=y
 CONFIG_LOGIWHEELS_FF=y
 CONFIG_HID_MAGICMOUSE=y
+# CONFIG_HID_MALTRON is not set
 # CONFIG_HID_MAYFLASH is not set
 # CONFIG_HID_REDRAGON is not set
 CONFIG_HID_MICROSOFT=y
@@ -4396,6 +4406,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_EHCI_PCI=y
+# CONFIG_USB_EHCI_FSL is not set
 # CONFIG_USB_EHCI_HCD_PLATFORM is not set
 # CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
@@ -4743,6 +4754,10 @@ CONFIG_MLX4_INFINIBAND=y
 # CONFIG_INFINIBAND_OCRDMA is not set
 # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
 CONFIG_INFINIBAND_USNIC=y
+# CONFIG_INFINIBAND_BNXT_RE is not set
+# CONFIG_INFINIBAND_HFI1 is not set
+CONFIG_INFINIBAND_RDMAVT=y
+CONFIG_RDMA_RXE=y
 CONFIG_INFINIBAND_IPOIB=y
 CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
@@ -4750,10 +4765,6 @@ CONFIG_INFINIBAND_IPOIB_DEBUG=y
 CONFIG_INFINIBAND_SRP=y
 CONFIG_INFINIBAND_ISER=y
 CONFIG_INFINIBAND_OPA_VNIC=y
-CONFIG_INFINIBAND_RDMAVT=y
-CONFIG_RDMA_RXE=y
-# CONFIG_INFINIBAND_HFI1 is not set
-# CONFIG_INFINIBAND_BNXT_RE is not set
 CONFIG_EDAC_ATOMIC_SCRUB=y
 CONFIG_EDAC_SUPPORT=y
 CONFIG_EDAC=y
@@ -4820,6 +4831,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_RX8025 is not set
 # CONFIG_RTC_DRV_EM3027 is not set
 # CONFIG_RTC_DRV_RV8803 is not set
+# CONFIG_RTC_DRV_SD3078 is not set

 #
 # SPI RTC drivers
@@ -4978,7 +4990,6 @@ CONFIG_STAGING=y
 # CONFIG_VT6655 is not set
 # CONFIG_VT6656 is not set
 # CONFIG_FB_SM750 is not set
-# CONFIG_FB_XGI is not set

 #
 # Speakup console speech
@@ -5102,6 +5113,7 @@ CONFIG_CLKBLD_I8253=y
 CONFIG_MAILBOX=y
 CONFIG_PCC=y
 # CONFIG_ALTERA_MBOX is not set
+CONFIG_IOMMU_IOVA=y
 CONFIG_IOMMU_API=y
 CONFIG_IOMMU_SUPPORT=y

@@ -5110,7 +5122,6 @@ CONFIG_IOMMU_SUPPORT=y
 #
 # CONFIG_IOMMU_DEBUGFS is not set
 # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
-CONFIG_IOMMU_IOVA=y
 CONFIG_AMD_IOMMU=y
 # CONFIG_AMD_IOMMU_V2 is not set
 CONFIG_DMAR_TABLE=y
@@ -5288,7 +5299,6 @@ CONFIG_EXPORTFS_BLOCK_OPS=y
 CONFIG_FILE_LOCKING=y
 CONFIG_MANDATORY_FILE_LOCKING=y
 CONFIG_FS_ENCRYPTION=y
-# CONFIG_FS_VERITY is not set
 CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -5549,7 +5559,6 @@ CONFIG_FORTIFY_SOURCE=y
 # CONFIG_STATIC_USERMODEHELPER is not set
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SELINUX_DEVELOP=y
 CONFIG_SECURITY_SELINUX_AVC_STATS=y
@@ -5558,9 +5567,11 @@ CONFIG_SECURITY_SMACK=y
 # CONFIG_SECURITY_SMACK_BRINGUP is not set
 CONFIG_SECURITY_SMACK_NETFILTER=y
 # CONFIG_SECURITY_SMACK_APPEND_SIGNALS is not set
-# CONFIG_SECURITY_TOMOYO is not set
+CONFIG_SECURITY_TOMOYO=y
+CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
+CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
+CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y
 CONFIG_SECURITY_APPARMOR=y
-CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
 CONFIG_SECURITY_APPARMOR_HASH=y
 CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
 CONFIG_SECURITY_APPARMOR_DEBUG=y
@@ -5568,6 +5579,7 @@ CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
 # CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
 # CONFIG_SECURITY_LOADPIN is not set
 CONFIG_SECURITY_YAMA=y
+# CONFIG_SECURITY_SAFESETID is not set
 CONFIG_INTEGRITY=y
 CONFIG_INTEGRITY_SIGNATURE=y
 CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
@@ -5598,11 +5610,7 @@ CONFIG_EVM_ATTR_FSUUID=y
 CONFIG_EVM_EXTRA_SMACK_XATTRS=y
 CONFIG_EVM_ADD_XATTRS=y
 # CONFIG_EVM_LOAD_X509 is not set
-# CONFIG_DEFAULT_SECURITY_SELINUX is not set
-# CONFIG_DEFAULT_SECURITY_SMACK is not set
-CONFIG_DEFAULT_SECURITY_APPARMOR=y
-# CONFIG_DEFAULT_SECURITY_DAC is not set
-CONFIG_DEFAULT_SECURITY="apparmor"
+CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 CONFIG_XOR_BLOCKS=y
 CONFIG_ASYNC_CORE=y
 CONFIG_ASYNC_MEMCPY=y
