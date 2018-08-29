Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77AAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7913820847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WN6AMXjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7913820847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeH2QzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:55:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33197 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeH2QzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:55:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id m26-v6so4216431lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ytm94YatzjbxL9+K0K0kXmoeXbDk6olnNzLM9Aaov8s=;
        b=WN6AMXjbP5FPjS9sYOcSoeQHnWTof1wssRJWyhPyQS2+xP2pqU606Ags6bZQdpRfmL
         QLhHvytGJsCBQmTkfHmLoZEwR6f217t0Nlrq/9KvWrI8V5frZ2pRl7VaBE+S2Iq0gotx
         LGS2FsazXwgIyXAguaDSCaZqBaQwYYCHslLoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ytm94YatzjbxL9+K0K0kXmoeXbDk6olnNzLM9Aaov8s=;
        b=OUvfBVBAwmNKG7afBhaQP79aSO4C+CMTD5HgNT0ZulynVMpi5Aol0KF7lDO956yDXY
         E87gJqaOmvQHwz4pUJlX1mY5T68ykNdNkbPolno53B8jyBv+GVBI8Ij0quGDXkNI/ywc
         VdzvPs+GtET8Tay+Y0YP9XWyDf1Rr7g50WKag/8TrphTUU+lbBb84AzpmFx9T3MnhAwq
         5RW6rfpNEz3RFb6m+y8NXD/4l/f5mhm4h5L6aefwfbnBCADK3miqLPlIB5MLPtlvCb65
         tHOrsK8xz4Zy2w72rbSEdazfvLwKA6G2dHoi3JMSblpS/J19yjvH7XOzCiDkvYhP38Qm
         ZoyQ==
X-Gm-Message-State: APzg51DjICZvd8Olt8y0QtkrvqbVqVPgNvPBX1su6kwNOvmbQeVSL3a5
        Abhf5G2filN8fpkDBhFmE3s7cA==
X-Google-Smtp-Source: ANB0VdZ8bAUVFu2GhD8gnEoMr3kgMmIugAmxiYrmOgu/7dyl+ywCOTsn5xi6raRYJO4lXrtDVACd1Q==
X-Received: by 2002:a19:5154:: with SMTP id f81-v6mr4561833lfb.55.1535547499593;
        Wed, 29 Aug 2018 05:58:19 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 6-v6sm755089lfv.36.2018.08.29.05.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:58:19 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: db820c: Add qcom,apq8096 to compatible string
Date:   Wed, 29 Aug 2018 14:58:02 +0200
Message-Id: <20180829125803.11227-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829125803.11227-1-niklas.cassel@linaro.org>
References: <20180829125803.11227-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,apq8096 to compatible string.
This compatible is defined in Documentation/devicetree/bindings/arm/qcom.txt
and is needed for e.g. drivers/cpufreq/qcom-cpufreq-kryo.c to be probed
correctly (and for drivers/cpufreq/cpufreq-dt-platdev.c to work properly).

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 230e9c8484ac..da23bdafbd33 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -17,5 +17,5 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
+	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
 };
-- 
2.17.1

