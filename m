Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx4/L4XnkuHzkybuZIcsmComWZmjI2/Oxh5gCaDgpuxJ1DugFeGtiw/XBmNzAkpaJ0+C4MjHM
ARC-Seal: i=1; a=rsa-sha256; t=1524563282; cv=none;
        d=google.com; s=arc-20160816;
        b=GIvlxa3NSaLRqcr3JO8yxZ7yhmX6QuwGjaSHmZVIT5uIGz/vqYDNN3D9zJEcE+PIJq
         tV9B8vmTMb13dl64hmJKjbpUD8Z8SnmUUukMyHt5CbwuAisaPqzNtBiC08MUVokvC6XK
         B9l936+GMe/7HrU/vYMPihpuuM76vg6/82mqOLP0T1CUThwzyy9hfSHoy0ZS4NdVQ9DI
         BiikIcs1i9l6z81sYckuqY+VmyGZRVklSecKnNkabUeqsKvy4zOIyFealhEXlsCJ/8Rs
         JaqDgK8Be6l4OdlYN5Itd50gHoWBE3WW2UX+CgQDkn5MH3DZ5TgYNAPuqkUx2+qYsirV
         Bwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=A5hZS+UhgLTjIpjMgjBxJPj/Q1Y4fy0BmYqmXfIEoC4=;
        b=l9fUnJLQQWKRb3a0UbTnmonHHr/AinXfL9qbODJeqglQyIzj3LwbXLEmQvus45hn81
         38OkqbFa1xq3OPpDkrMrIPi+2nj/Md9smuMjZqljBduTwa4hodWAH0b1/chuPlzXL/j/
         JPHVt7BokP1wRnrDR66NI3o5oW/fUrSlfeVOlNNYUzTTVIkKWlv3DYGzOIsa0hIHK3ag
         yHWKg0sLvAJpNnN0fAjT4iquaU0Q61RcYjNBWYvG97RSLPVEBBFJO5y4N+iKA0N0y7RF
         J+LyM3ZBmXi9eV08SIvyLcBReEwNhK5ymsCoE87NFFXwwOA8d2MxI4ooasscXIzvyZrw
         4ifQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B472183C
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
Subject: [v2 resend 08/10] clk: mediatek: mt8173-mm: switch to mfd device
Date: Tue, 24 Apr 2018 11:47:05 +0200
Message-Id: <74bf4058534cf187e10ef041da1706878914aa45.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620468518295813?=
X-GMAIL-MSGID: =?utf-8?q?1598620468518295813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

As the new mfd device is in place, switch probing
for the MMSYS to support invocation from the mfd device.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/mediatek/clk-mt8173.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c3e440..abd2592078d4 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
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
