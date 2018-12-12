Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA1F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajlcF2ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA1F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeLLITm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:19:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36183 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:19:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so8254103plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yyfJFfTmgFxnz1jy34qHKpCpkDKEu+Kg4fc3GoUK//I=;
        b=ajlcF2ns5Dy783TXLqBOopdYf70FP0Z8VtlJ70asxMcKyti8lTVPH6lndSRtIMQ3Dy
         WQQZ8WSVO/+vYkFMHR2iASBPAHnZgO9YYcCwb0vz0K/d7YWDsjhJ5HdTp294bBw+wrf1
         BSsmLFuZCd+oOUH++3Ss7cLAY6Ry2XJHzrVxZxt54qsiMjmeXurkQ0+a0X6cyfCBy5FY
         kfZqFQ4iTuc63oNlsSHWVQJHtAR7XUoKarw5wStC0xFHVKLWwWEmVCig7HFcvGLOqlDb
         jlJny9Ttg98790nDmUywX396KL2L97ZgezdULSMJKvfq0WPB4EKfKo9OTyaKFi9Negki
         HmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yyfJFfTmgFxnz1jy34qHKpCpkDKEu+Kg4fc3GoUK//I=;
        b=A+cSm7l2oCX+gmSMogSGL95JLQGvbpAgfSUut8q88x+oriGKqDL4/6UzWOCAfu4zuN
         pFpWJzRklhzk2Ir/fpQGJ6gqJoZcNeNUIrMacKvH4tDfGzZqOZ9gI6cY12LrtskXqDG/
         2UDvdslU7XdjRwsi+zv37pykJDKimsBZc041XY3cKm9cB2Gcvo4WQPWcOOBa68N1pfYV
         4alcxjeVWFrUJEQoRiPz5DNGgtWapmzFfuh0ekg8f3fmAuQPC0gsdqOdQWnv8pvq0FLy
         AzwBW+yeFH70Ql6GMvrcqCNIIu46KVeI1EAYjbCYP2cWcP2F8F6W6oXVEV2zdgfkz8Sx
         MrBA==
X-Gm-Message-State: AA+aEWasqJ4Dt1nD+s1LCSkrdc1qnhW5slwObjsp+NICai9FsJoV0rlD
        NHBze53FWMTcJKbA9CMd9qXt1uVuyw==
X-Google-Smtp-Source: AFSGD/XfNB1mXLugutSLbatMX5KXf7xvdSaYNUGtRuj6x/Yilbd8zKDagDvEky7qNkmF2lJOke+/EQ==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr19366424pld.18.1544602780977;
        Wed, 12 Dec 2018 00:19:40 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t12sm25721039pfi.45.2018.12.12.00.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 00:19:40 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org
Subject: [PATCH] x86/kdump: directly find a candidate region when crashkernel=X
Date:   Wed, 12 Dec 2018 16:19:16 +0800
Message-Id: <1544602756-17449-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I encounter a case where crashkernel=384M, and kaslr is enabled. During the
test, sometimes, the system may fail to reserve region for crash kernel,
although there is much free space above 896MB. It is caused by the
truncation of the candidate region by kaslr kernel. It raises confusion to
the end user that sometimes crashkernel=X works while sometimes fails.
Since on x86, kaslr is a default option, and this corner case is
unavoidable.
This patch simplifies the method suggested in the mail [1]. It just goes
bottom-up to find a candidate region for crashkernel.
There is one trivial thing about the compatibility with old kexec-tools:
if the reserved region is above 896M, then old tool will fail to load
bzImage. But without this patch, the old tool also fail since there is no
memory below 896M can be reserved for crashkernel.

[1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

---
 arch/x86/kernel/setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..60f12c4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
 
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(true);
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(false);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4

