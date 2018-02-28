Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-420878-1519831514-2-1606097346973617422
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
    t=1519831514; b=OjDqc7AdS5A7jxSXnGxF1NignPDQgRdmhAAy5jQISXLfhJR
    sxJkTZ2S6/5/tcCQx9/bO7ugRBSUhFyOhy1ZTR1K0HBDXaqX8YtNl1s5xcrF3kq0
    0L1Y6J7XHELp4nzzX+jmBNrj2NfFTCBRHViLs/1T5MrdSMYKYkCnDiEDwicKPQqh
    0J9JvHCY28TZA/tUlthfvK7P8pQjOfBTdHLTB9/ShTmLOkOh8D4FcPl4zMgL86oi
    nzQxuPgINg/J5eiE14E27Gu1HVpx4+v0KnjuElqaxJld8TP/yOeQGINncNWyUI28
    aEASly1q8OJwCxYZ+m/TO2jkFLQPwKCt6hqJ2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831514; bh=GEKXjZmassIul/RfchI
    bG5sez6ULpvEcpYxIoGdCp2E=; b=EvJ3tkKDppAfe/mdarngxJGJZ9iB9B1NvsN
    yHSm8SxHnX9Ih0YPloRD2k1rw4lRNwZttd9IHiL08uoup7RW1J4SP5DNs5nLAjzM
    08Grb4xk49oeP0LlRuCWjN47+Yy+JYmfMLiDvTW9HZJVuL2I+EwzhImstlfX4XLS
    WDvgM9jxQLOMQQHFic3IdtjkuwZ3bIkSkxe4pLSjTABxD3ob2qhaQhNtc1dOmruu
    GbE0hCEC8JkzFhYwz2r7v/b/BGNuvUeyeJWivJ6ri5YPhsewgbnejDx0ADIeKdw2
    CWqUfmdOmUVtB2o2nlHF9D/wofKNr76tYcPma3C3WrjLkRPT6gw==
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
        id S932828AbeB1PYJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:24:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33400 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752887AbeB1PWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Maarten Lankhorst" <dev@mblankhorst.nl>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.196894121@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 050/140] PCI / PM: Force devices to D0 in
 pci_pm_thaw_noirq()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

commit 5839ee7389e893a31e4e3c9cf17b50d14103c902 upstream.

It is incorrect to call pci_restore_state() for devices in low-power
states (D1-D3), as that involves the restoration of MSI setup which
requires MMIO to be operational and that is only the case in D0.

However, pci_pm_thaw_noirq() may do that if the driver's "freeze"
callbacks put the device into a low-power state, so fix it by making
it force devices into D0 via pci_set_power_state() instead of trying
to "update" their power state which is pointless.

Fixes: e60514bd4485 (PCI/PM: Restore the status of PCI devices across hibernation)
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Maarten Lankhorst <dev@mblankhorst.nl>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Maarten Lankhorst <dev@mblankhorst.nl>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/pci-driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -872,7 +872,12 @@ static int pci_pm_thaw_noirq(struct devi
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
-	pci_update_current_state(pci_dev, PCI_D0);
+	/*
+	 * pci_restore_state() requires the device to be in D0 (because of MSI
+	 * restoration among other things), so force it into D0 in case the
+	 * driver's "freeze" callbacks put it into a low-power state directly.
+	 */
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 	if (drv && drv->pm && drv->pm->thaw_noirq)
