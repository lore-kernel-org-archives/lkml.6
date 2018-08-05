Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9705AC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AED021899
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kripp.ch header.i=@kripp.ch header.b="B243vehT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AED021899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kripp.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeHETZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 15:25:54 -0400
Received: from sw.superlogical.ch ([37.221.197.145]:58778 "EHLO
        sw.superlogical.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeHETZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 15:25:54 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2018 15:25:52 EDT
Received: from localhost (unknown [194.230.159.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@kripp.ch)
        by sw.superlogical.ch (Postfix) with ESMTPSA id 3F623C4192;
        Sun,  5 Aug 2018 19:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kripp.ch; s=default;
        t=1533489166; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=jiKuuTWUjRXpaHAE2SMw/YthLo9+/uDZ5y9BtrcKu2M=;
        b=B243vehTDoN7Y31gBg2mGLb/y3QK7jh8dOmlOrReg8MlCOaiy5kSAtb4IUyNAup6osElrp
        9AdOhHVI18Z/uB6MkC8criL5JgTVJHmuDMfiNXSm4WBzn+Xs9f5qVoyM8LPUXHP3SA0+y5
        JEt9xr1ITUa5dX6ymbnQ7H5Z334gaVfOdoIdJG358trtcWrF0T79CmLi6tEUmdzsFSIfsU
        nl8D1eRO/r3DgqLCsP6tT55GCNqpks6Dg+/DJGaiIw9qewd0D3qBPAHHIYKVFr4tUhH3mP
        n7sQgak7jtQAW3P+1za7fxLppcL+6f1KSpwdYgFsso3pB5hTW04GnDCq/J3ycQ==
From:   Frank Werner-Krippendorf <mail@kripp.ch>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, Frank Werner-Krippendorf <mail@kripp.ch>
Subject: [PATCH] Staging: rtl8712: rtl871x: removed unused code, to fix a coding style issue
Date:   Sun,  5 Aug 2018 19:12:32 +0200
Message-Id: <1533489152-19472-1-git-send-email-mail@kripp.ch>
X-Mailer: git-send-email 2.7.4
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=kripp.ch;
        s=default; t=1533489166;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=jiKuuTWUjRXpaHAE2SMw/YthLo9+/uDZ5y9BtrcKu2M=;
        b=HmpjH1+Zrgg1BQs1WxK2qtgy/Fs1FOrSIlvxDU+aIJmO1Ui+MwPFN0RsX/1h8UnJ2EiWAP
        0DrAYzH4CTGU6nuDCEEdhnDtmNHkD5KtAgk8L56jScdijdYuzyAlvx0RnAyCYk39kmPFPL
        bhz8nsigcUb4fMMr79AWCzfwR184Rhw46jIdct4uaw1LM4+55kF0iYKSXnqYcpkPYfHqr0
        GkR5YYI7xz+0DjCpwaenRT8cQ01gaXppXypRAOQH6RyrqdEH/+bRzuPmoLQoUSDMRfOZq/
        oE0B9fXmAtn0OusCqERN18tYYI6G2aKwehymb4R6qhaPlLXk3uXkWyUs/z4qrw==
ARC-Seal: i=1; s=default; d=kripp.ch; t=1533489166; a=rsa-sha256; cv=none;
        b=WuugQOjW3vyyAEtetYZwozFFQc+MwPrj8lRb2EoQhPpLEURYr84f4YMQSH7xKOaHXcOtp4cQs7ZRgLc4mnCS3co2UcC6feYEzcMTujFj5asOR163LYYLm6U9BKFJtq7n9IguQMAGDdIyjPqt2cQmLG/j+yjmBFEQFT+QiEBJpQq3dhvCyg+KycHrb4EgYE+WV+8xqeGvsSdt2AQP3BrxH0U5m3t4BeWo4Qlu/MVRqOBKKdwm6XSDFWMTQxKUzjylaRVQ4aFt6YzI3WmZEOwMRBe4E9oGW3A6ZntdqU1O2RDHmgFDoaqtEe76EKTJqqa0p7XZAoKmwVfBhLjCapRCpg==
ARC-Authentication-Results: i=1; sw.superlogical.ch;
        auth=pass smtp.auth=mail@kripp.ch smtp.mailfrom=mail@kripp.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
---
 drivers/staging/rtl8712/rtl871x_event.h   | 10 +++++-----
 drivers/staging/rtl8712/rtl871x_io.h      |  2 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h | 10 +++++-----
 drivers/staging/rtl8712/rtl871x_xmit.h    | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 5171379..2e59e8e 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -90,13 +90,13 @@ struct event_node {
 	unsigned char *node;
 	unsigned char evt_code;
 	unsigned short evt_sz;
-	/*volatile*/ int *caller_ff_tail;
+	int *caller_ff_tail;
 	int	caller_ff_sz;
 };
 
 struct c2hevent_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	int	head;
+	int	tail;
 	struct	event_node	nodes[C2HEVENT_SZ];
 	unsigned char	seq;
 };
@@ -104,8 +104,8 @@ struct c2hevent_queue {
 #define NETWORK_QUEUE_SZ	4
 
 struct network_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	int	head;
+	int	tail;
 	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
 };
 
diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index dd054d7..61d9e41 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -113,7 +113,7 @@ struct	_io_ops {
 struct io_req {
 	struct list_head list;
 	u32	addr;
-	/*volatile*/ u32	val;
+	u32	val;
 	u32	command;
 	u32	status;
 	u8	*pbuf;
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index bd2c3a2..6451beb 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -89,14 +89,14 @@ struct reportpwrstate_parm {
 
 struct	pwrctrl_priv {
 	struct mutex mutex_lock;
-	/*volatile*/ u8 rpwm; /* requested power state for fw */
+	u8 rpwm; /* requested power state for fw */
 	/* fw current power state. updated when 1. read from HCPWM or
 	 * 2. driver lowers power level
 	 */
-	/*volatile*/ u8 cpwm;
-	/*volatile*/ u8 tog; /* toggling */
-	/*volatile*/ u8 cpwm_tog; /* toggling */
-	/*volatile*/ u8 tgt_rpwm; /* wanted power state */
+	u8 cpwm;
+	u8 tog; /* toggling */
+	u8 cpwm_tog; /* toggling */
+	u8 tgt_rpwm; /* wanted power state */
 	uint pwr_mode;
 	uint smart_ps;
 	uint alives;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 4092727..aac0e14 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -160,8 +160,8 @@ struct xmit_frame {
 	_pkt *pkt;
 	int frame_tag;
 	struct _adapter *padapter;
-	 u8 *buf_addr;
-	 struct xmit_buf *pxmitbuf;
+	u8 *buf_addr;
+	struct xmit_buf *pxmitbuf;
 	u8 *mem_addr;
 	u16 sz[8];
 	struct urb *pxmit_urb[8];
@@ -194,11 +194,11 @@ struct sta_xmit_priv {
 };
 
 struct	hw_txqueue {
-	/*volatile*/ sint	head;
-	/*volatile*/ sint	tail;
-	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
-	/*volatile*/ sint      free_cmdsz;
-	/*volatile*/ sint	 txsz[8];
+	sint	head;
+	sint	tail;
+	sint	free_sz;	/*in units of 64 bytes*/
+	sint    free_cmdsz;
+	sint	txsz[8];
 	uint	ff_hwaddr;
 	uint	cmd_hwaddr;
 	sint	ac_tag;
-- 
2.7.4

