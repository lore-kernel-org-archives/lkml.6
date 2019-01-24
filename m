Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06446C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5A621726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jl0+3mCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfAXUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47076 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbfAXUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so3111231pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
        b=jl0+3mCU+nCI7YGq+itsqShkC/SfgVti3hEQ1ulSvukcgTB3ChDjHL1au/xyTtFmei
         gQYNExKO3Imrr0vQPZTTFzsBWG6MQKp50I0UaMarYeGQsx7pcN3ZG13p/jAWqjEKAxqo
         po5DR55psBPduQb+2DpXUqolNrzeewmlxyKzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
        b=qBtuGq2jnWJr5AFVIBU/q9C9N0+y+VugCh4dpGUL5F4SMvIkAEX10rpKe8EusYu08P
         mOHXhPvueO5e3ari86XyTW+RG3hnD5RhkUTLYcEsnt+vHsnQdchcVz0WfiEqHz4HzNTE
         ZRMiEM+bNgp/rfMpjG35WPIROXVUAc4JKQaS3Q0ULGSUYxBUN7xnPiolr0NR0U+hDhKQ
         y94W58/BBOPbPzLZLZgdQHEC5GY3csq8V5uT75tsx7XA862cKxhrID2iCbgMH36MMUnn
         DYQ3KcvEoWGOTMn4KDYOpENAO6E7JCTroEz7CK+dw4J5L1GJ5ns8D0WZ/hZExIJ3ZvOh
         RKUg==
X-Gm-Message-State: AJcUukchPtDJxeOozg8M2D4rnTkl3MXMwsmi03br8VcvgKQYrdfjXQiL
        mkmgUFfjJxmrJV2sA3uR+sIWrQ==
X-Google-Smtp-Source: ALg8bN4X3/hdgvk+W8P6tImZrbs+xvmgwlVFgfOK7unjfkPgCq8ckI457VZI6BJ2wPT55mSjYoPRvw==
X-Received: by 2002:a62:3943:: with SMTP id g64mr7995857pfa.114.1548360012725;
        Thu, 24 Jan 2019 12:00:12 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:12 -0800 (PST)
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
Subject: [PATCH v6 10/22] clk: sunxi-ng: Add check for minimal rate to NKM PLLs
Date:   Fri, 25 Jan 2019 01:28:48 +0530
Message-Id: <20190124195900.22620-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NKM PLLs doesn't work well when their output clock rate is set below
certain rate.

So, add support for minimal rate for relevant PLLs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 5 +++++
 drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 841840e35e61..096ff4f4839a 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -125,6 +125,11 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
+	if (rate < nkm->min_rate) {
+		rate = nkm->min_rate;
+		return rate;
+	}
+
 	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
 	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index cc6efb70a102..ff5bd00f429f 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -35,6 +35,7 @@ struct ccu_nkm {
 	struct ccu_mux_internal	mux;
 
 	unsigned int		fixed_post_div;
+	unsigned int		min_rate;
 
 	struct ccu_common	common;
 };
-- 
2.18.0.321.gffc6fa0e3

