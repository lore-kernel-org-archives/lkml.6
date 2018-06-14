Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F99CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CF720020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPbHWCU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CF720020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966209AbeFNOWv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966121AbeFNOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FD8208DB;
        Thu, 14 Jun 2018 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985570;
        bh=fmrqb8/BPVnygDxXXDG3deLci+7Hp+hi6YppVxTkLlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPbHWCU9zirdF4aWE8cUB4HKSBvrjkhm0h9BbRlYdciiWlUA2J6ubo2iRU4D7Z00X
         IgBeH+Oxw+qikh3xQ4Gs9JOZ3R+LDyspN0Ii+KupRJ4Kx3/+seYOWAqSgCKw12hM6U
         3i3H8yivoisx883yBOKsFsPxyUtleTtHmkmLQ4zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.9 30/30] perf: sync up x86/.../cpufeatures.h
Date:   Thu, 14 Jun 2018 16:05:11 +0200
Message-Id: <20180614132601.521375678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The x86 copy of cpufeatures.h is now out of sync, so fix that.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/arch/x86/include/asm/cpufeatures.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -104,7 +104,7 @@
 #define X86_FEATURE_EXTD_APICID	( 3*32+26) /* has extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM     ( 3*32+27) /* multi-node processor */
 #define X86_FEATURE_APERFMPERF	( 3*32+28) /* APERFMPERF */
-#define X86_FEATURE_EAGER_FPU	( 3*32+29) /* "eagerfpu" Non lazy FPU restore */
+/* free, was #define X86_FEATURE_EAGER_FPU	( 3*32+29) * "eagerfpu" Non lazy FPU restore */
 #define X86_FEATURE_NONSTOP_TSC_S3 ( 3*32+30) /* TSC doesn't stop in S3 state */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */


