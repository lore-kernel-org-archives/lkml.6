Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZrT3qHKAHsprxZ2Apv1v5aHQVIiR0iY1WPQ52g1oLaiTV372n3uIEw0PiLBHyA1UBkP8lja
ARC-Seal: i=1; a=rsa-sha256; t=1524821084; cv=none;
        d=google.com; s=arc-20160816;
        b=pBVGlILBJ6Sr1l7rtrkzvPqCZgKwUnc2VzhkclzFeP3gyDRZPCmtVRBLlxRdwKaaS3
         ldCgQDDKdPLeqSqXF3xVLkxJjA+HKsgyXw7PPx2Oy99wuqr3W04AjUfzVVQ3hxWiK5yM
         ijY0xnZ83c6+HPdPbDIPVGPZMjs9RpjjTNSGa+JgoyfuWVWboU9eE0vUIrcldwvLZdrs
         GBPMvI6xh+eEEDbxikerpFscuSEay+2TV+UoqzgADH7MFsTd1NWrdGmzTib+EDv7Ahaq
         5mTd9XmCVkLJqSlHrOwyZM46lFsddW3b5z0qoJUFwBG5fLZkHuPjr1jqHKlZTHoh7yA0
         yf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ljcDt4AGcEGzdtLHP9hRibjfu7gzvxrS4Sr3Hhz006k=;
        b=UNgFYA3Yz0Rm/FAl3V+edDkFKpumfAUJs3qtBQHhQVAZ/gw1t1Kmz+owMMNh9J9Sct
         JS28MQdKUumRahjOKaJQgtXE/gIwbhBX3j0Q8qDDeinKBSLg1wOgSoIFG0zpWWCjs6Ba
         zeAGjWW+gLNnemRhsrOifzpWmLM2aF2xtGNy/W1ukoUBuK9wWZvNaAClx6kxP4g7mo4M
         BaWpte/S2TignF0UXDgr3huGuAffiFndM2mw5J0uYSF0KJhqb78kVYWNvLm+p92FUb8S
         ulkq/0774CxDuynLoOuNAMvuVwCXox4BFEAwRiJGgarCK+PnIrFUuEtLm7yzFYBoA80s
         aE4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3EB21880
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
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 05/10] clk: mediatek: mt2701-mm: switch to mfd device
Date: Fri, 27 Apr 2018 11:23:57 +0200
Message-Id: <3230840517e3e5f3fcb4ea65482e5d86d3342f54.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890793312103722?=
X-GMAIL-MSGID: =?utf-8?q?1598890793312103722?=
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
