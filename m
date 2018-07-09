Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A33F2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A33F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeGIPt5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:49:57 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933446AbeGIPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:20 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LqCzQ-1gG1xM36ZM-00dpUb; Mon, 09 Jul 2018 17:49:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: vkms: select DRM_KMS_HELPER
Date:   Mon,  9 Jul 2018 17:48:18 +0200
Message-Id: <20180709154901.1989316-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:01ryQ/2IL83F4/pFX2IwSpvFPEhhfEaFfWFVR45rPRn2tyJbTg3
 8/RKSR8ytL71+HOl14aM4eYj6U/C9nGjvb89LvJO9B6R/WmlY/WawWstno+3aJJ954x7k9I
 FZBhcSgf4BLZpThRkEk2PYimTghehX0ZtqbK6HqpItwhmaiq/6L3l4T2BykA9MfKM9b2FmZ
 Awx2pwiazICNHf+sDhpGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w6ro+ZSJ8pM=:sVsKSeh4yDolHeAgbpBGJ+
 rPWtW31OMhNauR/R00iiybgG8HVYElfuPCwbSa4CX4RPMfT4rKSxM7mZKajV8zoJd8Xf/dPWj
 9G+meJC/s8U6UftPkHs2L46XqjT7FpcamAuqbHgKqpdodDpAjn/TsqREllQnvnge4JIoOvxJ0
 dR1we0tKrsF5/9AwvdEA5tDP8VQE8GSqd0TTUp9J9ogsxGYKQpoUQlDbicEO4WkzieNWBVat7
 QuExcneAwZPFXhJ1dw3J1j2EdS1QDCte2JfIO8kVo39BtK0GKzfLxAHivhs6TaTnEjDljsqTu
 +gOMkbDolU4WvPjdhZA6I7B2ejmxy46tnfSMItXsDSsvbinD+IgwDIMs5AP1dDH9QKcWWxewL
 +qlKCdV3ubnIBke5feLhEa/3ev3/L08bKSYo54QEZ8Idy/VURx03BIWwHnNFKBD1vC04uMyoF
 UCxyCEnTUxZ7ZezZS/6wTL0eAKV5IBbZRAWETTAgO8DYyqAwB5NiRmxEH4yb/SsS/l0l9wS27
 67BDpHVekP2YLM2YqexHCEN6Bc+/CXiAN/YnzidUybseRLu1iUpBlIPvlmzp88md9kZPC2F9S
 lUlj/3Ye4FGrpvl0blCV+06rbR014mXRCrtShGusy3rIXMNvqdtbmqwIPuhV+HUSXPSPlwGOJ
 w9bMa/R2wGS0jOjjzWbrfFRk9Z2Df+ZlNFrhRCeN/ilNSAszjNZFb/K9+CiQVqxLjB0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, we get link errors during randconfig build:

drivers/gpu/drm/vkms/vkms_drv.o:(.rodata+0xa0): undefined reference to `drm_atomic_helper_check'
drivers/gpu/drm/vkms/vkms_drv.o:(.rodata+0xa8): undefined reference to `drm_atomic_helper_commit'
drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x0): undefined reference to `drm_atomic_helper_update_plane'
drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x8): undefined reference to `drm_atomic_helper_disable_plane'
drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x18): undefined reference to `drm_atomic_helper_plane_reset'
drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x28): undefined reference to `drm_atomic_helper_plane_duplicate_state'
drivers/gpu/drm/vkms/vkms_plane.o:(.rodata+0x30): undefined reference to `drm_atomic_helper_plane_destroy_state'
drivers/gpu/drm/vkms/vkms_output.o:(.rodata+0x1c0): undefined reference to `drm_helper_probe_single_connector_modes'
drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x40): undefined reference to `drm_atomic_helper_crtc_reset'
drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x70): undefined reference to `drm_atomic_helper_set_config'
drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x78): undefined reference to `drm_atomic_helper_page_flip'
drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x90): undefined reference to `drm_atomic_helper_crtc_duplicate_state'
drivers/gpu/drm/vkms/vkms_crtc.o:(.rodata+0x98): undefined reference to `drm_atomic_helper_crtc_destroy_state'

Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")
Fixes: 1c7c5fd916a0 ("drm/vkms: Introduce basic VKMS driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 516a8f5d1ac6..e527772f5ca6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -214,6 +214,7 @@ config DRM_VGEM
 config DRM_VKMS
 	tristate "Virtual KMS (EXPERIMENTAL)"
 	depends on DRM
+	select DRM_KMS_HELPER
 	default n
 	help
 	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
-- 
2.9.0

