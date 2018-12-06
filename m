Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5144C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107212;
	bh=JePAK1qHet7dSe/5HYcKJi5wMOqoq/V9Io+cIAH2HcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrt0MwV86ZjBuBWTb3kvydj1D3TMdTehFVP0K0t7aIWnT+p5Y7cQX2RsqZSVOYKNp
	 8KACBxJc2JF32TYf2hztlE7ltyjxJ6PR6GPCqKh7Kyxfzia1QEeq5dJ/lb7OhPYARJ
	 xSm+p4F1Aixxfg9zXwDZ4tmB685DS6OOFphUW2/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E5D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeLFOkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbeLFOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB83208E7;
        Thu,  6 Dec 2018 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107207;
        bh=JePAK1qHet7dSe/5HYcKJi5wMOqoq/V9Io+cIAH2HcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSdI5kWkD5hHQjWdhd1L0KfQ6cskmpPPsG44Ke42OXMWqqYeGepHOvUt1tNq9biQy
         DlqEANQur6jKVgXWycNO2PWmtojTGXc4vIztnlBt70Qv0UhCso/DNH1bFK8noHZGFo
         LVujtojRt8DZCoZm0nLrVUpCPGIV23+yc3CR2vpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 16/41] drm/amd/dm: Understand why attaching path/tile properties are needed
Date:   Thu,  6 Dec 2018 15:38:56 +0100
Message-Id: <20181206142951.111277959@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 04ac4b0ed412f65230b456fcd9aa07e13befff89 upstream.

Path property is used for userspace to know what MST connector goes to what actual DRM DisplayPort connector, the tiling property is for tiling configurations. Not sure what else there is to figure out.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -377,9 +377,6 @@ dm_dp_add_mst_connector(struct drm_dp_ms
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
 
-	/*
-	 * TODO: understand why this one is needed
-	 */
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,


