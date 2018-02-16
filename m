Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032730AbeBPNtl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:49:41 -0500
Received: from osg.samsung.com ([64.30.133.232]:62478 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032300AbeBPNsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:30 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6/6] drm: intel_dpio_phy: fix kernel-doc comments at nested struct
Date: Fri, 16 Feb 2018 11:48:20 -0200
Message-Id: <9ba9ac773f4f9e60770bd9169b0e46ac974d858a.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The in-lined comments for channel.port doesn't follow the syntax
described at kernel-doc document, causing the following warning:

	$ ./scripts/kernel-doc -none drivers/gpu/drm/i915/intel_dpio_phy.c
	drivers/gpu/drm/i915/intel_dpio_phy.c:154: warning: Function parameter or member 'channel.port' not described in 'bxt_ddi_phy_info'

While the best would be for the Kernel to deduce that from the
context, supporting it is not trivial. So, let's just stick with
the existing syntax.

Reported-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/gpu/drm/i915/intel_dpio_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dpio_phy.c b/drivers/gpu/drm/i915/intel_dpio_phy.c
index 76473e9836c6..c8e9e44e5981 100644
--- a/drivers/gpu/drm/i915/intel_dpio_phy.c
+++ b/drivers/gpu/drm/i915/intel_dpio_phy.c
@@ -147,7 +147,7 @@ struct bxt_ddi_phy_info {
 	 */
 	struct {
 		/**
-		 * @port: which port maps to this channel.
+		 * @channel.port: which port maps to this channel.
 		 */
 		enum port port;
 	} channel[2];
-- 
2.14.3
