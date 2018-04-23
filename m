Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4/Z8JMI1/SN4eK9GCi5GeZDZGBHT04qOazl67fqpmsoq4JTeQDpfxLDLXjYobWF2isU3Hnu
ARC-Seal: i=1; a=rsa-sha256; t=1524497542; cv=none;
        d=google.com; s=arc-20160816;
        b=V/nW20GOyuluwX2iW11woDPXOl4dOdN7m3mbuJyNMvq569plYvefH95B719lT18h8Z
         fq28JRkEkfi4kSk2HE5BKACiRxBfWXIGPdW0qDVyOTnDOS29K8/+8GjmyjD1xyJNQNW/
         K00Lr5v7CUdRTQkTPkfR1b2aB2YXC8vNoJKptb2awIV8C29lNceZiU1Eg31/02WjemzB
         b3jZ5gINTXSyr+g1OJgfluxDjFm3j1g1BYpcQ/h/+VZJgR4oJWiGabxUwmgaunKmip9i
         p0FEewPX/0NF+k/R2soTkKtZtgMAizetJ7X7wTORMUwP1vc6xKGoobmEW9XqgfHE0yt6
         PR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c3hvLaxzt7FWXHjiB4L5Gs95ewA/sHj4103umpbOJXQ=;
        b=wVKrGGWDdFYgHLi1BhZTpOjk7ZxRep7SPiCGxkqpNeYB/aVqFHR3yXKEAUYWiGnuyj
         YMH7XZ8Mv2/5f28MbyWydobiSdlsj2cPgoOuMqXhDGrMCk8RA6uz2Z3h1WoYmDzGcgFU
         UHXzUsmj49b3ChvvaCfy6FhI0zl2yHc33xPw+S9+KyHWiehB1NQ1RrFjoRHbeByXRQQn
         l0ofjSR3ZP1Ea87aZq2uZCL1qwBBiG72EFeXklrbcnmikgw+vOYAdgsYa3Qk4AvdPTgs
         xJNlRb9aj2CdegxnFAk2MQ/EdkEQkLaMMys4J1NogbbDYqudEeGHmm5maOoDc+pXPKXS
         kqZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
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
Subject: [v2 05/10] clk: mediatek: mt2701-mm: switch to mfd device
Date: Mon, 23 Apr 2018 17:32:04 +0200
Message-Id: <16dd3041d81069f87422fd29b26d9d74c8a36293.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535588712601?=
X-GMAIL-MSGID: =?utf-8?q?1598551535588712601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
