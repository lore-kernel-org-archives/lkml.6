Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBGVq6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:46:58 -0500
Received: from mout.web.de ([212.227.15.4]:49314 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeBGVq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:46:56 -0500
Subject: [PATCH 2/2] drm/msm/mdp4: Return directly after a failed kzalloc() in
 mdp4_kms_init()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>, Jyri Sarha <jsarha@ti.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sushmita Susheelendra <ssusheel@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e090cf0c-0bb0-d28c-ac21-9e045993a995@users.sourceforge.net>
Message-ID: <5ae5dd90-6306-52a4-7601-3fb9dbe2f23a@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e090cf0c-0bb0-d28c-ac21-9e045993a995@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:z4JTolSQbF8lUDp4SBmv7Si0TX00OdEJeHv8xlwtS8pXhLiGVYv
 RsXjzKtEAOT3RGNn/9GZvFDDhHDZwvH4wDPgv7YiH+Ov7bNd+A+0fkwVYtplVlaH6gpZAzQ
 ycvob+nv7FGJn2ubstEoVT/uaDEdt/84Kwwlhowy3rlKXlPR0HDcWu4t7JeYkNKSC9you1Z
 UXZyfMhfRCSr7+pJiQJWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h3TzSYELPQM=:p957Q01zDFbImi/uk3C7oN
 lQ2AJXJIIGc2pXnfH/2LxbTPiaobBLs6d6/Am6auz2I9m90F/b1dYlD8cwKqrZjcI3E3q5kZG
 aSvIdeJspWjzH0wNa6DE1/9iGyi540KzHhb4lL/H+jgbyNSQZVeYMZg6p5+TCjoLKVdxEV99b
 FbUpH1jAwdjJIpCe03EE+I932Kk/aWXspljvkiN3BbGZBXRaD5/tRUfu2KGR9UWwT1O98U8+l
 vTXE4Kb7qkUJR0Flot9LxvmXlLQiha3OvHA6jH0vPMmAyQdvB+/G+Eh82zL0cT07FO6Sm35ip
 r3XiTVb4pEfRGo3383TLClW7tD8QtHQEy9PuNq7+NQxQmP6Neo1loURtU49CUSteWp1i4RToX
 8cvXHK3DuFSXw2lNTTYZAUAr+gxd9cV2DFINqErp3QhfZAu+i/T/PoDxN4/dq+RlG/tvRDUfv
 xY2YGoyQenGqKWOUfW4xsDYpc/4CMYRbKOWknEXH/TZaZt1Kiw2KtZgwc+t8i+3/2Nk2NAXL1
 Oks7sXN0jHQmGMLNyFfHWMoUNK2RFG6Q6zXF26HDBRJ8B3EQJHyEwO0qfDFejqIi4DjXFR+Yt
 HR1+WZvowrHz7cXL6Xr4WH/k/U8A3oLyZQ72EpCwqUsIMIe8b1gCJ24w80vWMMoMyxjv7ASbK
 yVQrUhX9RSML8TdnzBhxe9x9LMNhiI5Qli/qQfjKualnJLvmFsNtGBgK+m72PNwL9CynEaPek
 X1W/R8nkkpsqJhBU6NGc62MvfC26S9eO/ATsSm6fuKZcmS4cBzgzhcYDAlvZguGw9A7sUQeVK
 vp7DbwaohI1UPR/bY8fQqP7z3SQr+HBGRRGcUui7PGQInSoF1o=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:34:45 +0100

* Return directly after a call of the function "kzalloc" failed
  at the beginning.

* Delete an initialisation and a check (for the local variable "kms")
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
index 5c5965a9d1f9..4f15cd569ee1 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
@@ -411,15 +411,13 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	struct platform_device *pdev = to_platform_device(dev->dev);
 	struct mdp4_platform_config *config = mdp4_get_config(pdev);
 	struct mdp4_kms *mdp4_kms;
-	struct msm_kms *kms = NULL;
+	struct msm_kms *kms;
 	struct msm_gem_address_space *aspace;
 	int irq, ret;
 
 	mdp4_kms = kzalloc(sizeof(*mdp4_kms), GFP_KERNEL);
-	if (!mdp4_kms) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!mdp4_kms)
+		return ERR_PTR(-ENOMEM);
 
 	mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 
@@ -550,8 +548,7 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	return kms;
 
 fail:
-	if (kms)
-		mdp4_destroy(kms);
+	mdp4_destroy(kms);
 	return ERR_PTR(ret);
 }
 
-- 
2.16.1
