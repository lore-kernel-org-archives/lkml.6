Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FF20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne5zctDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2FF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeICWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40247 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so2248657oig.7;
        Mon, 03 Sep 2018 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NyzqkBvvRFaYY1/t28udcxu1QEwQXtRB+qE2FzRBy5M=;
        b=Ne5zctDo82Bgg7ySoKR1HfsX4PLT6fzAdIEuz3TfhUWUNJsY+lof2kmW/ELcSipR4U
         TV7LZgPEQT17gTJ2o3TtDZV8gElnvw/jgPqxbgoUMsjTisxDM1jG1U/MU0f46JY0TzxQ
         gwFi4zB0zL5BEVU/BJ6W/9tP5ms6QuH7SaG+IMrYj0Tq6gYoLNMGStrIJIZVLWgZWQsS
         7rqT1tNd1yGbB7fIfiFDCZStSAGEFzN5MM5oGtk7MVp7MpVaKl1VHC5fPUkR+haZAvEz
         e703+pQuAiFQxVw0vJtHDUg8LBm8jQ+Xq7FH0c5FGrp9W7JrpfjGVSA1pny1IFDqxcqi
         +7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NyzqkBvvRFaYY1/t28udcxu1QEwQXtRB+qE2FzRBy5M=;
        b=s5kwOrTzTk1k7Wbs2L5hQJm2dMw4u1hu0tPNIHrMLFPURZk9UYZ7suMSo+XXhC1R44
         u+ZfKn0fl0TwZrYNHUvs32VGs63225UbYyNxeJ1HjDawsODU98uPvrrjiNGxNuWwiDyI
         D3YXzQoLoB4dbz+i6D3K0kjrOyGkjCgugFgIsHQ3ebMqANTctFqC/KmqKrpr8NhHUiZ5
         fdDckgpMvsJ1S0aUMfY9lNChypmI0Vi2AmALLIA1/WcTz/smJEn9JQ3+vwQD2EI8xuKP
         In18TdsDs6e7pZwmLy41qUJvseggRlyNJiGBzyGDA8EnFLmd6PKpT/JwcIvUkgzM3Hm3
         PSQA==
X-Gm-Message-State: APzg51BKFtIQQ2EhlRgfHvLLzyCJwiLy9TvwlWmzsxqEXa+uuqqmoJD3
        nNevo3GvXVVYeRwbPv+xMt0ntPokGMM=
X-Google-Smtp-Source: ANB0VdYYDr5bk34Qgs9MNWjpgO37tGwue9WedkSJUaBN2J9ZpVHTozuprEeWnsTy9SBong8Er8TWwQ==
X-Received: by 2002:aca:b985:: with SMTP id j127-v6mr19739255oif.257.1535997773041;
        Mon, 03 Sep 2018 11:02:53 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:02:52 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH 0/9] Export PCIe bandwidth via sysfs
Date:   Mon,  3 Sep 2018 13:02:27 -0500
Message-Id: <20180903180242.14504-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-on series to
Commit 2d1ce5ec2117 ("PCI: Check for PCIe Link downtraining")

The remaining issues was that some pcie drivers print link status directly,
sometimes resulting in duplicate system log messages with degraded links.

From my understanding, the maintainers of these drivers are fine with
removing the duplicate prints as long as the bandwidth information is
readily available. sysfs seemed to be the consensus.

Example:

	$ cat /sys/bus/pci/devices/0000:b1:00.0/available_bandwidth
	7.876 Gb/s


Alexandru Gagniuc (9):
  PCI: sysfs: Export available PCIe bandwidth
  bnx2x: Do not call pcie_print_link_status()
  bnxt_en: Do not call pcie_print_link_status()
  cxgb4: Do not call pcie_print_link_status()
  fm10k: Do not call pcie_print_link_status()
  ixgbe: Do not call pcie_print_link_status()
  net/mlx4: Do not call pcie_print_link_status()
  net/mlx5: Do not call pcie_print_link_status()
  nfp: Do not call pcie_print_link_status()

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 -
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  3 ---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  3 ---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 -------------------
 drivers/net/ethernet/mellanox/mlx4/main.c     |  7 -----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 ---
 .../netronome/nfp/nfpcore/nfp6000_pcie.c      |  1 -
 drivers/pci/pci-sysfs.c                       | 13 ++++++++++
 9 files changed, 13 insertions(+), 46 deletions(-)

-- 
2.17.1

