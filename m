Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581930-1523992778-2-13315883113147684789
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
    1523992777; b=MquKotLFdA9fDxgejSyhVgDmFjIfmIznTPsooVtsT4SAgDWZSF
    qmb50CTXjtX0VcxkFGbkhpCjyv74UFaHIqksyDr12wmFnQbelTOsJPUk54BZIiQM
    sgcknLBQ3ngTDuy/owhHkAZtE2OIdw/2PfcIAKGuXFgaVg25X6kPy3PywFeuIydV
    ra1QXBVfRXcz7satjrTes0qvtB15PTElMfLv9gbC7ZizaZxlrePzIjiLieGrDe6w
    B57DRNlTtwVQahP98i6PhENXNj1vAVU0hDHpVsKTpfY/pfwCdx7MdVTHm/EkfjC7
    Bdny5Ri7WdzfohMx3Hqrivvs2N7TJyaQiVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523992777; bh=aHLC7/cvkVY8urv4TVLwPsjaxchcgIguVM5FBTbyYec=; b=m
    CYQS9/SL+/62j5zEBmxCUi98HtgKau8ewb+wwuWnqHELFo5CfZWMeBAnEwv2qikt
    Ra/8HBchgAx8qTB6fWNQg7dgDCtcwmUblXNAmNyC/yIGeXIMQffLQkmTHgp46F/x
    spr2AfyKQetZ0zuq1Zuz9RLGf70PF4aUMsg3+Ay5Ll6a3QTx2HK/iO9KFbMTewS3
    wqnfqb60xr6N4/h8Rpb6SP58ZnvVPVMjMSSimIg3ZkHkl3Gy9F7Bm0jRu5VNyqkJ
    DJQ7TGZZaD+5TsIiDj/x6sCywMrCg6bxEOxu88LC67oJRcewhavsTVa+HQTt86cd
    LbM/+2Ys5di1u297igdZQ==
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
X-CM-Envelope: MS4wfLxq7jFFn3i03JLuhQIceNJ7hMQVorKAkCyP/vxPsVJYoXx0+UaU3Ubdmu4IvIjctaoIyjbkOLJKQyAo1WSWjPMXckSB9DFYuM07yMKMPVplTvstYLZq
    GEb1SpcEkz8+M5w3L2F5ez62FN+zFHNHBL4LM799zRh/+gqA65B3ChcYaExR5a72hv7xHXOB6qzhD4QrRYGzDycHbpoHlCLfyiIOUHIBv3sD9j98b+vvqzux
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=qmGINNaJ-duC5M35E9cA:9
    a=7ZAcdd71beOg4NBA:21 a=jvplHoVlgn0i2gXx:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDQTS5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:18:57 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:54550
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752709AbeDQTS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:27 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 6/6] cifs: smbd: Dump SMB packet when configured
Date: Tue, 17 Apr 2018 12:17:10 -0700
Message-Id: <20180417191710.14855-6-longli@linuxonhyperv.com>
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

When sending through SMB Direct, also dump the packet in SMB send path.

Also fixed a typo in debug message.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
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
