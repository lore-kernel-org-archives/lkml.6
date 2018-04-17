Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442875-1523926947-2-15870365262446131214
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
    1523926946; b=BbLs4CrHtdbYkxLbO5OvW68NFoiUK6WykMum2DX71KIlU0u0Ms
    +w9Ma/1YPueCnCLJOVUuXfT7TUAEM0PcweqVERgd/09ln1KQX//FlJtqzjO4VKQ6
    /xyZ+AMgQdScIEpT01ZAopy7ymrzB1b1FSjBm3KlpDg+iBf6GEfaX02vuAJYa+Dc
    bw44dq/aj7JGSNN9DWpkrpkTbSWaHgI9lyn+6ahWP1fVPq4aYiZpnxxZgDdJnUBZ
    leiO8nfaN4FEdtxQSt2E0o1HpjE9RK1NoXoShF108x7fEuxgb6DF5QPOp+iOzjgl
    UUPl0PwGPzYdzyK+If3uom8yQWP/kRnRFvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523926946; bh=gT0YaHzWOJC9Sz0qAcjVhCozprVvDU2dKHgHBvbceuI=; b=p
    qrwWQviiBQeKcCsd10QMgA/xCOYwW3LBjmvmVp/03EC/HPxYwlQE40faKHv261+8
    RH5kLDJ/XvZCQYAfiPWCopR3j2uqDjIWVYS9b+piPKrhUjz9QZ8bB/5naEJ0eDRj
    X0tOUAi0Tqofc0V18/V/T4CEPN/wqTdATpMQFPFKtGh4recyFolOBjflIGzA6Y02
    jiW+z3CoPdtKiG9eCByCYX7dHIgCzb33i3VB5DIIPytR9FJrcjMO+cECkNkd0R88
    zH+LeCaJsxELvwvysn5VwYZkP6CjQZVTt1DgD2KXriwIFBk9ejtXQsbZFQS0MYaO
    /VSXY4WwY4YwcyVij9IDg==
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
X-CM-Envelope: MS4wfDB3gWIlI63VWkzKybzelQwW5tbikSOhfjT4wStuXC+1Tj7WW/Dhu6++CZYQBNwjqoGcT9xpBFPCESL/NG87x8cZbzPtrhdcUXJButYDqcipX4NCjXPV
    BvyZsHw7RlnXoPMNWvg9JjBExaFhOkg9k7eeWvO4bahtBbcLkqA8khiXw0km57ja9T/834cY+6Yj79GizcES7CV1QMPtQSMld514K2vgE/+0eNVPe+8vv3uH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=XqTFcmWXiVvMeVo3s_wA:9 a=UnNoCy3zrG_gv5xm:21
    a=3pGEV0j41RJisXNR:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeDQBCX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 21:02:23 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:36280
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751200AbeDQBCU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 21:02:20 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 3/6] cifs: smbd: Avoid allocating iov on the stack
Date: Mon, 16 Apr 2018 17:49:15 -0700
Message-Id: <20180417004918.29213-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417004918.29213-1-longli@linuxonhyperv.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfIIfCoW4GdMewIaUyEJ1B5h+PnBpDoaG7Q0+bvKNRPDp5MYPMgvpaQtNbhMVQsXYe6zoVkaa6iKa1pOQsuwTvbxfkZDL9y8LBDuK8Aq8utMfuaR8PDgF
 W8UsJ/6bxH7+VlrevEIhXk6E0GXPIiaUpH9vS/PFPtUNt0gJXb9Pq01xvRVu0tD02EypdbJKMju9RKj96aeJiTd8ufKZiGvyuWRgsjYo2qj4pjVk+L0cEy95
 GvuL376UwqEOUbSE6CWC5GLdkd2XLEt+QPuIn8UNJowooXtgdJWQNcWoEMBwSf/0Hf5aQrWEuphFBdTZhli8xtMbTonoUxKJN13n427NLMB9BCtwoiLYbCVG
 Av0p85NEN3p+/N/68LujwPZtpuD8/FQzVGqC2jGx3D3SWNylzXeHK9xDNUddRol9N05kOE5VwzORUX26LX8ABYZixsLNUbzDHxXL+WkojhOIpaq2sJs=
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
