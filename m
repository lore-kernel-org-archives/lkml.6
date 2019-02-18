Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641672070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501056;
	bh=LAY7wqFNOSs6lEOPAV+ZDq0MJ/kFJYljWaGPxIOjW7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZEi8OTgU2nSpxmtCQf/WPJJaPWGj0r171IXY6n/rWPujpE/DiOMdAO/OBEcqC87JR
	 0jMGDZFYdZYLu9rbr1kPl9HUUGEbxDKqgj90nwfDE96RO8A/VyX4BwdK3Jp8W3Tp1x
	 Da0ayx3rWEo9eN07ZhHjzMP/XnXkGtNepugJJcSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfBRNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfBRNsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D608021905;
        Mon, 18 Feb 2019 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497704;
        bh=LAY7wqFNOSs6lEOPAV+ZDq0MJ/kFJYljWaGPxIOjW7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkfYmomPAzVQtkNVmMOuoytEn1UyhzSh9MLOVN6zTGkQop5VUbUNuwIFtW/ZMzTfc
         TyeqkO3oTqguC/bHkPHPkehb66iQXy/qSGlgyNVwDzaHY6zHdW35LeauINk7QbBqvH
         02bsF1ZC2n2NHTl+wL846CzdJLM7EYEZuGqiTWTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Tracy <rct@frus.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.20 60/92] tools uapi: fix Alpha support
Date:   Mon, 18 Feb 2019 14:43:03 +0100
Message-Id: <20190218133500.482260394@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Tracy <rct@frus.com>

commit 842fc0f5dc5c9f9bd91f891554996d903c40cf35 upstream.

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Bob Tracy <rct@frus.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/uapi/asm/bitsperlong.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -15,6 +15,8 @@
 #include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
 #elif defined(__riscv)
 #include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
+#elif defined(__alpha__)
+#include "../../arch/alpha/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif


