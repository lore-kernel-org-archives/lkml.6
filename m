Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx48SKh+vUvhZuEwA8WSUnovHfnQjQn46Iuyu4ow8+UMQZusEuZUqKXl9ZZXGAuJUosH3jt6g
ARC-Seal: i=1; a=rsa-sha256; t=1524497542; cv=none;
        d=google.com; s=arc-20160816;
        b=LlZA0M1TWjAKqq0EdggOAT0VDxLhBRLoNJh/Kns90t0PByG+E6ikk7lTXHCN08lXrT
         anwBWKuWt4F4xxX4pYr5avXRs0uvt8SA6OBrFCJhaoe4nxw118U9N+RkHrn+fq781exm
         Lav6UxgWE5lWLdsJn8vo5AsmgEulAxmgmhRcFzoM5fYXtGw8xxM++DsOoZ+wfoRv9RhA
         xKtU7yxEcDESrWXOBEC/HiyJut/48dDV+JoT8spgXYerHh6kG3V0ZDi0u0mDiwxOPAqh
         1mR/wX355ldUI0nQzxUW1S/SEpS6J3faCLIm6OYKyrZuu6tuUx56VRgPDqb0OJZTt2Tr
         bL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qpv2WbYq3kAYIKMCZpBSES+sYtFQwkChPjoi5RigXjs=;
        b=C6YWPckQVY2ZHDZM7r9RCeEHk+JoDeaA1DVhScUqxwi9G+WlVasagat1bXB7mZs3ys
         CbLinIyvWWFPa0O+63w0KJaRHbvQHOGlLdd8fnDq9fs6Y1rq7O88e0xdIJIW2sGftJaj
         qI6K8ngtsPW4SSrWp+OfJv6d35DN8jf91qLRSY3CPmzUtHyBi+HBj/i6JGBlyfqZ8U8/
         1fSZx97JPaazsEEAENhKKcMuM0PwFeq8x8abFgSH/dSSJJcVm9GhgNisskX7t8b2mWS1
         UCdQPW7iw1T2h1H5ghvyHpByDGE0wZNaCAqPTppmAfzwBWj4KLAj2xoQZ+7DHQBQi4rs
         p+wQ==
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
Subject: [v2 06/10] mfd: mtk-mmsys: Add mt8173 nodes
Date: Mon, 23 Apr 2018 17:32:05 +0200
Message-Id: <ce7c173efe9929712af11ea38be7f3a4d515879b.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535295506337?=
X-GMAIL-MSGID: =?utf-8?q?1598551535295506337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add devices for the mt8173 SoC.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mfd/mtk-mmsys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
index c802343fb1c6..5585a561a02f 100644
--- a/drivers/mfd/mtk-mmsys.c
+++ b/drivers/mfd/mtk-mmsys.c
@@ -19,6 +19,7 @@
 
 enum {
 	MMSYS_MT2701 = 1,
+	MMSYS_MT8173,
 };
 
 static const struct mfd_cell mmsys_mt2701_devs[] = {
@@ -26,6 +27,12 @@ static const struct mfd_cell mmsys_mt2701_devs[] = {
 	{ .name = "drm-mt2701-mm", },
 };
 
+static const struct mfd_cell mmsys_mt8173_devs[] = {
+	{ .name = "clk-mt8173-mm", },
+	{ .name = "drm-mt8173-mm", },
+};
+
+
 static int mmsys_probe(struct platform_device *pdev)
 {
 	const struct mfd_cell *mmsys_cells;
@@ -44,6 +51,10 @@ static int mmsys_probe(struct platform_device *pdev)
 		mmsys_cells = mmsys_mt2701_devs;
 		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
 		break;
+	case MMSYS_MT8173:
+		mmsys_cells = mmsys_mt8173_devs;
+		nr_cells = ARRAY_SIZE(mmsys_mt8173_devs);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -62,6 +73,9 @@ static const struct of_device_id of_match_mmsys[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = (void *) MMSYS_MT2701,
 	},
+	{ .compatible = "mediatek,mt8173-mmsys",
+	  .data = (void *) MMSYS_MT8173,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.16.3
