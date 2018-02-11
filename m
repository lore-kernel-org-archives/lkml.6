Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326457-2-13569598661680671095
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
    t=1518326456; b=Xd1CiIzGk7H0GNXBTz/RrLwOpH4Czyv5sbJkomjCXAOug0j
    3nWAo6OIPYgOIzzNkULhxWXjAy6JkPD/bc5DkzCrwoIWr4a/S0EKepxFfDbPCXOs
    ym5KtU+bDTjNjm0HLJkUXIqa1PmG001Zqpqc52hF2csF05AJjG2wOWlOr3Djp9sO
    La4uujFsyT9xtA3uIU71++w/kM2Y5jvRTdd9r4PxxLqD97wLyqdvHqRb8Y/ozoeZ
    AKPS4xh4NgnFaDgDjGWOzJqvydJtf6n2vaVGgNymk9xwyWy/EXDeMQq5c43ZyDTv
    HxH+QNHL3Du4miLOOd/3ahUSoaYb2Cv5+xeoRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326456; bh=0Zww8DfJHA9YJRIyzoy
    t3UrxtrGfslRRrL5Iw5ayIGk=; b=rl9XFAbjAC5RHmM3/G4rfkdFCxjgQYNWn6o
    t/eQ7Iq2mZudivHwATzfqtFOlY/n82puoKFucdIsmIERIvJ0CQSv7PtdeVo6YJcW
    mzlyeAYxYt3hDCPzVdrIWhUFLeWZXqWl57YbTmA6yBSXRihjBaT9fl9WD26/cUdL
    WdIxFbb/NBIv+cxPWdOZ5zkLp6G8so9h1mJuwg6imaJwzg7MunATXri5CGcLcZaL
    QN6MO/bxeJ2yjfkZZs8n0QEpVjtmCleWsakz1mwN/jeiId6MLTCTjzBdJTw3FUDu
    GzPY47U2jVALpTl7pCFT1zhpfc3U3d8nyuZsnaOFFuJu2OLRrtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeBKFUj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:20:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932073AbeBKFSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "Bart Van Assche" <bart.vanassche@wdc.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.720056277@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 024/136] IB/srpt: Do not accept invalid initiator
 port names
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

From: Bart Van Assche <bart.vanassche@wdc.com>

commit c70ca38960399a63d5c048b7b700612ea321d17e upstream.

Make srpt_parse_i_port_id() return a negative value if hex2bin()
fails.

Fixes: commit a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3521,7 +3521,7 @@ static int srpt_parse_i_port_id(u8 i_por
 {
 	const char *p;
 	unsigned len, count, leading_zero_bytes;
-	int ret, rc;
+	int ret;
 
 	p = name;
 	if (strnicmp(p, "0x", 2) == 0)
@@ -3533,10 +3533,9 @@ static int srpt_parse_i_port_id(u8 i_por
 	count = min(len / 2, 16U);
 	leading_zero_bytes = 16 - count;
 	memset(i_port_id, 0, leading_zero_bytes);
-	rc = hex2bin(i_port_id + leading_zero_bytes, p, count);
-	if (rc < 0)
-		pr_debug("hex2bin failed for srpt_parse_i_port_id: %d\n", rc);
-	ret = 0;
+	ret = hex2bin(i_port_id + leading_zero_bytes, p, count);
+	if (ret < 0)
+		pr_debug("hex2bin failed for srpt_parse_i_port_id: %d\n", ret);
 out:
 	return ret;
 }
