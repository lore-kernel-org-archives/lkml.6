Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2654AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E459320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXHYChJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBUA6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUA6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id s1so13180030plp.9;
        Wed, 20 Feb 2019 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qeGucNcR1Ixrosfg05/ynjm177ucrRZgoNcvbGuBl8E=;
        b=XXHYChJdUNonKzSSzYTv6hz00p34+KRTpCyczG7MuFTArT7PqyJcGifbGGPFOBzEMp
         tcnLKpqKoRyoSGaBltOIxQ28HQydVAgTOzwV4LSKaBg97OI0HR2p/1qiXYEW1B7aByGd
         2Mqp3aOJlSqpH399kBhqbPMrIk30SGyw8tChmrYFaVEyf9WG93l8/wEn43Fpi6ui6Gvj
         zdQlmreDRJKP42uZJ9K88GHOVcZ/elfJNXMZFGP7wJYNo4g1FeNd6+Q0dHHMCuHMTUMe
         Ees9BTraoc8YxW0NBC0hO4ufW2eBJ2pkpblLARcNuvjVrtOgEGy9Y/KOhFeMiIudQR6/
         RP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qeGucNcR1Ixrosfg05/ynjm177ucrRZgoNcvbGuBl8E=;
        b=F3naSmjqu1tTpf+XqJNU0b3ihStVF+UgEq1HJnE9vOTpKYh8xTbVZW/v2UgZrGLK3N
         xMtuNvtnmHO54+/YetJFcfWcR2UHLwsfXozXoiHFa+4d9CEKy7zqVtIe+DspoTeFXA2h
         XKlp0aTwnBQ85bOIUxN+WVrf/7Jz6VvA4RXOM2Ja9qzPJX+HypV5/D6Kj0nQ6naNB4EF
         +cHOkinjh1UlfcqUFTh8MjL6TE19bv0lDZMMoMfM6gkIc61Go12KNkbezIOX40gUmeig
         HCVVZJnbCyG1oMYL3PewHWSO7Bf4Vl+YaFcza3zR68xguizLK5uXFpdAf/GRoAcRBs2y
         0u1w==
X-Gm-Message-State: AHQUAuZ2+sB9x0a7pc+Eu38Q0lt0f+nKg58EfO747Mop8O1hh5XPVvGD
        gJmXLb/F08clcB/kYHIbohC4/fiA
X-Google-Smtp-Source: AHgI3Ib1+nsbL3kGRG8grU1dS/rvqXUa53SMIRyE0MPRXvttfbozBYcT5SEN6prmACiacRfBLjtOFw==
X-Received: by 2002:a17:902:ea8c:: with SMTP id cv12mr15834301plb.123.1550710714434;
        Wed, 20 Feb 2019 16:58:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 0/8] net: Get rid of switchdev_port_attr_get()
Date:   Wed, 20 Feb 2019 16:58:18 -0800
Message-Id: <20190221005826.26317-1-f.fainelli@gmail.com>
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

David this does depend on Russell's "[PATCH net-next v5 0/3] net: dsa:
mv88e6xxx: fix IPv6".

Changes in v3:

- rebased against net-next/master after Russell's IPv6 changes to DSA
- ignore prepare/commit phase for PRE_BRIDGE_FLAGS since we don't
  want to trigger the WARN() in net/switchdev/switchdev.c in the commit
  phase

Changes in v2:

- differentiate callers not supporting switchdev_port_attr_set() from
  the driver not being able to support specific bridge flags

- pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check

- skip prepare phase for PRE_BRIDGE_FLAGS

- corrected documentation a bit more

- tested bridge_vlan_aware.sh with veth/VRF

Florian Fainelli (8):
  net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
  mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
  staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()

 Documentation/networking/switchdev.txt        |  6 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 32 ++++----
 drivers/net/ethernet/rocker/rocker_main.c     | 74 ++++++++++---------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 29 ++++----
 include/net/switchdev.h                       | 13 +---
 net/bridge/br_switchdev.c                     | 11 ++-
 net/dsa/dsa_priv.h                            |  2 +
 net/dsa/port.c                                | 12 +++
 net/dsa/slave.c                               | 25 +------
 9 files changed, 98 insertions(+), 106 deletions(-)

-- 
2.17.1

