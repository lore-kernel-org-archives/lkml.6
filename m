Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1295708-1525092145-2-16803619324009656400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525092145; b=iGs6pMtZGojOtpoNHZqktSsgoa97RdaudygTbqDiwfz6A1Ghaw
    Yo0HSV3OMnY7oc6z3V5bBlYmxrMXceAJuTy+zFV+OEbwuJ0xL+raXjHK3v0U4kF6
    HwUWay6EukKB9C4KNhlT0cbf6Qbvwuao7etYYXuxo4J9ka6DjR17OI0F6DV21Uk2
    XZzO7OVKBHhOVbDJasDFycjgoTLA2+zxbeqKcQhjtTha+ysfKOfITJdzoOlON/+S
    yZQXXYHQGfxtiTQTNfEZDAdoYTxhQyUNH0Dg2lCa14isVxwwjRT+2E3r1T9pFk66
    OTCJM+3NbVUUyFQrFjEtWKHMpL9aVpN881Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525092145; bh=
    hEeKn1s6QcWOfbfjk4TyoWG+r/Dkeivc6+tXtd8lTjA=; b=JYJreLzhxY1m53wu
    5xQdX7+slFd7uxif+Tn+o3SGOpzdnItDu0LYWF+PgoahRz2cRfqsRSVFpYgl4tT2
    Dki9Wdmk2KfURcIJ1oauH7pBMtxWhZ/01rKj18AFywYyklWLFgB1Ux1FmmtphWcV
    xgtzXhGGUKW3J/rLjzgDaFwcj81yPSFJHM3bR1fqk9l/f+RLqZCRk8AP03up+qeC
    qls9PjMgHY9qkrbik9bbEcq4GBwzCgHuuPbqB1G6CrZQjsDj1fO+C+vdNGwaIdeF
    JUhjsw/RyNm+qYGy55DFw5mcAuuXF8NHCGemJ66iobeTB9Zda7r0YfhoYITVZtmw
    Jvv+Mg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFCehS1gC+J8fY6EslJcA/K9rGKQehUkFrS03wIuvSgnE0McfeGf5Jq6+DhqrDRUUAYgQiOsSgNIKEwRt3PwosoDRaiUZHDeXGzeFJ3SVDRsICeVvk5O
    JyBIdnFVj1BaAM+0DYxljzpOvj67HlfdAlIDz3UNMX1QakoEnZs/RGdr5rfXOVJlBO++Ys1GqcooTaTx1v/TX7BE7GOOls8i5UvIy+Ue/iq4ggMzfASa93oJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=SAZhHXHJRjwJFazc4IoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeD3MmK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 08:42:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:39224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753480AbeD3MmH (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 30 Apr 2018 08:42:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51127026"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 3/4] usb: typec: fusb302: Fix debugfs issue
Date: Mon, 30 Apr 2018 15:41:57 +0300
Message-Id: <20180430124158.45269-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removing the "fusb302" debugfs directory when unloading
the driver. That allows the driver to be loaded more then
ones.

This fixes an issue where the driver, if unloaded, can't be
re-loaded, as the "fusb302" debugfs directory already
exists. While here, removing useless condition when creating
the debugfs directory.

Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/fusb302/fusb302.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index eba6bb890b17..0e5d0aa052f5 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -218,11 +218,9 @@ static struct dentry *rootdir;
 static int fusb302_debugfs_init(struct fusb302_chip *chip)
 {
 	mutex_init(&chip->logbuffer_lock);
-	if (!rootdir) {
-		rootdir = debugfs_create_dir("fusb302", NULL);
-		if (!rootdir)
-			return -ENOMEM;
-	}
+	rootdir = debugfs_create_dir("fusb302", NULL);
+	if (!rootdir)
+		return -ENOMEM;
 
 	chip->dentry = debugfs_create_file(dev_name(chip->dev),
 					   S_IFREG | 0444, rootdir,
@@ -234,6 +232,7 @@ static int fusb302_debugfs_init(struct fusb302_chip *chip)
 static void fusb302_debugfs_exit(struct fusb302_chip *chip)
 {
 	debugfs_remove(chip->dentry);
+	debugfs_remove(rootdir);
 }
 
 #else
-- 
2.17.0

