Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D67F8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA3B208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGSxzDaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA3B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbeFNMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:22:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44219 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754885AbeFNMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:21:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so6201715wro.11;
        Thu, 14 Jun 2018 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kqop6C1DrwAxkrsGucfcp55gxZ2JswPs/TFiHDWi0Vg=;
        b=QGSxzDaFzPLXeHmsH3QTxO1vd0oaqPFwt1+52Glu/vSI4ZWKEG0kQCU8cw8Di2+YUj
         Ekm9AVmS0Um6aTWTYTgors61OY6eqNPOraSATQPK8rsw4Mo1pXLCds7g82Ga8hSSdoF9
         ivNTlCfK5KC3LN4A4tZrje4b6U8SXiAQvmKYYq4PkcRTDqqkY5W+jMv8zR4QsIKUTRtH
         LPnRGHL+1hjiLOikEos3ary0ZoQFbLbt6SgKk0gw5HYeWcWvb5CQEbfNT4X4fhjTFCPh
         7y0Lycdx1EyCQqJA0L8/NwU6urwQ5GCIRwB6qYtXDr/ar5V64Z1CiIpS50PpkrcxEY0x
         DNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kqop6C1DrwAxkrsGucfcp55gxZ2JswPs/TFiHDWi0Vg=;
        b=ivAWFXy7AxKMAJ+8/3Ccsnzt5OlbdPyBqPIFSN2GoVx4Sldz6/CWB85QswQwp50CLG
         WBhoUbzYNQPxbQFBpyLvcwqcDwxEbt2Tt0PiCClKxVlGDklh8vC0QFiSTfAacxU4MhcA
         +nrYxsjGwlcANUPcmfrL55Y5n2zXDTOumr0dgrDRUoUi5YKR7ETus0+S/Oekr1A5gcZv
         /STuZLSfcv1kSeYVVBcX5vhvCY/48pL7SMIE1r0OOd2FfVqmrlVPXKDrPWJlEYuEn+pG
         E/WF0cmpM/mlmqlc+YGduuZnAWcbFSVaVs65oXwqaCDYciE/gnLamIMhl76MbOcbHeYA
         iI8A==
X-Gm-Message-State: APt69E3vD4dMTolFPrSKhPHmGRayo7rThnRiSlGKFcZdvkBVK3agb//q
        n6JxHlW2MxK4o4k97oqJcNQ=
X-Google-Smtp-Source: ADUXVKK3JZ7ZdUe6gCzsJCYqE4TuXdbS5IvJe9c2RDREoY5Gm5nEPtwyon7loUIrFmwabJtc7MzVgw==
X-Received: by 2002:adf:eace:: with SMTP id o14-v6mr1917427wrn.150.1528978909277;
        Thu, 14 Jun 2018 05:21:49 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1257:4460:a58a:cd2:d067:8318])
        by smtp.gmail.com with ESMTPSA id v13-v6sm5086191wrq.43.2018.06.14.05.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 05:21:48 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: cleanup PCI_REBAR_CTRL_BAR_SHIFT handling
Date:   Thu, 14 Jun 2018 14:21:46 +0200
Message-Id: <20180614122146.62118-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180614122146.62118-1-christian.koenig@amd.com>
References: <20180614122146.62118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That was hard coded instead of properly defined in the header for some
reason.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.c             | 6 +++---
 include/uapi/linux/pci_regs.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d4685090378b..a905e35d9360 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1181,7 +1181,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		res = pdev->resource + bar_idx;
 		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= size << 8;
+		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	}
 }
@@ -3066,7 +3066,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
 		return pos;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> 8;
+	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
 }
 
 /**
@@ -3089,7 +3089,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= size << 8;
+	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	return 0;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5e9b8..7358ad00f5dd 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -950,8 +950,9 @@
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-#define  PCI_REBAR_CTRL_NBAR_SHIFT	5  	    /* shift for # of BARs */
+#define  PCI_REBAR_CTRL_NBAR_SHIFT	5	    /* shift for # of BARs */
 #define  PCI_REBAR_CTRL_BAR_SIZE	0x00001F00  /* BAR size */
+#define  PCI_REBAR_CTRL_BAR_SHIFT	8	    /* shift for BAR size */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
-- 
2.14.1

