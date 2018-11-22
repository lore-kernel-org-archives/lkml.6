Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B4BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868B020821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868B020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391880AbeKVNt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:49:27 -0500
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:34320
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbeKVNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:49:24 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id PfOQg0k7yvsMIPfOQgJ81q; Wed, 21 Nov 2018 20:11:03 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gPfOP-0004GW-WC; Wed, 21 Nov 2018 20:11:02 -0700
From:   kys@linuxonhyperv.com
To:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/4] Drivers: hv: Enable CONFIG_HYPERV on ARM64
Date:   Thu, 22 Nov 2018 03:10:59 +0000
Message-Id: <20181122031059.16338-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOx954EiZt2MJi8NIdX3lQvLf5mlF+JSVQHcvlnz1xEIigE6oS7mIurbQBHredupRjX3gddRD1qtHm8u7fLFXkMiJYrTNzWj+WcR3/uNwJd6H6N6ZR8I
 VEZPLDaIyuyKPNotuCzTyLUiElTjXLTM5i0ifc/cHna7f/kjM4FpacrY+1fhCEZSECLsPP++7QwW4wFtm7YkeLDYznEqp3dExT1Dw7gISVzvnkj/cgq1wFGs
 j3f6yD4lKUnJTdcrDqufDRFMcPH/7Z68xeXspnsqGvCjJX305+xG4pwfnQa/o5T8Rr3HvuU/LlTmLc5I5uTjMFPMC5MgXPJ5+fttsgAlmQ7TyoUZ8QlV/ocw
 UMCYCZg/zNkZysYkr/I4EKxgnBG5i8JyKfBR7/ouXcRWUZ25XZnidjJpwHpLzZsve/VcRIQaZVSVV4+w/b2hmyg2py7jhYs5n2CuMOurrPejI2BZz+AmtWRN
 XKXSP56Rdb9lMTTCLSMRl+oWsWKqpfaJElGATXaZi7Ya2H2LcdyDc5OvPrAy9voddacUfvL0vjaHh1cGGUchi9bAzyRd7WGIYxlhAcaqU608SxU8ym3V8jwh
 WXbse4087N5OMrxVEuy4LqYxxuC/d68PEbCdC1iqDCDniQgTbcw6LYi60ULdxyadKNsDjlgmDcutOgR0fcexyZKg9BhudqfvLyylBEqhTozDyseF+Llb3sQW
 /pav5aXB+oy8G7c7KvcIJ1Ro33+uqO/74cKJhdkZkIlu1aWsKUKhVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on ARM64,
causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f575c3f..c3e11a2f9c70 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && PCI && \
+			((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
2.19.1

