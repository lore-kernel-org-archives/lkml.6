Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73741C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4FB206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4FB206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeI2EWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:22:18 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:54419 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbeI2EWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:22:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B5CB8181D3419;
        Fri, 28 Sep 2018 21:56:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: watch49_7389f4a283802
X-Filterd-Recvd-Size: 2881
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:56:33 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Pismenny <borisp@mellanox.com>, netdev@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MELLANOX ETHERNET INNOVA IPSEC DRIVER'
Date:   Fri, 28 Sep 2018 14:56:32 -0700
Message-Id: <20180928215632.30162-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9325	MELLANOX ETHERNET INNOVA IPSEC DRIVER
	9326	R:	Boris Pismenny <borisp@mellanox.com>
	9327	L:	netdev@vger.kernel.org
	9328	S:	Supported
	9329	W:	http://www.mellanox.com
	9330	Q:	http://patchwork.ozlabs.org/project/netdev/list/
	9331	F:	drivers/net/ethernet/mellanox/mlx5/core/en_ipsec/*
-->	9332	F:	drivers/net/ethernet/mellanox/mlx5/core/ipsec*

Commit that introduced this:

commit 547eede070eb981f1442e494f08f4567dcf1d1c7
 Author: Ilan Tayari <ilant@mellanox.com>
 Date:   Tue Apr 18 16:04:28 2017 +0300
 
     net/mlx5e: IPSec, Innova IPSec offload infrastructure
     
     Add Innova IPSec ESP crypto offload configuration paths.
     Detect Innova IPSec device and set the NETIF_F_HW_ESP flag.
     Configure Security Associations using the API introduced in a previous
     patch.
     
     Add Software-parser hardware descriptor layout
     Software-Parser (swp) is a hardware feature in ConnectX which allows the
     host software to specify protocol header offsets in the TX path, thus
     overriding the hardware parser.
     This is useful for protocols that the ASIC may not be able to parse on
     its own.
     
     Note that due to inline metadata, XDP is not supported in Innova IPSec.
     
     Signed-off-by: Ilan Tayari <ilant@mellanox.com>
     Signed-off-by: Yossi Kuperman <yossiku@mellanox.com>
     Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
     Signed-off-by: Boris Pismenny <borisp@mellanox.com>
     Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
 
  MAINTAINERS                                        |  10 +
  drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |  12 +
  drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +
  drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 +
  .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 415 +++++++++++++++++++++
  .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  78 ++++
  drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  14 +
  include/linux/mlx5/mlx5_ifc.h                      |   8 +-
  include/linux/mlx5/qp.h                            |  14 +-
  9 files changed, 552 insertions(+), 4 deletions(-)

No commit with drivers/net/ethernet/mellanox/mlx5/core/ipsec* found

