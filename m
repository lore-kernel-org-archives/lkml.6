Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D8320652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uELPYY5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D8320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030858AbeFST6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:58:53 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42581 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030528AbeFST6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:58:48 -0400
Received: by mail-ot0-f195.google.com with SMTP id 92-v6so1071732otw.9;
        Tue, 19 Jun 2018 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3bB1M/YGqvLEtORVyClAmRwlLUSXyn2Qacu7CYP8XuA=;
        b=uELPYY5DSjUIawYwiH1+2zr9/bsvPUJum0YpAjpELsYvyX2R964yIC8PHpqCfJPsGu
         TDPVtzW4rgeg0UpsD9UskofAIdgyniD+qJMhcWT6DqaH9efH/hYqkl4QHOJtqQT5nbL1
         AHtrWdJ5yW3SUYOjsqBYjHxVl8knkwJaIByEmAgmsXRpVe8R5biuGzWlc4yhW3jW4RNc
         Cd3CrOhILpJHw79B38S4ridsksw4RR5x+jzbPga36Ugue9RLTXoQmJoWC4IfDZV74m7L
         CFhp31ToU5rCUZ9IRkDlgx9keDl68YwJEboA+FvBbRnE6PBo5UHn8jKcMfVYjIJXbIVA
         WwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3bB1M/YGqvLEtORVyClAmRwlLUSXyn2Qacu7CYP8XuA=;
        b=DpDS2CfXnRdvX8Ye9/ii5eZBTizGosInvvOcWxGThk5K9U6P8jSoiR7NqdmzzyRfAW
         wnBZ0tqMezk3HxAHMHJoecfgMW82dOQkLmCbBoH4PQPVHF+c3XgHWt1om79iLMXJlcfW
         UioyjybDtt/8dMj8mDBqf3rb9/ky05QdqueEu3cZvXW7/LUGS4pwWNNnKp1owYgm+93r
         NNcoifA8NLiyWsbJM7G1kahvAzM0bmodAz+Z5eWMt8B7EGraUdHIahXWeN9YIjYFFnWS
         RUYC5Si+tNj5izSxoiEG2qfb/c4foqO1xi8FDN3Jps5mN321qa0sts4rKYGNkEtr7l8j
         1nXw==
X-Gm-Message-State: APt69E3sR4w3gYV9gmkIYiWLLWR8awOnxbg0bjea5zLxE8PGhyYeuIVj
        NL4qwfL374ZqOcAuJhaIe3o=
X-Google-Smtp-Source: ADUXVKJPiyVCNGbdfxyG+r0+gNfxmqnqmlVlpllMitoE9m1SYT0zp+cUCtDZuI4TIZ1uEXPKBh6Cdg==
X-Received: by 2002:a9d:1f74:: with SMTP id x49-v6mr10545416otx.108.1529438327676;
        Tue, 19 Jun 2018 12:58:47 -0700 (PDT)
Received: from nuclearis2_1.lan (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id l17-v6sm520831ote.76.2018.06.19.12.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 12:58:47 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com, keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date:   Tue, 19 Jun 2018 14:58:20 -0500
Message-Id: <20180619195835.5423-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation, "pcie_ports=native", linux should use
native AER and DPC services. While that is true for the _OSC method
parsing, this is not the only place that is checked. Should the HEST
table list PCIe ports as firmware-first, linux will not use native
services.

This happens because aer_acpi_firmware_first() doesn't take
'pcie_ports' into account. This is wrong. DPC uses the same logic when
it decides whether to load or not, so fixing this also fixes DPC not
loading.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes since v1:
 - Re-tested with latest and greatest (v4.18-rc1) -- works great

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..98ced0f7c850 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -291,7 +291,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
 
 	rc = apei_hest_parse(aer_hest_parse, &info);
 
-	if (rc)
+	if (rc || pcie_ports_native)
 		pci_dev->__aer_firmware_first = 0;
 	else
 		pci_dev->__aer_firmware_first = info.firmware_first;
@@ -327,6 +327,9 @@ bool aer_acpi_firmware_first(void)
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first = info.firmware_first;
 		parsed = true;
+		if (pcie_ports_native)
+			aer_firmware_first = 0;
+
 	}
 	return aer_firmware_first;
 }
-- 
2.14.3

