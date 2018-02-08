Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeBHOhf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:37:35 -0500
Received: from mout.web.de ([212.227.15.14]:33819 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:37:33 -0500
Subject: [PATCH 1/3] drm/gma500: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Message-ID: <bfd6d815-3c09-9faf-e85f-fe837c38bd4a@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:37:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:tMPIpSimiiYGh3g4fpx1qUbYslFUY3dh2neUCy/q5jARz5FJrep
 bALwgBy4gDSywyPhwExxmJwCNJEEJ0Ns15hKFxwdyyTJsvLFPFPexUzYi9TW7uQuwwCjjto
 ZsXB+zRf5/rESwCdIqWLQ131PvsiFrdfNS3dYrRq6G2D7CwI9WDNrTEgrsM/C5bSO9AWVwx
 02ulmc/x4yhUjXksLOATA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jLYy8XabJr0=:UOs/P3I1IukTyQ8SnYwd0T
 qHM4b8/aqbJ9XuSytlYWNxbT6pAWSmuGUo6CStR5Um8Z1wdEiwtVuOmKh/ordcZiER8mwqw6p
 +2lUcHhYiRGldtvBycMUq8hxE5nJkI9AEpVfM8bjsU3XqfZepDpMH8mhPrNXGRgCG4yG+tTWf
 zHhZ8VN21tanTKcrP5g3+PORIsEyaN7To7qWJdC3fhXzGA8dtZUttWF8U5WiFi0wyZoKstq7X
 +6wIQLGHiGc7XjFlInaCxep7fnGZnjWjllydxhmhvnxe8Yexk03jxTJe81s7vjT/9n7+H5kjQ
 nhM9pAEW4H44VIehvgCtztMpZa1eG9fdpORylVqxJm9sG82uVeq2Wi8tdwdwVhf6mGqT+toMw
 YwOY456wGFyjFFhxLNCewYPMyJGwTn5LwXxF7j2Ssv5GhDRngkOuGzqo20UhsS5VkoACarDDP
 tiGWo5r1sfpj8yIAN+hYrhSpx8MZCbFzVieaPVgwSnprmPgqdNGy9gHrcijd11UA9MvROZXlw
 gq45Fluy9MP+0+2Hvtf+FymLp0Q7oPM7nQhYhpvGVA+ofFiFPHzZ+qLoNmgXlTdOdrDMlUAMW
 nrSBMEiglxs7if4fbW9gWPrxrUbNUpgkkJgTjQUe43gWuz3Bg+VCiIuP/UQfd6BOnUwD8yAJ2
 qbeHUA6TIc9jokJw7jv9KVN7o04Vo0yN3i6qns3TOm/RF4uu2H+/gWp3PRjm5Z4Y3yDCgbvW3
 Rm3nH3myMmqVEj33WfcBXzI5iK1woKUJV6aBVQKzxqpPuX8oi4RQyRl0jzx3AlrE1+Sck1TKl
 G00ploBMpQ4x/hGzSiWwDfzMWp54gHeN1JPp84+cHysCCRO7Gs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 14:55:49 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/gma500/framebuffer.c   | 4 +---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index cb0a2ae916e0..3ff320f3ff47 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -530,10 +530,8 @@ int psb_fbdev_init(struct drm_device *dev)
 	int ret;
 
 	fbdev = kzalloc(sizeof(struct psb_fbdev), GFP_KERNEL);
-	if (!fbdev) {
-		dev_err(dev->dev, "no memory\n");
+	if (!fbdev)
 		return -ENOMEM;
-	}
 
 	dev_priv->fbdev = fbdev;
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 8b2eb32ee988..d9a6d54b6641 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -690,11 +690,8 @@ void oaktrail_hdmi_setup(struct drm_device *dev)
 		return;
 
 	hdmi_dev = kzalloc(sizeof(struct oaktrail_hdmi_dev), GFP_KERNEL);
-	if (!hdmi_dev) {
-		dev_err(dev->dev, "failed to allocate memory\n");
+	if (!hdmi_dev)
 		goto out;
-	}
-
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
-- 
2.16.1
