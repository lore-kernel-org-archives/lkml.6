Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7822146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvnVvtZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7822146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeKUUOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:14:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34039 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKUUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:14:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so4925938wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MeZ5z9u9mVL/xjvrUR2DdMqd7NAirflwMhSs//+R1rE=;
        b=NvnVvtZg1+dRO2tmlnuPVEjZvIN2hvS7Tij+PE8zNsmoEfZw84T+tXn22CgQAza6HI
         AZ8ZsOgJgOmLBF54OK6ka7kEsYk0dxJSEIxAvPV3GJOLCd0q7XBGC7RxKlcDc63eSdPK
         jrfS07kvTkJxezFPobdqxfyHFaaOUkYRa0bTHRwMb30gkdJHmS7Wl1NL1k/yWH7vMIi4
         ru2TmNrBopoCIMtt19YZ6YldWoSEISOGbc2hM6yoWAyeDhVAgBkZxOk1wGTaYzGa77zo
         6khBF3NtPCzjO5HlrkMyl0AZj6qhbSlc8jhaH6RHyonuBj1JN+kRvJtbyjl2mlTw49Qk
         9J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MeZ5z9u9mVL/xjvrUR2DdMqd7NAirflwMhSs//+R1rE=;
        b=nAW94vMK5kG06566OYNjQ3PQC+dAt71zmOZqlaYNmC+r6KM0GI81aZ0QoC/CW0llQi
         rOBBkzP5QJJWKtEvQO7QdXiiBtaSyaQ1lubORXfqwVgb4z05gAhYaioIY4Jrfvw99VwN
         /XivNdEN4/nld/q7a5or48aPZmRPws3cA+LtGXJV5HVyzvpJ3Vu+xLhol5JeJzCEc0UB
         FrYIWm6GeCdjdloyZj0rqFXsnVNXJrs9WCYwKNhgwLvrR3UhnTTshLKEXJ+mcWuIH12u
         pl9em8/18HK5NVM8oSjNgBEfWBJLeXKKN/kH0S4pwUIKrggbdf9T1wUYju7AGRCa0Cvt
         v4Iw==
X-Gm-Message-State: AA+aEWYwr50gNg8eqcDd3RuWzw+1lorjmtAK+fG4FUAAbn4G/hb4cuzO
        m/ufb7JvV1FPYRSHJOe9hx8=
X-Google-Smtp-Source: AFSGD/XrdHv2ssdgXhmwhUHTaCgdiU+eByQ564snOuKoPhOAatw4D0VXWY2Is2ZJH5WbuVdY9/G3qw==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr4793635wrw.316.1542793219686;
        Wed, 21 Nov 2018 01:40:19 -0800 (PST)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id c4-v6sm33338144wrr.74.2018.11.21.01.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 01:40:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: add support for 1080p25 mode
Date:   Wed, 21 Nov 2018 13:39:29 +0400
Message-Id: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This essential mode for PAL users is missing, so add it.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index acbbad3..ab16046 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
 	{ 5, &meson_hdmi_encp_mode_1080i60 },
 	{ 20, &meson_hdmi_encp_mode_1080i50 },
 	{ 32, &meson_hdmi_encp_mode_1080p24 },
+	{ 33, &meson_hdmi_encp_mode_1080p50 },
 	{ 34, &meson_hdmi_encp_mode_1080p30 },
 	{ 31, &meson_hdmi_encp_mode_1080p50 },
 	{ 16, &meson_hdmi_encp_mode_1080p60 },
-- 
2.7.4

