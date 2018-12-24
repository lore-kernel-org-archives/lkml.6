Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E2C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA852184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzsRFqVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLXPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:13:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32958 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:13:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so8393582lfc.0;
        Mon, 24 Dec 2018 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UaWfd3O19XFkMzUDjx1zcfGAJ1JvDT4OOC5mghnfrY=;
        b=tzsRFqVYP0X22Z6I1nmJRHa/6rtRPmda5yc9GU0f3NhcGnVUIkPWFMCxzFhozR3Z66
         lGfDEMdzQhPdaYI+JauBOpuY5LLe7j1dXKPIdFOC8tCq9XAxeLCU1pT1+JMiP4Nqx73K
         EZ+gNlkSObes9WfOsQKl1yLh4XqFc1jkbzBH2APM5nfNba0exqnP8Byj5NxXgq6G0TLd
         pyzKQdaVqVWSYbSlsULWLssJP7BgachGEhai/f4dAqxQYuQSRW3gWnQboWDzHQr/YV3M
         5RD3eyfwBhjFTn+8Qnqe0w/CqT15pwSrb3nFPcDlJIrXn9+ela1U3s9SkLxSXCWuC6je
         FkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UaWfd3O19XFkMzUDjx1zcfGAJ1JvDT4OOC5mghnfrY=;
        b=edj60YymMWNjw9ZAC2wd1WuS2JRBbapztqe+s8G8UR6pqNCp4HTeV0YwJRkezUiDLm
         shuVLHJcy2KX2LjZFRnRsccYJgeLCIZADH7ItHIpF/Gg1XkROJv4thvn5or/b5zL5a11
         7KEPAC3layXlH0f6f8a6deNJYI1nIbQXPwoxqy0t1Hb/E43Dto/SR+h62XNDyfmq7BBm
         1fzLYUo616n0bJ70+rmAt351YjFkGH55NehNd0PdkF7CjbbJxFkHB9uM/UFRi39aafLF
         C/y1Z9SbpafGc/UoHx0VZ7mWKf4XiVeBlqAHk7Ws0GXKg14hcyBp7FmXpc7ieujNNWMT
         ATjQ==
X-Gm-Message-State: AA+aEWaEo/kfq2s6WHQ9QnJeXFs4/ZZPdsWBgSxx86BVivTm1Ec+vp6d
        YUH8t//Y5g8zAOyI9yK6h1E0cljIcGaC65oq
X-Google-Smtp-Source: AFSGD/W+vjF2SCwvwnUn/xrX0qhRdISgV99Gi2qMilV6Y4Qr1RVo5BCO7RxA4jFIvofj1frEhPNOzw==
X-Received: by 2002:a19:f89:: with SMTP id 9mr6530830lfp.10.1545664410434;
        Mon, 24 Dec 2018 07:13:30 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id r29-v6sm6324185ljd.44.2018.12.24.07.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 07:13:29 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [PATCH v2] bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some hw
Date:   Mon, 24 Dec 2018 20:13:05 +0500
Message-Id: <20181224151305.31027-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happened when I tried to boot normal Fedora 29 system with latest
available kernel (from fedora rawhide, plus some unrelated custom
patches):

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
	PGD 0 P4D 0
	Oops: 0010 [#1] SMP PTI
	CPU: 6 PID: 1422 Comm: libvirtd Tainted: G          I       4.20.0-0.rc7.git3.hpsa2.1.fc29.x86_64 #1
	Hardware name: HP ProLiant BL460c G6, BIOS I24 05/21/2018
	RIP: 0010:          (null)
	Code: Bad RIP value.
	RSP: 0018:ffffa47ccdc9fbe0 EFLAGS: 00010246
	RAX: 0000000000000000 RBX: 00000000000003e8 RCX: ffffa47ccdc9fbf8
	RDX: ffffa47ccdc9fc00 RSI: ffff97d9ee7b01f8 RDI: ffff97d9f0150b80
	RBP: ffff97d9f0150b80 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
	R13: ffff97d9ef1e53e8 R14: 0000000000000009 R15: ffff97d9f0ac6730
	FS:  00007f4d224ef700(0000) GS:ffff97d9fa200000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffffffffffffffd6 CR3: 00000011ece52006 CR4: 00000000000206e0
	Call Trace:
	 ? bnx2x_chip_cleanup+0x195/0x610 [bnx2x]
	 ? bnx2x_nic_unload+0x1e2/0x8f0 [bnx2x]
	 ? bnx2x_reload_if_running+0x24/0x40 [bnx2x]
	 ? bnx2x_set_features+0x79/0xa0 [bnx2x]
	 ? __netdev_update_features+0x244/0x9e0
	 ? netlink_broadcast_filtered+0x136/0x4b0
	 ? netdev_update_features+0x22/0x60
	 ? dev_disable_lro+0x1c/0xe0
	 ? devinet_sysctl_forward+0x1c6/0x211
	 ? proc_sys_call_handler+0xab/0x100
	 ? __vfs_write+0x36/0x1a0
	 ? rcu_read_lock_sched_held+0x79/0x80
	 ? rcu_sync_lockdep_assert+0x2e/0x60
	 ? __sb_start_write+0x14c/0x1b0
	 ? vfs_write+0x159/0x1c0
	 ? vfs_write+0xba/0x1c0
	 ? ksys_write+0x52/0xc0
	 ? do_syscall_64+0x60/0x1f0
	 ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

After some investigation I figured out that recently added cleanup code
tries to call VLAN filtering de-initialization function which exist only
for newer hardware. Corresponding function pointer is not
set (== 0) for older hardware, namely these chips:

	#define CHIP_NUM_57710			0x164e
	#define CHIP_NUM_57711			0x164f
	#define CHIP_NUM_57711E			0x1650

And I have one of those in my test system:

	Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]

Function bnx2x_init_vlan_mac_fp_objs() from
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h decides whether to
initialize relevant pointers in bnx2x_sp_objs.vlan_obj or not.

This regression was introduced after v4.20-rc7, and still exists in v4.20
release.

Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload sequence.")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
v2:
- As suggested by Sudarsana Reddy Kalluru, do not call bnx2x_del_all_vlans() at
  all if (!CHIP_IS_E1x(bp)).
v1:
- Check for chip num instead of (vlan_obj->delete_all != 0).
v0:
- Patch introduced.
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index b164f705709d..3b5b47e98c73 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9360,10 +9360,16 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
 		BNX2X_ERR("Failed to schedule DEL commands for UC MACs list: %d\n",
 			  rc);
 
-	/* Remove all currently configured VLANs */
-	rc = bnx2x_del_all_vlans(bp);
-	if (rc < 0)
-		BNX2X_ERR("Failed to delete all VLANs\n");
+	/* The whole *vlan_obj structure may be not initialized if VLAN
+	 * filtering offload is not supported by hardware. Currently this is
+	 * true for all hardware covered by CHIP_IS_E1x().
+	 */
+	if (!CHIP_IS_E1x(bp)) {
+		/* Remove all currently configured VLANs */
+		rc = bnx2x_del_all_vlans(bp);
+		if (rc < 0)
+			BNX2X_ERR("Failed to delete all VLANs\n");
+	}
 
 	/* Disable LLH */
 	if (!CHIP_IS_E1(bp))
-- 
2.20.1

