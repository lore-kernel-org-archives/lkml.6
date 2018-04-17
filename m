Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2548850-1523992704-2-12756314460313016144
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
    1523992703; b=nREVSPWZQEpf227rCEXsne7cv08NeXgzfrcKXOyEHoF87MDOEh
    K/5eW3FBWroUsb1f7G8PNGev9xRWhJL1iR586tnLAJIcrBVr6OoI1TpSRAoaNzkZ
    Ig/mTArzbOC+bpXJJEMuQcZ1uFzjeZcduJjffErhyy5NYlj5rDHm2dKRARbbuLBo
    DWhOdM+m8CxRN2VRb/V76IKvni8DD6WutQddJXq3fUutXLtkYBAxUsyX+WGLPYQ2
    1npK/AybAuZNZ9UQ9WTltuNhia/SMDAdwkZmFkUW8dUjjQE14iiaca8ljjD7nLj9
    mNfGGeeQHA3AjLYSzOpOvZ8we8ISEb/LSn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523992703; bh=WG4pHSNa8WWHnWI5IQPH9GJcz0Va0TcnjQsnSIeuR4A=; b=d
    PjbkKbx5dgV3I1yUKmhD85ONYNe6JqiW6d1ajlnkln/tHbLhMCsuve1X+B8Aok7W
    R8cSeeMm7YN+kbl15x36JI+wVUXCrmSoPhe+DoGUI7AbJEtPpN8z0dyWLf7Tb9+z
    nJGklgod5jXW0yE9AFwbjExWhqsHRpLeqbccjpu/1rt3MgVYDhPCF5g7fH2p2e++
    1XJ/WnQPL+3pn8f8Fzy14UnEodbBxyk6d13PeDjLPcOMmvSdF3mUKKjuiggsPR9A
    qk8wZ2ivABThqlU1xozMfTPxNe/4LQCuwJi+WgtN7ZgigvC+5gUkHOWkXMFEiOgO
    6WYEDpnH+Nb3lIrn4IOsw==
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
X-CM-Envelope: MS4wfFN/q+I7jxkd/cIHpKb1CBhY4W9JsmJtmBISW8NSa7t+TBMJWvHsg3NmeokXRy7bbmZVejzpLBTEGRSKUrDPwysKmiBSGGpsE82nsuk+nb2Oz8Vq0cZj
    ucJS4yU6Yu4pQk1w5P/TEyd99mahIShjnV/D1iYFtHn+N1vPb5+G3/l8GqyzbO/D4u1YtWWjeFxr+W1tuYSoQlcUafpoAIoWXv9f0l5dgkeCD7cNm4SmU7M8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=nXmEi__yKZsk49VwxFsA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDQTSV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:18:21 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:58222
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbeDQTSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:20 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 5/6] cifs: smbd: Enable signing with smbdirect
Date: Tue, 17 Apr 2018 12:17:09 -0700
Message-Id: <20180417191710.14855-5-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417191710.14855-1-longli@linuxonhyperv.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfHD7VcRwIxPLpH+5DBXZ0ULh1zpAWDLncT0HGY6UwY+fB8qv2r7Xb/wVkb4KbA56o5fO1lHnVaUFEqxpMR170TKDRwHDorkNxu6nrd008mDLEzWuiwAX
 i8+7XjnufibTxdV5jgBYm82uGIB1KHKFMOHOnzRW/x7qEhrR8G0c/f1NDg1I50jGwl0GpPqStGbJMwWumd8ReNWzfKqui6wkHiO77IhEyPyHunFggv5zQUnO
 W7Yg/RwYo6OtRUgOWiSQnfTVA9SUbVY96hDg2m/FF/mjG6nujgpwylJ+lnBM8kk/pRq5jTjtvrUriz5JRb/z+10GvtH8mNjGbOpNwXdY4sgc6KjrWeLyEelA
 XiLLX4DLxnIUMU2hhmZdUpcLCu5zDrIHd7vuEgIDpUVTdqBKYID5bYs0q+uJJcpNoTkNH5cxJo/ige3+NefnBrPcs2rZ3yt4ojRQ5cXmc/h3UohNUaI=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

Now signing is supported with RDMA transport.

Remove the code that disabled it.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/cifs/connect.c | 8 --------
 fs/cifs/smb2pdu.c | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index e8830f0..deef270 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1977,14 +1977,6 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 		goto cifs_parse_mount_err;
 	}
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (vol->rdma && vol->sign) {
-		cifs_dbg(VFS, "Currently SMB direct doesn't support signing."
-			" This is being fixed\n");
-		goto cifs_parse_mount_err;
-	}
-#endif
-
 #ifndef CONFIG_KEYS
 	/* Muliuser mounts require CONFIG_KEYS support */
 	if (vol->multiuser) {
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 33f612f..3e052a0 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -737,10 +737,6 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 
 	cifs_dbg(FYI, "validate negotiate\n");
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (tcon->ses->server->rdma)
-		return 0;
-#endif
 	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
 	if (!pneg_inbuf)
 		return -ENOMEM;
-- 
2.7.4
