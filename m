Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F62F2083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrgdPh5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F62F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeH3PnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:13 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35626 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeH3PnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id o18-v6so1696441wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dvluYXXhbs3bkFHe7bYXbDtGM4AV4lqI04lFKRyGa0=;
        b=FrgdPh5TBPIr4rtMd7tklQtyRgar4ZAsFHKz1PwEj3+VC5jau9Dry3d3VxRWxcx9DN
         aM7aeZudTWm7p/kNyIHKV/3zc+Y5VxHMcMOGT00Raehj8yCHK4qQRjbgPVV2KLJMxAqa
         3Rgdu4UCrXM9AqoS+dFhMRoW3rJ0nq+cpf74SiEB/jzedt9fBg4Hfm/m/pENAIQSu++0
         oMrCJovZb3IkPM50eWmd/9DzfAZugaZLcIZhmav9Cf0kn8UP4YxUMn9mjnercwABxtdG
         oWWF4BHN5MPrFvo1HQRM1riSm10AId1VXqNCaVpDU0IN56koQpJ+E8OSG+nLyWo4zchm
         X6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dvluYXXhbs3bkFHe7bYXbDtGM4AV4lqI04lFKRyGa0=;
        b=J21MHMlpmKKtpCFTgDG1ZsdnP7KCabRMrpb+9hMq7n1suWSounDt4PxGysuDdPWCEz
         6enJ5lGRLo+cDYuGc3OXGekBsukLNH1PIhdEd9WrPAeyDVrAw3YDpWHQn7/OtFW2Va+C
         Npu33J+UD/dk6aFAgXOg+SMWkNMcyjJIv9XU1FnYDG7U3VJeHf9XO6bsMwWxFQQzYY+Q
         TVdm6cKFt5You9TDuetKUecQ5F2l4wA97Qkm7T7uQenNFE2CATbnjVTp1JUa3qWCreNr
         DzT1sMdANsibKPdoM6eZCKxWuok8xVlT2Ch+Mg+bUmnWHeFKFQZ3kC6tx6llx7rZDuyY
         eE8w==
X-Gm-Message-State: APzg51C2Z2DMb3AoNpZeE2Rj2+sHmehEL22H5tpd+eMKMeStveSnzq2o
        3nBLRZzPn4bQ2UYYAU6SdHhg4w==
X-Google-Smtp-Source: ANB0VdaAurM5wWvTbuaKJB5Eic+D12Dz24+pkaychw8uSDgku8eMYRWKoLaud5DLPVltKXfKUxcYpw==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr1645342wmf.114.1535629288159;
        Thu, 30 Aug 2018 04:41:28 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:27 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 05/11] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Thu, 30 Aug 2018 13:41:10 +0200
Message-Id: <a31c2ab78925e0df0a9164e7ee402141ca1b0d6b.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

