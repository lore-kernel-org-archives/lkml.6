Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC933C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cG/y3GtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfAHOhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:37:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41978 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfAHOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:37:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so3066478lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 06:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTGRl9dd/QDz3icFhVgKltyUomrjK5khoIaVsDynIT4=;
        b=cG/y3GtHyp02GOqUBjThMBXgyBTbyTxI7wvWCFbIOp0uipkDAaMggEN8PfxlHfzYZW
         /vPOPE9Jzb5Q+u654VlgI/cyBekO6C6LjzChBKfLO5q8JKmJrBifF5Whv5nSNS1J4nO3
         HRroOkRGjcn+qzHz3eZcwy7sG2O1Rh560cd/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTGRl9dd/QDz3icFhVgKltyUomrjK5khoIaVsDynIT4=;
        b=k+Ee2b151I09xa5ix8bgLFLa6Q3IXsLq9UFAbgzQvSsTvBXfVnLRbJ52qExo8OWgGN
         0ALQcKiYX1OQQ2P/v1smQKP4TIgUNPI9T6WehN8Uxe9zZD5ZPpjp2PEjyJFvTzir7ufV
         0s6qloWml9TJiqmkKMtRFV04ePNp1arQpPLavtEuMJVvPbHu6qGMsgcYQsnfD+b6UIzp
         GfSalogtdE2UJgN+MmvBJY9NZr3XMcNZ+IWpZ8FsCBjF6fiPM9rWgfcBFlcIHyavBhv5
         7/Xr5O9xPq4Z+0lqBQ6gY9i7pbnefKpx6tNCYz00Cbp/CKHrsm7g+eif/UjssYNsx1wq
         tTXw==
X-Gm-Message-State: AJcUukffzDVxnWz7wL90GcWvfLwlOKGz+2SKoiPEo9+3Szm+6lLlI94K
        PPLJFNzoh99QPvS/bsabzvj6VA==
X-Google-Smtp-Source: ALg8bN5O0A8rq3+PM6IGcCnWxv7Mt2n9O+1RG1R0Wo68Acrha1X0TgxTj3m6j/LXeZO6vcybg9t4NA==
X-Received: by 2002:a19:c014:: with SMTP id q20mr1136336lff.16.1546958236745;
        Tue, 08 Jan 2019 06:37:16 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id o17sm12964665lff.77.2019.01.08.06.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 06:37:16 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mailbox: tegra-hsp: mark PM functions as __maybe_unused
Date:   Tue,  8 Jan 2019 15:37:13 +0100
Message-Id: <20190108143713.15120-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM_SLEEP, we get annoying warnings about unused
functions:

drivers/mailbox/tegra-hsp.c:782:12: warning: ‘tegra_hsp_resume’ defined but not used [-Wunused-function]
 static int tegra_hsp_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~

Mark them as __maybe_unused to shut up the warning and silently drop the
functions without having to add ugly #ifdefs.

Fixes: 9a63f0f40599 ("mailbox: tegra-hsp: Add suspend/resume support")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/mailbox/tegra-hsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index e443f6a2ec4b..b9ce823f79ab 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -779,7 +779,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_hsp_resume(struct device *dev)
+static __maybe_unused int tegra_hsp_resume(struct device *dev)
 {
 	struct tegra_hsp *hsp = dev_get_drvdata(dev);
 	unsigned int i;
-- 
2.19.2

