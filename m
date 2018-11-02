Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC49C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A58F20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A58F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKCAwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:52:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeKCAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:52:12 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOzCW-1ftEZT48Ds-00PJNp; Fri, 02 Nov 2018 16:44:28 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOzCW-1ftEZT48Ds-00PJNp; Fri, 02 Nov 2018 16:44:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: myrs: avoid stack overflow warning
Date:   Fri,  2 Nov 2018 16:44:13 +0100
Message-Id: <20181102154426.1951776-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:WPT/Ueqdsels/c/3nhc/ZnCHMhQZX/E1DafZp6Cw69G3O96kz2e
 n3+hIZ1lqoeiv0HTHUvAkt/jS7jwkA5AeOBPswXv+lUNEfTWu3KLTz2GdmXi5axe/PIGcVb
 uZfKjPe40mFAULsij7NAy9MadWCLIXyZhHukGeXJWWDs2M7ALovTFuyLYzNvMkjEIilHeGM
 uMZPZxm8PgVVNDCJNKr/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PaVVdk4xXzA=:HgKcRYpG4aNTtx05qg5jtw
 ABtmjGM316CNnQrY0+zosZyiaRwuTff4H8ehK8EljPyiLLJx95ZJ+6Xpz4ccDeY59xEqmGrR9
 CFybR7HlP0uulWCeTHU9Rw+ORFWH9CkJsfunJbR1+b8AFYoIaI5nv2kqxsUfhUZrNoqiHOnfZ
 k45zX5J5c9SCng4xA3e8l4BmmpqUuREa4SOM6vjuHd9y2HPG23JJ3eJwtyUgGKtrNZkLnn2n/
 jtdqu4jo+0+kLS7wbQC/SV1s4fVjPrp32m6zCWHYNPrn7wm4UZP/ql9FrYGExHYl+KfFM7XHe
 0Mw9vf7E+HmOKkN53t6/0Hiso8VrGUlMHHvhL3G6eBW6QVpAbqJpilt6yhVTbpnBp03eF53Y3
 mu9iZ9UbQ6G2ErVsRjo+HiQpXqTR1ego75Ot1Aj3jZq0ugq2zdxcM63zDQPhT1+m/v6P0XCO1
 RPG6srb56alk2cguP3iEdvY2/NW7XanzSX7WgvSD0J0STbFJDhdiKdG4p5Tju8FKVkCiVKqeL
 jG532gEsdBgmUhHpJRf8E/ppiszcRN/UsQMGP2va+5NyTR2EicQobYMkXsixaETNecEfIWKbv
 4P4mWcynnDXWmLftk+8pnjcKa2tZhwIN+fWA8tQsyMO5xGWsBB+ACTM3+3ZRXlHv5ZflQ9Pm5
 mW3Pz6YnbzUZXyVX1FBt6T5wE5CtdzV7f4tfMbthcLjsVjgcNnd1BBEfChaLPpGMS0OqM3P54
 4wZnAiIdbkw3tgXv7OuTspSjGJkpgANQR5B04NgZWAS+jxZGndtUj8Y7mgOvpg4pyi8KZc0Zd
 mmJdGYw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting a 1024 byte data structure on the stack is generally a bad idea.
On 32-bit systems, it also triggers a compile-time warning when building
with -Og:

drivers/scsi/myrs.c: In function 'myrs_get_ctlr_info':
drivers/scsi/myrs.c:212:1: error: the frame size of 1028 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

We only really need three members of the structure, so just read them
manually here instead of copying the entire structure.

Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/myrs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 0264a2e2bc19..b8d54ef8cf6d 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -163,9 +163,12 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
 	dma_addr_t ctlr_info_addr;
 	union myrs_sgl *sgl;
 	unsigned char status;
-	struct myrs_ctlr_info old;
+	unsigned short ldev_present, ldev_critical, ldev_offline;
+
+	ldev_present = cs->ctlr_info->ldev_present;
+	ldev_critical = cs->ctlr_info->ldev_critical;
+	ldev_offline = cs->ctlr_info->ldev_offline;
 
-	memcpy(&old, cs->ctlr_info, sizeof(struct myrs_ctlr_info));
 	ctlr_info_addr = dma_map_single(&cs->pdev->dev, cs->ctlr_info,
 					sizeof(struct myrs_ctlr_info),
 					DMA_FROM_DEVICE);
@@ -198,9 +201,9 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
 		    cs->ctlr_info->rbld_active +
 		    cs->ctlr_info->exp_active != 0)
 			cs->needs_update = true;
-		if (cs->ctlr_info->ldev_present != old.ldev_present ||
-		    cs->ctlr_info->ldev_critical != old.ldev_critical ||
-		    cs->ctlr_info->ldev_offline != old.ldev_offline)
+		if (cs->ctlr_info->ldev_present != ldev_present ||
+		    cs->ctlr_info->ldev_critical != ldev_critical ||
+		    cs->ctlr_info->ldev_offline != ldev_offline)
 			shost_printk(KERN_INFO, cs->host,
 				     "Logical drive count changes (%d/%d/%d)\n",
 				     cs->ctlr_info->ldev_critical,
-- 
2.18.0

