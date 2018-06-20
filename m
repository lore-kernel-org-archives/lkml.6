Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E997EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384520872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOTI8fNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeFTMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:12:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51157 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeFTML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so5631696wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IqhM5Ox8GZtLGas2YyRL1o8i1y7I7Q6nRSIg2WoLuIA=;
        b=IOTI8fNrS86MKNRUjjEtu6tRplQMqLzzb0Wwd8ektRS96w/GT4ZcpL1yim7fFKSzSx
         AUC2BKwJxW3zim77Yp9JlitDEVgsqob1S4dbH+lmOYmBXzVLrt4Kb0AL9eSh5AP4gKI4
         zhBY23t+yF3u0A0igMHhGqFSb3d3dT7Ms+iuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IqhM5Ox8GZtLGas2YyRL1o8i1y7I7Q6nRSIg2WoLuIA=;
        b=Asl8BjeUpEt9Bdu+YVU7a5XlJVa7od0DSKUwhsV0Rqx4V2X6sEaT4wyMRnP+Gs3lmG
         cvl6nVCsz5SoKT/kW4KJ2iWgxD84ErmR0SybC98VEpKjbgrMm3Rhs3SbqyptLt+zHe7+
         Fnk+/hwO3iWdc69IQK44dJaCIKzNpnWenI8+2M2tsDFYqEzHQYwmNIdvLWmTymrfWwyY
         ReW7iZGNM/9p2QCA/nVwLWAUIMHPbKelDGWEFdhR7ZpH3/JZjtkVxXTTcHtBPQdbb5gc
         sHOglTlJIfn5VoTmXyL/F3gDRsengygQddAbiEw2Zr8bUmUgNehY5OoIWcMVnfzilp4r
         aUfQ==
X-Gm-Message-State: APt69E3cTGLAiTJQ8IUT3QyZJmkVdjBzy2lcY6Q4kNQvJ9yTTkH7alKN
        USpThdHCeH9LTFEo+ToVJV0COQ==
X-Google-Smtp-Source: ADUXVKKiu85S3c2896OuqfdKaYy1Un2JXAx0yjsctcyH37m91nlfidSm3YIRxAbubCSO8oWoIV6WNA==
X-Received: by 2002:a1c:28c6:: with SMTP id o189-v6mr1636268wmo.102.1529496716284;
        Wed, 20 Jun 2018 05:11:56 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:55 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 7/8] dt-bindings: Introduce interconnect consumers bindings
Date:   Wed, 20 Jun 2018 15:11:40 +0300
Message-Id: <20180620121141.15403-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
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
index 6e2b2971b094..0ad65dccbe8b 100644
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
+The interconnect consumers are device nodes which consume the interconnect
+path(s) provided by the interconnect provider. There can be multiple
+interconnect providers on a SoC and the consumer may consume multiple paths
+from different providers depending on use case and the components it has to
+interact with.
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
