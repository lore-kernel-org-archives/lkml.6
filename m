Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AB3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5FB2150A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="eoG3YW1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5FB2150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeHOWrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:47:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40356 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeHOWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:47:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so932472pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwDV6mO7s1yCgZs7LsRX6sJli3p8jm6q+XlkWnTP1eA=;
        b=eoG3YW1I6gf7SZP9N8BV49J+iX+idOgpGbnA9AcoOlG2prb0iHrvOtWOFDkK5zsxBP
         bfnQZAM7y1sqHxzAV+yZd0KhSfmt4UOPrjTeVy+TzaZWObSCGJmAZQe2epCW4XwL5DCa
         vxUBgOtIHzHDLJ5Y0AeExsEeggTYxvVE1CYv3rE6TMC/nAV1+b73hySnaEghA1fQvizZ
         707JQSEj+ivWr8c2d38XkFB521A8cGn5iiYEuB9YNK2JpSsN1uthwDhLBae/czh4aq/S
         t3QJk+3yhhuthk9fw6pEF4b/xLuoFHwTBOglfdRylzt1pJIsVv31Oxt3kHNj9CGt0qJ6
         1lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwDV6mO7s1yCgZs7LsRX6sJli3p8jm6q+XlkWnTP1eA=;
        b=Z9E5saTNKbbH2ngGm+41zZMn0VZoIUkBKl/9EYoNkgKeRuCoZmB3npWX0LVoAyrbyi
         x2gy7JsY0pj4JIiK4ut/MBVN/vheAFRIDZtO0ly8+m0GXlXx3jAmveTY2c+H0vUd+aOR
         /DP9PP1VQ7B8ipsY9Hxk9XS5SDvRJQVbI2DuEvbW9r81jJbZUYWiR9PRxLspQBuLowpO
         hQY9a3UFlHidU7MInZ54KsYkTOzewM5yqgW0B9q142MTeJRVtFn69r/outfS1dvDYjc1
         ihIqcmpUg/OQi7gvLYKfmhupDROcfIy0N1lOjUf3wkA3jDKYGbScdmWJiwygbvPuBB7k
         ekpA==
X-Gm-Message-State: AOUpUlGjVUkmOUI55MMZrzlk6KKhpSO46sh4bA/Wxcrv9hWjnnJ/qX27
        9K+4cbVARIfeqB3JcaXJM5tVDQ==
X-Google-Smtp-Source: AA+uWPznxqNGjizY9bVg2IEDfgks2KNwo3tbDh8VwXFrfDUSXucWmyr3n364R9oE9N5pEOpls3S7Eg==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr29152690pfd.229.1534362814292;
        Wed, 15 Aug 2018 12:53:34 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id r23-v6sm72514617pfd.144.2018.08.15.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:53:33 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Greg Hackmann <ghackmann@google.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Date:   Wed, 15 Aug 2018 12:51:22 -0700
Message-Id: <20180815195123.187373-2-ghackmann@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815195123.187373-1-ghackmann@google.com>
References: <20180815195123.187373-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM's pfn_valid() has a similar shifting bug to the ARM64 bug fixed in
the previous patch.  This only affects non-LPAE kernels, since LPAE
kernels will promote to 64 bits inside __pfn_to_phys().

Fixes: 5e6f6aa1c243 ("memblock/arm: pfn_valid uses memblock_is_memory()")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 arch/arm/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..bee1f2e4ecf3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -196,7 +196,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_map_memory(__pfn_to_phys(pfn));
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.18.0.865.gffc8e1a3cd6-goog

