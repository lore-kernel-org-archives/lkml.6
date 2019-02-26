Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12046217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujvWRXMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfBZThA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:37:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfBZTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so6719843pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zxy0XxA1MxzsropNeklSR3wb+dlQlnhChJjlQro53Yk=;
        b=ujvWRXMgJdu1SG4HYPw1wKyEkMT7mYayCL5beQCpVSQc2sbYmc+5d3qG3bGcXJZuIy
         g6btJvd2T1GwQq4QioFb7yZguBI140NCIA7ohfvtEm4Bf42GaK2JAGY9xvRAdOh9iu2E
         +DwxlaJZo7ccCcHyKOysRdPiDuxIbynPTnkufVZHlHmRs51B98z0MbngyyqsBZ6BXZQA
         x2+Aw6ShDGzbCy4g0m0DmnjIhb7IW0GaOiNQT6TIclDijWVqsvVBuvk64Pz2E17y92Kd
         YUvFTxDKvh1WdD4q4YjmnAX7re5LibMDj5PZyDmrcIsJX6wIM0wIvK2R5bgbxNWHoXx8
         LxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zxy0XxA1MxzsropNeklSR3wb+dlQlnhChJjlQro53Yk=;
        b=HcS69B3+YD908awcT6Q3X0P4E2Wz8imWI0PrzGrEskIbeSG1kMQjGefzikd+itLkft
         BZSBRZ2NodAM6Dih3eO4VPjRr7GpUTtFCClSxxJUdGMFIZa2ZTVu0wfP0Kx/86aiysuY
         Pq/iIwvyNzjySDBbZ5eMOxpRlwU/k8Mr04Hl5kOiTGtSdMjItQHnzJm2C5uXgyFEhDXo
         Gm5Vr70gifLAUfReETsYD0030eqVBFl75YWYs7TlY4FN28MFHlpqhrEn6OoLkepxxvmC
         pcHExMZo6msUHrljnA4rnWeFYcp/IxYT7/eU99OGvBxWVS0/NJ6KfqCMcYiQYUN1CBuA
         MIgw==
X-Gm-Message-State: AHQUAuaj5Lqel5SZRGIcTnd620FUhKL2DxMAL+dNxIupA9SuAvReENxr
        fCaPpYhkwxfH9E744n6G+z4=
X-Google-Smtp-Source: AHgI3IZT9yKG8Xkr/0a+hzS3sbn6XFUn51XO6ZefgSuVbDnQlZ7ft839js2vRYXAJogFoNo4PnQtew==
X-Received: by 2002:a63:2ad4:: with SMTP id q203mr26606392pgq.43.1551209794912;
        Tue, 26 Feb 2019 11:36:34 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:34 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] drm/bridge: tc358767: Simplify error check in tc_aux_linx_setup()
Date:   Tue, 26 Feb 2019 11:36:06 -0800
Message-Id: <20190226193609.9862-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tc_poll_timeout() can only return -ETIMEDOUT, so checking for other
errors is not necessary. Drop it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ea30cec4a0c3..54ff95f66e30 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -569,11 +569,10 @@ static int tc_aux_link_setup(struct tc_data *tc)
 
 	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
 			      1000);
-	if (ret == -ETIMEDOUT) {
+	if (ret) {
 		dev_err(tc->dev, "Timeout waiting for PHY to become ready");
 		return ret;
-	} else if (ret)
-		goto err;
+	}
 
 	/* Setup AUX link */
 	tc_write(DP0_AUXCFG1, AUX_RX_FILTER_EN |
-- 
2.20.1

