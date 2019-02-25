Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52BE2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130211;
	bh=noIeZ+0nbDiL9IjKTyB2yYDCh9Z00gHD4LHUR5jNyv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=anrNQn17jHPLr6c3zhr3RsdhQ+X8FoG0LHv+4tkGGXyYAQADOJ8v2UI+4LDJTwJWc
	 3RrUlvL881SRvppmpUao8dyrCWlnEcFCX/YJhDxH68SlBPUQ8AA6xZuu2LAkdGdpFf
	 Wj8WCbuqIoGBuJDQAseVBqgbnNMqIJtUcw9sH3wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfBYVaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732089AbfBYVaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CAC21841;
        Mon, 25 Feb 2019 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130205;
        bh=noIeZ+0nbDiL9IjKTyB2yYDCh9Z00gHD4LHUR5jNyv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZENAfsr3ifItXpKobEmqNwIeRb7oxcEvJ2y1PlU6w2x0DbtzOxBY1f7sNZ6eLHukt
         YORoMDnBTwI9kqIqHqHvUfBDj5kD8NyBsoBRMjfVHmXlWapW/MXBL30cfOXJTra8I4
         0Bv/KsuivmMjCl/Ue1kWxOA58cJ+h0jlhzSF/EEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 020/183] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
Date:   Mon, 25 Feb 2019 22:09:53 +0100
Message-Id: <20190225195058.128923470@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b40ee006fe6a8a25093434e5d394128c356a48f3 ]

Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
different instances are uniquely identified. This is required in order
to support registering of multiple instances of same ti_am335x_tscadc IP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ti_am335x_tscadc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index c2d47d78705b8..fd111296b9592 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -264,8 +264,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		cell->pdata_size = sizeof(tscadc);
 	}
 
-	err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
-			tscadc->used_cells, NULL, 0, NULL);
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+			      tscadc->cells, tscadc->used_cells, NULL,
+			      0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
-- 
2.19.1



