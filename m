Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D0AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD7B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTgn/uM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD7B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeJKXGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD842098A;
        Thu, 11 Oct 2018 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272318;
        bh=2N/YZf/8rQ/IfiiF/yls7DQoMMmjN3HCcKdKJ+mOqo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTgn/uM5QqdeMyRkwx7zfQ54FcqogDNEyaGSKQnEdfmA/yYS1DbPTG684deqMjEGY
         c7sg8LaUnh+2lbV5BkzOwzTMNkFLJZyLGNSCAxpl+j8+op+jJgL4yBBtHNfIzerg+P
         e8WzbGrhTPssYKT5yPkMvy6D7eAkpAupObOCCRfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 027/120] x86/tsc: Add missing header to tsc_msr.c
Date:   Thu, 11 Oct 2018 17:33:28 +0200
Message-Id: <20181011152550.761885302@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit dbd0fbc76c77daac08ddd245afdcbade0d506e19 ]

Add a missing header otherwise compiler warns about missed prototype:

CC      arch/x86/kernel/tsc_msr.o
arch/x86/kernel/tsc_msr.c:73:15: warning: no previous prototype for ‘cpu_khz_from_msr’ [-Wmissing-prototypes]
   unsigned long cpu_khz_from_msr(void)
                 ^~~~~~~~~~~~~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/tsc_msr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 #include <asm/apic.h>
 #include <asm/param.h>
+#include <asm/tsc.h>
 
 /* CPU reference clock frequency: in KHz */
 #define FREQ_83		83200


