Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323939-2-705294328451080097
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
    t=1518323938; b=L87oGS/hhqiFdeLBJ+wZ9hDwUZYyGm9Zra4RdRLnm9JJsaT
    Dtdkh7A/qpQTv3vSrZuw5ldIYKUvAWVq8+9yjFTGqRP6eHXsvrnMBCFvvbZPaJHA
    MREvvYWC5l7lsM9VoaUSnKTCQwFJOoTYh4o76SJhE/P9QzW4EfdIQiwNMlGjuQ/G
    /FdgNQOFkPIIr67T6UijScbKX3hznq5NhfhB6v//vHljeYNnQgkS3KkCoq4vyXx+
    2zmgiD6wUC8qF5d7aLqZbiKVeMtZ2ojalh2fQNRFqbVo72wGcF4ZqFSBbaICYPbn
    TbJf0qXs4aR1JTywhXOflE+yU6yd+T25i2sutIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323938; bh=GOa+KqMCb94qrHVX9V6
    0XMWL2az0J/ZzxlHsA92QA1E=; b=PHWuC8pWZZE0a0YCwDYiSoh8yihGuLV8drI
    PNraigkn76wbeslziphrfS2rJZVO6diR5pjZL0trOoGQ9YXEV1p8x3YhDq9rjyFp
    G+OmEZT/ro17f16GHPz6rN+9RtUoIOuYqG3Ux3V56USQGcH1so+kU1iiz5RNR2oo
    Z0kFGwVH9YC3LEraw98SQM9QHJwc9tLxI+eqFEc/PiKofsP9BeaO2UYoFyUvYWca
    6RqAjq24Yu42R7hXWslXGYYZdo7uGTS2kf8VNpVFWmh1hub2jPfk9daeCo/hnAy5
    IujxIVO34wupUyg0haAb28mvIpo2AyCV2zaepkxrPNtpnX0I/eg==
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
        id S1753110AbeBKEiz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41724 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752965AbeBKEeK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Samuel Ortiz" <sameo@linux.intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Johan Hovold" <johan@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.417437717@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/136] NFC: fix device-allocation error return
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

From: Johan Hovold <johan@kernel.org>

commit c45e3e4c5b134b081e8af362109905427967eb19 upstream.

A recent change fixing NFC device allocation itself introduced an
error-handling bug by returning an error pointer in case device-id
allocation failed. This is clearly broken as the callers still expected
NULL to be returned on errors as detected by Dan's static checker.

Fix this up by returning NULL in the event that we've run out of memory
when allocating a new device id.

Note that the offending commit is marked for stable (3.8) so this fix
needs to be backported along with it.

Fixes: 20777bc57c34 ("NFC: fix broken device allocation")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/nfc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1074,7 +1074,7 @@ struct nfc_dev *nfc_allocate_device(stru
 err_free_dev:
 	kfree(dev);
 
-	return ERR_PTR(rc);
+	return NULL;
 }
 EXPORT_SYMBOL(nfc_allocate_device);
 
