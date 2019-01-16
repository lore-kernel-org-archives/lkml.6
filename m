Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F41520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547634245;
	bh=PZ8sk9lIN3Rzz8ye3tBUUja9CTbsuvBM7v/CPKqn+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/aoHZBOh6z9A+cE6/DnHQ5OpnQKyOAJCwl1WfMhYge6G8oiCbBA+JLnBN6HLiIn0
	 ysl6aU5u9jU1fttgW6/kQuG+VsaLN4ki5G78CJyPUGosTSL9WM8ePcnsJCcEGeYtVX
	 3Xf6NDB3T8KoWCPi6MxgNdz9B69ja8cbmgBb3TDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391983AbfAPKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:24:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40722 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389494AbfAPKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:23:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so4437087lfe.7;
        Wed, 16 Jan 2019 02:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9EBQmXkMNBYjjztGyv3wx7NdVyHDMd7kO+rKlttGLE=;
        b=kkLHzJ00TwNmFhbXq4OLPrfLbKq9G4P6M1rc3Q93jKQ4z1kXHpMR10Lv6yIHfk1SWk
         XNThPh22hneCiZ2l4W70Jw2rDVhvquMS5HYiycLfDsSixJ6RGxp460h88/ts5jkwogtv
         3VrOrnozPGvjcPlebPVQMQEJDA7Jg3kSaDvwuO6M+91FVYDtzblnbnzA++67lzeAkU5/
         9zLY7h6VIG1qmlgPIxAT1SPCKHy1H4p5tQel06qqLQ2Rj33tioZz/hoya/Xvp/foNNjL
         7uS5Tpq/HuO0PqhdKd6OSQoDen3fMQlJbswJcrKS7nfHWlwigy5e2ptvriQiwsHCBE31
         UIaw==
X-Gm-Message-State: AJcUuke/cDUqZtFrnAsz/1smtWLYwm0+nrub0qDWQsyBuKQsIy+3b4dR
        EM6pxnciCmDb7q62ct86UmE=
X-Google-Smtp-Source: ALg8bN7yIMFMCBA2f5c/mOOOSy8yRqgip1DOVfs5fuddLh4zuAEBYYqsJRS/Gq//4z0DGx3SE5gOuA==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr6095572lfb.121.1547634224443;
        Wed, 16 Jan 2019 02:23:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 1-v6sm942115lju.61.2019.01.16.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:23:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gjiMH-0007vq-T4; Wed, 16 Jan 2019 11:23:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] net: dsa: lantiq_gswip: drop bogus drvdata check
Date:   Wed, 16 Jan 2019 11:23:35 +0100
Message-Id: <20190116102335.30433-4-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116102335.30433-1-johan@kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform-device driver data is set on successful probe and will
never be NULL on remove (or we have much bigger problems).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 5792674dd4e4..27d092cab40e 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1126,9 +1126,6 @@ static int gswip_remove(struct platform_device *pdev)
 	struct gswip_priv *priv = platform_get_drvdata(pdev);
 	int i;
 
-	if (!priv)
-		return 0;
-
 	/* disable the switch */
 	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
 
-- 
2.20.1

