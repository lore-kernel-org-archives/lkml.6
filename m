Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69909C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386F22086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386F22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeKIMyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:54:14 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:47810 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:54:14 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 77AF472CC59;
        Fri,  9 Nov 2018 06:15:36 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 6D46E7CD1FF; Fri,  9 Nov 2018 06:15:36 +0300 (MSK)
Date:   Fri, 9 Nov 2018 06:15:36 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] elf-em.h: add EM_ARC
Message-ID: <20181109031536.GB21511@altlinux.org>
Mail-Followup-To: Andy Lutomirski <luto@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109031303.GA20906@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi/linux/audit.h header is going to use EM_ARC in order
to define AUDIT_ARCH_ARC which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

The value for EM_ARC has been taken from
http://www.sco.com/developers/gabi/2012-12-31/ch4.eheader.html

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index ba3696e3d694..56ff3f9d9633 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -26,6 +26,7 @@
 #define EM_ARM		40	/* ARM 32 bit */
 #define EM_SH		42	/* SuperH */
 #define EM_SPARCV9	43	/* SPARC v9 64-bit */
+#define EM_ARC		45	/* Argonaut RISC Core */
 #define EM_H8_300	46	/* Renesas H8/300 */
 #define EM_IA_64	50	/* HP/Intel IA-64 */
 #define EM_X86_64	62	/* AMD x86-64 */
-- 
ldv
