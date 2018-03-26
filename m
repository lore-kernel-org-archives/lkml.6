Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeCZItZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:49:25 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45032 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeCZItY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:49:24 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: cdall@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] KVM: arm/armv4 : merge the same case handler
Date: Tue, 27 Mar 2018 01:07:17 +0800
Message-Id: <1522084037-85559-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-03-26 16:48:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-03-26 16:48:53,
        Serialize complete at 2018-03-26 16:48:53
X-MAIL: mse01.zte.com.cn w2Q8mrVl015213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two switch cases have the same handler, so merge them.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 4650953..aa41b29 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1242,8 +1242,6 @@ static int vgic_its_handle_command(struct kvm *kvm, struct vgic_its *its,
 		ret = vgic_its_cmd_handle_mapc(kvm, its, its_cmd);
 		break;
 	case GITS_CMD_MAPI:
-		ret = vgic_its_cmd_handle_mapi(kvm, its, its_cmd);
-		break;
 	case GITS_CMD_MAPTI:
 		ret = vgic_its_cmd_handle_mapi(kvm, its, its_cmd);
 		break;
-- 
1.8.3.1
