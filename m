Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548850-1523992780-2-17396849156827281729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523992779; b=CGapnUU9HaahiyRLnsYCrWOTkE/AiMzaPJ/EFjbAtjUc7zkPxf
    jZUaw6JovHR0xIu2D6Gzhn3K4WyiDRqFfUy7oWn3K4+7UB/P/R36DmUH4Xy9vMMO
    31e6fyR1nPh3AzCDoj2gbkAkK6ExBTIyGDtZLgDbTOJlcK11Z37zfzm/ZimI+QYk
    l5fxw+Xr0/PGt2Cei3lQuwQevcBxsOSiWAAppGL5UoWwyOjnCco3LJKI0lTV41Vh
    kZCnXMqK83jOQdgbJkRTkAJAbQGBB1vwxBECp3hkSxiRodnUrdLJhtgUb9iYeZRj
    VVTNXqrrgdxs9cK5xBPG4vzKaqJB5YBkC0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523992779; bh=PUf9RhhLi7MhwcfZL1g1izp/PiW9wtSyxzyh5dIzliA=; b=s
    wjodVvo5Ipqx0N34wMdb8mPhdIdnOk70MpDlUEi+FVNezcWJHVlKkmDO7Wo/8o7F
    K8FFBqXAxvo7C/dKXW0bGDIsjQ19pQ//wHoLaDidiwfzstcfRThAIONfqKznxdCi
    bNERcZrtQok/ETSUa6V1DNAB2gH3x81ReBdicbBNkJNqfIuWuvor/2ciZECjVph0
    hkFLcG19Qd9ki4f0VlY51ktJv4jmwtUnPmZ1kcAOtShzMCame8VSZH9r4FpVaZSz
    8eRF9M3aaccNLR/Kxo9te1x5+yUSy+DXJzLETH7JJGuwCZ/emVPpoO5htI2eNv34
    vqT9BX93JE8qZXvxgplyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfBDdKCIx0hggYtF8Clil/qQdH5N94BN3kC15dN0zYOrHQrbQ9WnJbhysPLgkSGcR6gDSQhBl6/CC+phHeImvBWM0mE6bHzMbbO0xgASivzbeU+lfQ/kt
    wewAVK2elVt0NhV61iZNH3S1z99s5nqn0NT5H7XJ0tCFYMENShNoJJyOPutWBbf38j7st2tUR6kYSFjkBJc/zstHYWmmKqTuWnG74l3brJDU+plCg5Lo0Q84
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=9-Hw7CTpfe7dNwokO-oA:9
    a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDQTTg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:19:36 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:54546
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752703AbeDQTS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:27 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 2/6] cifs: Allocate validate negotiation request through kmalloc
Date: Tue, 17 Apr 2018 12:17:06 -0700
Message-Id: <20180417191710.14855-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417191710.14855-1-longli@linuxonhyperv.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfOGNSzcMy1vt/bmrXgU+tAxEC3lSsy2957m1JBalFZXEVs6p23YCzOfPGx9PUTGi5CGTQPOdZJrzFc3xPkgUvkEJD6tpBFtlEjLvSaIjBkUEjGDD15+0
 VNM+ch7GIifnm447SALVbbEafN9qOetKoqq+87wCGNP4ASLR6FsuaorE+faDUlgJmfcOCNIjp09nFiJCTU50VI9acUmxDoBRusA5BtoUCO8WGjfXtUb4Hc3r
 Ku5gVWVaQVDqGb80MegXxsB7CRGcM8DqikjMYRtPqCOhe4gRtxEcvJVaZKYbiCT2xyZmmM5vAxVDiFfAXedbe2Q6Cf/u8mDz/PwiiC00V4JVFnFoqHdZz5G+
 QVkPtJFcRncdimHkx+6VpPzDrtKLi85hDkKlmlyRb6KJOnQcbmNw8fkyRU9iINGY2sXXYAirrYfCuSbyKMEaqyhTTttFxSc8HZLnGKYXE+Y6d+6H/pI=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

