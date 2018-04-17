Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442876-1523926950-2-17786761476578730049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523926950; b=wbFlUKi1RTqpPDZchrGwih3SSIN99qRJKurgN8C74YWlT6eOrc
    0vKrXOwa1lTewCixAw09cwhvr3jJZkCa1QeCLtOcYPxZ0NPgS2hRTcEL2L9Ozz+U
    fhD1Zk7p1uJv1HF6TO2W+pl8tnafMmZJ9vc3WPTvaXbS54+7KX1WqSCE3GT/7hdQ
    /hBhRLGPEMpN7nZXb/qWEvPfzQJwXGlDZAHFMWxEyTJnsgjRwOVftA8HQXHCIsq8
    Bz2yysqX+SM0fSW/Ee8A/HFEa+ASSdzJoDkCPUJoKJs1RrsJWe+xSK4MMcjd7j7T
    bOpd+OdkgvdA5GPOHOkKQyO+RPgm9+5Sl6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523926950; bh=FCZkHpu3WqLGQ/T7XqDK32XSzBAG/6ujPg7NRcNGbCs=; b=d
    Mhb+N1uNy3FLYpe1sqSlgB7HMXFym/t2peyL1McOR3J25PM2amjHolOZzOgYmJNc
    jMK7jNwEttqO/IMoUApO02M7XhD/2KDk5zdCOQGRYaFQUovUJX4GWauIt5ETDgoM
    7kLE6z/5FTwBZ+dlXBLf+tyJpV3Nk0InPdo+l7D6Vt1UM5LgECsVW3v3I1I+AEdL
    8CbtNuJitldyKa7r6OvELXoamAWr8k4QONg02WtOYrvJIaXyeB25EcsHK9uFF06o
    kBYHUMo1sPdI7B6/7vF3+3uYcN9W9zklX9R1MfA26QtRhsTV/bKWmBynJi5mIggE
    BXDy+tmHwCJrMS+pJtCvQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNqNOEw6kX11OcztJmeOMxfDWGCkAzEjb5iZOcTfg3W94WYkmMm3XSpD01i5A1fS82CIsXT+Nm7Z3tB7lqQETaJJ0TsuH3Nox1xdo/KDIecXEQXJb1DF
    SV4bFPV9oxaem0byAYFYQh0QbegGXCB4B4zg2kF9ZRaYceZSNuQ2V8nLevgmhNzAQL1WLxZY6qYl8HPSwbZangl+mEwBAx1OgqAd7cV72BDeiObFAiP0nvM5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=6EaPpsYq5KF8U0OsA6kA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDQBC1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 21:02:27 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:60352
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751200AbeDQBCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 21:02:24 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 4/6] cifs: smbd: Don't use RDMA read/write when signing is used
Date: Mon, 16 Apr 2018 17:49:16 -0700
Message-Id: <20180417004918.29213-4-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417004918.29213-1-longli@linuxonhyperv.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfP2OI0AoAdJsMAc1pVxCSeqHBNtyNLCWakS9HrDwnOdcNRsPDO4OV/6sGtDs+sbeFPwOf2+bInjGlGQa78vwyI8OMKFtx4CCgbrm1OCnFJR1OHO3bnw1
 YFWM19a7iZQPn495bvP96yuF5UaZs9QUkMQsEs1Ps6nBgWuHqFEMlphey/ytdnlyY0Vep0NgLeBRtHPLlaqw0O6c8mcedaR+PANZjDMvuIbj2lprRJYVN8ZA
 a/r56EOrglWiXpseNDTKLlnPPyleWd7iCV3TpBW29bzb5xPh6vJwENBGvN5Cax2Xfqw9hphcVbaQ2w+k04ECnjSTTXxWXc3rcT1ucmx/Av8gy2/KvK/W8xys
 8TVPLOwrfg2BCrez5MbajwV1EThBZnJbEKI0EdeBKicveBOb+xuMoexb7CBXo/RzVXk/EfxqFtNjThs032gg3tDh0Mv7wz0DW3cw5QX1BO5DDvcWOs8=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

SMB server will not sign data transferred through RDMA read/write. When
signing is used, it's a good idea to have all the data signed.

In this case, use RDMA send/recv for all data transfers. This will degrade
performance as this is not generally configured in RDMA environemnt. So
warn the user on signing and RDMA send/recv.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifssmb.c |  3 +++
 fs/cifs/smb2ops.c | 18 ++++++++++++++----
 fs/cifs/smb2pdu.c |  4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 6d3e40d..1529a08 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -455,6 +455,9 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
 		server->sign = true;
 	}
 
+	if (cifs_rdma_enabled(server) && server->sign)
+		cifs_dbg(VFS, "Signing is enabled, and RDMA read/write will be disabled");
+
 	return 0;
 }
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 38ebf3f..b76b858 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -252,9 +252,14 @@ smb2_negotiate_wsize(struct cifs_tcon *tcon, struct smb_vol *volume_info)
 	wsize = volume_info->wsize ? volume_info->wsize : CIFS_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma)
-		wsize = min_t(unsigned int,
+	if (server->rdma) {
+		if (server->sign)
+			wsize = min_t(unsigned int,
+				wsize, server->smbd_conn->max_fragmented_send_size);
+		else
+			wsize = min_t(unsigned int,
 				wsize, server->smbd_conn->max_readwrite_size);
+	}
 #endif
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		wsize = min_t(unsigned int, wsize, SMB2_MAX_BUFFER_SIZE);
@@ -272,9 +277,14 @@ smb2_negotiate_rsize(struct cifs_tcon *tcon, struct smb_vol *volume_info)
 	rsize = volume_info->rsize ? volume_info->rsize : CIFS_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma)
-		rsize = min_t(unsigned int,
+	if (server->rdma) {
+		if (server->sign)
+			rsize = min_t(unsigned int,
+				rsize, server->smbd_conn->max_fragmented_recv_size);
+		else
+			rsize = min_t(unsigned int,
 				rsize, server->smbd_conn->max_readwrite_size);
+	}
 #endif
 
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index abbefe2..6759035 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2596,7 +2596,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	 * If we want to do a RDMA write, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of read request
 	 */
-	if (server->rdma && rdata &&
+	if (server->rdma && rdata && !server->sign &&
 		rdata->bytes >= server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
@@ -2974,7 +2974,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of write request
 	 */
-	if (server->rdma && wdata->bytes >=
+	if (server->rdma && !server->sign && wdata->bytes >=
 		server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
-- 
2.7.4
