Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAD3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE9E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeJAS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:56:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbeJAS4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A5A63086250;
        Mon,  1 Oct 2018 12:19:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE6F308BDA2;
        Mon,  1 Oct 2018 12:19:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 935481750F; Mon,  1 Oct 2018 14:19:11 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm: virtual connectors can have edid too
Date:   Mon,  1 Oct 2018 14:19:10 +0200
Message-Id: <20181001121911.27140-2-kraxel@redhat.com>
In-Reply-To: <20181001121911.27140-1-kraxel@redhat.com>
References: <20181001121911.27140-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 01 Oct 2018 12:19:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_connector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 6011d769d5..95cbbf7ee5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -254,8 +254,7 @@ int drm_connector_init(struct drm_device *dev,
 	config->num_connector++;
 	spin_unlock_irq(&config->connector_list_lock);
 
-	if (connector_type != DRM_MODE_CONNECTOR_VIRTUAL &&
-	    connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+	if (connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 		drm_object_attach_property(&connector->base,
 					      config->edid_property,
 					      0);
-- 
2.9.3

