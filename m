Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC056C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731572082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="NC7tOk5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731572082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLIUpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:45:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37299 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:45:10 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so14912808iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNaI3hDAMnUXZFjlHQHpvHuAp7kuC48ucAbx4V8btwc=;
        b=NC7tOk5WhKeOvqzr3cxn9lEQ1e8117UHymSLTKFys18259B7ObIPwrJjJqau2LcZPs
         Mko4AqGTobSiIuXMh0AxUcgvtEU8IeQpOtM6XIMhgIMerHag722VJ6imuPPI/rZwfUYp
         a0ngz5Wp62M2JsonOUaR6cgXNGQ/kiJokuXUTibthbVeK4rJo7BVHPlFFhmWfZItyL/W
         0OrN/00Q9gKuoDlXPnYq24Z9BLGX6mJ5UHcCRl8WEN03b3R21dFp00ZO0Xs9q8jlhODw
         jp2Urr9oHSeB1XmzmSR97Xk4ap88+ZV0EfPdXYQwV1AaR+rTAUj5YGV+c5TcoV3qCJgk
         qHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNaI3hDAMnUXZFjlHQHpvHuAp7kuC48ucAbx4V8btwc=;
        b=dDDYO/uJ7SubnpVBdsFFgx+YJ8M8te8hBgl9DTTQ8nDbqM0YUliTy0XMvZRG7oZJLb
         nqpJtnNaKNAEeUmiNdEhQg/ireOCoqD1oWGPW9n4nydxZss/ESSGCF2u08YRXGAS6QtV
         2vhpS6ZQnkqiTMQHGBLYTPfZDsxmIi79cyY5NAz4Z7v0UUjCoMDHCnZz5tEzvd6eCUXc
         45LFeuM38POr1V0Zg1RTpJGQGf4cY4B/Q1J5SNX9v7nBGJHsxL2UHe7zpygP05KJepZG
         cOLGcchIK9IHKiQXzeSGfTvNthj69D9rKU9ceuzjeMFznH8EDEkuIbyM1lDtbCKqV4iL
         Go9A==
X-Gm-Message-State: AA+aEWYvmV5AMfsy9yThm/ctGszzRQtgoXzPm1rPeVKzQl1H6FbmEKh2
        MQa9AmtFAgWOZAnbrjRCZ5hywDDSNlU=
X-Google-Smtp-Source: AFSGD/Wpe5dEucVsQv8KJvYs/vlhm3HYWH9HLw0CHQ3mYEO7+yTgbjo+qSBHfN1wX0UBrWcMX7M2TQ==
X-Received: by 2002:a02:95e4:: with SMTP id b91mr8532356jai.15.1544388309320;
        Sun, 09 Dec 2018 12:45:09 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id 72sm4282606itw.16.2018.12.09.12.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:45:08 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Date:   Sun,  9 Dec 2018 13:44:49 -0700
Message-Id: <20181209204449.18906-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some additional copy_to_user() checks for sparse, I
noticed that sparse's current copy_to_user() checks are not triggered. This
is because copy_to_user() is declared as __always_inline, and sparse
specifically looks for a call instruction to copy_to_user() when it tries
to apply the checks.

A quick fix is to explicitly not inline when __CHECKER__ is defined, so
that sparse will be able to analyze all the copy_{to,from}_user calls.
There may be some refactoring in sparse that we can do to fix this,
although it's not immediately obvious to me how, hence the RFC-ness of this
patch.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 include/linux/uaccess.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..f20a2d173e1f 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -140,7 +140,13 @@ extern unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 #endif
 
-static __always_inline unsigned long __must_check
+#ifdef __CHECKER__
+#define uaccess_inline __attribute__((__noinline__))
+#else
+#define uaccess_inline __always_inline
+#endif
+
+static uaccess_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (likely(check_copy_size(to, n, false)))
@@ -148,7 +154,7 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 	return n;
 }
 
-static __always_inline unsigned long __must_check
+static uaccess_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (likely(check_copy_size(from, n, true)))
-- 
2.19.1

