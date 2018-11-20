Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DE720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DE720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeKTKl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:41:28 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54316 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbeKTKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:41:27 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 305C672CA5E;
        Tue, 20 Nov 2018 03:15:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 23B8B7CD1FF; Tue, 20 Nov 2018 03:15:11 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:15:11 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] elf-em.h: add EM_XTENSA
Message-ID: <20181120001511.GE11387@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi/linux/audit.h header is going to use EM_XTENSA in order
to define AUDIT_ARCH_XTENSA which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

The value for EM_XTENSA has been taken from
http://www.sco.com/developers/gabi/2012-12-31/ch4.eheader.html

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
---
v2: added Reviewed-by to v1

 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index ba2e64cdbb6f..7b02cf339d8f 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -35,6 +35,7 @@
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */
 #define EM_ARCOMPACT	93	/* ARCompact processor */
+#define EM_XTENSA	94	/* Tensilica Xtensa Architecture */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_UNICORE	110	/* UniCore-32 */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
-- 
ldv
