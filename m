Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736173; cv=none;
        d=google.com; s=arc-20160816;
        b=e9n5etO7y8R1zB9cOq5q6R+kSdJJ7Ugv/AwcvFFQxmuUyNOFNT8n4SmIN08n5r0jG/
         JGnVqErokRlYwzsVeZvL7pXk9yBZAmoIOXT1ecWJyACfrYuAvlN1f5QG35ltb4h1lTev
         t8+ot3TgbKME07aOeRi2OfzP2A0ghTTDijgs1Qn+cwc+7AJWbS/bP7fjn5wq5MgwjoX7
         fobKod2/Rq1Q73r1xVLvspnkVMrFELqXLpEnoWuRWo8c+KG4eP4oiKrUozvsfShtjMhT
         yTjOmCxO64IZwN+V849RzAAsCgFYvkPceskiqGt86WA3qt6WXoIuZcOWbUE+AElF1d7g
         0kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=W7skse7fw+3bX6Qx0P+a8B8guzYohzn3Es2McL3471E=;
        b=TndIkZ6Zb0gd7vrWnUPrZGeU8KrmsP+x431F+w9olPE2QQmxRS6hxc1EG0GA7RR9LM
         Puut2wVsW0EknPRylOVVSS6pbLKWeirmxUeDqoYd71XYzNYsGHbMpiiWFKaBwPduau9d
         77A7byR4LbE/CLO0l/GZEaPeA6Vb8Gp3xHJOzp9QZi3OnCrvy/1swYVbDVX7/2/LP6ct
         bdbr1Hplj2VOKQFQQBdtv8hgc83G+anWDJbMGpnzCtxqke0JjK0NM5+13QFHEk/xMCFV
         LJlcZPFSg5124IO8NGXvoKyq89o2YvaCJJX7Q0F9xEhpPWRAZBzrdl1y970amRQQKqEq
         qvaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bzdndPpD;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bzdndPpD;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/t4a3+3Cku5u7B5giRJIsqQMUqSC+KUipqu7v7s6Z6tOKg/EykRUxBGBvVSGyZc3kdCdPY+w==
From: srinivas.kandagatla@linaro.org
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
Subject: [PATCH v6 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
Date: Thu, 26 Apr 2018 10:45:45 +0100
Message-Id: <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801758328613350?=
X-GMAIL-MSGID: =?utf-8?q?1598801758328613350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
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
