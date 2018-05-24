Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602388-1527149941-2-5514457041771915384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527149940; b=jzTNhL2AZOLCAmH0KzRwhOaqQEss6bCLu3mLEmb6HpWPqX0q08
    dLYLxdMEYzUA6waceUcChKpW5WXh2xvzCZ1Z1Mi2X+BjmfxVnLf7tO3DywzJHpER
    0L7K2YSlii9WmYUObRfBiRhsi1XCdew48P1qWWiZN8dxJI8wqqjuPnbv/36Qw7Ek
    u9X8EEP4ow5u/65Ef01LbKf4wViDYn0yBsI2ZkUUD7NZMhCeFxbwB60+mZ7fGyc7
    h5V4LLj8AIUS9wn+e+t+ZFGWJMrezvIpp/6jNz5m6Op5jRczj8RsUWbr9RU9mJF6
    ef5QqflT0jB/CiBNdMZBchIM45h4F2No4ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527149940; bh=
    WOYf8H386ls/kqWZZX/ebLFuCUzkJomjAZ4Y90j+B/4=; b=cro9qRgQ9xQabaEu
    aVKeRiKKd6840YRA8OqfuXYjUqzfE7miMmaer01Iwu0vgvlJIJKpyURlgnn8IXAG
    M86CKdHIjTY96Pmj0j/i9YdHi2kspDYJGxIIBEh9dAVBZ6A44zPfg8TOK1OflHv4
    HFuYvIn5MhrULYZROvXZA1WrvkCQyUvWlXzk5eDihHIew8y9lvmCWy+CdZCIy3Hl
    gF+1KP/MNHHOUGbY+6BqA2Q3utk1szwSniENXAqvSisje+e+boTFK0Y8QajeaSFi
    1kSmwk6ZoEW/P+wQJmqN6fLkW6p24s2vMDOgFm73gthum3O4beuk4Ztek6n+uT0K
    31Sw1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVt7yIYs/jGCl3l+nM+Uy7yq+puHHL1w387zQnSCCO22A5K/iOvVi2fgNnDnGpXZpmTBzZB2TmWECy+WRuIc+EHUD7cvTZeyJ+UMlPJB3cPb7myZh0C
    mQwI1z5zFRnWLeCet/+zjhBAuzEody1+YER2mel+OybwryQ2nICR8dYg46skYLTbkCNw2khrbLFm8XYaLR+ye9rf6j8ZGeyFECiu1ajGLpSDsx+fdwf4mFcN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=SAZhHXHJRjwJFazc4IoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbeEXISl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 04:18:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:65277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965244AbeEXISi (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 24 May 2018 04:18:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58073604"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 3/4] usb: typec: fusb302: Fix debugfs issue
Date: Thu, 24 May 2018 11:18:26 +0300
Message-Id: <20180524081827.37861-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
References: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removing the "fusb302" debugfs directory when unloading
the driver. That allows the driver to be loaded more then
one time. The directory will not get actually removed until
it is empty, so only after the last instance has been
removed.

This fixes an issue where the driver can't be re-loaded if
it has been unloaded as the "fusb302" debugfs directory
already exists.

Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/fusb302/fusb302.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index eba6bb890b17..9c1eba9ea004 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -234,6 +234,7 @@ static int fusb302_debugfs_init(struct fusb302_chip *chip)
 static void fusb302_debugfs_exit(struct fusb302_chip *chip)
 {
 	debugfs_remove(chip->dentry);
+	debugfs_remove(rootdir);
 }
 
 #else
-- 
2.17.0

