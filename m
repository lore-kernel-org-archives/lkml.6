Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZqSEblIxv6kLQQHZq689oHkC5NuQoDQ44Arj/RHNOrrwnLRIGJ4lw9wg1gBPmHoD1ZidZ5h
ARC-Seal: i=1; a=rsa-sha256; t=1524821089; cv=none;
        d=google.com; s=arc-20160816;
        b=b/Pge2FtAvm0/w6/Gq1row4CnRgutztAy97OVffsWDJHz+ARvr1xT98obbSnFKVhb3
         kzbj+qRzBzXyoN0yqoxyDWH+45w0vbTdIoHYzWribsPy4LDsLAKpggK9JfIqW92/zm2+
         8NlVvWoGj61Yr+QwItmIafiD01fhgvQeCWXcROg/FM7an9QvnWHkNy1C0qWxC5Q2a2ve
         NbFkKmLq3IfxaxxaztQ6+BgdYfFgPb43vN2TJ3/GZTDcaYXcv0Kxv6qZGoTl5PxtRWOt
         DAH1rLW7qo1i47/lsvzmaMPXi3GHfixoYTgsu+ExwD+dIJfRKJfvV2+mErWT8ARtgNu1
         mi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gR9MueLNwOrHH5adxCq6LzW22DgpViivBA+EzFwjB+I=;
        b=cnmqHtqJvYHl3Ny+FyNMq1RIWlQ6VI34h0hanH2HBvzutIfH9R/ATgx++u1lMkfHve
         YYb8EhwN+a7LCiC1C18Z3aGWiV4Qa0v7y21xi1rh4XFGN0erNNEH9oHm6WgPLCORhD5k
         LQTqF2rEPrP0piKE+H5Ag8AxiiTFH6Y5L01+d+NIKzpNsrCIRFbBBnB2+ETqyVfaDNHx
         HTLYjYqZBfMM6sVIY4OtxYY9tZE3XOXtmY5bydndx3if0Wqvzot0cWll12/QAn1fvP0/
         Oy9R46gCDlu9x0DZL2engBy7VFt+gd2Or8EOVkPgN/raKDGln9MHtdgNmvXfMdxALs2f
         JMmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760BC21878
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
Subject: [v3 06/10] mfd: mtk-mmsys: Add mt8173 nodes
Date: Fri, 27 Apr 2018 11:23:58 +0200
Message-Id: <fb942cf83613f75299cff6df1791c63ad7b02e3a.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890798111070049?=
X-GMAIL-MSGID: =?utf-8?q?1598890798111070049?=
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
