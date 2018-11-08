Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145AA2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UP+XhJbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145AA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKIAMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52688 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeKIAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so1495212wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCI3XzgNVAltAQe0ygEc6WjcTSNZu+vDSueRg2rkboA=;
        b=UP+XhJbt7rG/bdEpw8fc31VRF5aLTB6BTp86/sKBPDdvzf+3rKxrZx+R4xkXmuYNk4
         Z2kSoGRZtY2xgb0cZLZ8nqWLECPTlNaPdP21J5ZftO9/AJWV27UNRA3MqMVTh/5VBt86
         OR25TGd6GfMgbPUcVLtTp1LdrRAy+ildKK5CGWBA4J0gfpCpY2qo+ocTQb4EWphPlU6Q
         auFXwXntmIyQWzfLokABGdc0KwvDYW58Q+kRcY3/53A5RFB2TyvvkOfcZPB/L/44UZEC
         8kDE/Ckdr3nMddglr5ecwDqcjOXtIhIheYGjYA9pJ/KdMyecy+Hsgg9Tkw2BDFQ1m7aq
         kRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCI3XzgNVAltAQe0ygEc6WjcTSNZu+vDSueRg2rkboA=;
        b=L26BN1ynKieerc09+XkiMyRBrjkr28u930MGPPazQOkgG/u3+hEMog42vwIV2/z7t1
         JXhUiAwA+P3UiV3o/48lcpWLiNgca/29En3E5kMZm9POQHjuDrLoRxyqSjO2q92eoQ6E
         iLPYpiZMSlSATiH1tsIkQS+B8HQ54g4amvDKV60VgZc8tKlMkSXijVHOhriNAaJYWJbK
         jnA/bAAxotZBaJTDky7tTmM5I7ObSxonXzpEb0oGpUOHbjK0fXV7UABdhXk2QxAQKEsC
         YwMrnr10sAR0GZfNEu7ezS68upnPVs0Pdp7uah/rkYcFzGCN+qYCj38hmb/HAUx1jxwr
         KI8g==
X-Gm-Message-State: AGRZ1gLB8v/dvAAiIma6DvNE1V5CEHz46ZzkCBCpACA3Yt/c+nCweyHt
        aVfln6bo+6wUNdZl65TMyvr6MQ==
X-Google-Smtp-Source: AJdET5c+OpdgjUiZO9kVFnzi+iLq8I4Ia27Tsi9lTwsCI5F43MyC9kiQR9b4hA1qM6mueQyUfoxirQ==
X-Received: by 2002:a1c:154a:: with SMTP id 71-v6mr1368940wmv.83.1541687787548;
        Thu, 08 Nov 2018 06:36:27 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:26 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v8 5/8] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Thu,  8 Nov 2018 15:36:12 +0100
Message-Id: <4969eac81732e555ca1ec102c12eb1e29c82ed29.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
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
2.19.1.930.g4563a0d9d0-goog

