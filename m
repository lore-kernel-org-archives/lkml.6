Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44850C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0209F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D4HS/gfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJPVcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:32:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40063 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:32:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016134219euoutp02e5534156e1b615487b0df0872b8a2ac7~eGpKaI-eg3008430084euoutp02F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:42:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016134219euoutp02e5534156e1b615487b0df0872b8a2ac7~eGpKaI-eg3008430084euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539697339;
        bh=k1k+GWihXDcyZTo+yZWHT2SvH7GQZc8ZfTIqcXasn5c=;
        h=To:Cc:From:Subject:Date:References:From;
        b=D4HS/gfxd72jgkZd71/PVa58NfQpuVl2hU0WBRmIhWKh3o+UlE6NNyVAuu57MCka+
         tSae8P8YIW+WqmCd60/LXqrl7tul21dKp8BfFgGn6uAPHkaPRp6YUPABgD6uHl8JLk
         ozAn+K0W3fyF659iYpRSy211rnntvUCpozk0PO7U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016134218eucas1p105f3545dbc230cef06e6d4d57b682415~eGpJkq84j1238712387eucas1p1Z;
        Tue, 16 Oct 2018 13:42:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.C5.04806.ABAE5CB5; Tue, 16
        Oct 2018 14:42:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016134217eucas1p2102984488b89178a865162553369025b~eGpI5NlJo0851008510eucas1p2D;
        Tue, 16 Oct 2018 13:42:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016134217eusmtrp25f9406241c68518d1a5048515b679038~eGpIqtY-d1198311983eusmtrp25;
        Tue, 16 Oct 2018 13:42:17 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-3e-5bc5eaba4148
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.8F.04128.9BAE5CB5; Tue, 16
        Oct 2018 14:42:17 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016134217eusmtip10455a2c3a7407304365fd47f5bc5053a~eGpIOmPtB0984009840eusmtip1L;
        Tue, 16 Oct 2018 13:42:17 +0000 (GMT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.co>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] x86: remove redundant 'default n' from Kconfig-s
Date:   Tue, 16 Oct 2018 15:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTle5tPafQ5Kt5MMqY0C1yifjy1QiHi/chQf5lD6JgPtZwZmRlN
        o0hLzQbJLdPEMQmzXMhRB0slG9xGSwW3VjBapLTUwj1D8/WU/HfOPefe79zLR+PSFtKFjlfp
        eI1KkSCjbIjmnpVBr9apbrnv7TZgh4ozCXbOuEaxdxqc2ZL8IowdaS2j2GFzBcY2NRbh7LLx
        M8kumQqxQGtuKfMWwTXW3KS4mcFBK67z5yjB/Zp4R3Cz7WMUt1jXhri5xt1cb8Y8GWIdYXM0
        hk+IT+Y1PsejbOImMhbJxEm3lPSOWTINXd+pRzQNzBEwmWV6ZE1LmUcIBhbOiHgeQXa7To9s
        NvAcgnmDGRMEwd9bu0qKwkME+t4KK5HMIqgbfU8JxJEpR5A5NUEJLThTgKDP5CVgivGH/Bs1
        SMAOTBBU1pr+jSUYd2goqcaESE5MOOT27xfKEsYe+u5+IcQxbvBkugwX5gPTagVF5hxSNCVD
        rnFhM94JsIxWWonYAaYspk3sCust9zCxuRjBj98PCJHUb8Tu79nsDoBOyxAppMCZA1Df6iOW
        g8Dw+Dsm3ssW3kzbi4FsoaC5GBfLEsjOkopuDzBWGamtZ/Ut1ZsWDlbS/cTrnoXe5k48D+0p
        3bZl6bYtS/9HqEB4DXLmk7TKWF57WMVf9NYqlNokVaz3ObWyEW18qJdrloWnqP1PdAdiaCTb
        IVl+3SWXkopkbaqyAwGNyxwlscPdcqkkRpF6ideoIzVJCby2A+2iCZmzpKq8QS5lYhU6/gLP
        J/KaLRWjrV3SkKs+6v64v6HLNK7bh/pbNB9XlREuFcSp8PTAPg0fsDfHZPfKkux5Okzp6zT0
        lU5cC9PVZkrfvuhTq8f8jvW7e6jPu32L/GRUNPlFfxhY7cJCs0KfR+eoUmaeBdMnA+27Ji+7
        G64VxFumg9ctCQyfn2cwhxQGyQxDV/NHrth5yghtnOLQQVyjVfwF4G/FvUwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7o7Xx2NNrjfrW5xcXori8XnDf/Y
        LKZtFLeYMXEqk8XlXXPYLC4dWMBksXnTVGaLHxses1p83zKZyYHT43trH4vHplWdbB7vzp1j
        9zj84QqLx8ent1g83u+7yubxbc1uRo/Pm+Q8TrR8YQ3gjNKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeNryjbXgpXxF46H3rA2MzZJdjJwcEgIm
        EidW/2btYuTiEBJYyigxacFD9i5GDqCEjMTx9WUQNcISf651sUHUvGWUOPHtJxOIIyIwj1Fi
        Svt+NpAqZoFJjBIbdmSD2GwCVhIT21cxgtjCAo4SS1ZvYQKxeQXsJNqmbWUFsVkEVCU2zlgJ
        FhcViJC49bCDBaJGUOLkzCcsEDPVJf7Mu8QMYctLbH87h3kCI/8sJGWzkJTNQlK2gJF5FaNI
        amlxbnpusZFecWJucWleul5yfu4mRmA8bTv2c8sOxq53wYcYBTgYlXh4f1w/Ei3EmlhWXJl7
        iFGCg1lJhDf90tFoId6UxMqq1KL8+KLSnNTiQ4ymQIdPZJYSTc4HxnpeSbyhqaG5haWhubG5
        sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbG/YV3uaV8dRYfOKgtNGv76iS1wvnVNkUP
        +94m2AntC1XO2l4f1FP/RfvnzZ0a0x+ssNuVsOjNrM7/rOF8lhqL/ZntT+6xOznHY0Z83a+z
        9zsXvLYtfm+i6lLaxKJpq35IUrX/cC637oKKW3Mnr10d3HX35T+mJU+uL/T/Ms9v7svWTNXT
        d2p/K7EUZyQaajEXFScCAHmKldW9AgAA
