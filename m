Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937844AbeE1M5E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164287AbeE1Kyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 294/496] drm/amdkfd: Fix scratch memory with HWS enabled
Date: Mon, 28 May 2018 12:01:19 +0200
Message-Id: <20180528100332.207929301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit c70a36268799cf2f902b5a31e452571fcb96bfe9 ]

Program sh_hidden_private_base_vmid correctly in the map-process
PM4 packet.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -166,8 +166,7 @@ static int pm_create_map_process(struct
 	packet->sh_mem_ape1_base = qpd->sh_mem_ape1_base;
 	packet->sh_mem_ape1_limit = qpd->sh_mem_ape1_limit;
 
-	/* TODO: scratch support */
-	packet->sh_hidden_private_base_vmid = 0;
+	packet->sh_hidden_private_base_vmid = qpd->sh_hidden_private_base;
 
 	packet->gds_addr_lo = lower_32_bits(qpd->gds_context_area);
 	packet->gds_addr_hi = upper_32_bits(qpd->gds_context_area);
