Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E19DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B181420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV+gjjer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B181420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeILEHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:07:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53415 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeILEHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:07:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id b19-v6so323188wme.3;
        Tue, 11 Sep 2018 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8fwGaHnLUvqwblyCA/rvVEOLAj2qcRNPvRCo/SxbrRY=;
        b=iV+gjjerzBtf3AdlxXVKpL9nAMllKzO67dgVtOgqLug5g7lA9SSMtKvVegpCIF+q4L
         yLi1K59E2PRV/wr1/LpZMAbvzG9Ulwb7/0pXWtSulmnFXbW/8bmTjG8GqqtsPFUraHRo
         QKCHKhRTI6BraRCDGlOMaiXyDIx+EPVh2pvT/DTfRALPwb1ykUTjWbHk2wkfQtxKNLPV
         p4ql2kJ54GPE3N5cif4JdLkkbkucOYTHBi+PRn3hU1h4UNF8uO7StV2pq5v3B9RsZ8cc
         4/rK03r8UYeFD3b/IzvnDR4xFbAtTaJbSUCGXOZH8/vki75hO0TxWhs40y6vL/TRBShQ
         awDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8fwGaHnLUvqwblyCA/rvVEOLAj2qcRNPvRCo/SxbrRY=;
        b=rq9/11PG0bpKrDpiABVL788xSSXBTaPZbvr02KTV5dr/Of1nQJK+4HxGDB4I06eqUz
         qk9QDSUgSvgYYp+G8yHjv1Xhb5/M/VG709iHUtNeixJXVntnC1KLPtRM3sMTWZIsnaYG
         41T7cAGSC/IYHFNMrkH16tPZI94JiNfl7eW9x2X6I9/aBG58EeyUodDSkruhkTOrEtmc
         qPZNWNP2w7yd4yts+ecp69pFhr6awzoJzaw8iXuKcj+f+JAivUTgrST9in1KQzKpkkul
         zGGc3CCgzir2k4EqgF/rIG/3olZMDraV/Co2kgrgBo4F8Kqzh9R2OsxNAxI7tcMA/0Wf
         9uNw==
X-Gm-Message-State: APzg51DaY62TW3+jtsPPq8jnBi2eGT+fRZEXP2NfkzfCmfzsE5jpgYqJ
        JgNyuMhdcznwvNv5NZ+0X+I=
X-Google-Smtp-Source: ANB0VdZdIUNyJ15I7JSx17yb/OllhrEwCUvUehmx/1jPLAh6dhi5AcZepSZ0UWHpR69wkDsw5PDeuw==
X-Received: by 2002:a1c:14c3:: with SMTP id 186-v6mr2637762wmu.21.1536707161122;
        Tue, 11 Sep 2018 16:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1158254wmf.34.2018.09.11.16.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:06:00 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dmaengine: xilinx_dma: Fix __aligned attribute on zynqmp_dma_desc_ll
Date:   Tue, 11 Sep 2018 16:05:33 -0700
Message-Id: <20180911230533.31873-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
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

Place __aligned before the semicolon.

Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index c74a88b65039..dc19d67cb8c1 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
 	u32 ctrl;
 	u64 nxtdscraddr;
 	u64 rsvd;
-}; __aligned(64)
+} __aligned(64);
 
 /**
  * struct zynqmp_dma_desc_sw - Per Transaction structure
-- 
2.18.0

