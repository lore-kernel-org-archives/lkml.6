Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836378-2-12242174956465293139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836378; b=wUFCvYXKA8wIZ+gOSl+3UThfDPlJ+e1HItpNUkfoTm0waWJ
    tvn2V0f8dAco9dPfpUMhvDj3eKzaTENCYid+ZYPjIUkxLtmxvSBhhDQvRS6F0wP4
    IFkGQquf7/TZY/9kQUy8OQTPKra0fQVh1g+LjLJRX6RgpCtL3c5QX83jQYzGZxLA
    xJaysIS/KRwHYikQ+ytUtD0xM58y5yGcRwgIHUiLz6X5RtSpI7f1kpMErnqa3UfS
    dj4H1Nm2/yHmYZ1tok7/0cVF9OXyRufptVfjWH0sbxRH+HPtj7N20UtftZHd+0JF
    p7gNVclH04woXV//aYMjz4ue1h1b9pg5ebIkq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836378; bh=Yh8ut0H/alZXyDjDEr1
    ZEPtSxIR1mdZodydQPMincj8=; b=OH4AklSD6CWGx9YrGpOESYD9foSb090DnRK
    4QQLXFVuG+I10wuInoHft7DFFsPJcPiHITwh6UNr2BR9UHRynUAW9sQxBqgD3p5Q
    K2T5pbJDGelVrelxC9wB4xhy8JFX67s+5G8knOO2cCaxl42J+eBTopW6n0dBvXSy
    mZogzXXuzIJjb15KPfaP5yV2DzPv9CpH271v3ZWgMjXJNs/i9inxLgyUibuiRQaj
    NyVGaTx//Z43shl4xOGdGmDK/X+swJszOWI5wM5oxmTCfUVJK7awhh+UBnidVF0V
    T+bejcUBHp7153/pnpJGIbOG00BCd+HoyyDEJuFlqlRBRYz3wRA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeB1QAS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34646 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752543AbeB1QAQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.481417747@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 159/254] IB/srpt: Disable RDMA access by the initiator
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit bec40c26041de61162f7be9d2ce548c756ce0f65 upstream.

With the SRP protocol all RDMA operations are initiated by the target.
Since no RDMA operations are initiated by the initiator, do not grant
the initiator permission to submit RDMA reads or writes to the target.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -958,8 +958,7 @@ static int srpt_init_ch_qp(struct srpt_r
 		return -ENOMEM;
 
 	attr->qp_state = IB_QPS_INIT;
-	attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
-	    IB_ACCESS_REMOTE_WRITE;
+	attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE;
 	attr->port_num = ch->sport->port;
 	attr->pkey_index = 0;
 
