Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F85C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6CA20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdfHiKV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6CA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbeLJMvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33699 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLJMvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so10393540wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THrF65uyQ43y9XI4Oao8ZCD7W0hiODFoiBK2GnkK+6k=;
        b=PdfHiKV/nw+CfvDzzUmvpjA/YhVLjcLEJGbE4xRNKckctV4ggJLQ09SaEpJOCkc/Wd
         TsbWeQ7VqNxHNADvOwoiDxubfQDEDS0+PHacVgOSQwfEz02dQXLOTxmV5IykKVkn0f9a
         qcdjj+pRCBHgfvFs4fxlSCiaYPFMMXTkQUdwp3B9666yUCdbDg9xBDMR3zDN5H2HdY1U
         EAZ/zAia4HQUr1OpEIgycWmDLiok+qqigVLOzimiWXbPovc2JNH66nE7jrGjj0/pP7Xm
         u31n4umKu6azySOlPyk4zWiDSNjuQbTXYYgyyZeCL1TW0iqGcwgkW/T/pb9E8YfCUAZ2
         045Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THrF65uyQ43y9XI4Oao8ZCD7W0hiODFoiBK2GnkK+6k=;
        b=tm2yaq+ojohdtnTrxxisduL22PvtOI0uR4BY1ufTyoSL5O8G7aOzavd3kn9m5lPyz2
         FrNFY7Bsd5Qau+zjAxAPvMVA+fEUILj3k2z1vP//2VL5Xjx8Aw0SvJ9wIiMtOU8yOnXd
         F8MGNG4zQwFpjKmSOy/3X+zaibHTxwpfyuhAnlNdq6vYjtCmIYOgq2tTPeIrO4W5LSgV
         mPIR7uBG9aqo3yibFf/bCHgDX04JnKPaFHdpK1qdWW5c26RVx3CyA5D618pV05lMJ6x/
         LgVOLDBrO1ko30uVEWuSKbLpKyJ2EzoC/qHIqvc/bKPjgVdZfsqEiLAbBGj1rgyne6xw
         aCHQ==
X-Gm-Message-State: AA+aEWbIHrX5ua9KCjIuv8ZIXrYDzNHUcJZ/5R4H8Flg2gzJaHjrDgyn
        FxjBk75W0g0gCkKD73Wxb/BvrQ==
X-Google-Smtp-Source: AFSGD/VI/5BMsRXqnw18fB6Gll7b+Eig1k8PMWahNn8bGC0uXwXuMAwRBnIM/ZnTZkzB47NBiSqZdQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr9405307wrv.202.1544446277017;
        Mon, 10 Dec 2018 04:51:17 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:16 -0800 (PST)
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
Subject: [PATCH v9 5/8] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Mon, 10 Dec 2018 13:51:02 +0100
Message-Id: <2c573564b456327708d175f3124256bc71081bd8.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
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
2.20.0.rc2.403.gdbc3b29805-goog

