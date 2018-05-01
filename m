Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176629; cv=none;
        d=google.com; s=arc-20160816;
        b=MNHQfUSrVYjpGqDnq1ykzYist5bdF/Df76FW8pJ+tHALDi8mD4rHOqBnm4SilXLX6+
         7COKq/9bWQOD4EoZtJE/lPw/wBn/1hMJlCpUR6llYB1r98YSuK+kNchEG3S/xu+L/mW5
         7LY2E3HOUN7CuJgyiTl240Vr1dJEYVe5kD7AMOiXxTyGeN05CMrEt1kVPBAqWh0ndpDc
         bnhA4ZAqkbUImJZz1zsoNekRoe7CcCihU5hGt7qqWmjXNTYkIp51ck4gSdOfCBI5UoWC
         xpBV6ndknTJB2YzKf2Y4w5jdJCclTxVK7sssZyW/f3VXMuyKyR0lhVj225xJKxL/6kfy
         jdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6dhbJh3dLyW7tPuR+njdeTeZKcfFUurrfG9cix3iSBA=;
        b=W8N6/6FgMB3nzrTSrBgl8VDBlnrDhnTNRfOG/nmMiQE0ZzwTNoTMO5MVY8PrK53kzP
         EtgRMHhqYDiWFXZhlSV3VOheiToWMCBVx6c13yJAKjc1eWjfpYNCvvf3AEL5wwXxLQDX
         DulkEijYs79dMP7HdH4DGttPn5xNxE79YvUzsetzMH1Evidxphr1D7RZYKysLCvo1ypB
         2De0wXEg7FXUNvnSFZt92WtLPbKFtcTVvuqyrMCTwx21vN+oU9iX4HKwWC9/fwZPhUQE
         oWgBtyai7aPgWfcTycp2Jox0M6gnliGAHowwNtnRJGF2IL8RZPspuO5kn1QuZrjvbPXW
         asog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Qmi/EOyd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Qmi/EOyd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqo0/oX0t78aHKgHGYCW958a6n6IQlv2ecFbeVOxfqT85xfdoTTcC2L1u6ywegR96nvUJq4QA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
Date: Tue,  1 May 2018 13:07:59 +0100
Message-Id: <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263609248976088?=
X-GMAIL-MSGID: =?utf-8?q?1599263609248976088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..bd14e9a93490
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core@3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.16.2
