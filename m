Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeCNAKg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:10:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:21079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbeCNAKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:10:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="24276440"
Date: Wed, 14 Mar 2018 08:09:32 +0800
From: kbuild test robot <lkp@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: kbuild-all@01.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [RFC PATCH] drm/xen-front: xen_drm_front_platform_info can be static
Message-ID: <20180314000932.GA75578@lkp-sb-ep06>
References: <1520958066-22875-2-git-send-email-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520958066-22875-2-git-send-email-andr2000@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: db81084f9084 ("drm/xen-front: Add support for Xen PV display frontend")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 xen_drm_front.c     |    2 +-
 xen_drm_front_drv.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index dbabdf9..f421d23 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -417,7 +417,7 @@ static int xen_drm_drv_remove(struct platform_device *pdev)
 	return xen_drm_front_drv_remove(pdev);
 }
 
-struct platform_device_info xen_drm_front_platform_info = {
+static struct platform_device_info xen_drm_front_platform_info = {
 	.name = XENDISPL_DRIVER_NAME,
 	.id = 0,
 	.num_res = 0,
diff --git a/drivers/gpu/drm/xen/xen_drm_front_drv.c b/drivers/gpu/drm/xen/xen_drm_front_drv.c
index 3edefa2..04ee389 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_drv.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_drv.c
@@ -122,7 +122,7 @@ static const struct vm_operations_struct xen_drm_vm_ops = {
 	.close          = drm_gem_vm_close,
 };
 
-struct drm_driver xen_drm_driver = {
+static struct drm_driver xen_drm_driver = {
 	.driver_features           = DRIVER_GEM | DRIVER_MODESET |
 				     DRIVER_PRIME | DRIVER_ATOMIC,
 	.lastclose                 = lastclose,
