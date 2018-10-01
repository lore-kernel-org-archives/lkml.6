Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22AFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B79C2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo+Ij24G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B79C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJBAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:12:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43435 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:12:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so4745112wrt.10;
        Mon, 01 Oct 2018 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6+WImWnUmWpZZKMFxKXM/4APCjDo2oZYqiyTicI55qI=;
        b=uo+Ij24GRCf8XNrsVAwCfMWqjot73Dak0Qbk+IZ3F34E2QZn7Xtl7oH+TQMXblruyq
         PW8o2RHtpKNVGPJ+ZrcujE+DmitKhlKsY8P7nsYNK66Oyr+8FvLODezLFpowSpXnHkmb
         sgvQN2qosoCNTf7E5BPxmv1sVyfMXwhNAPAzki2ZnFpFZDRPadizXUar8k+RizpstJ1l
         IX5C5TofJTUcsXtqLTQDdYtTaUoKIsqvA8L+8OsQUjIUvRGjSKR5EhzWAgqfKRS8DRAn
         CMMnsHSLJWX4tLjC+T+KZMIrQRuyX/uBrOZaAjzEaql86xcr8LuFNfdXHkeHzkAixOnd
         sJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+WImWnUmWpZZKMFxKXM/4APCjDo2oZYqiyTicI55qI=;
        b=MMEIIboTVsbLR9SNURjoQWE/csIJ/QCNR10YJ7HPbFF6wcP9kogufj17uxaaDqz7u+
         fhcx7SGEiBUk2Z3xTRy1Odjd89y2se2zSydUGeDItj3USMsPXHbsCa53hH8xwYSPxm+M
         nnpOpsTozyUS4zWJrJzOeS2A/mvq2qtUjdC6PzC3UR1fdSriy85ugFPR/Vu4N6uaqGhL
         yMMynP7zXTgb5MBheB7b1p+FXZild8+ft9XQHr0/BPQdvQE6go+iXmyc0aG1daimi8I8
         vS/nD5I8ICf8uF04c03K3xqmArULoOfstRfB9+cvg9DZSIh+BLtAOiebrUXMvoR29LxB
         1JZA==
X-Gm-Message-State: ABuFfoja3Z5bSUCXsO90iL8pN8/Y8aslwkfnfCGEkRrLu/tD0rLMooeU
        hsgqwnAXjrG5zmbYRCjzBnmmoAdc
X-Google-Smtp-Source: ACcGV60XXEfakO4sqVwl25RvvtUzeCJi0O5SRq2+BxiQcON2KzqfUzYbMPrVziLhsL7nU+jg+Xf6Kg==
X-Received: by 2002:adf:d249:: with SMTP id o9-v6mr7287634wri.66.1538415193626;
        Mon, 01 Oct 2018 10:33:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7840651wru.31.2018.10.01.10.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:33:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 0/4] AHCI support for BCM63138
Date:   Mon,  1 Oct 2018 10:32:58 -0700
Message-Id: <20181001173302.25398-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This is a resend of the previous series posted here:

https://lkml.org/lkml/2018/9/20/1060

With a few minor changes:

- rebased against your for-4.20/libata branch
- added Rob's Reviewed-by to patch
- fixed the use of the reset controller API

Thank you!

Florian Fainelli (4):
  dt-bindings: ata: Document BCM63138 compatible string
  ata: ahci_brcm: Allow optional reset controller to be used
  ata: ahci_brcm: Match BCM63138 compatible strings
  ata: ahci_brcm: Allow using driver or DSL SoCs

 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 drivers/ata/Kconfig                                      | 3 ++-
 drivers/ata/ahci_brcm.c                                  | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

