Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323629-2-14153517198352843717
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
    t=1518323629; b=s7EmCYmJAXrAsMWZod2LnAjPioTFIw9z4b/54njzclH+bdm
    9oJzFRLc77BkLhpYybajl0HBvWxr/XVVVWBImEeOpbfezMB7X3o8GkGIAnBgaonO
    O/FHL9PUJgI1gPyVU/GwBtdzFsW1wcJQVUKbJII6MA53S9cXMnCTdh5sbM8Gv7kJ
    157fwhn2M/nRkIZtD8Vh/WENf4i/IvSU0XfREYkEzv941QCpCYTom+sod0KW3SQ5
    AJdbtDCChkDJHjxlVFO8CuRI+uGFxeKT3H1PuAvfTqbjayCXJjDPPL6UhkN+d3u/
    GiRWW6Af9V57olyxu71s/Ncq/v5caSR+ThXt4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323629; bh=oX4Vc7W/kYIjjJ3er91
    MHn4/+9Iw25zj+dc2raWRqFQ=; b=h4TwLCs6fRlEyeLhZrVHWsd80juZLv495EU
    owxBTgg9GbGCQkE+MRKXVedvxBNiwjxuoAXP8R2MWWAqwhdruKrVAlHdx/W1MaTP
    HYgpqHnnXxH5Zz8KAb8yVaEcoFZDzDeOJFvq1VEAFWL5m56rAoh2yFuCu7uT7/0N
    1BfK0pZWhGq3Phb0ZOkgLhcfVlyDnOGRFZ3IV1Bfiy0KdGuhyS6wZWXmqzcaqYv6
    ZtRVExmxs0GoC+pAiF5JcYiCQ00ZD7+6EpxXhE57xaNR7ydLFISjvStyDHK0ZJuU
    DZxQhgDfTssyo5bJ/2iRjLgsKAJDuqqt3Q/NcPnimYXFPxATiPg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBKEdn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:33:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41324 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752465AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.863275890@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 09/79] scsi: bfa: integer overflow in debugfs
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -276,7 +276,8 @@ bfad_debugfs_write_regrd(struct file *fi
 	struct bfad_s *bfad = port->bfad;
 	struct bfa_s *bfa = &bfad->bfa;
 	struct bfa_ioc_s *ioc = &bfa->ioc;
-	int addr, len, rc, i;
+	int addr, rc, i;
+	u32 len;
 	u32 *regbuf;
 	void __iomem *rb, *reg_addr;
 	unsigned long flags;
@@ -296,7 +297,7 @@ bfad_debugfs_write_regrd(struct file *fi
 	}
 
 	rc = sscanf(kern_buf, "%x:%x", &addr, &len);
-	if (rc < 2) {
+	if (rc < 2 || len > (UINT_MAX >> 2)) {
 		printk(KERN_INFO
 			"bfad[%d]: %s failed to read user buf\n",
 			bfad->inst_no, __func__);
