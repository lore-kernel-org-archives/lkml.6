Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E697C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C868920839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgnp+k9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C868920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeHaCju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so8535707lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBLbHzQVwA/9WhhEWQS0yLrSgbZh/KoWN9BTyPASLEo=;
        b=Qgnp+k9q/TkGUCGTOMZaUFIeFQpPWAVA6pgHyfl8dcdF4eLhtAiO/+0vHP1RuxChXP
         vjbd8oUGieul6ioXdBxcVJK4NGfWemm0UEKqBrGmZrWPjke/Knsjx4+qDV1t9n8TFCLp
         qDdIS3g6tZ0k7YvgDIWf2pCh8DLnydpASxONLkGZyIyvyNr72qRSA7O4DBbO4Nfjdwe5
         32PNbPvM1PO+sVaWeMDywdZ5cw7A5EvGJ55mb09CmXiRRdi4Q8rib1hnDTk/5EtYXFnM
         OmhsvXnoImaXag/+IZ7dqWdYqSFEou8Th4D+25NCjyNSlyZLNxPYUasM+zwgf/OS1rjD
         O47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBLbHzQVwA/9WhhEWQS0yLrSgbZh/KoWN9BTyPASLEo=;
        b=kova7dX2/NF9LIqLFS9SZ3M3+ChgjPHo41EuQS4jmMnAdbwmHkTiIUhgmlalVdprgx
         D9Xte8ztN9G3ZC0kdpZ+PLwgtJ4P3ZySQkp3FvcTWGk8MBCod6xqA/A5G35+Yy0lF/+s
         B/eJGHK6dJw2yOird0KLyPpwDMuzGSyt6g7sn/QYq3H6j/fjtFKfsGfz7a6gAF96gu5E
         wQDeaf4y848yUXbacBrQ/PIj27eqwc1Ez6qxzH22nMIncuvChBg/agQ59LCiY/5bgzel
         dfKwNL9rthbhuDCbXigQxpxSwH1jOjuRQ8vLwlZKSp3Zq9++1/KBq9DYGu3mJAdCLWn0
         HGhg==
X-Gm-Message-State: APzg51DVy4bf/ku3csn4Q4oEJOTT5lEVVUtx3673JkR39gqzg4TdDJKA
        TkyuAwyPJx02kYiok2Opscsue6zLupk=
X-Google-Smtp-Source: ANB0VdbgXgVL1G8l11VqB5Ra186ctYo1LYDGj7JZkdE2hnbPBl3C7k2a68saXhOTgIOKOoPqSi742Q==
X-Received: by 2002:a2e:88d0:: with SMTP id a16-v6mr8186095ljk.63.1535668523588;
        Thu, 30 Aug 2018 15:35:23 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:23 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 04/23] mips: bug: add unlikely() to BUG_ON()
Date:   Fri, 31 Aug 2018 01:34:10 +0300
Message-Id: <20180830223429.30051-5-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hint to the compiler that probably it won't be necessary to BUG()

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/mips/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 745dc160a069..02101b54aec2 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -31,7 +31,7 @@ static inline void  __BUG_ON(unsigned long condition)
 			     : : "r" (condition), "i" (BRK_BUG));
 }
 
-#define BUG_ON(C) __BUG_ON((unsigned long)(C))
+#define BUG_ON(C) __BUG_ON(unlikely((unsigned long)(C)))
 
 #define HAVE_ARCH_BUG_ON
 
-- 
2.17.1

