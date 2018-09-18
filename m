Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6706DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203502133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJcGAdGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203502133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeISDtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:49:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43408 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeISDtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:49:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id u20-v6so3653200otk.10;
        Tue, 18 Sep 2018 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rXvV8fXs2990Ulo3FcjusvBfvCLnVtKwk4vA/rqOC6o=;
        b=VJcGAdGUpobvwwBHFNpFkcMMkD2QpI94qPmUBxe4wbfaY46s19/BUCHJMbIN9xEAdF
         HXoZ0H8AUbLU3BlvcMSx/2XBF6iZyee7Fg133cVrmRjhhpmIB9XCpBgQvHfab7hWhmeM
         d0qLWrO471t0TnIC8xJ6zqRomza3j7V4UgGc158tdV6edsrnb2H5uXusay3RZxD3upcp
         SZnMBKeZD6eD3w4uAiNyZtf5SL49NXD1LytRxcXTec/6o4c5ybI/kupVQi/LjxnXBx/G
         XgxEibnyXktZauFvxSmtR0dQPSZVbGGSEac35wZG7lRKdRbLNeEJJ/mmEMfwPFhml7+P
         1OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rXvV8fXs2990Ulo3FcjusvBfvCLnVtKwk4vA/rqOC6o=;
        b=crVl3PJSHv13bTv8ntLUSRRrpDDrjIw6jaqtYK+J8qDsQbyziC+Kkig4VZzoe+Uz1m
         htZ6kMow5d6sbFJCkK8g9emd0MFKD5KE3U3L9SgEQ1wcl/LjIW+TnC4aAaEGrIW6VoDm
         Zj22Y0dtl+AQq7KnWIlp8KQx9jDWg/2QhlkiHyA/J2+ZTxTSdZkD8Jo9BgGQCjigimH1
         eX/sWIzNYATOJnRFYFWGuW7C6LPOS04y82IZHjMwtZrLPlhZ/husOJUqny2x+WR/CDiO
         0JUusA6ty6R7MMjg3DwltJeCojKVO2uWkK6vrCLTmwtgOhT1FTIdg3GDJDBtx3efa0eZ
         whzg==
X-Gm-Message-State: APzg51DtPCV/upzJXErzsrxYNuEio7+EhgForA4QXBJF1bIPpHdum8VU
        esxY2HInT7sKXWaONNrlMfcp9YKl
X-Google-Smtp-Source: ANB0VdacNUSlIXqjmUpYgfdDUtctWCKEmtYI13iBvEY0j7xZ0cRoDxhZ1yInMGl36k0+cTNNE/WROw==
X-Received: by 2002:a9d:2a50:: with SMTP id t74-v6mr18175193ota.234.1537308910612;
        Tue, 18 Sep 2018 15:15:10 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r18-v6sm6136732otc.24.2018.09.18.15.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 15:15:09 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
Date:   Tue, 18 Sep 2018 17:15:00 -0500
Message-Id: <20180918221501.13112-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PCI device is gone, we don't want to send IO to it if we can
avoid it. We expose functionality via the irq_chip structure. As
users of that structure may not know about the underlying PCI device,
it's our responsibility to guard against removed devices.

.irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
.irq_mask/unmask() are not. Guard them for completeness.

For example, surprise removal of a PCIe device triggers teardown. This
touches the irq_chips ops some point to disable the interrupts. I/O
generated here can crash the system on firmware-first machines.
Not triggering the IO in the first place greatly reduces the
possibility of the problem occurring.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f2ef896464b3..f31058fd2260 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
-- 
2.17.1

