Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325126-2-6409374325145141102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325126; b=CiEp2ZxyK1HXiZrFexO11Hu/yctlv2TN4qiuzVGoDD6KZ5A
    yjRBrf0GgS4VlRYP5BvxvJ3quOfE3JrTs0Y1rA3Je0fHdak5iFxP4vK+UpJJRnCd
    HxJFeQunUESLKfNC3cmkv9JqGsBP4jdh2UygJ8lstpudH/+kSJh8hJVrnZtRZhfU
    JUFXaKFCcw5a2y7r+D/CIF+vBnFTdkHwkW6dFX1G2IMTWfGsbTIKn3wKZlnbOL1Y
    f7vpT1T0sUlkHmC1cu+ejj/E+uWScU1YH3LdGadsW7vJzTa7EtJK77UilAJAGapO
    8vDWUaFkw0ZQ6u9wEawPKeu9SX8d42it/OrNUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325126; bh=YGsgAf2g9eN4QQBJJDO
    S0gQ7oJgQGgXfDC3kc/F3KkA=; b=Nk7TsZhIO0b1hq7IPSMKC2wkL/6Q1pHEbma
    5BQPK6kgL4e2a1q2q97C0kTBWmcSJ7B9Uznd7yg0FoWgF8u29Jhi++AxwbKtBTC1
    OKrqH1RHAKS2uS+61VbjBnyAWa0tsgye8gYNg7Z8VgJd5DcpfosOPfX0Gzsk/MnD
    GCha4mVe3nO9SGUYTubAwl2M92z1rNQe/SIYsnbGoAS5jN08j2IcygejqX9RDbYg
    bB0wbnUu93pvvjkjbtlHuvDcp9msJJIwqIVZIkngeOtkxjReQ3yoDq3SYkrGPgw3
    +NtYlTpH0y22cXNEzAD8ya9H+TnkZrSZ1l4fL3LD6biUBcLwBuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeBKE6D (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41692 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752792AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Kiszka" <jan.kiszka@siemens.com>,
        "Joerg Roedel" <jroedel@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.515458875@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 011/136] iommu/vt-d: Don't register bus-notifier
 under dmar_global_lock
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

From: Joerg Roedel <jroedel@suse.de>

commit ec154bf56b276a0bb36079a5d22a267b5f417801 upstream.

The notifier function will take the dmar_global_lock too, so
lockdep complains about inverse locking order when the
notifier is registered under the dmar_global_lock.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 59ce0515cdaf ('iommu/vt-d: Update DRHD/RMRR/ATSR device scope caches when PCI hotplug happens')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iommu/dmar.c        |  7 +++++--
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 include/linux/dmar.h        |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -718,13 +718,16 @@ int __init dmar_dev_scope_init(void)
 				dmar_free_pci_notify_info(info);
 			}
 		}
-
-		bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 	}
 
 	return dmar_dev_scope_status;
 }
 
+void dmar_register_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
+}
+
 
 int __init dmar_table_init(void)
 {
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4044,6 +4044,16 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+	up_write(&dmar_global_lock);
+
+	/*
+	 * The bus notifier takes the dmar_global_lock, so lockdep will
+	 * complain later when we register it under the lock.
+	 */
+	dmar_register_bus_notifier();
+
+	down_write(&dmar_global_lock);
+
 	if (no_iommu || dmar_disabled)
 		goto out_free_dmar;
 
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -100,6 +100,7 @@ static inline bool dmar_rcu_check(void)
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
+extern void dmar_register_bus_notifier(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
