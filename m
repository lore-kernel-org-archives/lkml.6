Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZorZKnlJTa0xrgcp4tH1soOiKS5OhklAxhCT/Fysqf/25D6ZdJfwwT6nVWN0f3+lkKKSQJV
ARC-Seal: i=1; a=rsa-sha256; t=1524821098; cv=none;
        d=google.com; s=arc-20160816;
        b=TSflIsIBe1W1nbo1zFpiL4OY4/8PvVFBp5iYr2zGcAJHs37WQ6ARch3mn+2cR4p2ES
         G1XEpKmAEDCINDJetRExTecB49ibU0MhX05Ss3bEsZUrYf2/V03cjO0yNPfKOlf5agFC
         /e8dURwseqa7MsI+CoKEJyKD88wVYgTf6go+COi/0hAha44VQ8RrfI0QLMUU3J6sEKUM
         5WyeodQOYYZpuDQ7YOgrPeZ46iMRmx5RDolJ2/6RjLZXede/L6V80f4uolsHLYV0Tff9
         qBNd14XvFLnTffRuJx9CKDBQlqOVC2Mp1HU+ygsFEtk5EtVayJbPnlb8KfBs3hzRWtMs
         A9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Fq4aBtV21HR25K2Nj2rwLpjpU199amEIgcEzjpwZr88=;
        b=uJXhoQLzRu/HfaXRU/wNdnGorAFUvPTbrJljxPLD9p0Q4Dj/Jqu+c4CjnIiTujlsmr
         ezfYNPklrnNAoe6owOqz+r3ffBahxJmdm7gAIeqcTab5dTC4En4YR1+jHGlG0DeemN1+
         G0uInQJYI5ISHSdaF5x1DEcuzjIh5NxboffDRwCwbq8tjI5RB8H8j6Mpfo7z+Ojbt/5E
         LBIHzRecjMrFgQMgLAJYebL+Optp9+lshJKMIXJ7wTPsHvTat/6kPiszqctGEeIEa6gw
         UkAzZvMCe59RsNa/Jkwm6kWwIweBTMrV/XxV91Vm3NXYhKRTnac2mgEr0R5nNszlpB8r
         vFXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB64B2187A
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
Subject: [v3 08/10] clk: mediatek: mt8173-mm: switch to mfd device
Date: Fri, 27 Apr 2018 11:24:00 +0200
Message-Id: <228863cbbde4a4c682a6596343a8071119b913e7.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890808120115238?=
X-GMAIL-MSGID: =?utf-8?q?1598890808120115238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

As the new mfd device is in place, switch probing
for the MMSYS to support invocation from the mfd device.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/mediatek/clk-mt8173.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c3e440..e31b3ee3e968 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -791,7 +792,7 @@ static const struct mtk_gate_regs mm1_cg_regs __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr,		\
 	}
 
-static const struct mtk_gate mm_clks[] __initconst = {
+static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
 	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
 	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
@@ -1152,10 +1153,13 @@ static void __init mtk_imgsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
-static void __init mtk_mmsys_init(struct device_node *node)
+static int mtk_mmsys_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
+	struct device_node *node;
+
+	node = pdev->dev.parent->of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
@@ -1166,8 +1170,17 @@ static void __init mtk_mmsys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	return r;
 }
-CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
+
+static struct platform_driver clk_mt8173_mm_drv = {
+	.probe = mtk_mmsys_probe,
+	.driver = {
+		.name = "clk-mt8173-mm",
+	},
+};
+builtin_platform_driver(clk_mt8173_mm_drv);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-- 
2.16.3
