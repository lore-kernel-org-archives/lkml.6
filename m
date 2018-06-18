Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6541C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9493020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/LF7gqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9493020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeFRQHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:07:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40120 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeFRQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:07:43 -0400
Received: by mail-oi0-f67.google.com with SMTP id f79-v6so15316103oib.7;
        Mon, 18 Jun 2018 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LwqPkrRKSHLwplVPk+u6CH4dMZuWTpW7aOKATQl5uU8=;
        b=B/LF7gqKhJz+vYw8j7QjpA0wbR7whWaSYnl+oDWqaW0c5QDT2IelU75fNLGByU6hUX
         Gg9AbqgNQVobmcBVeDSOBsq2U6iaFydm74ufa8kGq6u0BI2mmnqmW4pdXbmRa9WOuchF
         x+ri1K/IizdEMjJfaL2IKVsckeApVeg5lXqclTktECakjB92waaLFg6C7SqSt1OJ7GIB
         5aSoLDcgPx/Nu0q6B3T3QKT+iZX0p2/BJ56D7OL7f9eYcWMjuopTnVi2SHDF5KYjJ0xz
         dtK0MHySmutzCPbaxzyM5ds3Q3Ohh79NXESCqRXFFBVgfn7rqp4+WdtRbjAm7dSR6Pbw
         dWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LwqPkrRKSHLwplVPk+u6CH4dMZuWTpW7aOKATQl5uU8=;
        b=G+6RrM45N4cYhJRKgbusDmtgMqIzyFC6fJxhH+aHJII2XkUkHlbGntKge97WwkyiSq
         TrhC+VYoMnH29bAEDgjbdwP/Su71JBjwli2raMX1BMRAXEfijpyp/6M/O/G4oUx5G7dJ
         VKQOBok8/OTidWJ/6K1zU2gigiBPFDQn6AHTJObgoREr1+itaP/CZ30AUDV0GjmbIBpj
         Ff5ixcKASZu082NPuJ6TP2NzPM68OuuOV03yzAoBwBEwM3tYLEOMQlA/I0B8nXbE6w6C
         +sZ44u8iIZW7SUpjuv/kMOxzDOt5wPHIjLdFqbofU5Fm3N0KsGKQ0CTNpOdqVvmR9kgD
         4z8A==
X-Gm-Message-State: APt69E3IDazPTZYWxi9C6uJY3xhv8aJOuHdOGUho6sTyUXrXQuvrpy45
        Q6yToWRmPizfRSWopoBvCIM=
X-Google-Smtp-Source: ADUXVKJMssmK0HHrlrJqSqR/dHfztnsnApQzT4QoENtMJ9EepmdpSIxTxvowJ+BWj8fIx5Ltq+PZUQ==
X-Received: by 2002:aca:1c8:: with SMTP id 191-v6mr7720649oib.291.1529338062673;
        Mon, 18 Jun 2018 09:07:42 -0700 (PDT)
Received: from nuclearis2_1.lan (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id v8-v6sm15420025oti.35.2018.06.18.09.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 09:07:42 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, andy.shevchenko@gmail.com,
        okaya@codeaurora.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI: Check for PCIe downtraining conditions
Date:   Mon, 18 Jun 2018 11:07:32 -0500
Message-Id: <20180618160734.8134-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor straigh
forward.

The easiest way to detect this is with pcie_print_link_status(),
since the bottleneck is usually the link that is downtrained. It's not
a perfect solution, but it works extremely well in most cases.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v3:
 - Remove extra newline and parentheses.
 - Make sure v4.18-rc1 is still happy with the change (it is).

Changes since v2:
 - Check dev->is_virtfn flag

Changes since v1:
 - Use pcie_print_link_status() instead of reimplementing logic

 drivers/pci/probe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..5e0d0a34fe8c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_check_upstream_link(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	/* Look from the device up to avoid downstream ports with no devices. */
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/* Multi-function PCIe share the same link/status. */
+	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
+		return;
+
+	pcie_print_link_status(dev);
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	/* Check link and detect downtrain errors */
+	pcie_check_upstream_link(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
-- 
2.14.3

