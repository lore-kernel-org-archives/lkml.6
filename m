Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E890C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1C620874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZIKF4B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeLSVeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33062 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbeLSVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so18743320ljd.0;
        Wed, 19 Dec 2018 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=xeUBKKu9pM2Fl/EWnsAPb2mBNLFsikzJ4KNY/hC/k1s=;
        b=TZIKF4B0i3koI0BW8axIrrGf4qCRSgVc8vuBMQJuNZ1qpAqlmGEW+bOBxwCcDK/JY3
         mNOXn/Lytz0LlgdZK6s3JlI7atnuH7qez7sfQofkmzbIV2f2ZxskOsfp9NEhU5NaQTvN
         tFggyM8mgzKvz7s8hU9qqgBsaUM8BAmUcWFYR5zWO8a3RW+FvppFPc9fZecShjwJLJh/
         lBOqekityzb82UV0NrQDkyhgmPQox8nu6C1HKMReNtzcl/z9UGLkONLrC6fFakRwXStK
         q/7/hXtBDqCHpIXqfHQ2ugAPMEwgUpSvY+la3Uaoflk84Jo7xJduNGkOWP+FAq0r1yMl
         V6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=xeUBKKu9pM2Fl/EWnsAPb2mBNLFsikzJ4KNY/hC/k1s=;
        b=I082wEX+rC6ocwfocrZeL2ebzu0+qekHf9IA/GrxZxmcseYLTi/um7lMIbxGNDZhJX
         NlFu4mhlLc3xpffinj8ajapbb9GSN5krnFOF2rX2cLPj/obquHBBcY08V++MO5JxwVBp
         Ut7PnQ+mM05jcT9GgqOkTqzqc4WwUhg2E4hPpf474u4kvE7UFFSxDtmpJZof0/Zuqh9n
         ypJMz16dYrJqKklvRgYoTlQ8RtcXzmYvp2OwsP/CrvwzryYpMMoSFf0hNKdR/8pIZ7ss
         Xh51Gk5iJLpJAWU+xzbzMrF1WbAaInFMHch2ImJ2Orx8QzQ36SVbCvfG8oPFs2PkIwiG
         6lWA==
X-Gm-Message-State: AA+aEWYYZwXCDX32EEDsMBunLcbsPY3TQ2ojrUYjoR0kd3Codmsr5GxL
        uWg/7LFAtk6HeqGQoM8h4dE=
X-Google-Smtp-Source: AFSGD/VdVCH5iML0R9nPvIbiMPCBw0CGtT0CPJuGwuUVLfPeSRuvFLi8jSpphGe6vqzW2o8lG9K3Jw==
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr4048231lji.113.1545255255391;
        Wed, 19 Dec 2018 13:34:15 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:14 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] __wr_after_init: Documentation: self-protection
Date:   Wed, 19 Dec 2018 23:33:32 +0200
Message-Id: <20181219213338.26619-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219213338.26619-1-igor.stoppa@huawei.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
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

