Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7689222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULj+THdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395199AbfBMWm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395147AbfBMWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so4413786wrg.1;
        Wed, 13 Feb 2019 14:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=ULj+THdUZNWpGpW+KM463NwXvBXWj/ziG70TMcSMLTrDNndnvryzpWfDrOvQsAMlCy
         WTqTZgCLccOezugr9gkA0PatiHtL3QYcaVFHXdeDbHSfxmJnJ51XdhRFY2aUkbBgSTXx
         tipXJL3Dy6QXxBL3zVgPtPq1ANzRsbGAy0+TigONDh7YYLPUk1GGivftv1kHhyKzxr+p
         oyQSUS3fuoSUEsbw4S9g37thArexER13LrUX+3yjAYx3TqSBBIUg7eNLJ1ItQYMqyIY6
         X6RFb4SUKd44Df0ltx5kfaGf/joUGmooAumJyOgvpEFh9LCb/dYw4CmmbPPAwy2VlDMo
         0ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=MA2D/D+UEGQP2QKmU0eo8jXIWnSrcNOoRQd+f0jIb8o88SRInr3fzRjsJ1UBHXbylw
         T1iwKBxhI9JxywhLPiL1/X084TPRrVA5uMf+LeSdPyOksJhllpEHxTjUylzKlSetbnPq
         Gpy4JZGlx3aitD9kBG/BqDcdiLNnf6vGGWC3DP4dXO5zUaEUPUknboGclifzhQbl51tc
         H27huhiEQHN03RMjbWc34mPQzMXpejfJGDOn4+SwBU+EBM8ZGpXkfyBHbv23q/BiqwBI
         1EfYLcmaz4r1imUjNI8qpk8WLc87OH/7l33pAvcEUD6XDrWmVNpuT36n8frKdg64ZYPL
         KIwA==
X-Gm-Message-State: AHQUAubtC9CMDptXxM+/v4QyhRECfiy/x0PhZNIo7CVD+CWQE9sghih8
        6IT9z3CKs/fRShoFNr6wx1w=
X-Google-Smtp-Source: AHgI3IYegSvkdqTo7yAMNGYKpTH4etQCyxzK1x4a5zwRFav668/1dvUCN1p823cxzwulFtPYhon3xA==
X-Received: by 2002:adf:9004:: with SMTP id h4mr302936wrh.49.1550097740125;
        Wed, 13 Feb 2019 14:42:20 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:19 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 07/12] __wr_after_init: Documentation: self-protection
Date:   Thu, 14 Feb 2019 00:41:36 +0200
Message-Id: <f0335476914a519f573d271ef062dc02b39885d1.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

