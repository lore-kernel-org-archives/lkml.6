Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD81C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3252081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eDshweiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3252081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLCIhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:37:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34587 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:37:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so6099487plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wacvcPIeKMv9Jbty86UncENmT9BOQYNzfNz+0+AuXbA=;
        b=eDshweiMwVgy4CEUMivvDpBdZWwOc4jw+I3mEB55edgozmsc8GCxWTLVVK0jfq35RE
         EAO0ZVgHbRMJtBhnbPXRP8A1Qo9X/nxMzi1xovka9hHSfjHlMKiD/cCg9cJpXYpVuO3u
         /VJKFFahck+MlTxFsxQqYS4FYKIYu6/fDptdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wacvcPIeKMv9Jbty86UncENmT9BOQYNzfNz+0+AuXbA=;
        b=TA8BhdR51PvA77IJoCHO5qtkxGuJdF5tA1lZ7drcvI/c2ohDofi+UL/7dWZORSoc3t
         4v9PBH75D8I1RxtDqKJ77T60v9ozsfQl6hKaiBxx8f1Gi4fLjpTb0nwDR8F8+udXiFao
         87r4b5JeK1UIeqUD+NRJFS9Z5sKv4Ff+KFRxGlU1mEhxuam8wq/8FcyMpvmWjZnNbvUE
         FPC67nuXSdIoE4yT/Cp4tDvuGpw0/bjKvCxKsGzYI5Xq6/zNqX5zPU4hc95v+N5gdSfn
         m+mtnGFW7o0zW2hRUNBCaWrlcNPcCOWlR+u01SM6tiVEpVWroHy/1CfOKlrOw95gWuPX
         NeNg==
X-Gm-Message-State: AA+aEWYOiDXRA2Fo1iCwDG7/+6+InBqaqV5QpR+1ju6uc09VKD6QbVmb
        L05QH0ya8j54ALG61UFa3DPSiQ==
X-Google-Smtp-Source: AFSGD/Uf/Xkss4IdiGx9SOt6zyEIRLPxZo2yvDex/irhSJ1/BSqj0ClAyvJGHVxTy5+V7DvSNVQ0Dw==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr15097424plz.75.1543826224237;
        Mon, 03 Dec 2018 00:37:04 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 78sm17304426pft.184.2018.12.03.00.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 00:37:03 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] Stingray usb phy driver support
Date:   Mon,  3 Dec 2018 14:06:45 +0530
Message-Id: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add stingray usb phy driver and its
corresponding DT nodes with documentation.

All patches are based on Linux-4.19.

Changes from v1:
  - Addressed Kishon review comments
  - phy init call return value handle
  
Srinath Mannam (3):
  dt-bindings: phy: Add binding document for stingray usb phy
  phy: sr-usb: Add stingray usb phy driver
  arm64: dts: Add USB DT nodes for Stingray SoC

 .../bindings/phy/brcm,stingray-usb-phy.txt         |  62 ++++
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  95 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 373 +++++++++++++++++++++
 6 files changed, 543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

-- 
2.7.4

