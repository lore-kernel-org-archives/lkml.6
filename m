Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E07C20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr5S3nf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfAOIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:24:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfAOIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:24:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so1888118wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cM0RJRm/3Q1fxBs4C2PRSEbNLX7Sv2EWMUG4z2/ORs=;
        b=rr5S3nf6jAg/YOA1ZIERTAevE4qAdbz4UzSvCnKl+jaS7Mtid6McBlWZcvqbmWn7Tr
         xFYMS8c6t+rc1uWuIP7G1PXDLfLaak6uAVvcl/0cWZgZjbYxtf804i9OKiar3uSAQ4JO
         D82ochwUugKl3KooNlYcNcpJNMaOqUryghhcVLOAo2EaeKBxwQC7c4uCOuSkh1Co/ayA
         FH0LPolP19TU8vbZ6HdxMbQi6J2hT/nIH95BRFXcTXGPp7Et+zbRCwXVPVGlSZxrzN6n
         6E9brtOUEIE5ddeEag0h1CvJdyw+hNn200gqfXnKFEMXvunmwwYQFnXNSJp0eLB+V3Wj
         LSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cM0RJRm/3Q1fxBs4C2PRSEbNLX7Sv2EWMUG4z2/ORs=;
        b=dxiIGqZQ2VSIcrtD7aDniOG35Tgx0r0c1XFH34OCiUgalRoxp5gt4bXpd19y3tmxa4
         uchTlATd9cDFMgcOMi2cR8FdSHtuzQNcRKI08kyhghW+lZXo4agQCSCDqgVZ5TQpnR9z
         q8q4iGtbYXvLuIinxjeeHVNc2oV3EAKoJnXF1eSgiMLYPeGa/qRA77CIdw2m712d4EGw
         YFaOhaubec0TpHgfb8TjLoouMXGdj1TxwrFAI3VGdsOndWa/FryYHbt87Ll/PJMGTOLE
         qZKpirpJqYsJi7MGXa/EfwyKd3wEG1sOacxlfhllHIGMDBe22fC5Po9gQqldv5jjgX8W
         GV6w==
X-Gm-Message-State: AJcUukd8vPt3+5coLIZgqjgrkG7zCilP1y/RjGe7CU6wk8qqzwXbnzEB
        NCisYwrLPV799GdvpghQ/Wo=
X-Google-Smtp-Source: ALg8bN570DRg4k7U3Un8Imj1Lgk/00tpfMti15TwwScORP2ecPDafDHH+5PxYl6hm4vIbbOZz6Zslg==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr1902586wrn.102.1547540654231;
        Tue, 15 Jan 2019 00:24:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id u10sm62556295wrr.33.2019.01.15.00.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:24:13 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: remove unnecessary parentheses in os_intfs.c
Date:   Tue, 15 Jan 2019 09:24:00 +0100
Message-Id: <20190115082402.8519-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index abcce2240f15..6681383579ee 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -198,8 +198,8 @@ static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
 static struct net_device_stats *rtw_net_get_stats(struct net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct recv_priv *precvpriv = &(padapter->recvpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	padapter->stats.tx_packets = pxmitpriv->tx_pkts;
 	padapter->stats.rx_packets = precvpriv->rx_pkts;
-- 
2.20.1

