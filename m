Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C512229F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGVgSRHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLWPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:30:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41638 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbeLWPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:30:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so6973823lfj.8;
        Sun, 23 Dec 2018 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkjFKrNZhxiuqYRgqu1D75OJq3CNCEsNbt0aLaHyXkE=;
        b=WGVgSRHwZU9aJUPtwq7qz3jQtDe4Zm9x8FhOyASKuwCbXEbcEJOo2QxmEzAaanlECs
         XFkTm3b18Tyh2Ohldap57vEjy2bAnuwgwjrUaRPG4vjCK5Etyq9tcFqCPNxrrH7SDMzl
         D39W++Qv5sVXTuOnu6oH3jZMa0jchp2iXUP9r0ajVPlf77/XzBMYMmY4pctfWKwFPdcz
         ojOqdkNDOuRwCsqz5yMgn7RPrZN2oDn5byVTp1waix64YEkKXdmBZRzWNSWXH/4TjeRA
         avx9Qi6YOzclaVLUIJgO8h2ChEu1QzVJctjOoSxPX3A/KsrkcXeTC85Did4puJG7dSlh
         e3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkjFKrNZhxiuqYRgqu1D75OJq3CNCEsNbt0aLaHyXkE=;
        b=WGgWhBqDQ05uXqqmE4nLP5ICBR/JBCNf4Aw37kXkuh8IiRaHNf2KFLbTQCWJ6+vsiO
         yewSIGkHvM04L3R3UL+2aQp5qnovP3kGU19C8XoPJLI9NBgkggR6WwASRqCnN+26JPkm
         0xQRZyk7opJcv02u4MnDUc32LQJEI23md5cBSte0bpGtuyinTcYATLahEZY2gRGUB+Jx
         QHXArTwCiEIsQQ+ms2/S5mWmRSgJ6d0TPXxMGgU0H9OII2J2hUe7hOuMrdnMQ1MSe0Y2
         CANNjHqZ4O7Fe9RT7HAVe6ENdh+lA5+KBegS+aWeBkXYIjOt6XakwCTUOr1GgSGeZw6g
         YXEA==
X-Gm-Message-State: AA+aEWZ/fOBjMiMJFWAErm/hnkVPW+6XCC6kWBOLR+qzx3SmpUNSP6KI
        NiWRCKsuLRGO9mnvVEeQ2+Jmr2L4pnWeTQ==
X-Google-Smtp-Source: AFSGD/Xe30liFQ2OHo0H2RdTLp9D6UyUoaeQjUqBqz5gVatMo+vtd65nP0Q1xUwj+v72N7Qx3vWD7g==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr5203091lfe.137.1545579026160;
        Sun, 23 Dec 2018 07:30:26 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id p186sm5887332lfd.83.2018.12.23.07.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 07:30:25 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ivan Mironov <mironov.ivan@gmail.com>
Subject: [PATCH] bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some hw
Date:   Sun, 23 Dec 2018 20:29:30 +0500
Message-Id: <20181223152930.7925-1-mironov.ivan@gmail.com>
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
initialized (== 0) for older hardware, namely these chips:

	#define CHIP_NUM_57710			0x164e
	#define CHIP_NUM_57711			0x164f
	#define CHIP_NUM_57711E			0x1650

And I have one of those in my test system:

	02:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]
	02:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]

Function bnx2x_init_vlan_mac_fp_objs() from
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h decides whether to
initialize relevant pointers in bnx2x_sp_objs.vlan_obj or not.

This regression was introduced after v4.20-rc7.

Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload sequence.")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index b164f705709d..0e37c2484ac2 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8504,15 +8504,23 @@ int bnx2x_set_vlan_one(struct bnx2x *bp, u16 vlan,
 static int bnx2x_del_all_vlans(struct bnx2x *bp)
 {
 	struct bnx2x_vlan_mac_obj *vlan_obj = &bp->sp_objs[0].vlan_obj;
-	unsigned long ramrod_flags = 0, vlan_flags = 0;
 	struct bnx2x_vlan_entry *vlan;
-	int rc;
 
-	__set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
-	__set_bit(BNX2X_VLAN, &vlan_flags);
-	rc = vlan_obj->delete_all(bp, vlan_obj, &vlan_flags, &ramrod_flags);
-	if (rc)
-		return rc;
+	/* The whole *vlan_obj structure may be not initialized if VLAN
+	 * filtering offload is not supported by hardware. Currently this is
+	 * true for all hardware covered by CHIP_IS_E1x().
+	 */
+	if (vlan_obj->delete_all) {
+		unsigned long ramrod_flags = 0, vlan_flags = 0;
+		int rc;
+
+		__set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
+		__set_bit(BNX2X_VLAN, &vlan_flags);
+		rc = vlan_obj->delete_all(bp, vlan_obj, &vlan_flags,
+					  &ramrod_flags);
+		if (rc)
+			return rc;
+	}
 
 	/* Mark that hw forgot all entries */
 	list_for_each_entry(vlan, &bp->vlan_reg, link)
-- 
2.20.1

