Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C8F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3D8OnJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeH2QzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:55:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeH2QzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:55:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so4245866ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tafjmie3vqp+ylzMpXgxmXYrwVI/YlnYDWc8MjXNALE=;
        b=A3D8OnJ9UjKcwN7P7zBugbcT/xAmihOAmVktJ0by22Nzf/yz/P0Z12HqSsyKLelIwD
         xfFS/uqofkgun67zwdSzQ5w3421GjD6OGe/Ooe4GcTBfb0+pXaMJL000ir2+WojZCrLJ
         3zBhgiQ7koJz30voJ+kdIDbpFfqK7Rmh/aLFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tafjmie3vqp+ylzMpXgxmXYrwVI/YlnYDWc8MjXNALE=;
        b=tuj5CjBoarD0x8SXb/dgwIKn6vy+Tgq42WAGOH2ZkTKhxecO4mocY2Cj5Yfu9w9/iq
         KOH8uQ/7YeJo7mlp+ePmHiGL55Ulh1CYXGrz8mBRlMj0pbD1EUpcd2RaVmcvhp4d23y+
         W6+a3K/OsQaUUxNwXK4QR25SMxEc7Ll8lovdz5fOQgBBClvzrFNle9sXw+bLMRfUDYmk
         zGz4mzB9yI2ckdu2b2Rqc+InEtQK5VsPQWhcZF6o5sbtVTNt+RFsP65iU5MUum+u2P6s
         qCuXSUqzSysbn9TlA1PXsPKcrGOmieCSiF/Bzv4j+3xw0/vylz9glHpPOd6DDZacabTy
         nbhQ==
X-Gm-Message-State: APzg51AOaCP8pksadaZHPK7G/VnJQSXyy7Ni1l8DnqF+AD8R9d0leMhz
        U3fcFSbas+G6RlsPIi3ecMm7Uw==
X-Google-Smtp-Source: ANB0VdZoqHzgN11h84oVOVN+apggIHBxEvS8XIz45yhZh827P05W9bE9n0HBGLIhLw5MkYOIulj20w==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr4151910ljc.71.1535547498365;
        Wed, 29 Aug 2018 05:58:18 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 6-v6sm755089lfv.36.2018.08.29.05.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:58:17 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8996: Add a default compatible string
Date:   Wed, 29 Aug 2018 14:58:01 +0200
Message-Id: <20180829125803.11227-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a default compatible string.
This compatible is defined in Documentation/devicetree/bindings/arm/qcom.txt
and matches how it's done in arch/arm64/boot/dts/qcom/msm8916.dtsi

Usually the dts overrides this compatible property, however, if the dts
doesn't specify a compatible, this compatible string will be used.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cd3865e7a270..354d3f900f72 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -17,6 +17,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
+	compatible = "qcom,msm8996";
 
 	interrupt-parent = <&intc>;
 
-- 
2.17.1

