Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200D2C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120F2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvsaISUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404363AbeLUSPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34090 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLUSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:14:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so4553838lfc.1;
        Fri, 21 Dec 2018 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=SvsaISUsENLTRerxTlrw5WngUCL6xcuf+y6j/r5ybSpTEfxaevKrsab709fKKhBFHj
         bDwmZRFgmlGlLH6FjZIZscR0mARSzL5Yc1Hymyod01ulZ++YoZYQqgmNdt5hGgCy/c1w
         dOBT1TON7MOsOs6Xw7MVbfxdS7EHIQYmGSXAmKQBDdENjV/u+AOBJ2y2A59gz4QamBCP
         UTifq3MQpLnaFdW5Xk4MLjGbO5nBEo9pGRwBG+W6PIBX76n7iZh9k2R9oNkzAxmSHaKA
         Z19GApJN2rFbLKVpY9/VsZ+zfN78gSapfg+d5LN8SNYSOESPzDlqQaFJ+a0L0WMvu1B/
         svYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=XuUAVsViAxDrasnVE8bzww9MbO27+Og5AaPTrtNF2wvgLFbaQVezjD/TIOLgd5KmRa
         BHecUnqXDOk7AIGlm9Yb3iZdiPRKbPRVfoNNofT0dJMWpxz4h+HPHZaggANgMzU6A7E4
         JNWxZb82c/f9gkc6SurnMxgr3dVcC/LVjfgECDmLlzd+7YwEB/kk0zZD/6b5loT5vPWN
         0zjv3nbkLTR6UQrJ5aAonHBelo3Fwsi3K80J3WKnbjGRtm3qpthvk0UDoQ9B62Va0WYc
         t6K78rekFlXfBsd4TwJB5A/bcHYlBN0SiIMMrV379tAgtHcZeN4zhTeEX7KEWZSWazTd
         fXxg==
X-Gm-Message-State: AA+aEWbYg+yx/n4lICc8TpqwUImv0RX3S/9KmTJL6JsB3GyVEwdYU2SA
        Eu7fChO/HZii3RR7+tsNhDU=
X-Google-Smtp-Source: AFSGD/UUw4QOTr1Fz5pqLC5tPgrFCIm78stVTJm1s66btznV4xeiArrlcZYeL5woLgX/8UrqetsuTw==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr2115400lfe.63.1545416096496;
        Fri, 21 Dec 2018 10:14:56 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:55 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] __wr_after_init: Documentation: self-protection
Date:   Fri, 21 Dec 2018 20:14:17 +0200
Message-Id: <20181221181423.20455-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221181423.20455-1-igor.stoppa@huawei.com>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the self-protection documentation, to mention also the use of the
__wr_after_init attribute.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/security/self-protection.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index f584fb74b4ff..df2614bc25b9 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -84,12 +84,14 @@ For variables that are initialized once at ``__init`` time, these can
 be marked with the (new and under development) ``__ro_after_init``
 attribute.
 
-What remains are variables that are updated rarely (e.g. GDT). These
-will need another infrastructure (similar to the temporary exceptions
-made to kernel code mentioned above) that allow them to spend the rest
-of their lifetime read-only. (For example, when being updated, only the
-CPU thread performing the update would be given uninterruptible write
-access to the memory.)
+Others, which are statically allocated, but still need to be updated
+rarely, can be marked with the ``__wr_after_init`` attribute.
+
+The update mechanism must avoid exposing the data to rogue alterations
+during the update. For example, only the CPU thread performing the update
+would be given uninterruptible write access to the memory.
+
+Currently there is no protection available for data allocated dynamically.
 
 Segregation of kernel memory from userspace memory
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.19.1

