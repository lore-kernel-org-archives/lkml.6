Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuansByA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfAOSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:44:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfAOSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:44:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so1595875pgq.8;
        Tue, 15 Jan 2019 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KAVBr5CS8Qo4S67pHQw9icu33rQ3S+2XzKFXM2ytaxg=;
        b=IuansByA0fxme6Tv2drKKhqr7YIFZCNOCy0fGHAQORUVVLhE1pQX6HA2pvkV5uvZP6
         HuE6/SIGErPfYe4PeQB17Kxq/5Ux0Jejo9BxHfZR78aoRgLwFm4rrdDUlyS6hXi9p9aJ
         3QQjJxN/KIFtngyQlth3PGUE0C8NUjEjE7CQHKlySdloOcfzMWzr8yrxWI9pM0q+B+Dz
         X2BWxjqCjzX7R3u+7rJ20BwbM7gT3YOf4gK44/3ltRoxhfh6mlgi2vHT2jc3o/435zal
         DOIaNu4D4C8gk0fSdYGdUVpmPOgkHvNrUa6Atqqp375c/Cdd8QdLSSKaCHYkVcI1ibjl
         KPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KAVBr5CS8Qo4S67pHQw9icu33rQ3S+2XzKFXM2ytaxg=;
        b=oLD0Ozx+UW5eX8enl3ftjLUfn/s5Teu1wG0LY0wn4Os1IhoKQZ73XafgXCX7EBV5cM
         jrGVtrDYq0P2l0ZeRVjJPl4wSNMObC9Rr5+XtPnlQKgJ6cmELfq7O/R0xNL7HBxNZ4qx
         rvFqdgy/eT/lAtWGfnWP6643wXwfpL07kK591OkbErtBiPwsx75Z2CP1umlxtBpFvrx6
         HPbSNFLf089YRYkVclJuiSvWwO3bV2ZinidVZpcu/7gwNo4Z2SYrMjYhZ0swojN3mOV0
         8TQ3ecCcbhtm4GGeai+U/JN0L6LckxIM3b6McGv77q8pi62ztZqH+FkdMBYFwNSmWWS/
         15vg==
X-Gm-Message-State: AJcUukfzjI3jtUtS0Jnb1SMbtdhHlU0JnNEo77jcqT+3fRhWL6JjV7GM
        kvTTpzEgpv2aNSgbhOoDmtJmYP4d
X-Google-Smtp-Source: ALg8bN7XWuqtXJlHmz0fnF7/u560DfK8y4X1sa8JIG/U3j4O5XfIOKhgS3XqGRO8eWSNohCvJI3MUw==
X-Received: by 2002:a62:1992:: with SMTP id 140mr5449956pfz.33.1547577867838;
        Tue, 15 Jan 2019 10:44:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id m67sm9156950pfb.25.2019.01.15.10.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:44:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v2 0/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date:   Tue, 15 Jan 2019 10:44:04 -0800
Message-Id: <20190115184406.3164-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This patch series adds support for the Broadcom STB reset controller
using SW_INIT-style registers which have one or more banks of 32
reset lines and separate CLEAR/SET/STATUS registers.

Thanks!

Changes in v2:

- utilize SW_INIT_BIT() in status callback
- removed unused members of private structure
- confirmed maximum reset duration with designers
- renamed binding to brcm,brcmstb-reset.txt


Florian Fainelli (2):
  dt-bindings: reset: Add document for Broadcom STB reset controller
  reset: Add Broadcom STB SW_INIT reset controller driver

 .../bindings/reset/brcm,brcmstb-reset.txt     |  27 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb.c                 | 130 ++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 drivers/reset/reset-brcmstb.c

-- 
2.17.1

