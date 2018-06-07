Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4iD9LnuaGVu7IwAAmS7hNA
	; Thu, 07 Jun 2018 20:51:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 925F7606FA; Thu,  7 Jun 2018 20:51:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xx4dol2e"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19305606DD;
	Thu,  7 Jun 2018 20:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19305606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeFGUvS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:51:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35152 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFGUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:49:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so5317352pge.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JgXwfx070wqrzLNDUyrx7PZU4EU8+MQVUuulnO4MgAs=;
        b=Xx4dol2ew4gdMdV9I0WhFZPrQsmnVFCFjIOwbdyDK5w/TQfaoAL3dsxJiir1p0xKPt
         Dm2fSapUvMF7HqpGHHT7PDpQoYrzRH7iQZ30tdh4PS7C2HYPZ2MUaBLJdML5ZqqftP5p
         Yk2lesm6BbzTHKnmF2IOmv+BDVFMCaxbxRcwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JgXwfx070wqrzLNDUyrx7PZU4EU8+MQVUuulnO4MgAs=;
        b=qglnrs/RxXyAV2UYrc3yL3DscljmoNrMF496tqQGCHUFYAIXxw00DyWv7nIKd4DgIh
         +mUYIdwreIZPVhYCfhKB7F74/72cfMgg1L3+6GwpbYyXJd4mK9B2SCw4/Xs2p52XDy5u
         rbsAaGiRNzccEYrDYcx1zARvp8i89XRFw6CvPZvXfojKU+vrDrlS8AQRIE0PbxMRxo/t
         1hzudnnF0x0TvAL+IHphnayFUX8m6oo9RD6nbt+MhR43K5MyfUsisXkOwDFLZavsgaSP
         e40jNpT2sedDVWoglXJmV7Ys1ofMwvt50JjSjyR396rJAijhs/MRTUYUkS+b0nBS/TZA
         uLjw==
X-Gm-Message-State: APt69E38TAPIxREfKpyQFeVU+4SynHPtJogzWKHx5c5eoFFEFJJbsQol
        jdYFEUfHjfPp7Ay5b9zBOk/tTQ==
X-Google-Smtp-Source: ADUXVKKfkbWL7x5AVi5/fYUgWM+0g579SPIRzoDwjATQJJdgSapd0oT380uNO97Dr0Pqze1gwe7cxA==
X-Received: by 2002:a65:498e:: with SMTP id r14-v6mr2745914pgs.78.1528404586310;
        Thu, 07 Jun 2018 13:49:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id g80-v6sm35758452pfd.21.2018.06.07.13.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:49:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: andy.gross@linaro.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        kramasub@codeaurora.org, sdharia@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: Enable debug UART and I2C10 on sdm845-mtp
Date: Thu,  7 Jun 2018 13:46:08 -0700
Message-Id: <20180607204608.27688-2-dianders@chromium.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607204608.27688-1-dianders@chromium.org>
References: <20180607204608.27688-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug UART is very useful to have.  I2C10 is enabled as an example
of a I2C port we can talk on for now.  Eventually we'll want to put
peripherals under it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 979ab49913f1..e1eda143a725 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -12,4 +12,56 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp";
+
+	aliases {
+		serial0 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_i2c10_default {
+	pinconf {
+		pins = "gpio55", "gpio56";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&qup_uart9_default {
+	pinconf-tx {
+		pins = "gpio4";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pinconf-rx {
+		pins = "gpio5";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&qup_uart9_sleep {
+	pinconf {
+		pins = "gpio4", "gpio5";
+		bias-pull-down;
+	};
 };
-- 
2.17.1.1185.g55be947832-goog
