Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6537C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BAD222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeeoVOnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394587AbfBPE4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35236 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfBPE4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so20225631otm.2;
        Fri, 15 Feb 2019 20:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNG4klDGEv3kNGo5+FcMdjwL5gIJg7XptcxvkwMC+hY=;
        b=AeeoVOnW+7IZAlDl8y1mm89//9WY4i78VAFEVoyGppcNMJsIDtu+GZ17Ml70RTjUJ9
         2WGxwjhaGDFL0RHbwkT4S7c3b1FD76CdnyGJkddbXHnAwKwNP2I6AZSir7NN0M4kI/IV
         irPGJ0OwpNnyEG/6UN4ZlulFanJzWkyvHMhfCnhv0zKzZeieS3aCRwCDPAINBGzVIpvE
         Hxa/uTzuZLTS9qrAwDTUgTGSF4wIQRok8nfQ8FOPVd6Oqiksn/fi0+UjYnLgiplLLe7D
         zE9QtVfWfnUyegS3K4oirjt87YRIzzqRre5wQg/6hEYPaZVluqcrkKooBwZg/cPe3PJD
         wFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNG4klDGEv3kNGo5+FcMdjwL5gIJg7XptcxvkwMC+hY=;
        b=g8wUiK+lo/94cwvMWJGh/RUEA6A1cL16hEs0qPMp736sYhOfCaN61f+5Cy00szFWp1
         wTrZ7vSoVDq+Zmfg1V/08CjcYlhxboWife01xG28KN0K5lPSHdwkJi+jC8EP17o63RBi
         +Qf0o0ejtKmocNEp6M8zz2pSenJpHprP/wWfTb5a53+7QNFrrnu9/rLjfnkEvozv4P3X
         vX1JNvr6HdaArSzELQmcHoLmV0ZdxEsSzb76Tt2G8u4AoByg+FFZUsMFaqb+jQAsqxiJ
         WfakBRyx/nG3d8aUKvY+sMsO54ddtyAZkltxvGsrmOTv7lpgIhsSrNXTLPris0voLw12
         p9kw==
X-Gm-Message-State: AHQUAuZXgtSCdm67x6nPXo6mA5Oua+JAdvVZNKzp49ifo2T8DG1ym+iX
        Foe+jBsio0N4zef4MZ6fbYlWVWSG
X-Google-Smtp-Source: AHgI3IZtlVS86zqrp3A2ZooBHBdOIioMB3Q7LuqAT8rHd/nnTo1ieLdJGbmDIKzTqluXLjMkB8en0A==
X-Received: by 2002:aca:c2c4:: with SMTP id s187mr2582811oif.175.1550292963040;
        Fri, 15 Feb 2019 20:56:03 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 0/9] net: Get rid of switchdev_port_attr_get()
Date:   Fri, 15 Feb 2019 20:55:47 -0800
Message-Id: <20190216045556.3514-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes in v3:
- fixed build failure in mlxsw/spectrum_switchdev.c due to left over
  argument

- fixed unused variable in rocker

Changes in v2:

- differentiate callers not supporting switchdev_port_attr_set() from
  the driver not being able to support specific bridge flags

- pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check

- skip prepare phase for PRE_BRIDGE_FLAGS

- corrected documentation a bit more

- tested bridge_vlan_aware.sh with veth/VRF

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
  rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: switchdev: Replace port attr get/set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
 drivers/net/ethernet/mscc/ocelot.c            |  26 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  28 ++---
 net/dsa/slave.c                               |  30 ++++-
 net/switchdev/switchdev.c                     | 107 ++++++------------
 11 files changed, 168 insertions(+), 146 deletions(-)

-- 
2.19.1

