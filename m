Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837908-2-8224736345821329788
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
    t=1519837907; b=VNLwlt9kB0ax2R5UmHSJwv80NY+LeFea1Mz32XxU6eAgj4c
    Qmx9wqwpsUX1JAMcgdpQBYSVJ/dlVf30ZnZoLhVHediZmHRK88X5c6jUYiWIxNhl
    c9E2MWkKlPI2S5PD/Mj22gH40LsXYum33Mm1PgLCUMXvG+omnhbo8dlKmK+FMxWl
    81pVUHZYIOJxHuadT57NvQ6TVl8xyHmlutRGWFp5HeGysmLoBXmTZF9uMIleeo0M
    sEVo2qfHIdDsdtiZBZCf8/FjDPAA2wTc11TIZeTW/KJR78lnW6DY1ku2GZFW6MQ5
    574bURlM9YLuk4lmsU9qkiYV7DqI5eU3TLNC7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837907; bh=cNlXGYOR6ycqjetGvv5
    skkCsSISIcEaCxM5+RJyphZ8=; b=nRUwVibp0+PPxyxmZ3YFmrBkIXQvFOcj8y3
    /RhVl0z3znwwehwHcdFUTBB88a9MWKxBDQG5BU6xLNevwtVsaaUYA8Lk3mwmd8lW
    4xQv/Coq9sFE6jGdhKYXbhvmPVBdeobN7lvt2yukQlK94V5khIvNH8uKlXaruNGP
    XrdHl2//zJXtZ2gIXJQ+z2yQYp9m8h8LJ4mxlU0w3+AztOtAZPc96dq2XKb/GUPW
    TKTGEwVVWsZjsjQmGHqNpAf24RPBipkGReKsq8EEnXwHeiWP7RpsKgU4Pr/P0W78
    peU0E53hB4gH0U5kzTaA0H2k9AwYqQdJ57RT8hz3gIK3rtzevZA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeB1RKs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:10:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34292 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933279AbeB1Pt5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:49:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wolfram Sang" <wsa@the-dreams.de>,
        "Lixin Wang" <alan.1.wang@nokia-sbell.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.548185190@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 216/254] i2c: core: decrease reference count of
 device node in i2c_unregister_device
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

From: Lixin Wang <alan.1.wang@nokia-sbell.com>

commit e0638fa400eaccf9fa8060f67140264c4e276552 upstream.

Reference count of device node was increased in of_i2c_register_device,
but without decreasing it in i2c_unregister_device. Then the added
device node will never be released. Fix this by adding the of_node_put.

Signed-off-by: Lixin Wang <alan.1.wang@nokia-sbell.com>
Tested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/i2c/i2c-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -740,6 +740,10 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
+	if (client->dev.of_node) {
+		of_node_put(client->dev.of_node);
+	}
+
 	device_unregister(&client->dev);
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
