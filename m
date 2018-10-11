Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732EC2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkVOqlWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732EC2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeJKXMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbeJKXMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:12:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7721213A2;
        Thu, 11 Oct 2018 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272662;
        bh=gKurg/mzp6IKS/8dwzyrepC96vSrSxSKx9ZObcLnkDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkVOqlWVYEzXhNG9JuiknATVzbJouEnx0pDFXV1L3XTzRexhJeqcUA5ESMLbp44wt
         d8DfKGUP94v+J+t4+Xa0KPtGTEvXu6skDPdicEBds3H+ijG/tamoNL+WtQg8ztPvz+
         HsIxYWBlWOxWu5/Jf/yoMzxRgAFBCpeBShtlOHvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.9 34/35] Revert "perf: sync up x86/.../cpufeatures.h"
Date:   Thu, 11 Oct 2018 17:35:36 +0200
Message-Id: <20181011152521.545425721@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit f09a7b0eead737b33d940bf5c2509ca1441e9590

Daniel writes:
	Because the modification in this patch actually belongs to
	e63650840e8b ("x86/fpu: Finish excising 'eagerfpu'")

Reported-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
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
-/* free, was #define X86_FEATURE_EAGER_FPU	( 3*32+29) * "eagerfpu" Non lazy FPU restore */
+#define X86_FEATURE_EAGER_FPU	( 3*32+29) /* "eagerfpu" Non lazy FPU restore */
 #define X86_FEATURE_NONSTOP_TSC_S3 ( 3*32+30) /* TSC doesn't stop in S3 state */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */


