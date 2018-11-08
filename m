Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0252081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTQIa3cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0252081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKIAMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39858 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeKIAMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so21491165wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyHAJ7bm8yqliTwjL59/PERrC1/EJlU4Hst47qO5nm4=;
        b=hTQIa3cT8mQ6PRrw+ArPxNwUIt8G3xNjt0LPrCZ2+3MjH5B+tB03HhLfo9JtaDflG7
         1WS5ukgZJKhb3Ft+7oWDzcuhvWXYYqx0oGvId1rHas5NYbuZlzgh+jsCM0J8W0xqrJa0
         OhmkLb2QT3xrgFMUjfPkpf38HSHLQ5o2uSKcXbsGzJDAc1p3wW4syg78MncnKzkxdlQ2
         jTset9xpCPu5advaWYtuw31DIxNZhkWjXoUPz18Ntq6yzfcR8/4GKmf2sUarr6Qq88IJ
         IhHrM2tjOxLBZ3p5PAc6ad18rgsGMiuDoHvHKgFHyyMONd2xM9xj5Hbiv/hkt+t/CGAx
         Vh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyHAJ7bm8yqliTwjL59/PERrC1/EJlU4Hst47qO5nm4=;
        b=P4SEcwjCChIUJAFYCbMRC8uSfatgQm5Aiv3ZqfNfdcV8ozKD74jW8xqYrf1LBSOm/X
         00+CeE3WEsDa4tda60VM9lzpawLzBqBlWXPSveK0uKddFZDbnKArcqBTPYe1qfdVUswn
         knGoXOwtdSRhJY5TaAorH3l/vxDX6izGowddxr2Mv52DxxeEPf6edGk9win+fPKZlu95
         etJUnHkwCCEZVAEmWMjiJjLFcq0YUugmuOV3yCiCvQOfAzFGMtdkH7IzWdwbwWvLwSlu
         5Yvz1Gtkhp7+ChMte+IhgPrU3H+Vriyy51rhQuG/cT9mk3Oqn8+ey+DzZH1iWR1N3Wk/
         a1rg==
X-Gm-Message-State: AGRZ1gJdbnGP5tIXFLAh8/PQZGOstxD1/1N5l7hxzI6Oe/sJ1Cd95E8n
        wJQXmjgw3P6Ze61RGn3Zyd/Nqg==
X-Google-Smtp-Source: AJdET5d0FY6pZsoxQnT5NEn9m/O0HpttSzArfI8Y3zJIn/M/EFbpljwG8ooaFhLFbogzGGQcdQFN0w==
X-Received: by 2002:adf:c752:: with SMTP id b18-v6mr4088793wrh.197.1541687781406;
        Thu, 08 Nov 2018 06:36:21 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:20 -0800 (PST)
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
Subject: [PATCH v8 1/8] arm64: add type casts to untagged_addr macro
Date:   Thu,  8 Nov 2018 15:36:08 +0100
Message-Id: <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..c1325271e368 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.19.1.930.g4563a0d9d0-goog

