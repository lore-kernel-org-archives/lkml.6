Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC2C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4D4217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtFRSlt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4D4217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeHCXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:40:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44222 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeHCXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:40:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so6612778wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8pEeM9VIMkHYqbkH1uSJJdE/g9Kvfb8nzTeKO1Hs+dg=;
        b=OtFRSlt6zkld9oCIozRc+CDZHRbHIZdEqU8q368QCsE4u8oi5NBoEAbEpLPNN2M9P3
         4e/v9O2mVbjtf4mlodeB8XNBC9y/Jv/YYpGTt9H5bAqcCZpkeWrEwQjGTZbtGt+CiN9Q
         8uMFLoKcIsKHpaCtDSBTg17OzaeXCBRUFTh7ZrYp9Rh5SGGfVUQwzYq5s4rwEx3q8O/7
         UbqbpihOWjfNgHS1IaaoGyAAkwvKshhy+iFm4FbFBkilPVdoilK/+jIWr6ylruf+ksJ4
         NBgRoiVCznb3LTxTXvtM6sX7cMBBWNtPZxBXaJk2V08tcBzMfm6R9wAn1lmi65RiI3+C
         FqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8pEeM9VIMkHYqbkH1uSJJdE/g9Kvfb8nzTeKO1Hs+dg=;
        b=cvOgNj51yr0hikYhximGCgjc3ZfwPhMJHOXM4HkHRdOpJrwKcw/HFBRC7LYRVKVu4x
         zm38Cb87GcO701bXfhCx1ZpoGMDgLOKsax7rma/yKDiTpeoWdtWI/0C62j1J7FxRJK2d
         EO5t6+hGksI+LphSvLAzdo0U87kKMZH3LY+K+u8iBPivdZgh4u2VtcP6c7ydE4M97Hu8
         I1v18ZAl+Saz/3DPd/Mi4Kj+t6nrjTpGT6PwpGAYAXOwmx9JiDozWvS8PycdLc25Wudu
         we8BWCpkW/XSDPBtzffK8HN/ZYtT88z4KgDdqv1+DLiEE26R+yOAJzswC4qObXHOgDck
         IAww==
X-Gm-Message-State: AOUpUlGGJ4e4WdlaP5Lfy1H4kATiKeVNB/DdLnYxeKOrjGnSzWMZtjdF
        Z21drITxhFjLe6cc1EpHrrP2nEJc
X-Google-Smtp-Source: AAOMgpfFpCfC2IvcXnLM2TPAa+cNgOqQm9UrrUhhYVYe1Xi/WKWyzQRdM9kyjFs+KTkxKfecwQQSyg==
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr3669668wrs.87.1533332539214;
        Fri, 03 Aug 2018 14:42:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id x82-v6sm941799wmd.11.2018.08.03.14.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 14:42:18 -0700 (PDT)
Subject: [PATCH 1/3] mei: Don't free irq when suspending
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Message-ID: <3eb5ef65-1426-58d0-0f45-eb83cee6f7cc@gmail.com>
Date:   Fri, 3 Aug 2018 23:39:02 +0200
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

Usually it's not needed to free and re-request the interrupt in a
suspend / resume cycle, so remove this.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/mei/pci-me.c  | 20 --------------------
 drivers/misc/mei/pci-txe.c | 27 +--------------------------
 2 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index ea4e1522..55ba1c41 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -336,9 +336,6 @@ static int mei_me_pci_suspend(struct device *device)
 
 	mei_disable_interrupts(dev);
 
-	free_irq(pdev->irq, dev);
-	pci_disable_msi(pdev);
-
 	return 0;
 }
 
@@ -346,29 +343,12 @@ static int mei_me_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
-	unsigned int irqflags;
 	int err;
 
 	dev = pci_get_drvdata(pdev);
 	if (!dev)
 		return -ENODEV;
 
-	pci_enable_msi(pdev);
-
-	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
-
-	/* request and enable interrupt */
-	err = request_threaded_irq(pdev->irq,
-			mei_me_irq_quick_handler,
-			mei_me_irq_thread_handler,
-			irqflags, KBUILD_MODNAME, dev);
-
-	if (err) {
-		dev_err(&pdev->dev, "request_threaded_irq failed: irq = %d.\n",
-				pdev->irq);
-		return err;
-	}
-
 	err = mei_restart(dev);
 	if (err)
 		return err;
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index e1b90912..b8a49581 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -240,9 +240,6 @@ static int mei_txe_pci_suspend(struct device *device)
 
 	mei_disable_interrupts(dev);
 
-	free_irq(pdev->irq, dev);
-	pci_disable_msi(pdev);
-
 	return 0;
 }
 
@@ -250,36 +247,14 @@ static int mei_txe_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
-	int err;
 
 	dev = pci_get_drvdata(pdev);
 	if (!dev)
 		return -ENODEV;
 
-	pci_enable_msi(pdev);
-
 	mei_clear_interrupts(dev);
 
-	/* request and enable interrupt */
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
-	if (err) {
-		dev_err(&pdev->dev, "request_threaded_irq failed: irq = %d.\n",
-				pdev->irq);
-		return err;
-	}
-
-	err = mei_restart(dev);
-
-	return err;
+	return mei_restart(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.18.0