The data buffer allocated on the stack can't be DMA'ed, and hence can't send
through RDMA via SMB Direct.

Fix this by allocating the request on the heap in smb3_validate_negotiate.

Fixes: ff1c038addc4f205d5f1ede449426c7d316c0eed "Check SMB3 dialects against
downgrade attacks"

Changes in v2:
Removed duplicated code on freeing buffers on function exit.
(Thanks to Parav Pandit <parav@mellanox.com>)

Fixed typo in the patch title.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/cifs/smb2pdu.c | 57 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0f044c4..41625e4 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 
 int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	int rc = 0;
-	struct validate_negotiate_info_req vneg_inbuf;
+	int ret, rc = -EIO;
+	struct validate_negotiate_info_req *pneg_inbuf;
 	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
 	u32 rsplen;
 	u32 inbuflen; /* max of 4 dialects */
@@ -741,6 +741,9 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->server->rdma)
 		return 0;
 #endif
+	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
+	if (!pneg_inbuf)
+		return -ENOMEM;
 
 	/* In SMB3.11 preauth integrity supersedes validate negotiate */
 	if (tcon->ses->server->dialect == SMB311_PROT_ID)
@@ -764,53 +767,53 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
-	vneg_inbuf.Capabilities =
+	pneg_inbuf->Capabilities =
 			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
-	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
+	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
 					SMB2_CLIENT_GUID_SIZE);
 
 	if (tcon->ses->sign)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
 	else if (global_secflags & CIFSSEC_MAY_SIGN)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
 	else
-		vneg_inbuf.SecurityMode = 0;
+		pneg_inbuf->SecurityMode = 0;
 
 
 	if (strcmp(tcon->ses->server->vals->version_string,
 		SMB3ANY_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(2);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(2);
 		/* structure is big enough for 3 dialects, sending only 2 */
 		inbuflen = sizeof(struct validate_negotiate_info_req) - 2;
 	} else if (strcmp(tcon->ses->server->vals->version_string,
 		SMBDEFAULT_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(3);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(3);
 		/* structure is big enough for 3 dialects */
 		inbuflen = sizeof(struct validate_negotiate_info_req);
 	} else {
 		/* otherwise specific dialect was requested */
-		vneg_inbuf.Dialects[0] =
+		pneg_inbuf->Dialects[0] =
 			cpu_to_le16(tcon->ses->server->vals->protocol_id);
-		vneg_inbuf.DialectCount = cpu_to_le16(1);
+		pneg_inbuf->DialectCount = cpu_to_le16(1);
 		/* structure is big enough for 3 dialects, sending only 1 */
 		inbuflen = sizeof(struct validate_negotiate_info_req) - 4;
 	}
 
-	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
+	ret = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
-		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
+		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
 		(char **)&pneg_rsp, &rsplen);
 
-	if (rc != 0) {
-		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
-		return -EIO;
+	if (ret != 0) {
+		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
+		goto out_free_inbuf;
 	}
 
 	if (rsplen != sizeof(struct validate_negotiate_info_rsp)) {
@@ -820,7 +823,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 		/* relax check since Mac returns max bufsize allowed on ioctl */
 		if ((rsplen > CIFSMaxBufSize)
 		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
-			goto err_rsp_free;
+			goto out_free_rsp;
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
@@ -838,14 +841,16 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 
 	/* validate negotiate successful */
 	cifs_dbg(FYI, "validate negotiate info successful\n");
-	kfree(pneg_rsp);
-	return 0;
+	rc = 0;
+	goto out_free_rsp;
 
 vneg_out:
 	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
-err_rsp_free:
+out_free_rsp:
 	kfree(pneg_rsp);
-	return -EIO;
+out_free_inbuf:
+	kfree(pneg_inbuf);
+	return rc;
 }
 
 enum securityEnum
-- 
2.7.4
