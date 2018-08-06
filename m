Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CF621A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vene/i5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CF621A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeHGBib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45031 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHGBia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so25222481oih.11;
        Mon, 06 Aug 2018 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hmTl8/1fRiYZPHtNk6ThTZh2VqXnVbDxTlqsL3JkjaA=;
        b=vene/i5bbGvykssAvZFw0/PWoB9Ma7/wBHYXcIfp0z1kKroMtjf+bOoQLGEG8Mi638
         WMqQEsBMrLA29DzYiEAHzGa2R+9DK5pc3kanO5o4hJRgRUhp9K4CSsqtePVYKQpWSLIa
         wY6KT6uEgzlqeqr+an8uf/yNWWIeGmOeg6cwIHWtrqPrxb0YSu9lvoZJfhYOKOzKfxfH
         ZfBrug+CTEsV2Od9lR3fYMcy5LLK3nn9Onag5rJjdyp6nFwqyuUitpI6YCfR+UN9g5UA
         wlEGJJh2Koa4NfgOjll3KZHO2s1eaDcxP8eZovRhh2vtGpAQOt0gcqb0hbJFjrlleUG3
         4yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hmTl8/1fRiYZPHtNk6ThTZh2VqXnVbDxTlqsL3JkjaA=;
        b=F8eV4ClJQGfxQYXfyT0AO3Ohne7C21Tp9ry8FdoPw7UwwmHyhE6m0UaXFbDIUIF7vO
         bH7hLSx2SYcbu5Bqo9AQQFOOMKCfAh+N/0ZEBLFRNIapKKtyOj40ZNvAGQxu2fTgfMxt
         1OiA+CP98HexizRRkGbjVDGESPqWVvej1ux3TiG7ryw3OR3kdptvHyMTHFKEruwqHtjN
         PE7bB4Hl9FarKO73+d0D3r+hgbnzqDKNI0qM+PDoEBx+zMKCqAkS92rPFcOd/1vyct1x
         UNSH/J7EeYZVlhiZJ031EXvJWyKEe82t3eyuryco+5ivo7uuW7mjF4q8gQZ7AICwEJKn
         kkLQ==
X-Gm-Message-State: AOUpUlHUEPyEr6epmN+BAEe0llTtBElko/RGU7F2VoC6dz6UO6CVNYAo
        nMk+O3ru+Ee1aTiYNWN9z7MF+FYOgUA=
X-Google-Smtp-Source: AAOMgpewaBmZ3Hx9zpVKNq6Ibe5ag++4mpSRQyPOTkZUlk6p8Vmg8wWx1x+DWynbGTI7w4yAS9H9dw==
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr17721451oif.22.1533598025648;
        Mon, 06 Aug 2018 16:27:05 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:27:05 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
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
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:42 -0500
Message-Id: <20180806232600.25694-8-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 615005e63819..e10f9c2bea3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1045,10 +1045,6 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	dev_info(&pdev->dev, "firmware version: %d.%d.%d\n", fw_rev_maj(dev),
 		 fw_rev_min(dev), fw_rev_sub(dev));
 
-	/* Only PFs hold the relevant PCIe information for this query */
-	if (mlx5_core_is_pf(dev))
-		pcie_print_link_status(dev->pdev);
-
 	/* on load removing any previous indication of internal error, device is
 	 * up
 	 */
-- 
2.17.1

