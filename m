Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F40C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616A2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGSzBqkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616A2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH1VrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:47:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45285 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1VrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:47:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4-v6so1072093pgv.12;
        Tue, 28 Aug 2018 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VGCBhX5C5SjEY0Ae21e75+ysoZqQXwgr6HRAfKEkgzk=;
        b=RGSzBqkmU/B5IpRh0hjwY1KAqrrKI8IknjME119cpGWlv1nWbUPcVey7DPd9ET2bzH
         ucVILk2RrbGGfEuxmqpWTh4Xkyi8oK3mAXtdW+qKzcgF8iVXMeqHDdwHuke6rdDMhR7+
         QSrFLR9+43sUInQhppWn+ASL0VfpUlSNI+mggFDmA9Mt9zXCAVIsE1J0sY+wmeAeBFH5
         iXQ6T6ZbGRLNNR/QfpIThFN/LYYbKMI/OQgTQH+ei3dm06uBoj4GhQ3G7gwIUPXxrRJm
         eCrs3LycTLuR4qLeupSuOXOBtDU7bEWx6QprU6HeRBGf13AgTjfIkj/w7Dj2RxhCNMgN
         2DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VGCBhX5C5SjEY0Ae21e75+ysoZqQXwgr6HRAfKEkgzk=;
        b=rMI3V1Sd0kTsrC2egFkw+S33Txvv3r/17GiOSFRC7ouz0jrJnASM7GzlZnM/dxxYRT
         h5WqF5uVDqkTmo1ae+F6Vzh+Df5nUALdvm+AV//5lwoCjHLdeDBWvz5zxFoRdN+wShI/
         4xz8j0HnQuZOKx07qLVkE/o+uYtC7zTe6uhxG+C8lZLyV1aaFnAqS8xSdpocaeezCbIU
         +wLnN0lvnadUEkmFYsxMz+78C3p/ZBAujn75BSr66lEDVcJro4VknQm6YXL+9Sxf3uMc
         +bbX0/0k22v1F/KkKCyD4A/59TLmOIod4hZ5UVcQLzabB49eQDyRmaGtC3isdwmKwSVR
         TTXA==
X-Gm-Message-State: APzg51DrtsfvC4AhyQnYOJ+ptONruaQNuS0KTcTqFxoNG64M/elV9ISU
        b/y1RGteniAgO6aoQJIlg9E=
X-Google-Smtp-Source: ANB0VdawcvgB1PaIoBwn3jGIY/OLaYyhMVEEV3ip0lu24L7IAcN7N1PceI6oNyEjqJ6rRbnzt8xKEQ==
X-Received: by 2002:a63:225f:: with SMTP id t31-v6mr2474940pgm.275.1535478872200;
        Tue, 28 Aug 2018 10:54:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v23-v6sm2664465pfm.80.2018.08.28.10.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:54:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH v2 0/3] ARM: NSP updates to support switch interrupts/SFP
Date:   Tue, 28 Aug 2018 10:54:17 -0700
Message-Id: <20180828175420.7992-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series updates the ARM NSP DTS and BCM958625HR in order to
support the SFP connected to port 5 on these reference boards.

I will be submitting the functional changes to drivers/net/dsa/b53 once
net-next opens back up, but this is largely independent from getting
these 3 patches out.

Thank you

Changes in v2:

- added missing managed = "in-band-status" property
- reworded the commit message to explain the limitation of i2c-proc
  is of 63 bytes per transfer, not 256 bytes

Florian Fainelli (3):
  ARM: dts: NSP: Enable SFP on bcm958625hr
  dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
  ARM: dts: NSP: Wire up switch interrupts

 .../devicetree/bindings/net/dsa/b53.txt       | 23 ++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 31 ++++++++++++++++++-
 arch/arm/boot/dts/bcm958625hr.dts             | 26 ++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.17.1