Message-Id: <20181016134217eucas1p2102984488b89178a865162553369025b~eGpI5NlJo0851008510eucas1p2D@eucas1p2.samsung.com>
X-CMS-MailID: 20181016134217eucas1p2102984488b89178a865162553369025b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016134217eucas1p2102984488b89178a865162553369025b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016134217eucas1p2102984488b89178a865162553369025b
References: <CGME20181016134217eucas1p2102984488b89178a865162553369025b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/x86/Kconfig       |    7 -------
 arch/x86/Kconfig.debug |    1 -
 arch/x86/xen/Kconfig   |    1 -
 3 files changed, 9 deletions(-)

Index: b/arch/x86/Kconfig
===================================================================
--- a/arch/x86/Kconfig	2018-10-09 15:58:36.747122883 +0200
+++ b/arch/x86/Kconfig	2018-10-16 15:37:16.787643127 +0200
@@ -449,7 +449,6 @@ config RETPOLINE
 
 config INTEL_RDT
 	bool "Intel Resource Director Technology support"
-	default n
 	depends on X86 && CPU_SUP_INTEL
 	select KERNFS
 	help
@@ -704,7 +703,6 @@ config STA2X11
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
-	default n
 	---help---
 	  This adds support for boards based on the STA2X11 IO-Hub,
 	  a.k.a. "ConneXt". The chip is used in place of the standard
@@ -805,7 +803,6 @@ config KVM_GUEST
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
-	default n
 	---help---
 	  This option enables collection of various statistics for KVM guest.
 	  Statistics are displayed in debugfs filesystem. Enabling this option
@@ -814,7 +811,6 @@ config KVM_DEBUG_FS
 config PARAVIRT_TIME_ACCOUNTING
 	bool "Paravirtual steal time accounting"
 	depends on PARAVIRT
-	default n
 	---help---
 	  Select this option to enable fine granularity task steal time
 	  accounting. Time spent executing other tasks in parallel with
@@ -1171,7 +1167,6 @@ source "arch/x86/events/Kconfig"
 
 config X86_LEGACY_VM86
 	bool "Legacy VM86 support"
-	default n
 	depends on X86_32
 	---help---
 	  This option allows user programs to put the CPU into V8086
@@ -2231,7 +2226,6 @@ config HOTPLUG_CPU
 
 config BOOTPARAM_HOTPLUG_CPU0
 	bool "Set default setting of cpu0_hotpluggable"
-	default n
 	depends on HOTPLUG_CPU
 	---help---
 	  Set whether default state of cpu0_hotpluggable is on or off.
@@ -2792,7 +2786,6 @@ source "drivers/pcmcia/Kconfig"
 config RAPIDIO
 	tristate "RapidIO support"
 	depends on PCI
-	default n
 	help
 	  If enabled this option will include drivers and the core
 	  infrastructure code to support RapidIO interconnect devices.
Index: b/arch/x86/Kconfig.debug
===================================================================
--- a/arch/x86/Kconfig.debug	2018-09-26 15:54:31.898819765 +0200
+++ b/arch/x86/Kconfig.debug	2018-10-16 15:37:37.903643659 +0200
@@ -314,7 +314,6 @@ config DEBUG_NMI_SELFTEST
 
 config DEBUG_IMR_SELFTEST
 	bool "Isolated Memory Region self test"
-	default n
 	depends on INTEL_IMR
 	---help---
 	  This option enables automated sanity testing of the IMR code.
Index: b/arch/x86/xen/Kconfig
===================================================================
--- a/arch/x86/xen/Kconfig	2018-10-09 15:58:37.003122889 +0200
+++ b/arch/x86/xen/Kconfig	2018-10-16 15:37:53.031644040 +0200
@@ -69,7 +69,6 @@ config XEN_SAVE_RESTORE
 config XEN_DEBUG_FS
 	bool "Enable Xen debug and tuning parameters in debugfs"
 	depends on XEN && DEBUG_FS
-	default n
 	help
 	  Enable statistics output and various tuning options in debugfs.
 	  Enabling this option may incur a significant performance overhead.
