Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52612C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcGK190f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBKVSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:18:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39721 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:18:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id f132so158061pfa.6;
        Mon, 11 Feb 2019 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dk33WpR7T6/ZBSK4ANXuVhEiabNiC++NqI2VNDCsbEo=;
        b=vcGK190fzb6qPmbRgU8H1IIYd1aRWwkutxxkc3qOLUpH7aFk8LgRuePLOfJ7OlCDF2
         ELWQ9CdD2sfrWO5c4x1wTm/p7ngbPTqs8NPHXKvSeyzSk0v2g6Y51n1ta3S3JVWVNrvT
         VWMkUpJ2JOkCTlWMsNOPD8Uu/bzbuDV3DdMrA1HRoG9MUyEVN5kpdGQq/4fGKS9RA3Iy
         1YBmQUeDRlIlXoxdWjfDnT9h9rCuPlNdFQLy9iuYomabgo67i5e1sDcG9OZ+JK+15qCC
         genOlZFzEFjBvY4AMZOZZLE+0nLI2olJIeZ0q4N/XcIx+dg7AMvMnyXXJL+BfTusU2VL
         FbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dk33WpR7T6/ZBSK4ANXuVhEiabNiC++NqI2VNDCsbEo=;
        b=lyBrhVnxxbBolPMuMh2qpxxJifnu1mFKEQt3rURZiuZkUqN81iXvNAE83SIrivU/GM
         IoHKMi6MJxhL0W0heFFlLCx/iwqGvVGBOM91Z89Oz7j6LTfzY81+yTlUkA84QRNM6Z3O
         7kZk+vH9EHBZNhbmQ7o6J9321mALNNz3Xoko5399YWbGJ96AZ2t7UUiYXjU09gvjMMcc
         ZXh4OJeto16ZY9BajNKFNI1VRWlIlcn6k3TQtZwflD3HeEjuqViQ1jh44ROlK3IAmk/H
         zt9zcBsPAcfgfnRFCOaXifz2uGF+oZCwItSiKEHCWQUbgQcVuaR+A9IpXMl5RYB9nJ5U
         dxXQ==
X-Gm-Message-State: AHQUAubBqi1XevUWvqnA9R+16nYCYbaaQyuvLu3DVn/BSodUcibL30du
        9IHz0+OPox2qzM3OUmrJ60bUVTAx
X-Google-Smtp-Source: AHgI3IYvEmu/OEong6fO6dyMHc1XKICqzejhQFN0zvFagYH0ZtxeD92unZ42YarOnaIkbnNVzUPzhw==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr262025pfm.71.1549919891253;
        Mon, 11 Feb 2019 13:18:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 24sm15213029pfr.75.2019.02.11.13.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:18:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 0/3] Remove getting SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Mon, 11 Feb 2019 13:17:46 -0800
Message-Id: <20190211211749.19847-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

AFAICT there is no code that attempts to get the value of the attribute
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
switchdev_port_attr_set().

This is effectively no doing anything and it can slow down future work
that tries to make modifications in these areas so remove that.

David, there should be no dependency with previous patch series, but
again, feedback from Ido and Jiri would be welcome in case this was
added for a reason.

Thanks!

Florian Fainelli (3):
  mlxsw: spectrum_switchdev: Remove getting PORT_BRIDGE_FLAGS
  rocker: Remove getting PORT_BRIDGE_FLAGS
  staging: fsl-dpaa2: ethsw: Remove getting PORT_BRIDGE_FLAGS

 .../mellanox/mlxsw/spectrum_switchdev.c         | 17 -----------------
 drivers/net/ethernet/rocker/rocker.h            |  2 --
 drivers/net/ethernet/rocker/rocker_main.c       | 15 ---------------
 drivers/net/ethernet/rocker/rocker_ofdpa.c      | 10 ----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |  5 -----
 5 files changed, 49 deletions(-)

-- 
2.17.1

