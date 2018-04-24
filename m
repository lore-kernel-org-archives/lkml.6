Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx49sPAvIVDDIcuIgURbRfMHtAw+TQVaqpjV9j5mR7uchCc2rP0RpO4Di6p5+z/NJWfHcJgkA
ARC-Seal: i=1; a=rsa-sha256; t=1524563272; cv=none;
        d=google.com; s=arc-20160816;
        b=WaL412bSB+xW2NatED3TWsgsV6TPhIUqNerdDIlXxcbRqoeqOL/x2cVVAyGbxJDq0q
         j3h/6IGJ9Edccax1TeDzmf0xkw8wS/ElnNSEhDQiQ+TAX7GbMdQGw5OUNEk3zQAsKq72
         98QvymTeoNjkZ2XMTbIQgZrFEHHGsHrNHYK5NErjfvZCsedciqvkkwVhMEEGzuIFpMjN
         2a24P15erQpe7Uzh2AU4rK7qOOzYbat9N67BjOaMSavqm8OlkqVx9JQMN5P+rIQGRV4u
         RfbGXB8jPmNrq9ocikd70IYFnhHHS6+m7IJO++sTWodr9M3BTOsXsmESBl82pIbKBbxP
         v+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gR9MueLNwOrHH5adxCq6LzW22DgpViivBA+EzFwjB+I=;
        b=n9jjbpmqP1rUqBIVX+JqdM6Ko+IpNHdReqhRymakBKOohRR8q8QiF8YDmrkOIOyWsQ
         hP2uvaCuDRaBEncK7DZ8ozd8fXSz93jBnO/dMt5PWfnbi0gDCOMfsniTeI7M5pkCBy1n
         UMiMTXFRqYe3SPrfXvwigNjL1OCxdoGHDIg5fYmFUwZjz82zShBc8dmYWN1gMPSULVgB
         YKDxrLjqSfHh2U3+zjycJic48uJFGKSSL28LTwToZTAmppVeZkOSQsmcvBCR4jQmzVPd
         Db6vO03+ExnQA6tJxp8pgHw0bS8uMu42AO2fZj8432uVCL/bKixFh0df1taImFZPUztZ
         2IXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451DD2183D
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
Subject: [v2 resend 06/10] mfd: mtk-mmsys: Add mt8173 nodes
Date: Tue, 24 Apr 2018 11:47:03 +0200
Message-Id: <ce7c173efe9929712af11ea38be7f3a4d515879b.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620458030919203?=
X-GMAIL-MSGID: =?utf-8?q?1598620458030919203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

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
