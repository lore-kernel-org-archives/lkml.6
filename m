Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF4EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B11218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B11218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeHQM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:57:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeHQM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:57:19 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M3C4d-1g6lAT3Vgt-00sxY5; Fri, 17 Aug 2018 11:54:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Todor Tomov <todor.tomov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hansverk@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: mark PM functions as __maybe_unused
Date:   Fri, 17 Aug 2018 11:53:42 +0200
Message-Id: <20180817095425.2630974-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:NVWjhwEohuSREh9AzGELW0acIAbZGvhs9AfgO9C8HIDjhot+A1R
 ZDCn9rrTthwsPgQYCgVoEs1x3g0wUq0Dp9s/bbvqnjli64mvpHaFXbZnIU9Rof34LVIAUpj
 d6yNXgxBc6MDWjQBBRGZ6Xc4shnsr0+px5oD2IyNu+x18SSmBAHKX+u7WAABJbIGHcTOZfh
 pq4aEHd3qlYafLqY713nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6IX4tnfdgf0=:nWNIEmvd8alZ2HAZdJWQc3
 iLVnj4z+n6G/0CHT1fMq9td/Ptxqz1feeRecjycr8TpLSoEAKAD1aiu3Jpvnuwouw50aXjUg2
 /QSK5BJJGPZ/1uWcDwfE7o075k6xkKQEwkRVcoyJJLlO4VvSZpdN2JMu3B2cVKA2Bq9/BX5za
 ICiLDIuPmOAqJqPf5DuOecykJfzh9N46dxqeiCcdKKLruU62h9zwzKctw4tqjvzSdJtX0hRwc
 Yey3r8rpUnY15DspXEX2rvTve4AF/f6RzpP9+k8SOulCgrt6CUC6GfdGNbfOD8iYA+XuZQb2W
 9ixth39eYCHRXJa6iCwAM3uQU3sVrOeGr8TFj25Yi/9rE2beQlXWWeIpDzB7fGgWy732kJpCr
 uuETKk9yNsa1lWkb9hT6jIgO9T2MQXu0LCjNo2Rm/FrXWz4BIFwJQbcCbjiqwUl3EwBybv+XV
 Ufzj8T27WGwwW2LBMwQD9oUKWoU4jt2oNwvXWIBQKuv4hF4Zi1DiHl89xq3SfLJ+hi6kE1V0a
 tLv22wr4aGqabsNjzygeLBVCuIkepIif12rxu+OLnZq+w6vd1+egZq2+WpDteik4OV9HNov+O
 iIatWj9Rdkmtk0+q3tKBORQvf2T4bQmg5k3SDhJxAKZjeB7LGNLbaDWWkOhAcZ7sscE4n70o6
 nL1iGaGsToTLCAD/+5m9q2msNLUUjrTEIfof+OjljfHMjU/v9eCObZAaPTQ02nKakTb4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty suspend/resume functions cause a build warning
when they are unused:

drivers/media/platform/qcom/camss/camss.c:1001:12: error: 'camss_runtime_resume' defined but not used [-Werror=unused-function]
drivers/media/platform/qcom/camss/camss.c:996:12: error: 'camss_runtime_suspend' defined but not used [-Werror=unused-function]

Mark them as __maybe_unused so the compiler can silently drop them.

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/qcom/camss/camss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index dcc0c30ef1b1..9f19d5f5966b 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -993,12 +993,12 @@ static const struct of_device_id camss_dt_match[] = {
 
 MODULE_DEVICE_TABLE(of, camss_dt_match);
 
-static int camss_runtime_suspend(struct device *dev)
+static int __maybe_unused camss_runtime_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int camss_runtime_resume(struct device *dev)
+static int __maybe_unused camss_runtime_resume(struct device *dev)
 {
 	return 0;
 }
-- 
2.18.0

