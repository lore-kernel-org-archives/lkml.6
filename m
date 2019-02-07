Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B294C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768E20449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549558732;
	bh=n9DJXdeppGeP1MUdxzImlNBYqAGLt70LwJGE0esVSHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uoEYZoxvEVy2tyRTxNO5TvT4zEwun/84R4e9Q87j80HMcuaE+oHuAccoL5tnhICAT
	 wbL81jxYr175QEF0wlYaLX19Rb9Q4I19h3egt4/ZWM6dQVcqNkT3jsHfje9h1fjIHT
	 ar0vkdlm/aIKW+sAg74wg7Y/Ztm17QzJ+R2YaQjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBGQ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:58:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33915 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBGQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:58:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id v14-v6so520569ljv.1;
        Thu, 07 Feb 2019 08:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/q//UD4ZstOt2/eUQlKTEObO/VkWoke0sh9vogELpAU=;
        b=rYhSG8DJc3oiH6JrqOT+3ZrqKT80cYYjMgyaYtZgR50qXD46HWgnBaZ/qf0xRRdn/6
         xGa8wDOZKE49JH2PWBiS/5MGGGBInWmZvNQXL8uzHZLLZmjOz1tIiLPTwGgp0WYPXHO1
         O1nGcHTJmKfMfFTRKdKZu0F7wyZ8+uegXlTeX6o577zEjW1dYvOTBHIR7MNm8PIrHZ6n
         ka8+qLfftMaq0GJEMQ1ad1FJEEfKVckAeJ0kiuMcjcK/FVw+bML2BgCEZpufTwJz1L3t
         ocv+YzugRq8+WvIfDzX262NJlRNKwpMUKkxQDyU/h6e2QvY3b7jM8pQvb3kLJIIXydia
         qoWg==
X-Gm-Message-State: AHQUAuZgjSZRZ2tZa2uEYCtmpCJjFj0+b7qm5NoCNAG/ilZYZ/3vr6R9
        Lhu0i2elQQcMhYH7blGLi1s=
X-Google-Smtp-Source: AHgI3IY79s7TXwqI/1J3CRQFstVHvw1rhDp4dA93l2zdfrU5APjpUU4xfa2cn6l3S9YyeowF1lUrnw==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr10671522ljj.95.1549558722831;
        Thu, 07 Feb 2019 08:58:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z18sm1110005lfb.36.2019.02.07.08.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:58:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1grn0Y-0000Q3-Bt; Thu, 07 Feb 2019 17:58:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] dt-bindings: sound: msm8916-wcd-analog: fix example regulator names
Date:   Thu,  7 Feb 2019 17:57:55 +0100
Message-Id: <20190207165755.1548-4-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix upper-case regulator names in the binding example which do not match
the corresponding required properties.

While at it, add a blank line after the required-properties section to
improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index fdcea3d12ee5..e7d17dda55db 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -30,6 +30,7 @@ Required properties
  - vdd-cdc-io-supply: phandle to VDD_CDC_IO regulator DT node.
  - vdd-cdc-tx-rx-cx-supply: phandle to VDD_CDC_TX/RX/CX regulator DT node.
  - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
+
 Optional Properties:
  - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
 			     detection on headset when the mbhc is powered up
@@ -92,9 +93,9 @@ spmi_bus {
 				  "cdc_ear_cnp_int",
 				  "cdc_hphr_cnp_int",
 				  "cdc_hphl_cnp_int";
-	               VDD-CDC-IO-supply = <&pm8916_l5>;
-	               VDD-CDC-TX-RX-CX-supply = <&pm8916_l5>;
-	               VDD-MICBIAS-supply = <&pm8916_l13>;
+	               vdd-cdc-io-supply = <&pm8916_l5>;
+	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	               vdd-micbias-supply = <&pm8916_l13>;
 	               #sound-dai-cells = <1>;
 	};
 };
-- 
2.20.1

