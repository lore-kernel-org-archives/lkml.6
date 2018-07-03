Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D775C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC392244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pcm43clb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC392244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGCHWy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:22:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44653 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGCHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so93834ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PHPETDsOiGGq3xfgwH/vt7T1bmX5m1zA8y8ZeR+hG0=;
        b=Pcm43clbEVR0KDD97bK9OM3d0G0JDVOL1xyVUC/NkXh7cwDmLoo3CHOfTTDjRoASUg
         cLQ1CTI+oU2lrEfMOzHclk6/FMy2tgl/Ci0zlculxFV06op6YYtl+0UIh1g97bI7Vfsm
         juBSZvyg2yKHnEc1c9s0tR1M0ltJYQJ8iGeDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PHPETDsOiGGq3xfgwH/vt7T1bmX5m1zA8y8ZeR+hG0=;
        b=NipcCHZk7l8EHjWQ13vvMSb9ovafWtxs9sRJdcMpxtcKLjxSIHWV97xjC0v0r0bpwA
         2RfNzrlBXGxP1uADkCTGhjWfxThGd+f+9Q8V2kIuumTRg3CE6g0ebslxjjxs8Yottgkk
         trYo00Y33F/CrQZp2vYJVybjBhfJC3fVMdR19QerO1Vb0IYTXnej+yDFwCXcreveqtVC
         a3ONBH8Rkm9jaxsrUXtbX7yi5q2gRnaSDeEBhaaT5SIB+jheIWIZJJCc0lJPRGh9vw5J
         5Lh4EMwukHsHHni7rjU93GoYJiJh/nBcXr87nWZC0DS7h8B5Umq67HKynqdR9Ru7D8Ny
         0wQQ==
X-Gm-Message-State: APt69E17Tc3RNk0cx49FSmqCSMD7QcW0O4g3AeDwjHHV4bJLlz7GDWxX
        zb/a3LO4548hT6lN6WSZ0cdXJQ==
X-Google-Smtp-Source: AAOMgpfd4EPxuzOJ0OhPusxhLB8UZvcwC9yZaKn3MwcKLBK88zhHRDg9M7gg+02dRZ7QfR2Va0sy3A==
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr2759448lje.41.1530602469858;
        Tue, 03 Jul 2018 00:21:09 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id k10-v6sm70519ljh.5.2018.07.03.00.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:21:09 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
Date:   Tue,  3 Jul 2018 09:20:32 +0200
Message-Id: <20180703072034.20213-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_SMD_RPM builds perfectly fine without CONFIG_OF set.
Remove the bogus depends of OF.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7da6e67c7ea1..ac657164a136 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -114,7 +114,7 @@ config QCOM_SMEM
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM
-	depends on RPMSG && OF
+	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
-- 
2.17.1

