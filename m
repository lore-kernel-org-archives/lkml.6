Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D2320835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev/znSSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D2320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeGIPwx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:52:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37543 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933819AbeGIPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so21296058wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IqhM5Ox8GZtLGas2YyRL1o8i1y7I7Q6nRSIg2WoLuIA=;
        b=ev/znSSYUOCgY99iFogLuTh8Rbq7ljCV1Xl3qfyfll/JVS/DbKytOCPpRkYmFo9Lhv
         PzT1Fwi5bUhYjBEgP5IsDGj0tKUfe5RTb7RzGZlU3MFrgSjvQkoHVYR65Q/5xXSiTstS
         W9EIZTsd47YQJbPm5OaMiH3e3qDMLWT3Ubvz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IqhM5Ox8GZtLGas2YyRL1o8i1y7I7Q6nRSIg2WoLuIA=;
        b=hXjGfc5n9I9su1KBY+NQV+D1ADzqQBLVd2SuRFsD/70GWmUuf0MsujrsXCoEgflhha
         lDwrKUSLxcWVpkijvMmIOcOBgmU6Ti2HobqG14FtUlow9SZqc3oR6d7/hp3Gs205ii2Q
         Z6Urz/MRPEzC1w9+UhJS5pWecPtUR15rATiDMngw3hQcXuEO9a66w4ewhCT1WcvqkqBs
         J9cilzmHAVvBY24AddETL1ayvY/XJDzKo91JmXbLSv0TMdHb9eBAsAIfTjSqXmjP4gAY
         /s/RdD7XwH1LGX9x8eZmHXi8yPSl8JOlLK1QzBYK2hN891yEL+k2ztfUWlr0YAgO9JdC
         LE7A==
X-Gm-Message-State: APt69E3g48XUURYbHJ9aph3Pey2EeHA6rhOnVqKHv/6+6zLo5wXAOnNF
        0P/dkIeO5nZ4s+LU3dJ4QVEqkg==
X-Google-Smtp-Source: AAOMgpdgV9JppOVDgWtm+KcJn5i7BG5YPOWi8vVGyWNHHiR2/u+snjdXpTVWAviSzaqkfdHzgP/7ng==
X-Received: by 2002:a1c:a8f:: with SMTP id 137-v6mr11419231wmk.119.1531151479838;
        Mon, 09 Jul 2018 08:51:19 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:19 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 7/8] dt-bindings: Introduce interconnect consumers bindings
Date:   Mon,  9 Jul 2018 18:51:03 +0300
Message-Id: <20180709155104.25528-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
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
