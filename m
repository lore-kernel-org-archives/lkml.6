Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 525BBC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED625208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h47y/+X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED625208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755091AbeFNL5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:57:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39557 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbeFNL5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:57:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so3128724pfl.6;
        Thu, 14 Jun 2018 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iaWQ/sZl61trrDNq5l36xcWF9Q9vzGPTiusYs3uvq/M=;
        b=h47y/+X2sfWB1l7Cg7CVTBcDk3eRmY3mPjFyER8Tzz8PCjDK0Y95gGsx8O7G5LDCJJ
         KDBcaFtFllUlaWa6tvgfZ349cAWVwUcVFsDrPr4N+A6V/1OUDsOWqcyO+UNYQKPzj9qu
         GdwSHfIDJGpwaiRH41I5CWQZ5raZcewTnek4TPxpxlktf7EkYwEjb/6FwU4cjVWQzne9
         UObOMd9Ch+sALK4NZ7W3IaNLA/99rGd7DYDqM3fvv/yfWnmh4QFVQYYwyCoxN3RG2wMs
         4vi/erLGqjTvFbAqPwaoJxP+p2l4XF/a9c9SBKvQppTov+oOaKq0B9lxbjQPGBfdqJwl
         WmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iaWQ/sZl61trrDNq5l36xcWF9Q9vzGPTiusYs3uvq/M=;
        b=p6+oUsJsIBbmjFmMyp/5Wp0my4SfYR9QNqHjjBNI9VE7SB5mhOzYvrvqucHDh/pzWA
         tCzeL/3HNQ6FpiKe/SiE1pULDyjEWUcI0JfN0ad2SZ6A6CEDlI4drg+tuv7TyenhN3tu
         nJMRnVy8YUo402ddLJq4ImVM/KHw0aU8zlUuDxNJs6vkr+FLorHBm8QrrKba+Dg9f5xf
         4yYGtN6k/C+g+jqgEK154CaDl2EM31qzRpWRJ+cF0dzRGryVljJnebm+SBIhV+YR4Yg0
         M/TLbFJa8dEIk6//beX8bgSPd4RPaWEHBQDp4KibY+brGeGKEyvy6IA8dZ8cPoun0xqc
         t+DA==
X-Gm-Message-State: APt69E3cHIBKMCynvWtGnN7uX/kA421f5bni7s4j03WOO9F4HNTfjAZo
        xou5UEihk6F7UZ1GMVI/BiF9bRQUp8o=
X-Google-Smtp-Source: ADUXVKJDjvt8B8FnViobtGQArdr5QAZp3NeoqHp0NcX6HGKCxB616InPSTvDkG9e3GY6NzAR2Q0zOg==
X-Received: by 2002:a63:6d0:: with SMTP id 199-v6mr2035984pgg.338.1528977464493;
        Thu, 14 Jun 2018 04:57:44 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id h27-v6sm14386150pfk.160.2018.06.14.04.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:57:43 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: bfa: add error handling for pci_iomap
Date:   Thu, 14 Jun 2018 19:57:39 +0800
Message-Id: <1528977459-52285-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528705581-34646-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528705581-34646-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_iomap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_iomap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Unmap bfad->pci_bar0_kva.
---
 drivers/scsi/bfa/bfad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index bd7e6a6f..693e180 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -760,6 +760,11 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 		goto out_release_region;
 	}
 
+	if (bfad->pci_bar2_kva == NULL) {
+		printk(KERN_ERR "Fail to map bar2\n");
+		goto out_unmap_bar0;
+	}
+
 	bfad->hal_pcidev.pci_slot = PCI_SLOT(pdev->devfn);
 	bfad->hal_pcidev.pci_func = PCI_FUNC(pdev->devfn);
 	bfad->hal_pcidev.pci_bar_kva = bfad->pci_bar0_kva;
@@ -797,6 +802,8 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 
 	return 0;
 
+out_unmap_bar0:
+	pci_iounmap(pdev, bfad->pci_bar0_kva);
 out_release_region:
 	pci_release_regions(pdev);
 out_disable_device:
-- 
2.7.4

