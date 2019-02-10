Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A87C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDBB20874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFhjxPHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBJRxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39748 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfBJRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so13892897otl.6;
        Sun, 10 Feb 2019 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9j78vu7ptfWqRyUO8h/FcNUzTEZkGd60eZJnk+28JkI=;
        b=LFhjxPHt8r/+VF7jvkLf35nXy0MpozaT0bKd630pgNvgmQ9OmbAfSPM3rEfWvNkFCA
         P2a/42B0bJ/Hg8X5iNvKFwr/A5cc0Nb04gm5l1RgSSyT1IWjGq7aCGJMrt6BYeur3x9G
         WMzx3rpBzxVstQtdSNydYlxGWdfSZDOtVBGAV3rkqxaacCz2wgMCqzDfsTyYNq8XU8uT
         ErqvAEmsdPMD4+tbcGKCk9yThrkUFcxRzEF/ABj0m/LWVdq0w47Os9vhWZ94nmI/o9Cd
         merPd1QjVAo+96PcNzRRNiQAmPtNHCEbZuU13+fcxHiMC/Y5VSqpD7qbr6WAfqBn0Kan
         hauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9j78vu7ptfWqRyUO8h/FcNUzTEZkGd60eZJnk+28JkI=;
        b=e78HG39/ZLBUjhec7QxyRhIHkA2UjzFAzXU6KnphQtaY/0XC06AtbrIZC8wQ93wIO8
         4Jf5Uaxaq0e11fEiQUbspLcxUs84Z+DWxkdPSW77bBzACkhIfiyZVhUoQahkr0amdCfJ
         GEWgi4dupXxKghWDZrYeHYTx/jq2l/yqY+SN/GLNajGG/ccNpjG1QmlfHWIf03Yc8dTZ
         W0CAl/qnXBshPPl+rb1ImU7T+a4rybhDncW5GaTkla2Hjm/P7yiSUlbVDoCr2oCxQvuQ
         DSS44uyTCEhrI3R19Mi6q2/Jynac3hbHbij1gLsl2l5hajfVlbRKRe9TzPLexYmSTJDf
         Vdxg==
X-Gm-Message-State: AHQUAub9Hj8lBzwwiWV/JroOUoIsuowHGJUNGU+iZnFakVD4ncjGHgVw
        Lv7UHZ2NOMSDNmP1VkegxkyCGvz+
X-Google-Smtp-Source: AHgI3IZXkxWfQrjE4ZCRSmB5Jle8Kzm5NPkCWzIXjbgurAlEVC2NsrY6HTpTSsVxZ5DtdSA3WvieTA==
X-Received: by 2002:a9d:3b21:: with SMTP id z30mr25764589otb.132.1549821194381;
        Sun, 10 Feb 2019 09:53:14 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 00/16] net: Remove switchdev_ops
Date:   Sun, 10 Feb 2019 09:50:49 -0800
Message-Id: <20190210175105.31629-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series finishes by the removal of switchdev_ops. To get there
we need to do a few things:

- get rid of the one and only call to switchdev_port_attr_get() which is
  used to fetch the device's bridge port flags capabilities, instead we
  can just check what flags are being programmed during the prepare
  phase

- once we get rid of getting switchdev port attributes we convert the
  setting of such attributes using a blocking notifier

And then remove switchdev_ops completely.

Please review and let me know what you think!

Changes in v2:
- fixed bisectability issues in patch #15
- added Acked-by from Jiri where necessary
- fixed a few minor issues according to Jiri's feedback:
	- rename port_attr_event -> port_attr_set_event
	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events

Florian Fainelli (16):
  Documentation: networking: switchdev: Update port parent ID section
  mlxsw: spectrum: Check bridge flags during prepare phase
  staging: fsl-dpaa2: ethsw: Check bridge port flags during set
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check bridge flags during prepare phase
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        | 15 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 ---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       | 69 ++++----------
 drivers/net/ethernet/mscc/ocelot.c            | 21 +++-
 drivers/net/ethernet/rocker/rocker_main.c     | 95 ++++++++-----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 48 ++++------
 include/linux/netdevice.h                     |  3 -
 include/net/switchdev.h                       | 36 ++-----
 net/bridge/br_switchdev.c                     | 20 +---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 10 ++
 net/dsa/slave.c                               | 40 ++++----
 net/switchdev/switchdev.c                     | 92 +++++-------------
 14 files changed, 170 insertions(+), 296 deletions(-)

-- 
2.19.1

