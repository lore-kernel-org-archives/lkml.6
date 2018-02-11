Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324945-2-2433665953472833649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324944; b=iZ8h+tiaT2mBinuWDsVme+6IPdm0dtTGtMLgP4AdQexuQzr
    Pn3w3Aw8JpzR7T4XwLSQ9bhj0dOJSfbLopfsj5bHBLPrV8Y5oWCt76fD5IrzNfOE
    eVtgSFKu2Bnv/DYfEPJMiO+t0kvJi+LxF3H32ZBYD4A+sDvWGpanFKj1LOXyQPj3
    eql+yAAwGwjpsLsdX9ckjsWKzKigGUB2mH01VAK+s5lBOp8YSrvyDATXqVx7gkuS
    zR0/LWu5VE6SxbLTVB1I8p6Z/dmKdTcTYgqqk0+lrJ/xvk6FMpnhPGUupIp4juL1
    kKRCj5OEiDRPEA64tG6bXTnXjBgTWDsxMuFmZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324944; bh=FFmBmxCm0ey4iBRqB8V
    4lBTQDSevUsxRnNPq+ZE08Hc=; b=O14hbGkjHDg9e1b/49dsMSHgRiU6dD0KaId
    LrQjrwhYblXV+ntWOvRwaIdNSRn6FI+NmTZHkmfxEHa/sfnmRW3sk5R2CNSsQuqR
    qVkT4t5h3NjZuBlUzaAYJj3IM2PIR9Tcgtykh+fUPfP/X4GfErttOff2Gl+cT+sp
    Un5mEOWwfJYjknKz1nxMjvSuEci27nkrQdkDER8DHP5dI9CLVaUwLZTJpUiROWti
    RukCqoSP+Avxj4jKGEGWvBSrAhYvWeQkkbh2kU7JkXME4FSknoufdMkzhIlcPogU
    S1RtEqzMEyTHsZaUdVGK+qEbuoWvOQN2Tl5u6k3D8xAG3LMxUJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBKEyQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:54:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41741 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752813AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mohamed Ghannam" <simo.ghannam@gmail.com>,
        "Santosh Shilimkar" <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.531574093@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 120/136] RDS: null pointer dereference in
 rds_atomic_free_op
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit 7d11f77f84b27cef452cee332f4e469503084737 upstream.

set rm->atomic.op_active to 0 when rds_pin_pages() fails
or the user supplied address is invalid,
this prevents a NULL pointer usage in rds_atomic_free_op()

Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/rds/rdma.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -855,6 +855,7 @@ int rds_cmsg_atomic(struct rds_sock *rs,
 err:
 	if (page)
 		put_page(page);
+	rm->atomic.op_active = 0;
 	kfree(rm->atomic.op_notifier);
 
 	return ret;
