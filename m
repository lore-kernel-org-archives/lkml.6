Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 12DD2C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+J5jN+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A993E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964850AbeFLDNO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:13:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45877 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeFLDNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:13:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so11303087pfo.12;
        Mon, 11 Jun 2018 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j3KA2NFX0AzJv2Vj1N5Oev49kaFWOvSBz4YnDDlEBiY=;
        b=Y+J5jN+Xjpx0+AYA+d3L0j7ah7cuExOci7QiYJQO0STNEIbhPFbkSOZRz73iF9M38d
         PiDn7QSdu3UPsfiwGyDBRaMCvFvkh0bmNPjzL69eZHUhBweoROel29hf84ZPjpDf2tek
         P+KCG+1jHZ/gEDXIti99p/eb56Lq2ogmgy3j6bH7tAPl9+4l9D08Tk7UoZvcd3eIyFVE
         akEczNjmXNyLZqgKLUxJ1GgGoJ9oM31vV3kcBhaIrWYtwFNILPB/UJoAbUdP8vd1zCVH
         oAQJOxEUaVAGVZ66hm3gxvUl9YH3UNSI5F8BH/f1DX85yQuHUORUpm4Caoyd7847yDc3
         43xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3KA2NFX0AzJv2Vj1N5Oev49kaFWOvSBz4YnDDlEBiY=;
        b=XOSnPCB6aK5yC+IkJnPthZv4rcEOQFrjQlaJPzzvZCLie7G+7ExJVbHtmv+hmu0JnW
         IrN1Hc8Jg/9XYzA1RLlb4HX6LAVWbgLHUe6IrKLZFLWF5yQxfHJ6IPjRj0uMCiMDG1jd
         X5vid7LsJeIUxv9AxI1UDdph+CLZkKR+xt7EyOaOF1QA/0s8blZYC4eDiu0igjt8j6yj
         UwNqp/fUj/Hu8UIaFuuApDWiPr49jik0S5z1Q5SMznSql8TFev5eEqULR1tvLrQdPUA7
         8W3MMziPM3roHcVnYYPo124QlREXN1usYI/Y3RdywvNdLevo0f27ZLIdOp1ESvtafR2O
         y9uQ==
X-Gm-Message-State: APt69E3OqyAEvcRLbF8Wgb90loFPKLECmf84/Y7o0/7nXKsepi0hD/1D
        cWbBKEZYKqmmHlUlwIE4vSg=
X-Google-Smtp-Source: ADUXVKLdtGHZaVZ+uyYJssyKeHwFDa15uOJLUZbj14YhtAn1nidJ/q2ER54rF7GP1Vl8UxSxeCRtfA==
X-Received: by 2002:a63:6dc5:: with SMTP id i188-v6mr1528759pgc.391.1528773191992;
        Mon, 11 Jun 2018 20:13:11 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z4-v6sm80642645pfm.28.2018.06.11.20.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:13:11 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2i: add error handling for ioremap_nocache
Date:   Tue, 12 Jun 2018 11:13:00 +0800
Message-Id: <1528773180-37120-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap_nocache fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index 8f03a86..e9e669a 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2727,6 +2727,8 @@ int bnx2i_map_ep_dbell_regs(struct bnx2i_endpoint *ep)
 					      BNX2X_DOORBELL_PCI_BAR);
 		reg_off = (1 << BNX2X_DB_SHIFT) * (cid_num & 0x1FFFF);
 		ep->qp.ctx_base = ioremap_nocache(reg_base + reg_off, 4);
+		if (!ep->qp.ctx_base)
+			return -ENOMEM;
 		goto arm_cq;
 	}
 
-- 
2.7.4

