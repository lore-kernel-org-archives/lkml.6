Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806842-2-15033171291477056661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806841; b=X3K/xvoUNIRYxq5YVk+SWtBuKX1U/bmcc/n1GkQU8zRIwtF
    iA42mg1iDsfYdrknokUjafv3Dpbvu79ZUlQ0Yql+teDzvUnQwC7exd5MHlKXqqBJ
    f+SX6CkNm6/YZTqRKfuW5EqpQf15VeVKOePUN2dgROqgQpJbB7Y8R7u2Awfk0sb4
    sceTzUfFmrxTBB86V0qL/sVPVvH7cL2QD4tC0po/C1LDcStDPtVlkVT5XCc/ZxHr
    CrY0X+Wz4M9rRJIUAicWOto87WVUE4g055MhlI2gjBlJZO2YUz3yL4J/OznpvOdY
    gVG8HEWrIzZRfluGzByP7FKCjF08ZpvVWyksGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806841; bh=C1WkGMcSFwfwfvG+x2jFpykGcF
    w0eO9ClizfoaKEUMQ=; b=xDNo1PZY8VhH9t8aaSaw0yLQnlNzUnyOzIRQeckWu3
    k3CDMkKAHf1DPKtaaujnjUS7z+Zp0v74CD0Zd99TAmnHjezAw6epL6ue6zWtv0gN
    +SwJmr51OSi+GaNtQjcuP8XyWhHherdJIfA7fTAyCsYPU3o/OWSZ1G6iWxdUgoSA
    unNniiCekerG64u4/dczjUUKBTGXwxFpV6h13g2g7w4gdhs+OxgHb1q7UBsTaEHe
    5Egr7bLz+FAxv3sJyxYRTVTmepGKvL3E1lpdZpUfDCOY6XrjIE69tyl5iIptn7Jf
    B6bV33I9zLJ/mkNxJvEF0BkhzD1Wqp3pBPJjxaFt5JmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeCWMHE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:07:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeCWJ6u (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 53/84] PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
Date: Fri, 23 Mar 2018 10:54:07 +0100
Message-Id: <20180323095419.997389319@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 83c75ddd816e979802bd244ad494139f28152921 ]

rcar_pcie_parse_request_of_pci_ranges() can fail and return an error
code, but this is not checked nor handled.

Fix this by adding the missing error handling.

Fixes: 5d2917d469faab72 ("PCI: rcar: Convert to DT resource parsing API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pcie-rcar.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1123,7 +1123,9 @@ static int rcar_pcie_probe(struct platfo
 
 	INIT_LIST_HEAD(&pcie->resources);
 
-	rcar_pcie_parse_request_of_pci_ranges(pcie);
+	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
+	if (err)
+		goto err_free_bridge;
 
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
@@ -1178,6 +1180,7 @@ err_pm_disable:
 
 err_free_resource_list:
 	pci_free_resource_list(&pcie->resources);
+err_free_bridge:
 	pci_free_host_bridge(bridge);
 
 	return err;
