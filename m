Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB82C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DD820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217860;
	bh=wa//pIZjnta58CNe8jdud9BG4a+cvFT5+781LrmEcao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3NPjpyXFAzVmgh8dHU/9oKxiADU2z6hr+ikyZF4/4D3qvfESGysX5dXjIgbtya8I
	 SLcBnG2P89/afSPvGj6zh9RPRFC6jBCxR+TqYGY0kqhcYXkmB/bqzHLfAvTK5Y6owf
	 t336aSOuLYnhQfn0Z4TKwZvo4xkYNvftPh0COeNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfAKOoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404563AbfAKOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63FB820872;
        Fri, 11 Jan 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217856;
        bh=wa//pIZjnta58CNe8jdud9BG4a+cvFT5+781LrmEcao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4qE47edAh+mgw5XMD21c/fo1Ov1x2BomWpnOwO7CQHFWOioKOj9+YA2OkeOf7oNm
         uRuOuUB1WVQNZ24TxyGNm2LxkWlIvTovRQ4GrRJFU3Jn+sKjWQfLVeMh5amic+Tqr1
         Y/WeztttVHuNLGOKkluSq8TfGbpEC0LrB08VDdUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.20 65/65] drm/rockchip: psr: do not dereference encoder before it is null checked.
Date:   Fri, 11 Jan 2019 15:15:51 +0100
Message-Id: <20190111131104.575512035@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


