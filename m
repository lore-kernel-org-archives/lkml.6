Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1820685
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLJ3iguW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbeGaRy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:54:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45840 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732572AbeGaRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so7364911wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+OuSyfn41q9eG33WrMKqO2krbdG9pjKcv2baAyctME=;
        b=CLJ3iguWWFbaIUz2Z+1ims8YJIQtFqvuzc422GhxGQFk5fLddWtgOhxu8JxcgYVfry
         zNdoN0nXPT7UvGtxDcQ1ix1B7vbXkZJ3SqZdYdBYI/wXG/LEh34DAnLKjh9e700iXPtA
         FEJvpp3421DE2X7npcXQLW+VItS4FPRnExR5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+OuSyfn41q9eG33WrMKqO2krbdG9pjKcv2baAyctME=;
        b=ki2fniO/ocsgphyUpb/kV+JHvdgwAN7JpKTLu0aNO0v2pysH0gqi1d2YmjGMFRYHdJ
         NFJHJvrtgI/MMnfZTMLrblgFGrQNa4i0xlunjxg6vcLSGxrTw9AG/LKN+VrKNm0vliVd
         +/8ZneRmLzgYU2Xrd591anVZVk+7/DTpcuCZ5xaBxA2A50dwEQrVLhSDxsMR6v0XLbWW
         EeUPnB9biBPpSuJC/7Am6KJ7exzzbxLOGTdyqRxqSEFeJqQaKgwhCUTDpurCqQATP4hF
         K4ZlERinjJdRwt+YS0drpW0BHehlx2L2SdQrNPtKPWDrrpGsDlvUfcL1GP37JnmdZwx+
         9Npw==
X-Gm-Message-State: AOUpUlGk0QP/uCCqvXtNorQpGNvYrkCNkyx1UZP7+A6ZJrQscSeJeECw
        9Oi/ln1I9TG5c97wAKIphwQN4Q==
X-Google-Smtp-Source: AAOMgpeKXRMeTa9D5g2sSV+TQwa6SVZGHMy9DkBiMs8xcpbmANoNwk9/+1OVj4NLWZ6er5yEfzR5Pg==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr21291114wrd.67.1533053635362;
        Tue, 31 Jul 2018 09:13:55 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t186-v6sm3643457wmf.14.2018.07.31.09.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 09:13:54 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v7 7/8] dt-bindings: Introduce interconnect consumers bindings
Date:   Tue, 31 Jul 2018 19:13:39 +0300
Message-Id: <20180731161340.13000-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731161340.13000-1-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect consumer bindings, that will allow
to link a device node (consumer) to its interconnect controller hardware.

Tha aim is to enable drivers to request a framework API to configure an
interconnect path by providing their struct device pointer and a name.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6e2b2971b094..5cb7d3c8d44d 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -31,3 +31,30 @@ Example:
 			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
 				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
+
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which dynamically express their
+bandwidth requirements along interconnect paths they are connected to. There
+can be multiple interconnect providers on a SoC and the consumer may consume
+multiple paths from different providers depending on use case and the
+components it has to interact with.
+
+Required properties:
+interconnects : Pairs of phandles and interconnect provider specifier to denote
+	        the edge source and destination ports of the interconnect path.
+
+Optional properties:
+interconnect-names : List of interconnect path name strings sorted in the same
+		     order as the interconnects property. Consumers drivers will use
+		     interconnect-names to match interconnect paths with interconnect
+		     specifiers.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "ddr";
+	};
