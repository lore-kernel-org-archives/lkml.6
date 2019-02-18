Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE471C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F18321906
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497996;
	bh=vCtZKajdIfTmPnMe+xoVP4trmv0aE7ivwETL1uXf7gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnx0z7FwEvROutyJ3Z0n0qCp/C9T6k6XZGk9s/VVscqrgbgIrjl22FbTuQ2HEpHLo
	 h8CaVnBim3DOButAYCs9l6QhHy0z9WxDSPW380RHFmJ2NBI3qDAvcPHxMGnn3iwwqO
	 RSonZMX0fPmunHiReGDLH+jmCItuG1GOLqS0GzEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfBRNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732906AbfBRNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36762190B;
        Mon, 18 Feb 2019 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497991;
        bh=vCtZKajdIfTmPnMe+xoVP4trmv0aE7ivwETL1uXf7gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj7OacmE2iQYh5gk0hF7ZYQocbt4D9g3nhyK13GsETllkWpgNoPYX63I6LPgcCzJM
         8aR3iXqYNv2QuxG+PbUpL77MtYtwxH2lMVnLjkNMFJC3zlYVBvRU6intjLKYbosNJO
         PB1oJH0h+vy36VtXTLBfJIeNUC85Mzp6FUjapPX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Tracy <rct@frus.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.19 59/85] tools uapi: fix Alpha support
Date:   Mon, 18 Feb 2019 14:43:25 +0100
Message-Id: <20190218133505.773468436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


