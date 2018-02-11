Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323662-3-16839670453827975326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323662; b=VhUK0W7uScMgF9ZcP6BzSFcSxXitVeKOBzd4CeIRjH+X8ca
    Favbp9IXlWVM27bFKdrrP1cgnylyxFn4zRqu1ce3E7555rJvZlF2728GtnPEPfOn
    DJj/JpiZy7ctBfeD+C/Blmv7HahP8CPQsQEh1RlVrglgpcoxuUDREC0lzoLrMBDs
    6lVHNl3w2OUKm8RWnbJI5oR63Asq1+cLFsPaxU07xySajB/iRnWW71HKb58+g2N7
    VMt88fpBakyfeSUuUUdXPDgCgln2M8ObgGddMyhPENK5dOzZt1UGNUFhpAXhv0mi
    Q6MnvZOniA/eOzvAmDXpvGcIpi+DHaQueszNj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323662; bh=G+Jql89xNjY+T0Z17rY
    uf5fxmDFM1tZZqMvZ785kIYg=; b=r9gsxWWf110AeR3zMH2eK957AJ5MHNayquW
    52TCFEDmwTItfp6ZgIEV6waMTEdc+FwaGQ9b8wObJFvt1ox41nQzC2sYA/lDe9Q+
    7jO3CY8uvHz+9VeOffRQgCaxZbgDuBFJa0zXP5007o6snFAadETlPE1WYsAWLj9u
    W3jfi/HMJq0NywWdlzy1F/NGuCUVsRFjYtKAbi/QjFCaSJxnswz0Etlhqv8RJg8W
    T+fseyE/3dV86MdjYcWk8JA+2FNXVM8okfJyrpc3dHJZx+yrDb1QWLXNtnGq6Bpy
    pGzDUABZWjYItv12SFi/v9CPaeZdqkuCPL/wyWCHeJHSjx90O1w==
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
        id S1753024AbeBKEeS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:34:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41664 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752924AbeBKEeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.930109718@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 023/136] scsi: bfa: integer overflow in debugfs
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 3e351275655d3c84dc28abf170def9786db5176d upstream.

We could allocate less memory than intended because we do:

	bfad->regdata = kzalloc(len << 2, GFP_KERNEL);

The shift can overflow leading to a crash.  This is debugfs code so the
impact is very small.  I fixed the network version of this in March with
commit 13e2d5187f6b ("bna: integer overflow bug in debugfs").

Fixes: ab2a9ba189e8 ("[SCSI] bfa: add debugfs support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/bfa/bfad_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -254,7 +254,8 @@ bfad_debugfs_write_regrd(struct file *fi
 	struct bfad_s *bfad = port->bfad;
 	struct bfa_s *bfa = &bfad->bfa;
 	struct bfa_ioc_s *ioc = &bfa->ioc;
-	int addr, len, rc, i;
+	int addr, rc, i;
+	u32 len;
 	u32 *regbuf;
 	void __iomem *rb, *reg_addr;
 	unsigned long flags;
@@ -274,7 +275,7 @@ bfad_debugfs_write_regrd(struct file *fi
 	}
 
 	rc = sscanf(kern_buf, "%x:%x", &addr, &len);
-	if (rc < 2) {
+	if (rc < 2 || len > (UINT_MAX >> 2)) {
 		printk(KERN_INFO
 			"bfad[%d]: %s failed to read user buf\n",
 			bfad->inst_no, __func__);
