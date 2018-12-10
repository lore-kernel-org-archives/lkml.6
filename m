Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75A420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFDzySXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75A420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeLJMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32980 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeLJMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so6561660wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnNoEMrMgUcWWKorAen45ktTirJw06vWZl+y3HjnYKc=;
        b=ZFDzySXH+RcGKbu7apwOJhQV89JvZa+gIzkdi3lCpAr8rANmuaA696lcNSMihz5jsd
         Mgc8z5GDqlKqPiGIFUGFJV5LZ6mPD1yG7h/fXqDnZeBSJrvzsxOfDPf/WQ2TgUnbPF+K
         BulPEM7LRkLz/+A0NCyQ10FFjDpEaoS17rWmhBEhu1vWUWzxbXcbBgiYI+GWlU+bKJpF
         hbHErYklHv8F4KC/8y3KrbRg/WdRewnyb+I6zzpz2QW0JhyjVBllF1qeuzcMDR2q476/
         85vwRgG7I3nE+1b5PDbnOhjIJiH5ILXwm/PcvsVjUrvLOA0sv3kgXe81o9mc0j3Nhaf+
         o9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnNoEMrMgUcWWKorAen45ktTirJw06vWZl+y3HjnYKc=;
        b=VqNDiw+3PXWyQarpOQbocspJjPhW55gxbfMhHdUrX8/cmdROHs3sMj+s0T8vsOSa4f
         q5rQNogEmYWAS/lCixqW6s5DKNV8oF2NU5qSdUAFbeVqDSG47wlg6BwvpDbzTYD49iNh
         F825WkEhwMpkbUOOrZSWpmJCYwA7MKMkj1Oyht6vKRs8MMomJebNCm1lL+z/pv0BYsWD
         rJrIgiTf5e3YBqZ6MoAxKvC1JdKFBwUKEltqyp09X9W6eRoJd6VIFdiXcDOrjnR3K0wm
         3I8yne3L7ZhQZFMy8Z3zplKdgp7M9UznXG20SKDgvAS3crXjBb5+bJIzeGpM1sy4B7F9
         Z3PA==
X-Gm-Message-State: AA+aEWYI4cEbE1QRjYFUjtcep9zYX4VN4RrJx4Wr8WUtyMj6Hitu41HD
        HvKW+I9poJxUWWnoDJgOkpTzGA==
X-Google-Smtp-Source: AFSGD/XfpH+7b2MBHMbSzaZiRmsmRTBYGLOi6i4h/Gy2a0EmicqS+e3KfIv69EriIxjgI+TvTV5Ofg==
X-Received: by 2002:a1c:d08b:: with SMTP id h133mr10494086wmg.8.1544446272635;
        Mon, 10 Dec 2018 04:51:12 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:11 -0800 (PST)
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
Subject: [PATCH v9 2/8] uaccess: add untagged_addr definition for other arches
Date:   Mon, 10 Dec 2018 13:50:59 +0100
Message-Id: <35f97a89d5cc881f0f4052f43d56b3b7ed736581.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for other architectures besides arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..42b7a4ac65e2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.20.0.rc2.403.gdbc3b29805-goog

