Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZrtaJ91veD+D/Yr1qyW4dN1bOAKmJR0wOONdLk3hC59T2aUC7mNDfxmqV5Do/REc0e+yHUj
ARC-Seal: i=1; a=rsa-sha256; t=1524821103; cv=none;
        d=google.com; s=arc-20160816;
        b=c38y52evrl4v+i0b8G/ZnERGEuB7bRdCBtkk1RUcHE+TTv/ABFuTYDetDGlby94nQg
         7sH4u/sssdAo7XRa/Py7h+KCKQruulRXxApkz8iCkZSaXrbhGBVRL0FT6RS/6bhLZehW
         KuVVUlAj4LwlgdGvzuRZJEonxFWlvZ4ZOILERWUutuM+VeuwDQuDI6I9vZVK3oAhiPQz
         WejlnbBKeqpEVp7/oB5oEKX0sZ86gVyYZM1v+4HOqVPDVNgQtQw2cLdok79bOy6WhLc8
         RaIU1cw3RBmN4L4uOETS8OUaduxPyx8PGwfiGaxmtmXHmjv0bMXWO/rcpjv0xUlR8bhN
         344w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=dmeCkJ7AvKJtcBLqEPUe9SmlWlckwxvG0vcODkRP51E=;
        b=XF9eyBL8iQFatEBPwnMccKgKZ8rg+kZtoHqvQ3QoDN5y9jc6WUz5iaEjOrTxfTG+rX
         Z2aOdUKnja3ueywhf0YiQhfx4HAmWSXwdSc/E03i/PmuXrVyAsrCXdF51mz+0hHfBRsa
         B2nH5fnNM8fl2yUAOODk50Dqwr70CDPbUMW/amFnaxejQ43KAqWeo5u+mRsFEdOqCiY6
         v5IBzT8us31ShJsy7HEd5kYlnaeWhmyZgT6VjdjftaqOTPg5UXQzNK3w2h5xAjCbTLg7
         DmRLmxWpyLTB/HcyoVLRVRJQTM66iokw/WPHeOx3Ra+SOUMcIFm8bL2UMwhY0aAsILKf
         nLaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6542A20779
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
Subject: [v3 09/10] drm: mediatek: Omit warning on probe defers
Date: Fri, 27 Apr 2018 11:24:01 +0200
Message-Id: <9d514a4ab45f0700663fa756d5aa3913922b6fb7.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890812954762218?=
X-GMAIL-MSGID: =?utf-8?q?1598890812954762218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

When probe through the MFD, it can happen that the
clock drivers wasn't probed before the ddp driver gets
invoked. The driver used to omit a warning that the driver
failed to get the clocks. Omit this error on the defered probe path.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index bafc5c77c4fb..6b399348a2dc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 
 	ddp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
+		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock\n");
 		return PTR_ERR(ddp->clk);
 	}
 
-- 
2.16.3
