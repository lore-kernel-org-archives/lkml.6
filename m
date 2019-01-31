Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F7C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ+DOyoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfAaAkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:40:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40070 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfAaAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:39:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so583107pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rku1BaWpLuzz+j+NKPgUgAkxtH2UnE4qdz465ne+ekY=;
        b=kQ+DOyoGl9amjlhKsWQX11UEQ/ST1ykM8cDg06n85E+OiO+nk/ISg3sJzZX89C39SR
         cw8ry+mLvsFnXdrFwxI7ZtXNxvvGG/S0bk79yG7rb2QPD0QO6BYKf2S2aFGcdq9HGKBn
         6R2jJNpSUfC5TPpDkLyuvShRfrgVydyg5hgYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rku1BaWpLuzz+j+NKPgUgAkxtH2UnE4qdz465ne+ekY=;
        b=l5UhwFDCUGO/8tOjmgSmlRVOsv59XXC8z8RNt2/PpcNSooQv4iYMzNXC2ptc6JcvUg
         tr2Xp4mXru4BtpvoFx2XRErLhN7B5Y82Y7H4/Ozg5Feb6OWXVEgAml29Dm1NitMngl2V
         mthz4+eGYlMeJe9fDh9UItv+c6Q79FKukWfAvHUa2WYwBYxTAx0EKaAqj9nzQmZWNOth
         d9PETYmtX93/NbksKW45blCahm1nkHRvJ3gVHMRwWSuMvoJy52QUK30hQ9dM9U9x/7Ul
         bRrJNv4Kz9dWmkv+c27OLo2kkhtpHbrzc0/c7yOu5cuzNQcc3ABI2zB/IpIXT2iOv1H1
         Uemw==
X-Gm-Message-State: AJcUukfGVrTFljcVwykBsAxYBQKWdrt3SWbRLHyxq/du9hs8UTrSEQX6
        mc72IkUKTbS+3FzAiBSr/P8+BA==
X-Google-Smtp-Source: ALg8bN67fHb6QRKmWHU70Rt4FgJmRNj5VVPmZevkGSy+NIuVdb2MPdrNboXHO2pO5kt0xjmcr2eTkg==
X-Received: by 2002:a65:4784:: with SMTP id e4mr28990086pgs.12.1548895193337;
        Wed, 30 Jan 2019 16:39:53 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:39:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
Date:   Wed, 30 Jan 2019 16:39:25 -0800
Message-Id: <20190131003933.11436-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the rmtfs memory node. As the memory region specified in version
10 of the memory map is only 1MB a chunk of unallocated memory is
chosen.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Moved rmtfs_mem, to not collide with xbl_mem

Changes since v3:
- Labeled the node

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 45b1616392aa..d19486ba1e5e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -104,6 +104,15 @@
 			no-map;
 		};
 
+		rmtfs_mem: memory@88f0000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x88f00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		qseecom_mem: memory@8ab00000 {
 			reg = <0 0x8ab00000 0 0x1400000>;
 			no-map;
-- 
2.18.0

