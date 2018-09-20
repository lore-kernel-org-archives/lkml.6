Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D66ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD62214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHscSlwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD62214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeIUCXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:23:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42933 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbeIUCXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:23:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so10706415wrr.9;
        Thu, 20 Sep 2018 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EShoCh1yTUmYs7mxqRccTbFulMeLRLTe0aAIS7Qm+a4=;
        b=FHscSlwEGQsHolF+ZBgRgVXEPT4K23Lfq5PB8jajt4w+nSnLB2G6hyTZ/8Xoq3bCMv
         FlU8v9gtvWV1HHfbv5SEBJdDfyIbfZp8qUec+eoFv7QHVJy1+gOlNSTcOaQWjGTOadTG
         pqjI8nw5DD0rzYUg4D0iLWR1elxCkwVHb/tE2dpbncr/yhSnPpp6UeqY5pqYunumfddW
         d3Ch56urpJr2kBZvoW7HvDGkns+xJm0cDBg1TlGI1QGdpSpD2juHVxOZDIbuYFWELBkw
         CU+fd/6Z3kWgW4lr8hS6TzmxIbUCgoFR8BTBHF8YgmsC0P8fIYKxHhEZeeblQVyQuPB3
         bx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EShoCh1yTUmYs7mxqRccTbFulMeLRLTe0aAIS7Qm+a4=;
        b=RoV/9LV8WOOIrPKZ5xaY9n9mt3//kmd4bm0w1/Zr3BwWrE6alm8KAE9kQtX1jpOuV2
         Q6LxR31/TXWnwMX+EsqjOV6nborLm4ExYRsTFuWNFRTtqGD8KOZ5LyhOxK+XOE5Bcghx
         hXdVvWPwaYl2CoGLBoDfmcMSvXYMqGV6ruBbQJxTf/YzLcLtX7JA2A4hq/wojvrdPd8G
         kc5Oicjm8pAxmUAGUZdjd001J6tYFdoszdQUx/AlAZptG8Wuj4Zf8pMCgUiVTvqhsN5z
         BcR9uJLOtQZ9vJ00bRCyWFLfydpWYORNj+SQ43oigC+JYffIgVYne4yk6gfrVTFc58oK
         7vlA==
X-Gm-Message-State: ABuFfoiQ5EUtw+S7Qqmrq7UZKTjpBc7DFUQEVWCUDvchNFCSjPwJIJMN
        mLGpnVS9EtJCTjHb6yMdOY/Miez4o0ubFQ==
X-Google-Smtp-Source: ACcGV61QXdwf8NO93ttCKd0G5bpnM2re9MuAKn2yOb67TFOSEPX/zuLZumFNYrMauraOyAkpEnClKg==
X-Received: by 2002:a5d:4a10:: with SMTP id m16-v6mr3386547wrq.278.1537475863317;
        Thu, 20 Sep 2018 13:37:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r140-v6sm2637665wmd.7.2018.09.20.13.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:37:42 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jon Mason <jdmason@kudzu.us>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: neterion: vxge: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 13:37:33 -0700
Message-Id: <20180920203733.32019-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/net/ethernet/neterion/vxge/vxge-traffic.c:2265:31: warning:
equality comparison with extraneous parentheses [-Wparentheses-equality]
        if ((hldev->config.intr_mode ==
VXGE_HW_INTR_MODE_MSIX_ONE_SHOT))
             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/neterion/vxge/vxge-traffic.c:2265:31: note: remove
extraneous parentheses around the comparison to silence this warning
        if ((hldev->config.intr_mode ==
VXGE_HW_INTR_MODE_MSIX_ONE_SHOT))
            ~                        ^                                 ~
drivers/net/ethernet/neterion/vxge/vxge-traffic.c:2265:31: note: use '='
to turn this equality comparison into an assignment
        if ((hldev->config.intr_mode ==
VXGE_HW_INTR_MODE_MSIX_ONE_SHOT))
                                     ^~
                                     =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/124
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
index 30e5cdc52eb6..f7a0d1d5885e 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
@@ -2262,7 +2262,7 @@ void vxge_hw_vpath_msix_clear(struct __vxge_hw_vpath_handle *vp, int msix_id)
 {
 	struct __vxge_hw_device *hldev = vp->vpath->hldev;
 
-	if ((hldev->config.intr_mode == VXGE_HW_INTR_MODE_MSIX_ONE_SHOT))
+	if (hldev->config.intr_mode == VXGE_HW_INTR_MODE_MSIX_ONE_SHOT)
 		__vxge_hw_pio_mem_write32_upper(
 			(u32) vxge_bVALn(vxge_mBIT((msix_id >> 2)), 0, 32),
 			&hldev->common_reg->clr_msix_one_shot_vec[msix_id % 4]);
-- 
2.19.0

