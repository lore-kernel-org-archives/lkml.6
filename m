Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A23C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE92175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDhlpiEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfA2XVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:21:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47004 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfA2XUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10417527pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IK7vUmkScfb4GTJa0Qmfj4ukRpGnUehE4KZAK/2fFS4=;
        b=dDhlpiEkrSzRnfbSHSUP0+EJQW45ZCPu1KXn2BnUS3nrGqo59qeABKPkEBFCYjqFin
         BzlSl+hE+eVbJU75mvAio07ggS949ygNqH18nHK5sQWhAX1JYdwb/fIJ33lqe6Fsd8lh
         /mhmWPqWQMVxzL8ICkZ3gD/yBeT4c5p2hDMTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IK7vUmkScfb4GTJa0Qmfj4ukRpGnUehE4KZAK/2fFS4=;
        b=eAAOhOu3Ct+cC6C4Lc0h3ih+71ldFwXfmboqidxpFySuJ7A7RD6jx0w3eHOD9PbDq5
         LDDWFAxk+naH2QxEsY65AF2ryazRW79meNSkIfEXkvU+KsMASlfX8bjgdkl+aKL3K+gF
         XGd20bKiyJb3ZYzTGExun9MrAzQv0s8Wh+BZo9GsaDqM9DYpbvUvXUgjy1z/tgk5XxWe
         wAd33HqZvu3jNyzsp48+qgyaYU2iSwz431IEgCQajEOJtbyRFk72/fD36rk/orE2vJUb
         skVg3NSlVMS8lKMjtjA/T+OGlL40+T7+3DG1JJULM5wBqQhkS2CYf5v8yJjDhoC4msWx
         X9gA==
X-Gm-Message-State: AJcUukeEOJL9uk206GMixKNAM3Hgj9e2FXkrTUEFspaqykaAyzedkCtN
        6LxwAkR7xxmbG8M4txgfTSKRpg==
X-Google-Smtp-Source: ALg8bN5niIIRDw3IgF4bqbB0E+1s5W659Ccbdpb88WBzpDc3UsYSOr2uzH7r9N9PIq+OL34Oh1Pi7g==
X-Received: by 2002:a63:f811:: with SMTP id n17mr26001195pgh.23.1548804031009;
        Tue, 29 Jan 2019 15:20:31 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:30 -0800 (PST)
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
Subject: [PATCH v4 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
Date:   Tue, 29 Jan 2019 15:20:01 -0800
Message-Id: <20190129232009.5033-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the rmtfs memory node, as described in version 10 of the memory
map.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Labeled the node

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c363848e9001..afaffcc1e835 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -78,6 +78,15 @@
 			no-map;
 		};
 
+		mpss_efs: memory@85d00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0x85d00000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		xbl_mem: memory@85e00000 {
 			reg = <0x0 0x85e00000 0 0x100000>;
 			no-map;
-- 
2.18.0

