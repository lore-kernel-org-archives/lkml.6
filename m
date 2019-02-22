Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D43C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF62070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mN2rwWcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBVMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:53:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfBVMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so2265574wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cci7ZilHiWLbA64Mc6AMOu/bLCyx/LwY/bSfReud1WI=;
        b=mN2rwWcXbmXv4T54C8g+dQZceONkqeqfDnfFBkdS/1z2f+11756LZtilFVL9vmN8Ub
         asXmJYdmjDVQkCK9dtCydjOWxr+KWTUU0EEaMipiA+1WfFsqs10CUXUyp5B+yuljcBc1
         0C0tywzNl+KEsDi5E1V9a1Ws2dGSyCYbuw6oXbdAfIH3UZ7l6SUpfEF4GcTbMbPCNeeB
         Ot4+ZahceUY35FVe2YDPYC6Ax0ARG1yKOQgJNw51FBiolm56hh/XyUho+qccTDZViTri
         rRytDOGFcggeSEQD/tMlfRQXS2V8i4wpp47+jYCO3tkhuGYSljzEFFfYn0oW2evDAak3
         2ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cci7ZilHiWLbA64Mc6AMOu/bLCyx/LwY/bSfReud1WI=;
        b=HXVoCaxsYGKmfHFpHWjwPiKPRgYr7juKAby6EINTepMx7R/f/k8DGQske1zx9kcPMN
         ObbaKGMy8Ov2ODhdw0rbGIp3mJS7W/FcF7LuwNa09bXnyhKeFqauXNbfH/UGEREj6DvM
         fzqeZg0ZnLzosDghmuxhPCZT7POfAlD3noMR4MxzRv2pZMqDJlzV2IoklcN58OpXrUd6
         2CBYn0btGJ8l+J3gnmCWEargrIAYVTzOeL9PrVjbQuyHlEQB11ET2Ji0h4BXvSkZxFLc
         yzII4MBjHFBib2fYx+dukVFRv+aO7crywqh69TPVjoDrjR/UgSr8NBtuM0u/3qwIIFj6
         NeJA==
X-Gm-Message-State: AHQUAubjc37IkwTXzIhxsjw+n0HPkTygC90rGzqC5FdraPA5X8146lu7
        Tnf85abCo8znmIvHm3e9OVsVQQ==
X-Google-Smtp-Source: AHgI3IYNE5YTD6dA2Rm0c87bwvFj8qPgC6wZI8wCmOm2tGxzmyo49L1MzMubdg2VCbScaD+W4rhlpw==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr2869999wrp.148.1550840011806;
        Fri, 22 Feb 2019 04:53:31 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:30 -0800 (PST)
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 01/12] uaccess: add untagged_addr definition for other arches
Date:   Fri, 22 Feb 2019 13:53:13 +0100
Message-Id: <2b5a5d7d7a36a75a2a796f0c2b9b30669d81d470.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index a6ddefc60517..fc383bc39ab8 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -21,6 +21,10 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
 struct memory_block {
-- 
2.21.0.rc0.258.g878e2cd30e-goog

