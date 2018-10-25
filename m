Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B505C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F71820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHr1rJuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F71820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJZCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:40:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37331 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:40:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so10268590wrq.4;
        Thu, 25 Oct 2018 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBKz2T//G9OngGCPqFlxdVwY9Ric2yMKcHTmbAq8Sgg=;
        b=sHr1rJuPzRqJkiF1vqAPT+VUCzVJNGfyWJxzM5Dzy7Fsx+6/boAOx3AbcfyLSBM5+W
         Dk/IV/grPlz/aSKh6UvYaCJ72z3/zRhtX9c9shd0grFjcCWDFtiiVWQuH3dJHB2kLLPi
         lsQnwbxdypLr8QFWN6GHQ5lfmEDifuimoQF1zui58aQNGWnKDvverqk7ogJRJiOyr8en
         Lqr1viCkDQ+kiQJBFmgotqiWSIDyWNgT5HIB6+l7uD5OUCuPy3gt19HHr0YW02N/3+Pr
         jEuGGGt5NhmlgajoCcQGhrm15YMkVOf/AUjWNcVxcitnJKUwhXEjthZJlI9d/qJNW1N4
         R/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBKz2T//G9OngGCPqFlxdVwY9Ric2yMKcHTmbAq8Sgg=;
        b=GhRx7STgZAgxgqNJkniR8Vqaorce3l4gxQOAiJA6w507HJlt9Arq0FOznEz/vYMzUE
         UaDpYWBetT9egjjAI6h01sqm6o8kd2nXXVaecFiGacGDNt++BZORPEDluwSK73q6sQR3
         PSOEAsgWc7AebKJbrHg+NI4Yy4I/l/jl6UshcmaKTdQw894A35jbF1vblu+fsgG4d1tz
         5outuOJpYyBYOdbGKdgtRqo9gBJZEdm3tZtA/ta6WF85G7WqtHbWjMbkSgxUzZ5JRaHN
         SSEOlECnaElgGLtOs02mz4D0vF51vwzSKxu5I9rbJbVW/LC4ky6Qr9aWRvHkOAAcEOY8
         qh+A==
X-Gm-Message-State: AGRZ1gLwFap+0jFu4PNcLh45F1qOUvJDyt6xgl353k0e4uA0qUiRKFNN
        XgDE6JSZEKTZopn1VnUiIGQ=
X-Google-Smtp-Source: AJdET5dP2wRD54Y8gYRq0P762UrAEybiFTC2qP1aAlYWMoAmnWMb326VWJfrBxSxVx+xEjhedp5NbA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6-v6mr2962047wru.316.1540490773251;
        Thu, 25 Oct 2018 11:06:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j46-v6sm14732393wre.91.2018.10.25.11.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:06:12 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll
Date:   Thu, 25 Oct 2018 11:05:25 -0700
Message-Id: <20181025180525.28378-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
ignored, place it after "struct" to apply attribute to type declaration
[-Wignored-attributes]
}; __aligned(64)
   ^
./include/linux/compiler_types.h:200:38: note: expanded from macro
'__aligned'
#define __aligned(x)            __attribute__((aligned(x)))
                                               ^
1 warning generated.

As Nick pointed out in the previous version of this patch, the author
likely intended for this struct to be 8-byte (64-bit) aligned, not
64-byte, which is the default. Remove the hanging __aligned attribute.

Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index c74a88b65039..73de6a6179fc 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
 	u32 ctrl;
 	u64 nxtdscraddr;
 	u64 rsvd;
-}; __aligned(64)
+};
 
 /**
  * struct zynqmp_dma_desc_sw - Per Transaction structure
-- 
2.19.1

