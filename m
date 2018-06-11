Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JnaBADkyHltjfAAAmS7hNA
	; Mon, 11 Jun 2018 08:26:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD859607A4; Mon, 11 Jun 2018 08:26:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNThQjms"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6D2F260791;
	Mon, 11 Jun 2018 08:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D2F260791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeFKI0a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:26:30 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36492 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:26:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so9404699plp.3;
        Mon, 11 Jun 2018 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TVVOEI6h0780tnAylhUZDND+FOZfDBDaGWtZb7OFp9A=;
        b=kNThQjmsMATe3qwDCv9QI6u7T4YpZVow05YzK30myIG7obWl55CwdmqEQl6exaKgTH
         xCB+S4H5UekKDtOtBz5OTWKMubVcYBYUILqdM+m7UgfplU6A5SJ8tXvfWacxHGjdtpoi
         4OYYGVlQBOF1wTEFEx9BE9XJdbq+RhQr6WDgfY1E4bwSWJ6MQ1KWL3W/2bqF93o/TBeg
         HaEKKv5vYma8kzBsDhv/jCMpotoRL9WyMGsSZXDZvscVo6gfERFeirtFx0RuyUEeyOiF
         SzsW80aeXOnGIAiTkmxae5UhAZrqE0MC+vjGUlxTzaN1nSF88x+HLBwEWzm3Jvndo6MG
         eBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TVVOEI6h0780tnAylhUZDND+FOZfDBDaGWtZb7OFp9A=;
        b=kv3j5XJssR6j8jUF+C7kLJLo3nBMm3FLmO9Zrt0KtbtPXGoex2QAItgkOrZPab936r
         4jDD+1PhM4Cje8DsQB8U9RUygfpUFYHfRRGvDheGn5ahzbjYfE1nqH5I77BZHmOoHZwM
         bU5et5wIbJdRK2pQNKryDcEKlWXIPEKqg3FC/USUssfnYY4aSH67fep1SlJzXLnx2Rmt
         6AzA09Hm6MDHVJ6WjKaeCEtKV17zT4IB8Svtjpajyh5tE1zfg7XkYxf13kxL+bwrX07P
         qGDuhqzkq//mJvBeIxXtUr9lR6iFlc6JetbIOab9dR/xAHi1WU5OG05zmCCRCDuQIV/Q
         sC1g==
X-Gm-Message-State: APt69E3z1odpbKi745K1txJXXlSYfpwJglX3BLZiwqnzDkYcnPDEk80q
        EDhLltdFKD6WFsS4yLxpmqM=
X-Google-Smtp-Source: ADUXVKKAP02Os/Ht/aI+CotwgMmb0rHN3aK4L0RZ31K09gVOoki/UOpPsj3FQWl0+zUwdxAZcrh7xA==
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr17198127plc.341.1528705588389;
        Mon, 11 Jun 2018 01:26:28 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id w125-v6sm16988020pgb.92.2018.06.11.01.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:26:27 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bfa: add error handling for pci_iomap
Date: Mon, 11 Jun 2018 16:26:21 +0800
Message-Id: <1528705581-34646-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_iomap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_iomap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/bfa/bfad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index bd7e6a6f..74e39d7 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -760,6 +760,11 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 		goto out_release_region;
 	}
 
+	if (bfad->pci_bar2_kva == NULL) {
+		printk(KERN_ERR "Fail to map bar2\n");
+		goto out_release_region;
+	}
+
 	bfad->hal_pcidev.pci_slot = PCI_SLOT(pdev->devfn);
 	bfad->hal_pcidev.pci_func = PCI_FUNC(pdev->devfn);
 	bfad->hal_pcidev.pci_bar_kva = bfad->pci_bar0_kva;
-- 
2.7.4
