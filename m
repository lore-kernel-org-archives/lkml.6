Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE57222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAMYPy44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfBMWHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfBMWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so1826874pfh.13;
        Wed, 13 Feb 2019 14:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yH0+HAx5nlwub69336QwKNCKOG2nZFkQBO4sLZZiCxQ=;
        b=DAMYPy44Dh8jB5zXG7Vw6j3qR/lSAeS1xx+A74NqsGs98Os0bCd+SFSmc6prkHZpWy
         g4Kh5cPkLSde4mc4L4iX5GVlWps2mjyh7LPidLNtzAU3l9j/L6gt3AFdYmg6LDRk+hRL
         PChCcKaewiwYkPglASE+h+hIsGFfIjudGjtquvDZlpSu6Weg4gBW5cotwLXKt1G0T3hw
         mUr1i7+qNeaXStCFGUfCPK8mAufmzN/bklcifhcO/7NTYmCpT13dbeQdEUK8hWpWVskj
         R8NVbEnbwPCa/a/BtoESHXExviQ4lmkKPbl0OUCIn2BvAKIDPIoj/O+vUTRiaSWPU7Ys
         JKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yH0+HAx5nlwub69336QwKNCKOG2nZFkQBO4sLZZiCxQ=;
        b=h3F/F16f1WfKyvijNl+xlvxRA8uWjRdvceNUC4qgu9bctjH04pU/IRpmh3tgfEgaRG
         gR2GkowuExIsqxemMp8gecHdrUOcbqSigyi3uxDkqDbmLIe6v3pli3HqCabBm+yiLgaQ
         Lv3547gROw/X2kvGZ3qs5boQgEibOOoFPFIjoYSY8O4FvDwGg1UH8zUE8mebSvO/F/UE
         njgAvopHlc0SXgsNsvcMcyAL6batlkeDqxCB/2Fc7IQoaz60tr8o7pknotl9hZ4OaYdV
         wuQDj4x/a7WZU9DNuw6fFZmk23F1W8eC0pL9Ho2ItaWf0oHB2PxZ+09N2NZATE+g4whC
         w4ew==
X-Gm-Message-State: AHQUAuZrU2qHiCM8e5vzeMjpomZjbANhea5Fv0bBV0HRLP8jyCSzXkti
        HGRLsAIH5DFBgcp7u+HRIobhrW/8
X-Google-Smtp-Source: AHgI3Iaayku/iu20xdr03gkLkSmdcYoK1y7QpqUGSFLeX/KiwWmlGXiGFNtG9HGYBJAJXykNu/k5/Q==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr367455pfq.243.1550095631111;
        Wed, 13 Feb 2019 14:07:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 0/9] net: Get rid of switchdev_port_attr_get()
Date:   Wed, 13 Feb 2019 14:06:29 -0800
Message-Id: <20190213220638.1552-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series splits the removal of the switchdev_ops that was
proposed a few times before and first tackles the easy part which is the
removal of the single call to switchdev_port_attr_get() within the
bridge code.

As suggestd by Ido, this patch series adds a
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS which is used in the same
context as the caller of switchdev_port_attr_set(), so not deferred, and
then the operation is carried out in deferred context with setting a
support bridge port flag.

Follow-up patches will do the switchdev_ops removal after introducing
the proper helpers for the switchdev blocking notifier to work across
stacked devices (unlike the previous submissions).

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
  mlxsw: spectrum: Check bridge flags during prepare phase
  staging: fsl-dpaa2: ethsw: Check bridge port flags during prepare
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check bridge flags during prepare phase
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()

 Documentation/networking/switchdev.txt        | 15 ++---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 30 +++------
 drivers/net/ethernet/rocker/rocker_main.c     | 67 +++++++++----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 27 +++-----
 include/net/switchdev.h                       | 13 +---
 net/bridge/br_switchdev.c                     | 16 ++---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 11 +++
 net/dsa/slave.c                               | 22 ++----
 9 files changed, 88 insertions(+), 116 deletions(-)

-- 
2.17.1

