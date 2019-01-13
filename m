Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC16C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73212064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfAMKV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:21:56 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47950
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfAMKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:21:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291728762"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 11:21:54 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] add missing of_node_put
Date:   Sun, 13 Jan 2019 10:44:48 +0100
Message-Id: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of of_graph_get_remote_port_parent needs an of_node_put,
even if it is not available.

---

 drivers/gpu/drm/meson/meson_drv.c     |    9 +++++++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.c |    1 +
 drivers/of/property.c                 |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)
