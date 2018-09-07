Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973BB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4GflOKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973BB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIGWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:45:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39447 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:45:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id v77-v6so12730093lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WCP4JlpgixlAuxMIVAef6ZdT4lFJWxoSXx8pBBtb2rM=;
        b=Z4GflOKKNMs7VJxVvWIU6K6uJDOsOHnd9GcUaYG2XKUgy/xoeGfnh70mJx2JBxTgIu
         9pi/vouHMb/hjpIX05uyMWBSi9H/1iXNRyZ3AfOiTq3rKn86m4GgJ9TqJbNkFn6M3I9e
         1gX44vSm//ywLN2lnHdrll5kUGjzS7EWXTCYbTt4elB+BULUf3HdO2quQD+TSWIdcSrh
         IRAogt++pExEYnNzi2ZlJ1Y2nGsbHSg6Jqj3TQnmT+TrRjPQ4+O/x2h9sUegPGkErAcv
         LePWZKCVPZDQonUN1dEugXImd97kk6Ne/1DViOt0LyOUahpjdhrOTrWlV3pW7jJ0auCb
         FF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WCP4JlpgixlAuxMIVAef6ZdT4lFJWxoSXx8pBBtb2rM=;
        b=eezcWnYnHJI49lJYeNoX7aDvqdq8LgShYAsCwv2Y+p8bmD7wRk/a2gmcX0pMrpbOM4
         lNEeP7tRSmQq3uv9vvIzjVpUwwt3NY/DZINp44QNX2fChtBgGIPsvZDL0FYZdO49Iemw
         ocptqwWscD2dtdqTWst/ANSS2kPLZ05pmHJPJ2/ZU2cLvS9CHfm7eDfJCz+bY1hmrZnM
         hOQSttdt7nokQXw52mD3dfPbMYNMs5QhBxILDesjGOeChkB2rKjSLIr7mdW01+sHYe21
         YjWrNs3fNrySEG1s+f4XWSwxHmyPTJAdNm/ryvkj8VjCGRTKfj2Z1rbH2tXl7wyny7pS
         JGRg==
X-Gm-Message-State: APzg51CgSemq1/iNGB4MdZYy8zUc9nVFbnjpakLMsxkdi5qgwHhM8hkE
        EViZ7MVtV2cErJ6Qu3ytAlw=
X-Google-Smtp-Source: ANB0Vdb+2GsqHadK7Zx0YmNcgarp6mG8SesB+TRqeORhHBIMx6tROtpYzqpNNpxI+JTzNHYvneinEQ==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr5666369lfg.120.1536343392744;
        Fri, 07 Sep 2018 11:03:12 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1362962ljd.70.2018.09.07.11.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:03:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: bug: add unlikely() to BUG_ON()
Date:   Fri,  7 Sep 2018 21:03:02 +0300
Message-Id: <20180907180302.656-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
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

