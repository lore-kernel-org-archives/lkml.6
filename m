Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeBHSgc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:36:32 -0500
Received: from mout.web.de ([212.227.15.14]:44877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeBHSga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:36:30 -0500
To: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm_fb_cma_helper: Delete an error message for a failed
 memory allocation in drm_fbdev_cma_init_with_funcs()
Message-ID: <b42a3095-fc99-1ee4-b3d7-2a71277454d9@users.sourceforge.net>
Date: Thu, 8 Feb 2018 19:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yUadrMW+JGLNk1VRjFfGvVjYpMF7ddrTu0xL30aK4dJ5e+yLfbp
 +OmSEKJG6Ne2QsnocC3EYweHBDNag9l7HtQKFpmU3OiewrhUC2D7irzJhqB7XbQkdIxAYzq
 N6Yfkco2c1GjsIrC0cbEAPdT7nogLoM7zFfEfoHb5CGGgQToK3VobIDEbBy4lAfKu6AD038
 6XUU4e4UcjMk/QlAYKhRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:INDBXYnklwQ=:NjbCIk7/5qf0hgFQErLrR+
 6z6cBH6hk17lgos+oVP+goPLkBVaATNaH57dEVWqEu2R/4vKbUl5DUnUO9siXwXqkobIbo1i7
 ou0snIC0nKZAQLtyzJvrxBvReeDP5+4Ee7Q/yciWlQTrvmQIcOKbQlrgJpw2fI4ByROH03edj
 rLQ+omOoTe6JGPHATt31lHd7I7vxAsW0axoU7y3aFmn78oVb9yAgizmVspqVKmAervKBuNG25
 B75D8HRKQSthCxCGcFsuhC6VqKhwi9w6+meZ1B+Myr7QzTLXX41LfftgeWN6cyu6zu1/7Q7YN
 VwHm4rN6ImOchP6xA4neVqQF6ambYi758XzMgbbIqJ953HXWUp92Sy/3r3UWGsK7EaMqNsVQb
 XBq8zX0ucWaUv4YvTP9+rlpMG3b1ZH9eGYHfxkO52uxddEQtwDVmnmKe8oA0SElQ7o+Jd49vM
 lCAkPStgCIK7i+0l8SnTLEt62tLikoOxc4/KkYXwVnegrZIBas0KvznklOUei34oaoVqDrpNd
 BU6aeMOnXUk7KhJ9J4cXSDk4Aq4jmMM3ywUy3dC0ARf/MMfoCH+wfAEzQz48IeEYwDfR0ew3g
 yfLX70DI+Hx6MPYsc8mCCunBc1q8KZCERAcu8UAEx0DAjG1BTM8Ius5iUB6b9FDvemcuokPjk
 AaFQbp6KXo9rK4jEOM3iBPO6kWGhkFw3Qnr4mNTx6Mo5DK2i6th3PiiWW8oB1titBxuIZiTm7
 PjPAO4f69V/zDFTwruCm64Z6b/SvMUeF7NZk7OZRc+AT+FmBWxtfJehzZ3AhNIzqHGC6qUIPg
 6tMJh2VJ1qKp/eFlbyNHPFJgXodhPNCa96pDjXZOUG2KX1b6/0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 19:30:06 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 186d00adfb5f..59f0d8dbfa61 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -408,10 +408,9 @@ struct drm_fbdev_cma *drm_fbdev_cma_init_with_funcs(struct drm_device *dev,
 	int ret;
 
 	fbdev_cma = kzalloc(sizeof(*fbdev_cma), GFP_KERNEL);
-	if (!fbdev_cma) {
-		dev_err(dev->dev, "Failed to allocate drm fbdev.\n");
+	if (!fbdev_cma)
 		return ERR_PTR(-ENOMEM);
-	}
+
 	fbdev_cma->fb_funcs = funcs;
 
 	helper = &fbdev_cma->fb_helper;
-- 
2.16.1
