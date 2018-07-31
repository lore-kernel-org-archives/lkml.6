Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B05C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9908B208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ohhil7C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9908B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeGaNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGaNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so16265210wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcgvjTVuCeScErIn/r5aAcT3ziY0BVvkd54GXvnjjuQ=;
        b=Ohhil7C2tX+raHz6usqAfHsGHlHfcezhXVWkZOXiPiI+6D+x4s/oD7ReAJVCrArCqx
         kverEzTFsMHxfcCTvUI8Pnz8ooo46gc+bnYfTF2QlHPi5kkH5LXx6o3nm7MhkShbx9Mx
         Iq9TIH+hrV4WSM87zUOg+U45oHmZbBHRNVh4CREqLYsRpG0ndcOpR3IBh8iANtvMGNDH
         Rf896gcZ0ELwtX/11LqJyGIpeGBNKXCQImajOHOc/lsy6A0K8RTIJB1RnXdOBX6sb4FU
         tDh67PLZI+fcg65ITzKDyaPCZ/Wn86uhjV9ITceKxckpL3HlFME1shRMo50VmSTGaBnW
         nluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcgvjTVuCeScErIn/r5aAcT3ziY0BVvkd54GXvnjjuQ=;
        b=T0Pp+n3a35xGpDXrEhqNzzHvipAnn02lLwoTJdDf0XmwldLeNYKQC88ZBNPKVQSel8
         P/7Jm8pHoD4qyGhhXv8a5CAUApF0nosLe8KFR7QOA+Ghw7TfLqvqL0MlR9SqBljdtfHS
         SgFjcKGQtdvCy9nVDOL0RY4Y5xKRPJv8Nlzb+Rh4RZFNQsO18Z3qGcGQ4t0r/+Lwffsb
         QugqXAt0LQcTkgP/0pQ5ZP2IC7RivZN4tnzMdaXWjrEc0OniATyO8zdI8ZBNTtf32o5a
         PkmSI8U8mQQpBc+ccAIRhVGjatqMj8DT9TmOhM9j4cWK8lZmaOlUfSY4XCzfubQU4Yua
         LekA==
X-Gm-Message-State: AOUpUlHhKg5hCM8F0LNvHj5CqupHgA9diKtUvetxvjWG6SyM7lvUkHpo
        2ln+BT95e9sop/aAWiGLZpY=
X-Google-Smtp-Source: AAOMgpfyMI5F3I0JbFTBa0uFfj+WNuVlPqd35DN4gjqhJ6c+A4cIjujni0cP3Jmwgejuxcje+NlH0A==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr21329321wrn.23.1533036870181;
        Tue, 31 Jul 2018 04:34:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: rtl8188eu: fix comparsions to NULL - style
Date:   Tue, 31 Jul 2018 13:34:11 +0200
Message-Id: <20180731113415.1500-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use x instead of x != NULL.
Use !x instead of x == NULL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c      |  2 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c      |  6 +++---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 10 +++++-----
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c    |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 9b810c76d6de..62294bdc465e 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -311,7 +311,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
 
-	if (old_padapter != NULL)
+	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv((void *)old_padapter);
 
 	if (!pnetdev)
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 69f04fa0a189..28cbd6b3d26c 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -325,7 +325,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	int status = _FAIL;
 
 	padapter = vzalloc(sizeof(*padapter));
-	if (padapter == NULL)
+	if (!padapter)
 		goto exit;
 	padapter->dvobj = dvobj;
 	dvobj->if1 = padapter;
@@ -334,14 +334,14 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	mutex_init(&padapter->hw_init_mutex);
 
 	pnetdev = rtw_init_netdev(padapter);
-	if (pnetdev == NULL)
+	if (!pnetdev)
 		goto free_adapter;
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 	padapter = rtw_netdev_priv(pnetdev);
 
 	if (padapter->registrypriv.monitor_enable) {
 		pmondev = rtl88eu_mon_init();
-		if (pmondev == NULL)
+		if (!pmondev)
 			netdev_warn(pnetdev, "Failed to initialize monitor interface");
 		padapter->pmondev = pmondev;
 	}
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index c69edb7d174c..a59eb017227f 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -58,7 +58,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
-		if (precvframe == NULL) {
+		if (!precvframe) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvbuf2recvframe: precvframe==NULL\n"));
 			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
 			goto _exit_recvbuf2recvframe;
@@ -436,16 +436,16 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 		return _FAIL;
 	}
 
-	if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+	if ((!precvbuf->reuse) || (!precvbuf->pskb)) {
 		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
-		if (precvbuf->pskb != NULL)
+		if (precvbuf->pskb)
 			precvbuf->reuse = true;
 	}
 
 	/* re-assign for linux based on skb */
-	if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+	if ((!precvbuf->reuse) || (!precvbuf->pskb)) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ);
-		if (precvbuf->pskb == NULL) {
+		if (!precvbuf->pskb) {
 			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
 			DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
 			return _FAIL;
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 85cde696d369..d8ef9b5d81a8 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -19,7 +19,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	int i;
 
 	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
-	if (pxmitbuf->pallocated_buf == NULL)
+	if (!pxmitbuf->pallocated_buf)
 		return _FAIL;
 
 	pxmitbuf->pbuf = PTR_ALIGN(pxmitbuf->pallocated_buf, XMITBUF_ALIGN_SZ);
-- 
2.18.0

