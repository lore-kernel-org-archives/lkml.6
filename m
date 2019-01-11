Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E87C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD8C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217694;
	bh=PzJuKdoBwRECwvtft59735y3C5WNB1kRcq+CO/rejLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=skMB9YTKjG19gmnxaCl0qGAkh/S6DO7tEs4UVtHBOSGcuoF8gvtGAM/MLWoZWRzzl
	 DSH3k13oX8ew1qEiCIhTDTd7PMGoHNlnjpC6gQAtyqZMppLFwQDbRAod9c6XER4cVZ
	 biyQTkK/eaTURzopF4CmIIiM7AXhkkMyCgefhLh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbfAKOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404013AbfAKOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862C5206B6;
        Fri, 11 Jan 2019 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217691;
        bh=PzJuKdoBwRECwvtft59735y3C5WNB1kRcq+CO/rejLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgLWlh3H3Noi+XlkGD+RXtDvwj+eRXHHXPkcLSClC6dwrSGdvbrmLeZA8VMQw/MVc
         GM1v2nXlkVO+gdUewsfeNNAUxYyS62Smc6ExwaZQwDDZjKMO5ZWLFCpWF8efzQbyoD
         nodTSLkQN+b1O8S/R6pOC+P4ZOKf3dGcM/AOmG8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 147/148] drm/rockchip: psr: do not dereference encoder before it is null checked.
Date:   Fri, 11 Jan 2019 15:15:25 +0100
Message-Id: <20190111131120.203901080@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit 4eda776c3cefcb1f01b2d85bd8753f67606282b5 upstream.

'encoder' is dereferenced before it is null sanity checked, hence we
potentially have a null pointer dereference bug. Instead, initialise
drm_drv from encoder->dev->dev_private after we are sure 'encoder' is
not null.

Fixes: 5182c1a556d7f ("drm/rockchip: add an common abstracted PSR driver")
Cc: stable@vger.kernel.org
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20181013105654.11827-1-enric.balletbo@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -189,12 +189,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable))
 {
-	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
+	struct rockchip_drm_private *drm_drv;
 	struct psr_drv *psr;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
 
+	drm_drv = encoder->dev->dev_private;
+
 	psr = kzalloc(sizeof(struct psr_drv), GFP_KERNEL);
 	if (!psr)
 		return -ENOMEM;


