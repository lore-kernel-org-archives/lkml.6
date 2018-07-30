Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD96C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AE920890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld9XgAzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AE920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeG3W64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:58:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34135 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3W6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:58:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so24011100ois.1;
        Mon, 30 Jul 2018 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iAB0ptfW9Uda2ky2wRFKf67ggz1zW28T4Okwkzn/jxQ=;
        b=Ld9XgAzDcmSPKMhwv0AoKy84km9jWihkFYls74wVij8U2hJLBunRUYu+zZbVfeBFFq
         TlBx5OFD/7jtB/AOPeWgrgfOLomCZayxzKVSeGWQuPtrQItB7RHFQuVixsLKzIc/muXf
         qQ3UG9zliOCdlBMwSSYM5Eik7s4DiGP3wb/uJqhOWa53m6SYZs+BIxCOtEZD67uov+I5
         w0uebzNyvFl9q0yfj8M7YDf8kP+hK2uJcOQTx8Ma1ihHadfUYFuiLjJsdHvqZdGpoSUI
         y7zVY8ZXDd4rmERsCtwDAJuRu//+VB98/VzY4J6ONZWn8WC3QwtHHDuhKUwGr2Cd7rJh
         TA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iAB0ptfW9Uda2ky2wRFKf67ggz1zW28T4Okwkzn/jxQ=;
        b=tu6ThLxInfaoBED9V/WudOBZ7ESLBZ+vzvqhsOn3vP89nVMVe71P8BH5/43QyWcvFa
         rqmhgHti/Q9aMzuUG9PJbWYudV/7hN6SNJhS/RyusyNiMKoDSfYnC3IImk0LKrqF5O0t
         cbfhydKxia6gI3x+gajXaUnOAUDjlwMVjyj+auRTpSfzH5UFgZ+qbTIDOZqDDpc1m5AE
         QeLGnsXj+NfErXbuGCo8EWEjhMb0FFU2uN9sag+zRGrXje+Vd26aGhRVWdoB6GvIP1Y9
         Cj2kopq7JPyUGBqn2VQe7XLU4yXHE0w938/Bm4pp5vEVrPx0MlW5oK80lruyciyom35Z
         cA8g==
X-Gm-Message-State: AOUpUlHs66OepNXwgzmdLs4IkT50XTEQfHy4EdkiCp64pPH7ONo2oXHv
        GogwRBFAKQPmnpJAZR1XuFSFjhh2y4Q=
X-Google-Smtp-Source: AAOMgpdkfFwnitZkgYQG1q/jPg7dMLJHhDpYSTRtBEVrXhnEhRxnoDLXuNITI0WaDJ05tuOjFI/oJA==
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr19282468oia.345.1532985723142;
        Mon, 30 Jul 2018 14:22:03 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d5-v6sm7897998oia.57.2018.07.30.14.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:22:02 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, Narendra_K@Dell.com,
        Stuart_Hayes@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
Date:   Mon, 30 Jul 2018 16:21:44 -0500
Message-Id: <20180730212146.31909-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PCI device is gone, we don't want to send IO to it if we can
avoid it. We expose functionality via the irq_chip structure. As
users of that structure may not know about the underlying PCI device,
it's our responsibility to guard against removed devices.

irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.
Guard them for completeness.

For example, surprise removal of a PCIe device triggers teardown. This
touches the irq_chips ops some point to disable the interrupts. I/O
generated here can crash the system on machines with buggy firmware.
Not triggering the IO in the first place eliminates the problem.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

There's another patch by Lukas Wunner that is needed (not yet published)
in order to fully block IO on SURPRISE!!! removal. The existing code only
sets the PCI_DEV_DISCONNECTED bit in an unreasonably narrow set of
circumstances. Lukas' patch fixes that.

However, this change is otherwise fully independent, and enjoy!

 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4d88afdfc843..5f47b5cb0401 100644
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

