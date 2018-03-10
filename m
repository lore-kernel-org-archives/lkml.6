Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3497703-1520698625-2-5727651569925437078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520698625; b=AjjtmBHjvXgQmBQzrb4pxXBh3agWLnUYwwCoeL7VsaKQiUR
    GGrN0F1cBz+ye6OVLV21UWmigc03nLch6xokZ9bV5kXU4HokIEUSrF+aloM60BiJ
    uzqLfCh9WgEDocTJmYIz92Mvdaf+ZwJ0klTxyLkvirnwiWg8sAULN2Pf/em1Dsin
    Jq8cpY4vHp0mNYSFG7OvF1PzDRXF8HM8XY2EYRAOtFYxq/eJ9VFwrytpbujeaYWR
    qCj3X+c/QfG7db6eXdalBQSBUxBywKCafiOdC8S8/yalCUBVeh2dK8ozZMf8G8dC
    R7PD8Eh/gt30mc18q4eVT8aOHWENsXoA31ie0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520698625; bh=a6wl7iM96kC9zgFPbHCqm9hSNF
    Gfx7S0lVpqmsX/5M8=; b=u53t31xULbzgQrgmwiL3Jo0+XTloEsLwSrS3ee5hHg
    68B/7jQoTBI94fKixgwjOl5cM6KvCJT5N0N7jynvGMA5ORl8NMD3UGBghhkXZRnQ
    OA0Fqtcpql++HrR8K5ZunXvQNkI9lW94sd80F14XCwsB+30REJZSXnxtNvZWrDUX
    1FwX8T397vLs07RmG4B05uLQ+yaC8XdzWN4HXsndMaq/CwLWem+iN2bKk52GPJJs
    StmsHFzfzt+0F0hkfHV0BcoaLShcVfIosushoHkhfT0vXYSCEJFRHTr3TjZORruX
    oKuM7A/LBUNZWKoBTE6uAnjsWy7UFBH8v6+bTkEmDpuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeCJQQt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 11:16:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:3557 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQQr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Mar 2018 11:16:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="scan'208";a="40832262"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: allow TCPA log area to be empty
Date: Sat, 10 Mar 2018 18:16:37 +0200
Message-Id: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

TCPA log are can be empty when the TPM is disabled. This commit changes the
behavior of tpm_read_log_acpi() to return successfully in this case.

Cc: stable@vger.kernel.org
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_eventlog_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_acpi.c b/drivers/char/tpm/tpm_eventlog_acpi.c
index 66f19e93c216..f5f66dcd6f30 100644
--- a/drivers/char/tpm/tpm_eventlog_acpi.c
+++ b/drivers/char/tpm/tpm_eventlog_acpi.c
@@ -84,8 +84,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		break;
 	}
 	if (!len) {
-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
-		return -EIO;
+		dev_info(&chip->dev, "TCPA log area is empty\n");
+		return 0;
 	}
 
 	/* malloc EventLog space */
-- 
2.15.1
