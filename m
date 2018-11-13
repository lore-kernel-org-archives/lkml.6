Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B822245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TAm6eBAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B822245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeKMOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:10:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:10:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so11634947wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AA8xfN9oVIjrou05vpo2v216B0Xne4IRam4qI6U+yM0=;
        b=TAm6eBAi00MIsSvJBcF9bczBhm92k4mBFX3jaTlS2rkOWX5Dba254P3PZ5Ew7asH1f
         EeU7+PbcrkXQQa9ghwt0wOv5mEx4P6N3BJ89VU3al0otZQto+4y01P58BdS0cBO08p5h
         BVjn/GSetRnLBTs7aKeJl5Se/megOnyYPEGgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AA8xfN9oVIjrou05vpo2v216B0Xne4IRam4qI6U+yM0=;
        b=O5OgFBKS5SkwkWBJPYIHE6/6DFxDR7XJ3KuN8Yz7sE1DuyBKgVGeb+rCtr07IPzzrL
         AkyL93z+066B+twJylDo69gd1cMa4260yNbPp+vMlKly3D99Dm4CJbu7fjRLQuO5+hqi
         Hvsuc8GZpecAuBrkS2qtrUX0EhdDZ2Je0k7aJ2tLJc1OP4eLDX39zSUBdU37Wc7Nncds
         pRUdU/9BmS5JuuORtC0lZtzZdaMXQ8T/Vmel3feEmCfZyHk6Mgy4XI6GMKPYrZuJIBNn
         Y61Bv697NknAiyssycjzCDkPRnyaIAlcbUe+pQNWig4K6JCHp2GMwpo0OhxKcf38gWqw
         aF7A==
X-Gm-Message-State: AGRZ1gIF8Oyatkya555PzE5cmtmzwsmosBLYMRYpEqeQWPKE0Tigeuyk
        goPvLmOwhgQ96LtwfTin2coZWQ==
X-Google-Smtp-Source: AJdET5dmgWcKcNJtVDI0bB6kIs6KUh4h/5RRqFgUzZka6hklGGLFxhu9qoBg1QyR46JobT8oP8MOvQ==
X-Received: by 2002:a5d:4f08:: with SMTP id c8-v6mr3158808wru.310.1542082433004;
        Mon, 12 Nov 2018 20:13:53 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x2-v6sm12206193wrw.42.2018.11.12.20.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 20:13:52 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] Stingray usb phy driver support
Date:   Tue, 13 Nov 2018 09:43:35 +0530
Message-Id: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add stingray usb phy driver and its
corresponding DT nodes with documentation.

All patches are based on Linux-4.19.

Srinath Mannam (3):
  dt-bindings: phy: Add binding document for stingray usb phy
  phy: sr-usb: Add stingray usb phy driver
  arm64: dts: Add USB DT nodes for Stingray SoC

 .../bindings/phy/brcm,stingray-usb-phy.txt         |  62 ++++
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  95 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 367 +++++++++++++++++++++
 6 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

-- 
2.7.4

