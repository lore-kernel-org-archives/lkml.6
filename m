Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeBGUX6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:23:58 -0500
Received: from mout.web.de ([212.227.15.14]:57903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754087AbeBGUX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:23:56 -0500
To: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm/tegra/fb: Delete an error message for a failed memory
 allocation in tegra_fbdev_create()
Message-ID: <0704416a-23f7-3ce3-2bd2-d6a8c106f10d@users.sourceforge.net>
Date: Wed, 7 Feb 2018 21:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bLO10b90k9Og9SRgy9jFlDiqRVp7JR5TNPyyxj7XhbPLlvr9bX2
 848+LGrZ6z3NDnEoDKvcMSUzT8giqkvdcJlm2vCAoWD47YqopeX/yFFFUHP80RVn1SD01bc
 ttE/A8/j9XW8VhBDQtf18WcPh0vX8MleD3nfv3pWPRzZ+uPJD795auery/LAY7Xip/mDMh6
 UdHjhVmRklEnaMK7Inkvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rIa91ndW1HY=:SVdH5zuRtRblPDUPXlVYyL
 /uGzXFRlL1gFGOrPCPrtRYgzGo8mw4RUe3VX2XjKifOSSyBB//jBjY8vvan21rJ7/wiORGKf6
 5Jedl2UEmm0N3qs/i9sLEVf55NsvFGx8t01s6WPX45GgRBEs9WrBWgYLNytEqUW42jAb0Si/o
 xgIJQmUPtljLfw9r9Ekn+Dmh+oSpVtEapJB7dmMJPsrwQ9qxhH3E2NT8SqBbKMTM/noe+MiWH
 yYei0F/QJyay6LqDy/oCGKA6IK0IbpEwzHLU9s3tw+0tily9zwbLxWrpCu/U2lFuyU+90uDlE
 nw6PKhMxweajCN/QRhzc8JGbichpKWqWRLXq+PJxKG/oym6Gz50aaeLN9CrP+JkWppIaZtvkf
 93qhNCGhpFzkXvUtAP1sWeXw9c5pjElBJitIz1j0NCfOswpXWXf5pqSgZjt6VF8ge9FBDhVdw
 LKztacvhlyqgOIaKCgK6qIquInhPa+DIrX1OQhx3fQA9ScZHyMp+vmwV8Ou4iNyVehhqXCNnG
 ChvW4bHJki2ShKR8pG+oyN7HZKpqAZ6XH7U9tJM8xVBd2BVMj1rlg8RtMgeiVVyiddAiqoIa9
 dT38L+XLMN/zuCeDd+fJvP61e/eza9o/rm/k3Y0d/BZpauiszjqD0uquAI+GV7hrPzizzSH9V
 4d0f/YIWGJYmpdcLQstBg3n+hwY0RqPWTptEQlMya0wf51J/BFoSCdU/V02OYqI6uyFYQAFws
 8m1Pefk1AFQ0U5QHyW6NaKqXUzp/aoY/rQyeZEyqmCmvKElsIbtOFaPlfs8R6KGexI6a/Na5r
 u3OPVwxxW6iJ6SNitzy6DUhprU/AJXPp4YjmXQMirNHQ36CA2k=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 7 Feb 2018 21:17:17 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/tegra/fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 001cb77e2f59..e63a0b228751 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -325,10 +325,8 @@ static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm)
 	struct tegra_fbdev *fbdev;
 
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
-	if (!fbdev) {
-		dev_err(drm->dev, "failed to allocate DRM fbdev\n");
+	if (!fbdev)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	drm_fb_helper_prepare(drm, &fbdev->base, &tegra_fb_helper_funcs);
 
-- 
2.16.1
