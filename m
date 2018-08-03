Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D37C4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A29217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAP+C8Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A29217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeHCXk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:40:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52848 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbeHCXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:40:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so7614640wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KwVwMfrQRScak9FzqybHuea6QQnCPKJPo3A3uIvhHMM=;
        b=hAP+C8Bm0C18f8rayChaCKdvubYzjp1ahVEfI2ntu51eJF7jLG5dcUXoZ3xGez+Oh8
         EsOWnE/oa2rr6KQe9LT0yIVQxDmnXR0evXPhRd5dzUxdfVpG0SiDPhfjPBnZB9YGzJkd
         fMf3TYLugMw/MNpvZZQP3X5OKLr/f5sQMPClMLJgjLjn1z0dm6qoV3/JqCqTSTCa/s/m
         2dzkq3WjMeu2I073FP47ERHwS7hz0VjvCNK5Keb8tTiUVlCgCwkfSIND0yWPL4ZHwPcV
         ikWyhfujEYxd5Dyqbx/odZSSuVf5QOgkI6EXPvxfFukeoLRdXo80+5gMlcQnEWuFpBCL
         b4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwVwMfrQRScak9FzqybHuea6QQnCPKJPo3A3uIvhHMM=;
        b=ZhR3Iei+nHbScxu52PZRXWLUG0RnmpOR2fzW0btjtVGJVXfKBewn4ZVmD/qEc5HMdS
         2Zl8X5Jl8eIk52b5F60cIrPr7x4GtmR99B36a6rHiBwMG/qvBO7GHA03ueTUzXzpR364
         r3O2en7WfKv9CUoO7+Y7BpKeNwlRSm05vlVkv4g4dsYtk/kbNSVqA8KNNd1a81CHWzRp
         amuUtBk/cOCO/O5ZxXc2fPwe1OqvXnKrx04SdapOOntHOqqnebu1A21ZCxoKCdMFQvmo
         c57awvt6BpJ/asw54xsSXYFLO7AkwZbq4kb1lZ8m1hmpBWgMSuVZAN+lK1tL8FVoVL/8
         7Avw==
X-Gm-Message-State: AOUpUlE28zfWIiy3DdqYvN24ZMP8RliZnLSQJ2LKaqXOla55cGBvlpzg
        troOxtJLT7CVt/cK+dB7lH+nRePY
X-Google-Smtp-Source: AAOMgpddsR9uPd8dACjdTBig34IlWBk5NwEbIIbA4BOE0T2kXQSSXkSIQswLmfZUaKqrUgx3XsANlg==
X-Received: by 2002:a1c:545:: with SMTP id 66-v6mr6351654wmf.140.1533332540599;
        Fri, 03 Aug 2018 14:42:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id z11-v6sm8448035wrm.94.2018.08.03.14.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 14:42:20 -0700 (PDT)
Subject: [PATCH 2/3] mei: Migrate to pci_alloc_irq_vectors API
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Message-ID: <c6426b7f-8fee-77ad-56be-00a0d5d04fa6@gmail.com>
Date:   Fri, 3 Aug 2018 23:40:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the driver to the pci_alloc_irq_vectors API, this allows to get
rid of legacy calls like pci_enable_msi(). Another benefit is that
no driver change would be needed in case the hardware starts
supporting MSI-X.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/mei/pci-me.c  | 25 +++++++++++--------------
 drivers/misc/mei/pci-txe.c | 30 ++++++++++++++----------------
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 55ba1c41..a60376f0 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -149,7 +149,6 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct mei_cfg *cfg;
 	struct mei_device *dev;
 	struct mei_me_hw *hw;
-	unsigned int irqflags;
 	int err;
 
 	cfg = mei_me_get_cfg(ent->driver_data);
@@ -196,18 +195,16 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw = to_me_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
 
-	pci_enable_msi(pdev);
-
-	 /* request and enable interrupt */
-	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
+	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (err < 0)
+		goto end;
 
-	err = request_threaded_irq(pdev->irq,
-			mei_me_irq_quick_handler,
-			mei_me_irq_thread_handler,
-			irqflags, KBUILD_MODNAME, dev);
+	/* request and enable interrupt */
+	err = pci_request_irq(pdev, 0, mei_me_irq_quick_handler,
+			      mei_me_irq_thread_handler, dev, KBUILD_MODNAME);
 	if (err) {
-		dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
-		       pdev->irq);
+		pci_err(pdev, "pci_request_irq failure. irq = %d\n",
+			pci_irq_vector(pdev, 0));
 		goto end;
 	}
 
@@ -258,7 +255,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 end:
 	dev_err(&pdev->dev, "initialization failed.\n");
 	return err;
@@ -287,7 +284,7 @@ static void mei_me_shutdown(struct pci_dev *pdev)
 	mei_me_unset_pm_domain(dev);
 
 	mei_disable_interrupts(dev);
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 }
 
 /**
@@ -316,7 +313,7 @@ static void mei_me_remove(struct pci_dev *pdev)
 
 	mei_disable_interrupts(dev);
 
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 
 	mei_deregister(dev);
 }
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index b8a49581..3ea2b8f6 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -64,6 +64,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct mei_device *dev;
 	struct mei_txe_hw *hw;
+	irq_handler_t qh = NULL;
 	const int mask = BIT(SEC_BAR) | BIT(BRIDGE_BAR);
 	int err;
 
@@ -100,25 +101,22 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw = to_txe_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev);
 
-	pci_enable_msi(pdev);
+	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (err < 0)
+		goto end;
 
 	/* clear spurious interrupts */
 	mei_clear_interrupts(dev);
 
+	if (!pci_dev_msi_enabled(pdev))
+		qh = mei_txe_irq_quick_handler;
+
 	/* request and enable interrupt  */
-	if (pci_dev_msi_enabled(pdev))
-		err = request_threaded_irq(pdev->irq,
-			NULL,
-			mei_txe_irq_thread_handler,
-			IRQF_ONESHOT, KBUILD_MODNAME, dev);
-	else
-		err = request_threaded_irq(pdev->irq,
-			mei_txe_irq_quick_handler,
-			mei_txe_irq_thread_handler,
-			IRQF_SHARED, KBUILD_MODNAME, dev);
+	err = pci_request_irq(pdev, 0, qh, mei_txe_irq_thread_handler,
+			      dev, KBUILD_MODNAME);
 	if (err) {
-		dev_err(&pdev->dev, "mei: request_threaded_irq failure. irq = %d\n",
-			pdev->irq);
+		pci_err(pdev, "mei: pci_request_irq failure. irq = %d\n",
+			pci_irq_vector(pdev, 0));
 		goto end;
 	}
 
@@ -162,7 +160,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 end:
 	dev_err(&pdev->dev, "initialization failed.\n");
 	return err;
@@ -191,7 +189,7 @@ static void mei_txe_shutdown(struct pci_dev *pdev)
 	mei_txe_unset_pm_domain(dev);
 
 	mei_disable_interrupts(dev);
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 }
 
 /**
@@ -219,7 +217,7 @@ static void mei_txe_remove(struct pci_dev *pdev)
 	mei_txe_unset_pm_domain(dev);
 
 	mei_disable_interrupts(dev);
-	free_irq(pdev->irq, dev);
+	pci_free_irq(pdev, 0, dev);
 
 	mei_deregister(dev);
 }
-- 
2.18.0


