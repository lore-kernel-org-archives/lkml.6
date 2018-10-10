Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB920835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwzqO7dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBB920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJJQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42788 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJJQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so4151006lje.9;
        Wed, 10 Oct 2018 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joyn6OLBg1f4D+Fifxa/SS4Ke79l5wLNhvUf6HfLSis=;
        b=UwzqO7dLXaqGsobplb0rRenHcymcWD4t0o/wLYke1IE5ecHCzgaE4iY+GsfUTF+n7L
         BudA0/q5lMD8Y9t1A1Iy2/yzawrWgZmw6CU8gNVGVmFifPZ39+2Rg1aQFkKu7yfccP2l
         EMhCNFegmYEuTK3e/Eox9SiCKC+Kjd2b8nODMY284WUNvN7gGmA5PiHnpYcsPNpZta0M
         ynwl+LMhMYW7uIjei+JdBM7p+CuZ37+LJRIZv0JtsO+oKYgF2htYdtXGHBBn2Cr5UHw9
         2pp7uKSNegWGr5y0E1w+qgd1I2UTH+D818xRFQUclIWuuHhlR4rJ9rlsfg2QnqICPM4m
         yazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=joyn6OLBg1f4D+Fifxa/SS4Ke79l5wLNhvUf6HfLSis=;
        b=spqODZSIwRxTLuF03BBngadbSydEyjTsVf7LLXcscIKyA5qg/Z4aNTvyOvb3VgPfLO
         suSKo4gkNiDA0UnTmXEfna8UD8dwf+nRbPYiPJ/XHMXJSG9XWsJvRBiu1g/o8rWlOgRd
         JP61fVnYdsQ9VH/QpfVg3FPtX6s8uGv6LsnENITISLFov8vUgJ1CX4NbUSG/D0OrdUTc
         sm2lz604p5ENCPqfs0WcoA4K0+Pj++7Bo5mopq+1z+tCgUDxBuRXmS/hzPfRQQVI4p4v
         rW+nGn00ga7O3Q9gBru1yTw10DQjT7bpUOyRoKA3TAIkjbXtzWC/RekiCb9IVWhVMnrv
         to6w==
X-Gm-Message-State: ABuFfohVWgAG7/A0aZFPNTLSwTHBqkMt61dz/joOl/9LdKWqpraBRwkC
        Sr0NaRkB9r4feYUXfFdGE5/8WVDB10o=
X-Google-Smtp-Source: ACcGV60CUCC4NeYdYDziVaGp4qNnsIFv551K06yJPnVj2rcCu4FGrg18xdg4WZDUVlp6O8cwMey8tQ==
X-Received: by 2002:a2e:4751:: with SMTP id u78-v6mr9503679lja.72.1539162106471;
        Wed, 10 Oct 2018 02:01:46 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:45 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Huibin Hong <huibin.hong@rock-chips.com>
Subject: [PATCH 1/7] spi: rockchip: initialize dma_slave_config properly
Date:   Wed, 10 Oct 2018 11:00:32 +0200
Message-Id: <20181010090038.20834-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huibin Hong <huibin.hong@rock-chips.com>

The rxconf and txconf structs are allocated on the
stack, so make sure we zero them before filling out
the relevant fields.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..185bbdce62b1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -445,6 +445,9 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
+	memset(&rxconf, 0, sizeof(rxconf));
+	memset(&txconf, 0, sizeof(txconf));
+
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
-- 
2.19.1

