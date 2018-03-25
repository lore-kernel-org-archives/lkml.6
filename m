Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeCYSDF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:03:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40976 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbeCYSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:02:57 -0400
X-Google-Smtp-Source: AG47ELvh2yvSM1VKIOQdFbLVuIYVE1/J5jMDZUUQUJdBgItpGvehdZe3XODfV3MDAt7ZK7Hw0vESjw==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie,
        seanpaul@chromium.org, gustavo@padovan.org, daniel.vetter@intel.com,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 2/2] gpu: drm: nouveau: Use list_{next/prev}_entry instead of list_entry
Date: Sun, 25 Mar 2018 23:31:33 +0530
Message-Id: <1522000893-5331-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use list_entry instead of list_{next/prev}_entry
as it makes the code more clear to read.
This patch replace list_entry with list_{next/prev}_entry.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index e4c8d31..81c3567 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
 			       nvkm_volt_map(volt, volt->max2_id, clk->temp));
 
 	for (cstate = start; &cstate->head != &pstate->list;
-	     cstate = list_entry(cstate->head.prev, typeof(*cstate), head)) {
+	     cstate = list_prev_entry(cstate, head)) {
 		if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
 			break;
 	}
-- 
2.7.4
