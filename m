Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548850-1523992809-2-15743607838412708416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523992808; b=e/9E39YpwOZkq39u3VuYTMY3d6QVoudK+HKKFTQ44DsmswJ8/p
    uM+3E0Bjhz+2fKzvRXYua/f/QcqzMyYYOytvBaXdMGeKlLh4OHUGqL2DFi20Zgaa
    KktioDv99FGWkQ/xPispg2zL6UDMzSmC8edJceL0qnXpbNrcozcbVc9Sr+5Vb1Te
    voRPZgN6eC5lnFm/Qp4QQTsz57GyetAAMI5MbJN2G4zvnxPA2Fa5VR/mXYpoXKRU
    1jr0R/gtnQK1pw/pnbxQ93m2ZryaGfa6F3/dRSdK0AR6XVCYlwYchwu/QQtpla2u
    cOXL3godP7f4B6eBn+6Znu2lSXqOmS2PNQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523992808; bh=JbHCDR1Sw3WKD89WLOCCztpfeJdxP59eJp0SYZugH4M=; b=e
    6iwqvRYagqbf2p2Cb/AGYEJmjzGYnum4s3YnIUp1QwyxI4ITCl4xV9UsYBM+xMQo
    abmzmOibkLhKkSZ/Va8xYQW8mnagzz6TlEnKAxXGT6YgY76y95+tcsw0QDFkJTgw
    K0a1Gl+Rej7Ct11sCga9o4QES9lOt78HHOB3KMMkKEmboLBUVFh5bEYvAcKtUuKi
    l/QAGSj+7taUADU9KtZotAofgmyBLFsMBLNB+7M4tBSTBkdrxxPbfBqciCa7Zcnf
    RlIVk7/gKm8ErtEAmptwFFaj0Nr91A4Egd6bPsoMrWiHmVJ515ttauftvO7wVulN
    tMwwLngz/7zEHM/QiXArg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCvqCbIK1bxMD46AgW5xoOfH2PGhofInygKP1WhKcSSOhYTV7dcwvUhaxmLlAIQY8Kvr/rfZSlYsZI6xqL4mX9jCK0WV7ecd0EfRu64RTFs6fQUfVpXO
    TzooD9chruk3iE/NmdxKvX/g0JZzdwZBNS2uvWWCnuP/fyymOHrLNJBvzCraVYkX2q6LHlQq4kCWX2VKfiMW1o5GXOcdNGX1x5T2uQWd5wyo2vAAqDLBF+ln
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=XqTFcmWXiVvMeVo3s_wA:9
    a=dOhS9ErQSd7VLEHf:21 a=-KUCBwiW52P5O-PW:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeDQTS1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:18:27 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:53542
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752568AbeDQTSZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:25 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 3/6] cifs: smbd: Avoid allocating iov on the stack
Date: Tue, 17 Apr 2018 12:17:07 -0700
Message-Id: <20180417191710.14855-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417191710.14855-1-longli@linuxonhyperv.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfFFyrHmGPBnp8v7gnOzs6TL6+PTuEYW9qQRTRaOW6pLf3JLYL3h7jsKrSwLAQzC8YqNzE9CGqmTR/njE8fC6VlaoYodhbiyOhurJ7kpsxknr1P4Jozj4
 TI6M7fL0Qwu8qWHnOmA2z+p/iVzjjNpolxiOqFq2B7CG4rLvnd1x1g0rgplXJCTb5rz3Khx5iTmtSPdyJtPnUkvR5IeEA4fMVmwZhcK36z9K1liePqlnnFgh
 YKDc6X4LU5Vb3AeVwUIau164vBT6hecDdW/8N1CtAfux16UKu9Piloe2lu998QsUDdLblXvGSSGmO8dpkDn92mpNh0iDykHYawVP77gjquesMPe2kmaD3kKS
 0zk6+njtwVzTCIX69y6qLqfBWsWLjvBlDUeqJyf73+gggsE1S0ZyIoxiMm8qGKvcXwJ18G7nuYoKap03O6qa2n19n3tXIi3nAKIFxQ9QyF6CjwJL0vw=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

It's not necessary to allocate another iov when going through the buffers
in smbd_send() through RDMA send.

Remove it to reduce stack size.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/cifs/smbdirect.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index b5c6c0d..f575e9a 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2088,7 +2088,7 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 	int start, i, j;
 	int max_iov_size =
 		info->max_send_size - sizeof(struct smbd_data_transfer);
-	struct kvec iov[SMBDIRECT_MAX_SGE];
+	struct kvec *iov;
 	int rc;
 
 	info->smbd_send_pending++;
@@ -2099,32 +2099,20 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 	}
 
 	/*
-	 * This usually means a configuration error
-	 * We use RDMA read/write for packet size > rdma_readwrite_threshold
-	 * as long as it's properly configured we should never get into this
-	 * situation
-	 */
-	if (rqst->rq_nvec + rqst->rq_npages > SMBDIRECT_MAX_SGE) {
-		log_write(ERR, "maximum send segment %x exceeding %x\n",
-			 rqst->rq_nvec + rqst->rq_npages, SMBDIRECT_MAX_SGE);
-		rc = -EINVAL;
-		goto done;
-	}
-
-	/*
-	 * Remove the RFC1002 length defined in MS-SMB2 section 2.1
-	 * It is used only for TCP transport
+	 * Skip the RFC1002 length defined in MS-SMB2 section 2.1
+	 * It is used only for TCP transport in the iov[0]
 	 * In future we may want to add a transport layer under protocol
 	 * layer so this will only be issued to TCP transport
 	 */
-	iov[0].iov_base = (char *)rqst->rq_iov[0].iov_base + 4;
-	iov[0].iov_len = rqst->rq_iov[0].iov_len - 4;
-	buflen += iov[0].iov_len;
+
+	if (rqst->rq_iov[0].iov_len != 4) {
+		log_write(ERR, "expected the pdu length in 1st iov, but got 0x%lu\n", rqst->rq_iov[0].iov_len);
+		return -EINVAL;
+	}
+	iov = &rqst->rq_iov[1];
 
 	/* total up iov array first */
-	for (i = 1; i < rqst->rq_nvec; i++) {
-		iov[i].iov_base = rqst->rq_iov[i].iov_base;
-		iov[i].iov_len = rqst->rq_iov[i].iov_len;
+	for (i = 0; i < rqst->rq_nvec-1; i++) {
 		buflen += iov[i].iov_len;
 	}
 
@@ -2197,14 +2185,14 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 						goto done;
 				}
 				i++;
-				if (i == rqst->rq_nvec)
+				if (i == rqst->rq_nvec-1)
 					break;
 			}
 			start = i;
 			buflen = 0;
 		} else {
 			i++;
-			if (i == rqst->rq_nvec) {
+			if (i == rqst->rq_nvec-1) {
 				/* send out all remaining vecs */
 				remaining_data_length -= buflen;
 				log_write(INFO,
-- 
2.7.4
