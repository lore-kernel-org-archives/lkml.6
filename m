Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5003C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906FC208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd8F34+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906FC208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbeFNMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:21:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39358 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeFNMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:21:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so6208814wrn.6;
        Thu, 14 Jun 2018 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRmZFiOJSZDB20f7uqPd9NZeP2i4FhIRYyVWnfN098o=;
        b=Dd8F34+nIfRDyaHKIcvWCt2iLLS+N4FVWQUTf48qM+7OIv/UrVJ6AgSf/a42IVBWH4
         1dRHLgJx2ad4iO0KlJGtCYs+g8PuRxWMFXTuZihEVNq0oGErioFbt0xi0SQK6LNxs4dT
         RGI8yv9AlpQhB8vXFIdgQ/D411izKtO9jPni6syudVSiDYQubrjpPCXFPSqYIS1xNswZ
         gkBXfwKG+ok6sqnyK/GqCzVzuWREpAhemdkqpHXhc8R9WATtozIGc2anm36QTM/UX1cO
         0lfG7Ost8K60KZFMCxIk+VfRnrGCqh3JbnubtZ37whaeD5PbnwrgHLjMpKYCfunNH2b3
         ykvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRmZFiOJSZDB20f7uqPd9NZeP2i4FhIRYyVWnfN098o=;
        b=BT93oSOZz37xdmJh7TSjtM0E20ClY4zr3X35YbMJql+yQfMh2F+pHSSAB2EIIL+5i2
         MhvYJ3b0ZHOoGqq3b15buPmNBElJn6T0THrVF+fT25ESJKhWuMoJqfKdpZ8MqBYl51Ey
         uiLZBTRMUSQbRiGKN5T4vSA5MQq/yiOlzF3GFO6hGaos2D0GBZDkGQg44yx1xUFb1ycI
         7IgGQL4jRY4vFUGMk12q/xiCaVgHDxdkEWaGLbR4y/4Igp5U0qxELZBQpjQbWW10t41W
         kve6knoNP1vj62fP8mQN+V5o3Km8L6y2E6wDm0F9E4mYPxOLsCPOC6pwm4s+3PRPyU3t
         M14g==
X-Gm-Message-State: APt69E1H6RuRjn1ptlpZuE7m4ygENJdirIyrJExXZLl1uydjHK4v08mJ
        KtLrc5XpZMNiz3IIz+/iztM=
X-Google-Smtp-Source: ADUXVKKj4D8sehUtkxW1rJAsJNjZRfGRaEYMRPZbHgWmzAKep4ACPdxXO3M5UP2E3yvzRTTbODoKKw==
X-Received: by 2002:adf:8da1:: with SMTP id o30-v6mr2020472wrb.81.1528978908512;
        Thu, 14 Jun 2018 05:21:48 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1257:4460:a58a:cd2:d067:8318])
        by smtp.gmail.com with ESMTPSA id v13-v6sm5086191wrq.43.2018.06.14.05.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 05:21:47 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Date:   Thu, 14 Jun 2018 14:21:45 +0200
Message-Id: <20180614122146.62118-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resize BARs after resume to the expected size again.

Signed-off-by: Christian König <christian.koenig@amd.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
CC: stable@vger.kernel.org      # v4.15+
---
 drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd6f156dc3cf..d4685090378b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	}
 }
 
+static void pci_restore_rebar_state(struct pci_dev *pdev)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
+		    PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		res = pdev->resource + bar_idx;
+		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= size << 8;
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: - PCI device that we're dealing with
@@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_pri_state(dev);
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
+	pci_restore_rebar_state(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
 
-- 
2.14.1

