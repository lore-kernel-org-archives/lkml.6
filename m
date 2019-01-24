Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30552C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D0A21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MzCBl01/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfAXUBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:01:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46318 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfAXUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so3358980ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM8sVvN3Te6g1rqXOdAqs2KSOeU1frtX72ddxyLNR30=;
        b=MzCBl01/KEWGjIvWEHBS8QjD6yS7sBjuX8vMC1wntVcgcKGdBBB6xfLjy62P7oXNGc
         ClR+2tbn6U1g2/wbTV4rignbYp91Q6e4q+1SEBY05XnGZfzPc1ZQdgQytM+d/B/78ZII
         v2R66+PdrttXkbBTjj9YJ5wHCZPspEmS8pdlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM8sVvN3Te6g1rqXOdAqs2KSOeU1frtX72ddxyLNR30=;
        b=umcN7Tb1WLme5e/JPpLoiUxwasbgFKPcpH0rKvmQekHEjTW8HxASeP6NdEVXeyPciy
         LxvvnltgsvhBgqNNQeg/eVGeu67XvdQHu9A4UjWp8krhUj+3iUM3sNfIJEbOoa5GjA8A
         dxkb+xoEx2chXWxYe9aHM9QDgHfehb5J7Ws0Adj5XD8MGP/3SrSSLBQ1uaJnHmKbaVqB
         p7zsLrYwbAnZEh6NtotBoVLnYtdCycf+OUQ1L5vK7oQ62tDnhVUXmdblQpkfdoDEW+nC
         KXJ02uslqO4Yrgo0QFKj+HZpsruHuLaxtEghgzkW12lN/3MYaQN5sy2nQzIKUD6V63f0
         sfSA==
X-Gm-Message-State: AJcUukeSOMnmlInpRtO0hj6dsbTL8nuDYaoalxOFtlrfhgmUvWuu0+3M
        W4onsu7y0SJH37b/yXekoA+WVA==
X-Google-Smtp-Source: ALg8bN4qeWnLZUxwNxKPUT5z6WnCfVKyW3VbHKtNjoOBm1gRK3mCVUtBVWmtP016p/gOy0jyHQd6dA==
X-Received: by 2002:a17:902:2969:: with SMTP id g96mr7811174plb.295.1548360058106;
        Thu, 24 Jan 2019 12:00:58 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 18/22] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Fri, 25 Jan 2019 01:28:56 +0530
Message-Id: <20190124195900.22620-19-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 9be414131460..58bda0928aef 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -983,6 +983,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

