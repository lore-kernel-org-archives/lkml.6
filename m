Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758093AbeDXNyA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:54:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35605 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933520AbeDXNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:41 -0400
X-Google-Smtp-Source: AIpwx49/+dOKDFDW8n1hnGEog8OSap14NwzxFH6jPhJ9roc4EENhikAeQqLwZ116BEhTM6DoyHP0+g==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: fix nouveau_dsm_get_client_id()'s return type
Date: Tue, 24 Apr 2018 15:15:38 +0200
Message-Id: <20180424131539.2662-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct vga_switcheroo_handler::get_client_id() is defined
as returning an 'enum vga_switcheroo_client_id' but the implementation
in this driver, nouveau_dsm_get_client_id(), returns an 'int'.

Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 5ffcb6683..ffb195850 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -193,7 +193,7 @@ static int nouveau_dsm_power_state(enum vga_switcheroo_client_id id,
 	return nouveau_dsm_set_discrete_state(nouveau_dsm_priv.dhandle, state);
 }
 
-static int nouveau_dsm_get_client_id(struct pci_dev *pdev)
+static enum vga_switcheroo_client_id nouveau_dsm_get_client_id(struct pci_dev *pdev)
 {
 	/* easy option one - intel vendor ID means Integrated */
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
-- 
2.17.0
