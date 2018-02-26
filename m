Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676363-2-13559410614798671325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676362; b=Bs2XATmmnfH2tX8Lrk6ucElXE0zMwHXk65TMqVRa9gj+IEc
    ZVidpLqL6L5vpySawuOkWeavEyl2DATp/KLtYmMZmU1c7BgKycpFf6NZW+vQkIvV
    st/Bh+/MC4XL6iC9QNap4VFgTbVVOnRRkD5S+ULYhNLXh4n61ze/Zhniw3SfM4Fl
    ykIN0LTz1csRpnEBAYnlHLLbF+NOx6KK/nD8LPYYA2XpDy8GZ4HM6ZPZ+oa6HMj6
    DBDd4ODW0on1F20y4i4sxXqskPZJG9pZDYAIvrr7GwQGr1lEtDSohVQhV+HNm+QR
    UiCDBZPZGeAU7v9CcYk76o9RDHy1CO8CWdwcFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676362; bh=DLxHQpBJpiX6bCCQyzPqIeY5Pg
    pIEhDq1ZR570Ed0Kk=; b=h/i7sPRFGs/YdB9ivcVdSX9fLqIxaelX5kRIeAC3pf
    9f52dNEZ6M66tHlCHQ/sqCKCIVYpbeSi1CAmbxqDcrt9NXXlwxCbawABvpSFr0cv
    BYBfe3zD/LYFD8eeHozZZnW1qIUnOW5OpYV+MtHFHBLbE9tZ5ntsj4RBcGlhJaYW
    m7YvYdKM0SbWMOqUmaTq5IUGTsy9o+autkBC3l9YfA0v4Q98i6LlI6/GTYwVhE6C
    DDv3pYSVWib8yT16UZXPqEcblA3Y9W8haWwYAuv/JdGKo/lkH3KP7vzQZvMnU3kk
    qSf45/9/zCskXFlciRE8cST4tkyv1yOX7KbevDbmCU9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeBZURT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZURS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.4 03/22] PCI: keystone: Fix interrupt-controller-node lookup
Date: Mon, 26 Feb 2018 21:16:03 +0100
Message-Id: <20180226201558.873205932@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit eac56aa3bc8af3d9b9850345d0f2da9d83529134 upstream.

Fix child-node lookup during initialisation which was using the wrong
OF-helper and ended up searching the whole device tree depth-first
starting at the parent rather than just matching on its children.

To make things worse, the parent pci node could end up being prematurely
freed as of_find_node_by_name() drops a reference to its first argument.
Any matching child interrupt-controller node was also leaked.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Cc: stable <stable@vger.kernel.org>     # 3.18
Acked-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
[lorenzo.pieralisi@arm.com: updated commit subject]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
[johan: backport to 4.4]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-keystone.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -179,14 +179,16 @@ static int ks_pcie_get_irq_controller_in
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		goto out;
 	}
 	temp = of_irq_count(*np_temp);
-	if (!temp)
+	if (!temp) {
+		of_node_put(*np_temp);
 		goto out;
+	}
 	if (temp > max_host_irqs)
 		dev_warn(dev, "Too many %s interrupts defined %u\n",
 			(legacy ? "legacy" : "MSI"), temp);
@@ -200,6 +202,9 @@ static int ks_pcie_get_irq_controller_in
 		if (!host_irqs[temp])
 			break;
 	}
+
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		ret = 0;
