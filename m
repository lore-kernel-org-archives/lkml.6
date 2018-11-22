Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm1uolxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2E720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437060AbeKWAcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37280 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405602AbeKWAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so9170813wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QZANr9kBlX/znyFbCnlYFHsCDpT6DJXSmJ4rkSx1cs=;
        b=Tm1uolxspgRfh+hhRtyxzfkKRzrdOjgZska2G9YzE+cdr3eWJRQLCr2hl051zE7tEL
         nhpk2ASopX5FCuoIW7PGcp7lniGigCnt0wJKuO2cKlaXzw2F6E08IsVMn9XyNlHOZRPD
         huWmyFkLaqXkqoEKhoD2QeYa+hvhM5syIG2DUII23LUwFXVa1DEJWso6ggvKZb6EhD67
         1N4VYJarbGzrbWnyMPRhWCGLCb2PYBBK8AQBFxsmG0DhEaA5ZlG2oosw5PLFsLb/NxDV
         wfiA6F3pDO6Hi27i20nao2Nz1uQhN0x7DR8IxHPU1haeI+r2qcPQGDE1qqjZQUWWinTV
         kW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QZANr9kBlX/znyFbCnlYFHsCDpT6DJXSmJ4rkSx1cs=;
        b=YiTvXYa8dUSsZQ8BSyHNL6Pq/MELqq/L76cJanQ44KwJivSxF0KKiptvvl3TXHW5+p
         EZUOoY3gwmftJixqsajlZfKDKXTQvNPIWgIAeHmdqls2TFhW+sJVu6FJoaMAWY5uaTaS
         085HcK6SoaFXWu3f0tkNdAvzkhqMN+g/dVlnMARbQhwmXsJxDZjlYydCEJ4jK2UtQoAh
         KF9M6LtBOiZSrBvAZ8JfZj86AINFn1F3TOZosXwVc+re6vF0M9E4+FXCNq0pfV570LFd
         U7GJD6rV1IRCkTRHKDg8dBlYaevN8PSEGFxfiTQwXixlg1ZOmOR6Hj+/x8irwTx3ge+t
         lOcg==
X-Gm-Message-State: AGRZ1gIlsfCoEYVbhNCDKY8Jc4XtZ1yyzPEnap5xNpKB+5Hh8P8Ynbp+
        3WEWQ5cHm5d0SQzJxE+d6d/0ZEcq
X-Google-Smtp-Source: AFSGD/X/bwQMSITL4wOQyKpbCbCMtw6yQtaBwzT64SSO/XywHwwHcwqZBisJFxF1KN3s7NPgRfYJ2A==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr10225243wms.70.1542894753316;
        Thu, 22 Nov 2018 05:52:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: cleanup line ending with a '('
Date:   Thu, 22 Nov 2018 14:52:12 +0100
Message-Id: <20181122135218.1703-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup line ending with a '(' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index f8d2b141a6c6..d792301a5ac2 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -155,13 +155,11 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			handle_txrpt_ccx_88e(adapt, precvframe->pkt->data);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 		} else if (pattrib->pkt_rpt_type == TX_REPORT2) {
-			ODM_RA_TxRPT2Handle_8188E(
-						&haldata->odmpriv,
-						precvframe->pkt->data,
-						pattrib->pkt_len,
-						pattrib->MacIDValidEntry[0],
-						pattrib->MacIDValidEntry[1]
-						);
+			ODM_RA_TxRPT2Handle_8188E(&haldata->odmpriv,
+						  precvframe->pkt->data,
+						  pattrib->pkt_len,
+						  pattrib->MacIDValidEntry[0],
+						  pattrib->MacIDValidEntry[1]);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 		} else if (pattrib->pkt_rpt_type == HIS_REPORT) {
 			interrupt_handler_8188eu(adapt, pattrib->pkt_len, precvframe->pkt->data);
-- 
2.19.1

