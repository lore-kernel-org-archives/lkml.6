Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442875-1523926952-2-16978593231191604429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523926952; b=X9wJ1rJAIbr0lMlu4MP7NPl5/N8tSBi89GHbIic9iIUxs2/KY1
    FNBIvm/7avcaTz29BAjuMsf9rQP2vtOp7g6oBtj4BM4mzf25B0eDNOqsmBn08u9J
    aYitn0ri6ZjWTeZmJEy5BJp/gmPD4qRZFgCVK1CX8APCvNIXkfSM8+T/jm3q0TcE
    TnoTPhdBt2ivVrcpoMIoljJdkmrrmgh5QKGAudIH9QiF+3QaIWyEjQV/Kt4FpP/L
    xjyT/CH7Idz3E08XOSyTY3Vp5lBNVy1WbDF0F1qVWxuKLe8pwDbm3FUvRhBJOeL6
    flEIXyW+wFiTeJSOVr8a3Q/Dos1o9X1hyOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523926952; bh=kdJ4yGtezAtlA7SeQ6ExLRKwaE4mmUuTL9yVk19lSok=; b=s
    gOuSoH14SBb/Vgry84BExIMYZdlj23Bh9mE9U+3lJJVZBl9mplXBD0MhT+8j+pMa
    Yel6p6idTMlSwc+iCa6hVE1cMUCPabVOBTUNO2ebqZh/cmz5CN+jPvjnyOjg5RZw
    aMh7jYeP5qhObuPzt2VyLkt9cMEzL/aWnHenxyh/G09HMOkvWHgladgKLLmMrKnr
    JfsndCpB2dlKoStOhyGsUBESgEKU6qGNrMzzVCN9YElIajADMh4bU7KCGjmSul8W
    P+jy3KYf4CVjeinVq/cPMixhisqBUV7QILJR4LsVIx9mx84EQq1wbYICJ3VOl9kO
    ctvva3PNTeQCMJqXwTp3g==
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
X-CM-Envelope: MS4wfIzafA80d3C0cRMjW2h3elqGBJJNub70aiSxbAp4po9xy7p81ly1i4s5JTArcaWXhUIVt+ApYFggnum7+39xuJ9H8YkFFHl8wo725r0BtxVzn78CMZ//
    lJMIuQtpTxttyLcrN3JR5zy727C0RNALsv4aqqQCjgNh+D3aMmOTHKMhy/7/TNCWZi/WE7yAmO+L2MaZEjFj+VcnwMIAYuppD16qY5RfELypzF3qilExcGq7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=IKJQ97iYfRcLqWwx9dIA:9 a=ISDgcP7blpfILZxm:21
    a=eVApJhrQPY6Ug-T0:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeDQBC0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 21:02:26 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:60428
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751940AbeDQBCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 21:02:24 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 6/6] cifs: smbd: Dump SMB packet when configured
Date: Mon, 16 Apr 2018 17:49:18 -0700
Message-Id: <20180417004918.29213-6-longli@linuxonhyperv.com>
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

When sending through SMB Direct, also dump the packet in SMB send path.

Also fixed a typo in debug message.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index f575e9a..6ff864a 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1029,7 +1029,7 @@ static int smbd_post_send(struct smbd_connection *info,
 	for (i = 0; i < request->num_sge; i++) {
 		log_rdma_send(INFO,
 			"rdma_request sge[%d] addr=%llu length=%u\n",
-			i, request->sge[0].addr, request->sge[0].length);
+			i, request->sge[i].addr, request->sge[i].length);
 		ib_dma_sync_single_for_device(
 			info->id->device,
 			request->sge[i].addr,
@@ -2130,6 +2130,10 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 		goto done;
 	}
 
+	cifs_dbg(FYI, "Sending smb (RDMA): smb_len=%u\n", buflen);
+	for (i = 0; i < rqst->rq_nvec-1; i++)
+		dump_smb(iov[i].iov_base, iov[i].iov_len);
+
 	remaining_data_length = buflen;
 
 	log_write(INFO, "rqst->rq_nvec=%d rqst->rq_npages=%d rq_pagesz=%d "
-- 
2.7.4
