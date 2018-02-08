Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBHOiu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:38:50 -0500
Received: from mout.web.de ([212.227.15.14]:42457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeBHOis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:38:48 -0500
Subject: [PATCH 2/3] drm/gma500: Improve four size determinations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Message-ID: <9165671d-8a07-30e7-c0ee-936e91331297@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:a8Tdv8hgQUOvzTfyPOZPjtUfzNHgqhBiIjXzSsLtD9w6pDSwQuY
 xNJS+6okzGROZ0v9qbT0bszkK9eEmCbQJD3yojNMDbKQsOcCvExyZ8DrDDHOmO4pAGhXmgw
 Sr5Bc/7ffrbnLG0DLz3MC9Ev8l/5o2SyA/EreDNth+lXoWxIkniHqlObGBPbpwC364wp1SU
 WdhKjrTf0jqnlmhcvEMew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:auIJ8o99ETY=:zSPtb3DQXOmYl77PSxL24U
 A5/J9/6zPfj/uF1qI2K9Ls9Al9DGnVH8/PELCiTtmIEndiSVn14ZJJUwMXbbJe/gdWGE3ybvH
 4S+yk6eJP8PhZUeaf49hjrhgKTgX5HwCwHtIUf7FL3bmeb40I6ZCSu1kRyftk24iD046iShsU
 XPlv8XC2awXnZrYkkU28xoLTgHtUz7FkUQG9q2kkO+7+JCeYqF1z3jZUgjhpkcVCS702CSNuv
 CGlv0XSjjHL9TcdMJDT3VLTuv8MUis/n9TnoqhaRjnyH55j4EM5LosBjDLCpBl1RFJ/qwYE89
 ykSyK52cwGorA3GdkckVeP7uOmC9FrnRc9AxvpBwkBuftWmsKQSMer0lxANgU9joY1n7qUxay
 WtOIlHOKjHNECbICHeqz3G/8OBzSj7E+Gg0XvpVd0+gUrOMegxirjc8hJyIbCYA3OHdF/1PqX
 +Vb/m2x9MCTHtIqiLxjLPJitTqgPKGHDczgPzgpZxYSlPu+a5IuIAcwGVXi2zhrkrlSpnAK/F
 RLbhalLfLQSJ7L9wB6zXsD0CszyDZ3m0tAZWeF9VdBixR19DM+xuS8uzF/QRtTUE28NoTqzHO
 zmKPHr4AShsLjJ3UdRmoFUXkYGiaUzxZ03zTPvKwv8M3Gsc7rxbBjXH4LKAWyDSuRdIziIUzD
 eJj9Y30lhXzscXGo37Ail/2zpGBbCG/XMVw07W8DGDRAm4z/Eeb8xDv/oKmA/1mhJmYMk0Qdw
 f7PyEQM2XMkj3CrUh4k0VbJth/4ZMfzAgMwkqUkb7TQFK0EehkPo/IXxAWB87b3iLB/4O+m9y
 qCaXV4aFMW3X70EqoIBKC2+Oq429cE/xZXCUsHf+mwec5m6U8w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:08:39 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/gma500/framebuffer.c   | 3 +--
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 3ff320f3ff47..ad96a542d137 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -525,11 +525,10 @@ static int psb_fbdev_destroy(struct drm_device *dev, struct psb_fbdev *fbdev)
 
 int psb_fbdev_init(struct drm_device *dev)
 {
-	struct psb_fbdev *fbdev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	int ret;
+	struct psb_fbdev *fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 
-	fbdev = kzalloc(sizeof(struct psb_fbdev), GFP_KERNEL);
 	if (!fbdev)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index d9a6d54b6641..dbc58e5130bb 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -637,11 +637,11 @@ void oaktrail_hdmi_init(struct drm_device *dev,
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 
-	gma_encoder = kzalloc(sizeof(struct gma_encoder), GFP_KERNEL);
+	gma_encoder = kzalloc(sizeof(*gma_encoder), GFP_KERNEL);
 	if (!gma_encoder)
 		return;
 
-	gma_connector = kzalloc(sizeof(struct gma_connector), GFP_KERNEL);
+	gma_connector = kzalloc(sizeof(*gma_connector), GFP_KERNEL);
 	if (!gma_connector)
 		goto failed_connector;
 
@@ -689,7 +689,7 @@ void oaktrail_hdmi_setup(struct drm_device *dev)
 	if (!pdev)
 		return;
 
-	hdmi_dev = kzalloc(sizeof(struct oaktrail_hdmi_dev), GFP_KERNEL);
+	hdmi_dev = kzalloc(sizeof(*hdmi_dev), GFP_KERNEL);
 	if (!hdmi_dev)
 		goto out;
 
-- 
2.16.1
