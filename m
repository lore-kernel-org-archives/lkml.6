Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB4CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeIMTMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbeIMTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 044EED2E;
        Thu, 13 Sep 2018 14:02:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lubosz Sarnecki <lubosz.sarnecki@collabora.com>,
        Daniel Stone <daniels@collabora.com>
Subject: [PATCH 4.18 162/197] drm/edid: Quirk Vive Pro VR headset non-desktop.
Date:   Thu, 13 Sep 2018 15:31:51 +0200
Message-Id: <20180913131848.034749368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubosz Sarnecki <lubosz.sarnecki@collabora.com>

commit 6931317c714885f2d792e8150ef6715d416ac681 upstream.

This adds the Vive Pro's EDID information and
sets EDID_QUIRK_NON_DESKTOP.

Signed-off-by: Lubosz Sarnecki <lubosz.sarnecki@collabora.com>
Signed-off-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Cc: <stable@vger.kernel.org> # v4.15+
Link: https://patchwork.freedesktop.org/patch/msgid/20180529115215.4526-1-lubosz.sarnecki@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -163,8 +163,9 @@ static const struct edid_quirk {
 	/* Rotel RSX-1058 forwards sink's EDID but only does HDMI 1.1*/
 	{ "ETR", 13896, EDID_QUIRK_FORCE_8BPC },
 
-	/* HTC Vive VR Headset */
+	/* HTC Vive and Vive Pro VR Headsets */
 	{ "HVR", 0xaa01, EDID_QUIRK_NON_DESKTOP },
+	{ "HVR", 0xaa02, EDID_QUIRK_NON_DESKTOP },
 
 	/* Oculus Rift DK1, DK2, and CV1 VR Headsets */
 	{ "OVR", 0x0001, EDID_QUIRK_NON_DESKTOP },


