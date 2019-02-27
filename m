Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00388218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXFBR0HJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfB0GEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:04:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37141 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfB0GEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:04:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so7464079pll.4;
        Tue, 26 Feb 2019 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0yt638jW4EQp12IiJOhGMpFngqFC+Qq8MVhJJyxIdK0=;
        b=mXFBR0HJCYiHjxdTojmuz7CQ/2EzgTSmOjR9KCE+5ai0nx09sXyND9fgCACKvkUyRT
         A71Flj0kukkjXCkAT6Xcn9x/g7tqjuck/34EpQuItO9l/EODOsz/s234y+6Zo4zpRdLZ
         K196RuHQ+SBk517Caocj+wViuYnxBkjLZSty22RbaFvF7CqyejtSAIdmc6A7PVo9NCm6
         xWGX4r3d/cZOfN3PHjyyWFdcb89mwNsMYSUUOI8h1FgPfK/pk1xPnf7yRugjGHOC9sjn
         tWCGIUBk5OI20NyB7FYJ8E5Sfordr1+2xLr5wUtGRvvxKvDdb1PARpTtRNKD0glhzCy7
         pukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0yt638jW4EQp12IiJOhGMpFngqFC+Qq8MVhJJyxIdK0=;
        b=TswSYRAyLgaXYNviyy/dV1JP3k6HxjwWhHBYn0zyayorQkyeYNyAxlW4epV6oF/EX5
         +6I6Etpn80T0QlS6o5yAc/frVVWyHbJJ9TalL+y6U1QdEY5R809St8FnoyGZdv6wvq1w
         IEpy7kL6oUQp3CqLIlKKU2XTH0MSOgNZKx+ckLQOFzji1TXs9GOaNf9MUeR854rnUy8P
         mCAjjlya9PMmguDYP9Gy8/o5bU0zS2ePY9ZztLCpkIU8eAHP0deyXcGTTa66rN9CwlwY
         HW1COIL2+tYz9rQkVCWaFpifiCJ91fF29yqV8HZtXXuaw7eoEAt1WqStAH7p1WaefITN
         KNbw==
X-Gm-Message-State: AHQUAuZ1YsguyzBA15oibAwpxE9vUbajiQS8X4NGIY49eBD3/j7Kt7Ab
        Lx0+yj1jcajdA1FLMuvK0u0=
X-Google-Smtp-Source: AHgI3IaYm/mBxfT3Mm8M1K13ESgj7n8jrksa7CTJpQHI8I9xXHqThbTIhK7B00R2o1T2ePWOWABCQw==
X-Received: by 2002:a17:902:6508:: with SMTP id b8mr434758plk.17.1551247484007;
        Tue, 26 Feb 2019 22:04:44 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::87c4])
        by smtp.gmail.com with ESMTPSA id d6sm1403539pfg.47.2019.02.26.22.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 22:04:43 -0800 (PST)
Date:   Tue, 26 Feb 2019 22:04:54 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] net: ethernet: reduce calls to memset(,0)
Message-ID: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes calls to memset(,0) that are
redundant when used in conjunction with a zalloc call or
by simple zero-assignment of structs.

Robert Eshleman (8):
  net/mlx4: use kzalloc instead of kmalloc
  net/mlxsw: use pci_zalloc_consistent instead of pci_alloc_consistent
  tlan: use pci_zalloc instead of pci_alloc
  qed: remove unnecessary memsets
  at12: use pci_zalloc instead of pci_alloc
  netxen: remove unnecessary memset(,0) calls
  net: seeq: replace kmalloc / memset(,0) with kzalloc
  net: ethernet: ixp4xx_eth: remove memset(,0) with zalloc

 drivers/net/ethernet/atheros/atlx/atl2.c      |  5 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c      |  1 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  3 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  7 +-
 .../ethernet/qlogic/netxen/netxen_nic_ctx.c   | 36 ++++------
 drivers/net/ethernet/qlogic/qed/qed_cxt.c     |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_hw.c      |  3 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     | 70 ++++++-------------
 drivers/net/ethernet/seeq/ether3.c            |  3 +-
 drivers/net/ethernet/ti/tlan.c                |  9 ++-
 drivers/net/ethernet/xscale/ixp4xx_eth.c      |  7 +-
 11 files changed, 52 insertions(+), 96 deletions(-)

-- 
2.20.1

