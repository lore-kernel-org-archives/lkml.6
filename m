Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548850-1523992798-2-8389507152939352931
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
    1523992798; b=FGOJax3O1iAKzcpABufDC5aGz9Lnap6L+KwIhFM8habZ8SBIsC
    bbo10X7VQobOZxRY1cpVddWrcOjez7KRCoT63kTw3gXHPJx1fOOlo65c6DdOCW/J
    9lEAej5RpSQkY17EMLtqK4A+6vxf0phKGEKVXMTUlzLv1iCSr5/z75kpf17Lpfn+
    l1Otwg18a3hNWAdSJmZn4x34fyyTxxFrEGZ3dtxPUHzRMcT85XIDMFbYU/ktKzj3
    7H892Kjv8w1O97d+NXrsl/FpnQE4fAz5ygtv9+hYhgncCitzwdUFQQEKqi8ffS07
    IKe8+wEJcJZEtGECmiIqS0qvWAvheBtpI91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523992798; bh=5Z9xxvypwQ4bx/uFdqRy6JsRMtdX61YKf2en5N8bQCA=; b=T
    cu0aDJumUBBrtTKRpuOz1NNNHu9e81UbyGAPgz5gqx/RXEsuZQU9yUrwA/zSsIoy
    shLm1mTszblxciPUAoMP3kukg/g5p3Dh7IbAaBdPbp/cYxKzP496E1/CEyGwfZ73
    6akM6aexgMX1HQam4Pqz/+8gQVedxqCJMAsFmDQ+0oGMogWOYVJ11sWogWFsHGDU
    YVWQzlWN174XkIQ9lGlDU7w/5X4TwKa5U7R0nMwj9GYgN8oqsBBnJG2xb+U9jJuo
    5doq2olYfq6IfHzSrjttN8/DdZsPEmyxzyPjtRMSJmw0kQwHSwkGD8o7X8i7p0eW
    BxmGlZ79tCWmvNpDI84kw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfC16+rGKosrpvTqSBrQe7Ng4LRVn+DFAgNEjFSQF34+NtfjOusN41a+cQspd3TDv72idthNWXTMjvY0ccBs1O1Siow1Jq/tOlF8z20CC836JM3DgSxoc
    F1Rdh2OQn1/Vmi0cwKE2/8Vux4Mr3bf70tYi2aPGo0vt6pjHzGH//zf2xvIH6RS9OtJ0YgIHkzkxYac+ZvGQQs0xNhh3gI7t/+mmb/n9e5xHhKNdSGZC2eVb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=6EaPpsYq5KF8U0OsA6kA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeDQTTh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:19:37 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:54548
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbeDQTS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:27 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 4/6] cifs: smbd: Don't use RDMA read/write when signing is used
Date: Tue, 17 Apr 2018 12:17:08 -0700
Message-Id: <20180417191710.14855-4-longli@linuxonhyperv.com>
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

SMB server will not sign data transferred through RDMA read/write. When
signing is used, it's a good idea to have all the data signed.

In this case, use RDMA send/recv for all data transfers. This will degrade
performance as this is not generally configured in RDMA environemnt. So
warn the user on signing and RDMA send/recv.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
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
index 41625e4..33f612f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2595,7 +2595,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	 * If we want to do a RDMA write, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of read request
 	 */
-	if (server->rdma && rdata &&
+	if (server->rdma && rdata && !server->sign &&
 		rdata->bytes >= server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
@@ -2973,7 +2973,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of write request
 	 */
-	if (server->rdma && wdata->bytes >=
+	if (server->rdma && !server->sign && wdata->bytes >=
 		server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
-- 
2.7.4
