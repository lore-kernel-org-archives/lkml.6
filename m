Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A923C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0730222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJGqhF06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394094AbfBOWxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42744 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfBOWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so5506664pfi.9;
        Fri, 15 Feb 2019 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HHcbuQ1Dab87tMWPIDFQx2pV0Q6b8Koh9aAkf+7cAx4=;
        b=oJGqhF06sMp0i0bS0UkAgCF29jUOVqrOw+5dnoeVuDiOYApWTLwWIWN4nE5n60KfLc
         ChlXsFMhV75csVimykFkloo1uQ/lCbZLKETkkDDt5Aq2YF1qDGm/zwUtkw+yum2f5hss
         RfU6NMzl/BWe7mQ0MXuai6FLkjU/w8gSxg62zv3CiShe0wWaB96UY2c5UiCVUecLjGNs
         WrHKAbHTx6RKSzA32yNtwzCYysoMzK4Sr7SfTEtH0lMqRMRqCYpMashjE3XOqCt/7Emz
         G6JeNb8jZKXWOIsqiDLOkcY4XS5/ND3m/pNSnhwFUJ2izuVn094sZkZa+LAWDpXYfX0e
         qR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HHcbuQ1Dab87tMWPIDFQx2pV0Q6b8Koh9aAkf+7cAx4=;
        b=RR8G2fhWz4kRnivTlllxxzOjBGJ6Ct/4oEubje1Zk+q9arZre7KRXxiqE5zN+kltJP
         vJ1YmTBhk7i+KlTxnISLe1N6d0mqsAYhOngCQkHbDfVW08exS9oDn4wETJzzxL8SGjAj
         cS/CBTMli0DuuSzeJXyiGdCdq52qLYxf+14nQCG/eikyeLPc4pcNtlNeanMTXPP9839W
         3dOWWE4yjgYay/fxKaad2fhcGI8RW4yallAizi9Uv5XmcWrVPbC7fdQauPCgnlY4tk2Y
         q9zGfCpV5C3iRa56BLuCy+jnCNdYirQsQnmu3fMf23ERX1TzcD10wsPewFpoiMQ13Zf6
         6B9Q==
X-Gm-Message-State: AHQUAuYUlhMCpZpSZ1K4L3u7sJkPl1WWqMrti/62lfb41GQiDma0flt+
        GG1DMrRLXOqFDn+0vRRevPuZjmf5
X-Google-Smtp-Source: AHgI3IYk8DF7RySQ7iQGxX/EVgMQmVTtZM5nXG6Tngx9lAFpQOjkh9ryGHxF5gn1gl/gdR0Erlqg5g==
X-Received: by 2002:a63:105a:: with SMTP id 26mr7359531pgq.184.1550271198276;
        Fri, 15 Feb 2019 14:53:18 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 0/9] net: Get rid of switchdev_port_attr_get()
Date:   Fri, 15 Feb 2019 14:53:04 -0800
Message-Id: <20190215225313.32303-1-f.fainelli@gmail.com>
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

Changes in v2:

- differentiate callers not supporting switchdev_port_attr_set() from
  the driver not being able to support specific bridge flags

- pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check

- skip prepare phase for PRE_BRIDGE_FLAGS

- corrected documentation a bit more

- tested bridge_vlan_aware.sh with veth/VRF

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
  mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
  staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()

 Documentation/networking/switchdev.txt        | 16 ++--
 .../mellanox/mlxsw/spectrum_switchdev.c       | 38 +++++-----
 drivers/net/ethernet/rocker/rocker_main.c     | 75 +++++++++++--------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 32 ++++----
 include/net/switchdev.h                       | 13 +---
 net/bridge/br_switchdev.c                     | 11 ++-
 net/dsa/dsa_priv.h                            |  6 ++
 net/dsa/port.c                                | 17 +++++
 net/dsa/slave.c                               | 24 +++---
 9 files changed, 128 insertions(+), 104 deletions(-)

-- 
2.17.1

