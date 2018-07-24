Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5BCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DB920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DB920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeGXQnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:43:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:43:15 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LzJvV-1g3pci2AaX-014WD0; Tue, 24 Jul 2018 17:36:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: mark PM functions as __maybe_unused
Date:   Tue, 24 Jul 2018 17:35:37 +0200
Message-Id: <20180724153604.2811956-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:DJTuRnuOj8UrBO9tVhzV4Zi9Mv/Ug1nD38q9r4vtPCdO56pw3N8
 WKLHGzFvsDaOd2dNCxgTbNgvmt4uB6lLMbX/+WW7Ku9ZXtAlIzAVG5RtQ+6oVqpMAn9eztF
 ltujChWjqudxTV5Mq7PS26Bf3TGEc6UDg+fTwkpc01uO4RDZkUpowCq69wJE1oGqj58tr93
 X6F1Qxucc518F9jw30jSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XEKmNL+ONpo=:Rs0gIjNbW9+m+VIYYuApkR
 7Qn10a5DG0o4BbkBcNJ0l09Canu2y9VfGR1nvw/EWZyeU6lJk93bdfdek+qBXsCugvPuH5ZpI
 aAhfGFIZALwDd7NALk5e2dhctq1MsI3tuqRcNjKkMj/3GxPQYYLQdSnf2bHavBxdQ1naXWFld
 Ygw7l5GP2NpR4NQW6VcNO5bHTtrsYZFSc14PNtPejFEtJ7zKMun+h4lVG2Dn6mPlsvc7+xDEd
 36y4F9+nYueU16tMX5pPxxFEAdmk2mqhXAHgvb77BpHsFBjWeKvJ6xsBiN/ndzo9OApnmExxq
 +jUpM9ww9Q4lyrAu+mPbzp76gTj8GiyD4PA4fdt2MFHcIwagX/ED0acsBjK2sJOtNp1Tkh3RT
 t/pwFug+NFPV3pNq2El9x2KrPw7klFQjRrq/UNutYvtQKzJUI5csIoym0x9Wi1VAN/O2e/pcq
 Hwma1aHVzbZhuw9WimyUq+azux+8DMEMbxZup+JBaPMzVmDSQx6ClniJa6khMCz8dz9VtXoJL
 A2GP/9s4U1xdyMg4ktr3xW2b+jLXsZg2sKkLYyCw/xznaJ/8exU4EKYkyncEhw2No7KpCa6ta
 6ruJWfNCD7JAlQGYq02e00X3BvvWyGb7rDPt5noB9IGNk2XOChl3crUzF3D9Tmujn9AH/G8Sz
 RhJjUCbxAW+ejBpnWLxBcTZfbZ2OGDYZfBRDji2R8u2TvqfqmX/i27PHQNT4yZU8dC68=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend/resume functions are not referenced when power
management is disabled:

drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:1288:12: error: 'dpu_runtime_resume' defined but not used [-Werror=unused-function]
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:1261:12: error: 'dpu_runtime_suspend' defined but not used [-Werror=unused-function]

This marks them as __maybe_unused to let the compiler
drop the functions without complaining.

Fixes: 591225291ca2 ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 8d4678d29cc7..1c0838801e78 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1258,7 +1258,7 @@ static int dpu_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int dpu_runtime_suspend(struct device *dev)
+static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 {
 	int rc = -1;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1285,7 +1285,7 @@ static int dpu_runtime_suspend(struct device *dev)
 	return rc;
 }
 
-static int dpu_runtime_resume(struct device *dev)
+static int __maybe_unused dpu_runtime_resume(struct device *dev)
 {
 	int rc = -1;
 	struct platform_device *pdev = to_platform_device(dev);
-- 
2.18.0

