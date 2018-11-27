Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DEC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B0E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7r7yCwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B0E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeK1FCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36827 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbeK1FCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so23283287wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=M7r7yCwFSsUhkHktc+zUEkJf50vg8NeJQSFe9yigJlboIqAD1j1SSJbVER1VYY7moG
         cHYMDf0LgqVQiDNAqHY3SpNjR3vHK1JR4obuzTMleXExE10xrfPbKNTnXKz+u6Lduf7l
         bSQuBfk1fGn904knoPPCkjUUg1H2iY5D0R+so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=HuaIhbJ2wxZ38lLuJ27kTtdS1bvhCBiG4Azq3yp2ByL+fO92ZibO01QaR4MHLWzdtU
         YCsy2JF6XAgv2kWPIaDvwhb1O3XRf5wEAK2apZyr6D65I4soJv5EO/HTpRO1MKWiRwA3
         ujRLNTB73GSJ1I77bAHTAJt9r8euYNFaC+8hmlqkhKyxm3oHcx+AFxQdIVcDJoGtuNnP
         OTOBGqmWCBGd/ytwPhRxjB109lCiqBR1CUJWY0uN2ciz5lslnC3si/h/epYDJmxqxtp4
         X7KBlsnPhKr7W/QwW1xpz9jkj5O7ZLmXuzLgHLKEJsf/STle/Hw9dLr0Xt9zp33pvgzm
         JSbA==
X-Gm-Message-State: AGRZ1gIILHZlzBFaq0t8VSwwiyqpP6YVYROCCoaUBmNhBFwu+oa/fmjB
        cTEJGt/IeQfBYhqW2R8XgiGniQ==
X-Google-Smtp-Source: AFSGD/UXmwxkiSEROXEI7YSXN/7RqpCXL7VHu3J3tyNxJIWiM4bOT6v7WVlCBPARnY1SQEed9z6jmQ==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr30136354wmf.46.1543341845410;
        Tue, 27 Nov 2018 10:04:05 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm6459921wrs.58.2018.11.27.10.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 10:04:04 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 7/7] MAINTAINERS: add a maintainer for the interconnect API
Date:   Tue, 27 Nov 2018 20:03:49 +0200
Message-Id: <20181127180349.29997-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..4f426863ff3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7694,6 +7694,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
