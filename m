Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-218913-1527086319-2-9526959886684666822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
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
    1527086318; b=VMJu+0jkY7b2d1HvuP4M7NRIPV7UoYNvJBY8GFUgthNXQ/dqyg
    XeD/4hyZztesmyHPBDJpp/AoJiE0/RvHMDIMFTP4GcQwxA1bGN5ALEzSfTdr72dF
    PTq3Rdpo4DpQv6+645sbVgcT2OGj0IkHQ88GhnzGUO9bSyOpE3c56DrFhPSUDv6c
    3OYqVuSX24tkrpdWdmlDpBNaTUsUBEA6VCYzlvkwYLMiAKq1wZPGnC3danPfNfQS
    iux5hg30iQsqGzop4+II0NGFIV3eeRlXrhLMYnyEfVATcLBfUCU/X+3pUqLWAA31
    m2T+AXhEc2Emb9JNeyv6+6GT6grYHF7Q+Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527086318; bh=
    BCPuSs88YIVdoVCmxAWrjSI5PSv0nrSbF6L+UB/KhJc=; b=b7P+965H7L8HK8T9
    ZOEaNyAPwcqIjZ7m8zSoFrw/6MgQiLqNONx8xZuGcr8UdX2i1xzW7WPWl810L4m6
    xi5VjtzBjmW7zREbnu0yunVSeACnITvPSXNr0JspJiEqzRaQxhA7bH7FNlN9au8w
    X1Q5VfsoljuOXr2TPv2hhEleBZnM7aYBBz4QpAlGocyyfyBM0rKuIxfD5IfuCgu0
    YcIg4yEtZqK52fdynqhLIgeBx1H/y0K6PHw3pytUK7CzPC4FfjIyAwEaGcaKPlg7
    EqNWu+1S7wEQC4C9oDE0PyAvDAnhbXCL1io6jPStCYdthfo3D0FTwJZ3Fdx+f7wg
    K5Wx1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfA0JtPmsPK0MbbiMhCEecshf+/wFO7pmZ91M9QPdNavU7zYJnhobQP1mVfeLsBVTM/HNSDzWHwGdNephCxDPpNq2DZ33TmZzXZhN2fOOSS1CM/xhE9Z4
    /lSZl5GEDZ7TKXzPq8fakMt+XSSUEulFUTgZk552jWiKotPvv1jfRwGnBDUP2+GPuWyKcYqV2QDlMAGIt+5AC7yfHTL7GYB3brlVkgJmQUdip1rIejbVarFw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=SAZhHXHJRjwJFazc4IoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeEWOiM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 10:38:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:29020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933321AbeEWOiK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 10:38:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="57815050"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 3/3] usb: typec: fusb302: Fix debugfs issue
Date: Wed, 23 May 2018 17:37:58 +0300
Message-Id: <20180523143758.66348-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Removing the "fusb302" debugfs directory when unloading
the driver. That allows the driver to be loaded more then
ones. The directory will not get actually removed until it
is empty, so only after the last instance has been removed.

This fixes an issue where the driver can't be re-loaded if
it has been unloaded as the "fusb302" debugfs directory
already exists.

Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

