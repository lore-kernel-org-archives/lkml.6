Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeBGVAd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:00:33 -0500
Received: from mout.web.de ([212.227.15.4]:57225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbeBGVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:00:31 -0500
To: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm/msm/mdp5: Delete an error message for a failed memory
 allocation in two functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <7726fab0-dbe4-9d70-36a8-17d6078a39ce@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:x58EUAfklJAthGzxC7i3wsse5s6wYrtryTcAo4lSck8VLZoU4b2
 0XI73j0T5ksjCEiuATUPoF5QBkRwsJg9kJNfSRevmAEINqWA9lFL7kRhF5aUScf4zvzxQJZ
 ZfX4bc0k20p65lqt/E4F5+ThdzrDP7fQTc9qg9c+cJcYXRWBdRJkuTH2oct1NIV7E7JiAr2
 UsfHHGVkcPYbyXktO3OFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QVMcGaYZzR4=:hiWgbXnn+S56qDY6HNePxi
 KJrW3NORA0CNqpm3F/dWVIpF7Uq6G0I4AUu4J1kaycu/4rCmLVC5kY2o5i+2x0GcT5BP6TZTF
 4zwckhou0HV/u9O7s4g/H3/Vw0Rn6Ms4lntYBC1libgb1YHgUPK+P9PD76vbgKgpWRciMSLjw
 k5qmlL6USp2x6yNdTALVr9PqdTEfD/NdC6YYs7rEqQPKiZXFHC86OvmS4DbF/Gh2W+oRz7gON
 ZIFhbfyKnEWR45Zkfn5czsI4WbdtPr7tU3fvBnyQ8juc1I+bu8YnEjRKuECYXrIfffOGEneOr
 0/shgF5r3skurC+EcFQs/vCkpe1xcM6tovKKynejn/J4sNERx46HHeUf+7SwkOgZM0x+ImddW
 LLXSIxIQYpWH7SnSBSr61VD4sHggpPQFWskfSRo8ShhuFlKzHRHrhgV/Pj6KAQbDZ032Y0sgS
 jabXhDjsUGXB+GOuKuASVjUpXzTnNiHDatqlXzOot+F8cE2D4XsC4RlUL46eSW3ZUmkOiAkcb
 rDQXgPSMBPXjRrv/0VgBrl6FrqxNTFukkkCMX3rSnKrtzotPV89DQ97yNTvDQubEb3VQw6PRo
 4WAQnNgKFQGF7Cl+HLhCJMIrZHtw/8W2HrZ8W2uUgbROBa6Z0aqz7925cmyK/g+LtpO28JN89
 39tQU0nQT612GaFX/VnOTzFNX0oPLJJ6U0Cq/G6e1CJj6uVNBXkSTjgSvvsSa/T2NNVl/MGmq
 OIOT+OMp6efXbF2wvjOKJ1SxSsll2letT1KJIov0h9lAlTPxfwIjtrKjHXVQByF8sUMMfV6t4
 TEEvNjCweLWX4R4vg/Wu5ROVeCrOWUuMqvbykX/pnRu3PHhEvY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 7 Feb 2018 21:50:07 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_ctl.c | 1 -
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_ctl.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_ctl.c
index 439e0a300e25..daa224df4457 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_ctl.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_ctl.c
@@ -717,7 +717,6 @@ struct mdp5_ctl_manager *mdp5_ctlm_init(struct drm_device *dev,
 
 	ctl_mgr = kzalloc(sizeof(*ctl_mgr), GFP_KERNEL);
 	if (!ctl_mgr) {
-		dev_err(dev->dev, "failed to allocate CTL manager\n");
 		ret = -ENOMEM;
 		goto fail;
 	}
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
index 3e9bba4d6624..5bf54ca7ab0a 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -844,10 +844,8 @@ static int interface_init(struct mdp5_kms *mdp5_kms)
 			continue;
 
 		intf = kzalloc(sizeof(*intf), GFP_KERNEL);
-		if (!intf) {
-			dev_err(dev->dev, "failed to construct INTF%d\n", i);
+		if (!intf)
 			return -ENOMEM;
-		}
 
 		intf->num = i;
 		intf->type = intf_types[i];
-- 
2.16.1
