Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F54ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280DD21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZtrsDh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280DD21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbeITGDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:03:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeITGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:03:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id r1-v6so99945wmh.0;
        Wed, 19 Sep 2018 17:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iH4r24q2VoAOZUVlC84dyq2wSG0D5BgRBNdUuooiqI=;
        b=HZtrsDh41iU+Z4rxtQonhWFhSHYFlwmaYZGVwlYY5d+XKLut9hgvNSttecMOKpJxP5
         EakV3zo2VilPQ61hs0OHrwCmOTTs2UKQV3rWGqHrsvhII0Pr2INib++cCTOJ3K1LvQh5
         uBkf4zqyBT40ETUBZVB6vDuGaDh1OfKc3G8nkc40Fbyf5ftQ0RhYSJFgegE8ptKEf941
         hLXqKDRxxOtynXf/gqBr3LfkQCwhI/lMRbBwi0qCvSifpf6DEA3WVfgLV7WBrrQftdOA
         8iu/YH2Gqb5ssnyVq3sJLay4iRT6YGiNF88nLW5NP2GoESKRxfBWTObFJe8gk84gv/vQ
         Zx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iH4r24q2VoAOZUVlC84dyq2wSG0D5BgRBNdUuooiqI=;
        b=KjqGveEtMfXnCvocjp45qYIkv2BVhlAySkJxlADYBytopH8NYpBG4OeNOyYqv/BayI
         W+QFS1iexoTygFUNYwj7fbOGhnEfFIstNoH3g/yqGMD20HsN9hM0VorP1IpXZqXY5O8K
         ADar/62B7ucfvOGYeLz5xwkjRmWKa+jVk6GU5TmpgS4D/szx6zBW/l1pcT4A3OcZgu21
         4fTgiCnM78UqN/VbWCYBg2EH0KPyOgwljj9LML9tUssIcPAGbguIY3t3LOV0nEOOUMlV
         ufFJTsNO4kSFzGhm9IvKVn2eDmsy2qcpMDPSwJyMAE38wDZpjNyW6WrMp9lIEvYg1mJy
         CW9A==
X-Gm-Message-State: APzg51CiF+ygLAn42YffcM6klrNXIkUCEAMMoGLyuwus5QpfTzrXALXK
        2/5/9ANcNUecebX8qrqITN4=
X-Google-Smtp-Source: ACcGV60FNZw36/CDXtcKIATh3x1TkLqZd1aEbiwyaePlxaVesngQCz9DiyGNzuLYoJ5xAR/D1zYuXg==
X-Received: by 2002:a1c:ac07:: with SMTP id v7-v6mr249001wme.110.1537402964281;
        Wed, 19 Sep 2018 17:22:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm201317wmf.35.2018.09.19.17.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 17:22:43 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] cpufreq: qcom-kryo: Fix section annotations
Date:   Wed, 19 Sep 2018 17:22:21 -0700
Message-Id: <20180920002220.16644-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a warning when building the Kryo cpufreq driver into
the kernel image:

WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
the function qcom_cpufreq_kryo_probe() to the function
.init.text:qcom_cpufreq_kryo_get_msm_id()
The function qcom_cpufreq_kryo_probe() references
the function __init qcom_cpufreq_kryo_get_msm_id().
This is often because qcom_cpufreq_kryo_probe lacks a __init
annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.

Remove the '__init' annotation from qcom_cpufreq_kryo_get_msm_id
so that there is no more mismatch warning.

Additionally, Nick noticed that the remove function was marked as
'__init' when it should really be marked as '__exit'.

Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
qcom_cpufreq_kryo_get_msm_id.

v2 -> v3:

Go back to removing '__init' from qcom_cpufreq_kryo_get_msm_id instead
of adding '__init' to qcom_cpufreq_kryo_probe, which causes another
mismatch warning and add the '__init' -> '__exit' conversion noticed by
Nick.

The alternative solution is adding '__init' to qcom_cpufreq_kryo_probe,
removing the probe definition from qcom_cpufreq_kryo_driver, then
changing platform_driver_register to platform_driver_probe in
qcom_cpufreq_kryo_init, like [1]. I don't know how that would perform
given that I don't have a way to test this device.

[1]: https://lore.kernel.org/lkml/20180919185341.31298-1-natechancellor@gmail.com/

 drivers/cpufreq/qcom-cpufreq-kryo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index a1830fa25fc5..2a3675c24032 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -44,7 +44,7 @@ enum _msm8996_version {
 
 struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
 
-static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 {
 	size_t len;
 	u32 *msm_id;
@@ -222,7 +222,7 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
-static void __init qcom_cpufreq_kryo_exit(void)
+static void __exit qcom_cpufreq_kryo_exit(void)
 {
 	platform_device_unregister(kryo_cpufreq_pdev);
 	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
-- 
2.19.0

