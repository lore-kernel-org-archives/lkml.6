Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeDXNPq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53887 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933220AbeDXNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:39 -0400
X-Google-Smtp-Source: AIpwx4+x8loPLUlWEa9VBurdnmWox484ddyXZ1EEpUenU8uIyEZWW8onLUSbjn31381dvycNrRcRfQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu_atpx_get_client_id()'s return type
Date: Tue, 24 Apr 2018 15:15:34 +0200
Message-Id: <20180424131536.2611-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct vga_switcheroo_handler::get_client_id() is defined
as returning an 'enum vga_switcheroo_client_id' but the implementation
in this driver, amdgpu_atpx_get_client_id(), returns an 'int'.

Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 1ae5ae8c4..1bcb2b247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -550,7 +550,7 @@ static int amdgpu_atpx_init(void)
  * look up whether we are the integrated or discrete GPU (all asics).
  * Returns the client id.
  */
-static int amdgpu_atpx_get_client_id(struct pci_dev *pdev)
+static enum vga_switcheroo_client_id amdgpu_atpx_get_client_id(struct pci_dev *pdev)
 {
 	if (amdgpu_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
 		return VGA_SWITCHEROO_IGD;
-- 
2.17.0
