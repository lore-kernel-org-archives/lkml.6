Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B08C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7231021733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPHOtlCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7231021733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeI1GvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:51:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44251 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1GvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:51:12 -0400
Received: by mail-io1-f67.google.com with SMTP id u12-v6so3140703ioc.11;
        Thu, 27 Sep 2018 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uhdMuGSgilQYdfghsiQsGyl22I3jhLnaWudIsjlWo5k=;
        b=nPHOtlCJBHHMcYNVoH3gfY4Reo94K+uwfTO7gi+bzOtNR5n3RKWcc10qCNpqqGQD9k
         O+6Mgcm807Ne5vjIoWPi0jShS7ZnSNrJhDxQsZjJ0T/T5MnuBIHQQ82dgrslsZWntqh/
         91C66TF2kHNcXv1ZhJMakPZnSJsLjiYUaegaRqSR2mYcezTty6pTB504jJmUKhxQYjKP
         B1inZijmSAk/4+DsDHyWndEHqnomN/kTKb9hYITkru7BR4Zv0lFYyJm5Kcwm8hzO4E2Z
         enSmuf7gfj4RrV/9kAHIXienCMoTfp751sWltlafyvysQcE3fEQ1ievvnIm3/LdmsG9F
         W93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uhdMuGSgilQYdfghsiQsGyl22I3jhLnaWudIsjlWo5k=;
        b=TCh+ivtlUOT2hmgpwbIE60jG+RlKRbUrwCozM7voglFhbQui0Y1Eid/a3JjmLvplR3
         k6JW1ALjlqGduKty7eWtgxG1o8vPKLM835dRZMBk0uoWcfZpVrzAVdE9innEepjTOiGN
         TPnV523NEkwgWqqr6iJ/ggifp9/P3lErMLS0O9vQ64eIaXLLa3j1IZ6RlQF4OxxxUZBd
         C4pg8lkpYSziyxGuhUvXocP6wcjczc9dWtt25QZR2Gb//VzFLVdkALAXvew4U/bs7WG/
         kyFwciWf1LOE4dnsRRBZReTVg6BXmqbxJG64OdfT/XXnWqgWOBI93GIOCP9+BCvbZJNC
         5LQA==
X-Gm-Message-State: ABuFfojPzTUQsrUzG6rOC1w/LOX4ftOKJg6ecHAIUq8Jh70edaKiYL5K
        hiSeDHohuFfaUK7J9xlrrg==
X-Google-Smtp-Source: ACcGV60h7BwVvxlxAOTXWsI7G6Wi4qgyuWNVlm1u0ZO6kKx+v7kj4LbwFBYmQjecUIn5tJUePpdhOA==
X-Received: by 2002:a6b:8b8b:: with SMTP id n133-v6mr9992702iod.234.1538094614831;
        Thu, 27 Sep 2018 17:30:14 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id i8-v6sm1355106ioa.6.2018.09.27.17.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:30:13 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date:   Thu, 27 Sep 2018 20:29:57 -0400
Message-Id: <20180928002958.3935-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for ROHM BH1750 ambient light sensor driver.

Signed-off-by: ryang <decatf@gmail.com>
---
Changes in v4:
 - Change example node-name to light-sensor

 .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
new file mode 100644
index 000000000000..1e7685797d7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
@@ -0,0 +1,18 @@
+ROHM BH1750 - ALS, Ambient light sensor
+
+Required properties:
+
+- compatible: Must be one of:
+    "rohm,bh1710"
+    "rohm,bh1715"
+    "rohm,bh1721"
+    "rohm,bh1750"
+    "rohm,bh1751"
+- reg: the I2C address of the sensor
+
+Example:
+
+light-sensor@23 {
+	compatible = "rohm,bh1750";
+	reg = <0x23>;
+};
-- 
2.17.1

