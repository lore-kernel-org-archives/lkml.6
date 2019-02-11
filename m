Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BBCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D9E2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiIwOk4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBKX2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55210 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfBKX23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so1002821wmh.4;
        Mon, 11 Feb 2019 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=RiIwOk4Yh3oZElR1xL4cASyYj7D6BXihLz4aCG/v4xszt7i6uSqsxIV7ytYwftyfcc
         uTuXGibwTiA/aj+YnMYCpkiM2z6kfso+3dbhiW9YSOHBl6nP1RszYI63KB8K2NsBpdrq
         0O12+xpEmBDUqkUXAPxb8OuavppC4Jr2y/PKJY27TEuHaKKz0cs5qLr1lY41XPnz7Zxl
         sA5IfuG6fAjiZmtxt25Ed0yZ2F0YDSgON1s7dC59J6yvzTcBnm5YPJLSt9XplPkdVRWQ
         K3g6xJSwVQiZphYA66q/CfA/tFG9bpv0/xDVALdXoiSGfJj+EbFGKE64OBFZr0dgUItK
         w5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=y4zotDQYnZoXB9lfg1fC2W7czb+qE54ZRjKDYZQbGrM=;
        b=kZNR7RfWg8EyhuaAfQYIClVK6h0MJ4qN6U9JHjiVBruZjZ66djNWxLB+d8ITMeMGX8
         iC9pStpyqHIZY4Gr4L4/XbjpIhNwsD1ZrFqgyhHAv2OEMDT+JtLrqiar4iNxznCYYGTz
         372yHPbi64J6TqukS+dbjlXJQCwn85BHiaj8YcnX2B+1p2u3Sj51wsyy74Vqluf94+NM
         MofXmFc0d10P/WDY61J4pDOVffqqBrw8zrAEXbEnoJGaGUkd9EX2tX6ckmM68zgkhe4H
         GwTgStX8ReNXI1WRyztrn2OOG7yOXJ6tuKNio78m7zjSuDrlOoeV1bLPk50Hl4WU7ywX
         MoiQ==
X-Gm-Message-State: AHQUAua7rXOs5wdIbrNDIGboeJGQ/vOxtVJ+tt4qTZF51tsskoFXTL5M
        qYJYWmsM9ZPuVy0CPAAZ1nZjisb1NJ8=
X-Google-Smtp-Source: AHgI3IYPC5M3Lyg22y71g2LtAl1fvg/0Ej4pQcQ/hIiBIm9wNMef0twZh8pcHX4//0/AZscOz8ApJw==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr502017wmo.150.1549927707535;
        Mon, 11 Feb 2019 15:28:27 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:26 -0800 (PST)
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
Subject: [RFC PATCH v4 07/12] __wr_after_init: Documentation: self-protection
Date:   Tue, 12 Feb 2019 01:27:44 +0200
Message-Id: <cb930b9825a374126b62b897569cc722d3032161.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
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

