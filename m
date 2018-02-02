Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591078-2-9840499374281418659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591077; b=i6iCTAOEySJpHTvfEoDCIIypw5cgJOC7VLuybs70K+056WN
    V/Irf6zqJgUKkf79AB4ZGuBitVg6WEZz6GC3F750ocJ3DraufVisy6eL1G5dq835
    G0JzAYuIhImZpTYx+lBnvJ7kp7LQXzdEpcU5ERBBVeu5cVKYcYzKSR+WKvqxHnp8
    v/jz1ADVIgD9t1niEjA9lTGdKI0kbFQXqeHCcn2JFxJsKR6GRUh5B8xbAkskWNlo
    jXHqm5BvSAPZ/WicL6mfsVEm7LWmIBEBHSN8HjVFVY+0IDboGJj6jP4zezDnvcqG
    b4ZIS3xOqvsiMDXVsplAxTaRa2ozeFx5/1Uf1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591077; bh=8vT//m7uk/X6uemfNXDQyki1gM
    JvcP5PsrwY2Vikd50=; b=ZmYriDV4e+3b9f5SAJKqzT30Nq0GvyU344btH8LPK0
    G+a9o0TcmbRRrI0GmYVS5ljPIBf8eCPqq7v30jmaZNVhK9xcBGdo0/5IfdIDaRq9
    JSE5HOLJ0R3m/+PS0FrwpAf8IQkVETgjMzqa2VdCL4UiKUhJIrFe6bptti/4W6+9
    L005XxKgVTOMT7CMnMrNsv0wlyh8wd9AanELpSdvV2cQBH9nHEI0mgcB1pVuyLbm
    Lab+TzldbykOQMOrV5eyhE1qV4qImhmZhdVFXnUHI3ZSxkNWondnVu0UR1lQP+Jk
    K04s8X2/npHNaHXezb6Dfz6fY9EwTKcsomzPeEFjYJxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeBBREe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbeBBREc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 41/86] nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)
Date: Fri,  2 Feb 2018 17:58:01 +0100
Message-Id: <20180202140826.148532980@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit fb500a7cfee7f2f447d2bbf30cb59629feab6ac1 ]

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -63,6 +63,9 @@ static const stateid_t zero_stateid = {
 static const stateid_t currentstateid = {
 	.si_generation = 1,
 };
+static const stateid_t close_stateid = {
+	.si_generation = 0xffffffffU,
+};
 
 static u64 current_sessionid = 1;
 
@@ -5407,6 +5410,11 @@ nfsd4_close(struct svc_rqst *rqstp, stru
 	nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
 
+	/* See RFC5661 sectionm 18.2.4 */
+	if (stp->st_stid.sc_client->cl_minorversion)
+		memcpy(&close->cl_stateid, &close_stateid,
+				sizeof(close->cl_stateid));
+
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
