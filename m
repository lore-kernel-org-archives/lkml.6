Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F87C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139AA23FE7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139AA23FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeGFFsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:48:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932603AbeGFFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:48:01 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91313BA2;
        Fri,  6 Jul 2018 05:48:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikita Lipski <mikita.lipski@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 23/46] drm/amd/display: Clear connectors edid pointer
Date:   Fri,  6 Jul 2018 07:46:44 +0200
Message-Id: <20180706054525.708444787@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikita Lipski <mikita.lipski@amd.com>

commit 5326c4525d1b2d5f1519268dd305e19c9bd4ef56 upstream.

Clear connector's edid pointer on coonnector update, when unplugging
the display.

Fix poison EDID when hotplugging on previously used connector.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -928,6 +928,7 @@ amdgpu_dm_update_connector_after_detect(
 		drm_mode_connector_update_edid_property(connector, NULL);
 		aconnector->num_modes = 0;
 		aconnector->dc_sink = NULL;
+		aconnector->edid = NULL;
 	}
 
 	mutex_unlock(&dev->mode_config.mutex);


