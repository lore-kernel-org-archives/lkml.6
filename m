Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBGVpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:45:49 -0500
Received: from mout.web.de ([212.227.15.4]:53303 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeBGVpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:45:47 -0500
Subject: [PATCH 1/2] drm/msm/mdp4: Delete an error message for a failed memory
 allocation in mdp4_kms_init()
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
Message-ID: <242c009d-e801-57ef-cc95-e342776244de@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e090cf0c-0bb0-d28c-ac21-9e045993a995@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WJV4qxDgY+OuAGrFX7ypFv0MuJ3D9Ac0zL0Ygi/YvtZOfqF2X7y
 AOlPQzRbSB68qM6sxl7yIl2Usxl7XWn0zb0ubAEZqIA32UlqHV9H6HANaUlZK1t8nZdpEeH
 UVd3TcE8y0BtZrSODoFi2HX/pVHQ1s1dOXfy2pDhZdatAvx/ywV8A7Pq77SWR6pQFnT0tQ4
 Rj8EOtTX9LFNHWqJAGDuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GVHZuctKS2w=:eT10dNqWP2N00xO3hvbqK3
 Sj29gUMNTqAQWP+hZlZIQF7BJ9Cz5Pbz/u3xt9q9piAcosTcf7u/3KVP1MJZVMqu2IPT7ctzu
 dLSszEftJHRlsZ+864L8EnLlgUxsc49e5FOzi+p4Db52PAkUGqriQ+fHn5dn+b3ge8CkM62dr
 njlmbpmz4ugRALz51wC92HwHUOWPJUSURauXPROUD6UV6ax6enI+TxyRQ0L1ZegJb3L5g7Io4
 SH0sAiifdVDFhHwxX9N2QydD6cmidy3nR0PTfka2aztaK4EgW5V/UFqj0wdLk7YuNwBCsmDdk
 m9q/AxlPHc9hbFvhrB3rYWomlnhrTJzVYVvj1HpNXwuPl7efsexs2t3C5xDebUhotAFOPU4st
 94rd5o8WWiIq+mDugbPiNRg+Ylb2UnnPyRjV1UVE2p6ee4BFL1LDaJpde5mB/t5FFn32mEUGm
 sVqxtW0i66oZc1apUyYIrs9Sws+X0THUhoABktgKYnNL6yTvIIJMx44+HLW0JZ2rDo/YaGqwN
 N0wuVFcwimCsThxi3TT0xALr55AtLvBxQBOyzYmBm98d2yM9vfeT01uKR4c3dey0TgGH9iM+t
 iDfgImwaa4o9JF29VsWuM1GPt7IINB84s/TNsXndQqU2b8OKPQbR43Hk5f87vrnbfRB0t9kUj
 SD0r9+KXvLysNG4+RATsqVHeP7C2S1g63OZqiN1pbztuM4X1WF5BD4AkfSnUvK0du5BtL9P0V
 W7HriiXQDcXJn3vNfHkwPPMkrAu0iZXF3lEAmxMTumVmRooE6QmPY0TKYpaUwWd1TDnmfn9MU
 gHVrotmCSlViPCuaPQZ3/nQFxiF4v286xaCWuDkrU3fhU0BsRY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:22:28 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
index f7f087419ed8..5c5965a9d1f9 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c
@@ -417,7 +417,6 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 
 	mdp4_kms = kzalloc(sizeof(*mdp4_kms), GFP_KERNEL);
 	if (!mdp4_kms) {
-		dev_err(dev->dev, "failed to allocate kms\n");
 		ret = -ENOMEM;
 		goto fail;
 	}
-- 
2.16.1
