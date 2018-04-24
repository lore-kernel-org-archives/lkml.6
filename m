Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx4+Naaqg/E+e7Zjh1tDNNOqkiTP+RsHHxR+rL9KMf/n2joZEED/M59KXHSN6OJheT4kqQJbZ
ARC-Seal: i=1; a=rsa-sha256; t=1524563267; cv=none;
        d=google.com; s=arc-20160816;
        b=XdxUCsLlY1vcAPV7fewF4n4ZJsARw6YdIgf7K+6kVkgoJfz4o/jwRqUSzdUy1p+qf9
         KLeO5iPJZzMlXlaLB0PjW9uI8xcMWjqYg1MEMGKxfDJUn0+BDzuMCD08O5jXu/mNtsN2
         bTyJIP0xgtW/cjvEvVI3dMDiRsPO21N/bLQ9oSNd3Uy+Z3CRnEMJR5XbpTpA8GRkomm7
         oKVbMfm0RYcMJW03uPQMTzsHuX0wbotw3CYPyujLldzKy0twOkBuOPhT3UYeOMhLveFA
         mh3q4habIco47Lsni27QxEBJTZzhLyLPPFJ8tOfuKPyRg3FTYXB1obChzjwcNiDPZNix
         NnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ljcDt4AGcEGzdtLHP9hRibjfu7gzvxrS4Sr3Hhz006k=;
        b=v9QjJBAkSnrrc98f8kD5bDBcAsw6XXeSwXS2X3O+ag/PDmK5rz60TSywmRHBa1A85h
         33TNAkCUb9iwpU1idI3TiqkbRj5atRaY0jrxbUd7ilkjEkrt/r2ga/vbph9Pm+TMsHP8
         6rBTr6EBSiXZVn+rxnbXrkbKjBqzdHdRKedAoF5vuYlBzYX4CinaUorSkmiHmD3YRWgy
         ZA7humCihUCCB+/ZKnBhZb7d8U4D36p3A3UaEtupDrEhTPQZwZAq4QE2eDAxJWKyKTiG
         J+UGlpSVVLhcbYXHCcKX7l950EbFmt23X/BKGHVTu6NM0Hk3zMUElbIz/hyE6DL5k1zB
         lmPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6EC21836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 resend 05/10] clk: mediatek: mt2701-mm: switch to mfd device
Date: Tue, 24 Apr 2018 11:47:02 +0200
Message-Id: <16dd3041d81069f87422fd29b26d9d74c8a36293.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620452724166249?=
X-GMAIL-MSGID: =?utf-8?q?1598620452724166249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

As the new mfd device is in place, switch probing
for the MMSYS to support invocation from the mfd device.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/mediatek/clk-mt2701-mm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index fe1f85072fc5..4517525887dd 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -87,16 +87,13 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
 };
 
-static const struct of_device_id of_match_clk_mt2701_mm[] = {
-	{ .compatible = "mediatek,mt2701-mmsys", },
-	{}
-};
-
 static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
+	struct device_node *node;
+
+	node = pdev->dev.parent->of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
@@ -116,7 +113,6 @@ static struct platform_driver clk_mt2701_mm_drv = {
 	.probe = clk_mt2701_mm_probe,
 	.driver = {
 		.name = "clk-mt2701-mm",
-		.of_match_table = of_match_clk_mt2701_mm,
 	},
 };
 
-- 
2.16.3
