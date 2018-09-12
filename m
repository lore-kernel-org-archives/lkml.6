Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D402A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcSVCHTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D402A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeILO6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34853 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeILO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so1276462edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bVjNpCvKofUtyuEFgDB619KdrCitoQrvjqmhD8sWb0Q=;
        b=IcSVCHTNXhHda/x9tiTzq9MOaZs54JeUf+mlC3W5MO5gpC6vb5PMyqofYLAvqUI+ow
         jWBxwpgkZLSiyFj43C08+pry3/HcFCEijolxIerMwbojJVpxQgnmiWt57YPCQq0W93f8
         rS/OYttZ+j/JAD/kKZcIEUEkVTbl491Os0Sns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bVjNpCvKofUtyuEFgDB619KdrCitoQrvjqmhD8sWb0Q=;
        b=ZSvTGMj+ojlNkbaMYEYYb11KIw74Og+ObrE3AMXU7WdbZ4KqdQ/UFEuIp0y3joIS7V
         gvaJ4htQ4hkyvcCwbA/BnGbJS2nRdMckwHZje2h1aE4m4YweWWoWpBPCagOTpqOd1rHx
         an5Ddy8WZC6WXCCxKYvzRqz7cmn0nrcgl8d+10mRO4IVvxgXWBLAzfb9HDpGlSNoaxkO
         InF17lk9LvTeVFgwj1/R2e0no9oQU7tnEHZ1SCAJyEB67J9stV1NnhPKodhhvQ9pJWVo
         l0hMzWLwcUvBOAgSedJGgtkSsr86vQjPNlgEGgouUn/ONk4GPwLwvHwZk6NJ71jg6W9K
         Dh0w==
X-Gm-Message-State: APzg51CdRdSi5bBWOFAgzQZKVrBaaugt6HbGf+ON383V8iLpf2AVtVWv
        /ltMLF8BP/JZMtMFeFQvvRdaLasW4UA=
X-Google-Smtp-Source: ANB0Vda3rq+MJHMqk439MEeRaS0sKfNBJeclOJJnsUP5j44RlucLp19UPXnGjwv/tQiGd+SbDEBrTA==
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr1865390eda.14.1536746085454;
        Wed, 12 Sep 2018 02:54:45 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id i19-v6sm398734edg.64.2018.09.12.02.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:44 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 12/16] arm64: dts: msm8916: thermal: Add "qcom,sensors" property
Date:   Wed, 12 Sep 2018 15:22:57 +0530
Message-Id: <b471798c8e6de8c23de7ed4e2363049e2aad5486.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new property allows the number of sensors to be configured from DT
instead of being hardcoded in platform data. Use it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6a277fce3333..be27d8dc9e6b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -767,6 +767,7 @@
 			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
+			#qcom,sensors = <5>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

