Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D998C2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p2gyHzcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D998C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbeKNUWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:22:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42323 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKNUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:22:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so11343818wrn.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=p2gyHzcp08yKru+k9lPylupbw/WFVEd9Z7iyYTrF6gHn9xoInRGk9Ai9s/kdAzo5/x
         r+ktIqWb+QSLRRh7Rpp428kSLBZWRwuwbhZeCmlHt9+McwfQfqiUshAcbFiF9fm7tsVb
         IXzqgJnDAGZKaM6KCd7CLE0j0PTB/u4t26pW/lOGleBsq5E1CamWONwx+Qp36nI0ePl/
         ilYmJ0porwFbmSzed0+1XFxASZed15AYP9J0TwMNcBJkgp0ignyhMIQLx3lrk9Ye++MS
         KuWNb52nLdIZjFWBL7j7SbN5sY/zYQKVPPgTmIiUZ5WU3KpXNMzKJAoxodpI3IIkTJvW
         AXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=N/BOFTCEaj4lITXVV2SUotHTKFJHH9KjJjMGC/9otVqY2VUfQM0SG5hRiIAM7a7rTX
         xZVO66fAnE7iCcEhXXSdFMw1ocFN3qMKX1mQQpje6wVupnTWEb5sgID4LFRYJufHUA5m
         7EM8mFZPPRKj6OpQcjIOzPWAsy3OmP//dNfwUhkh8A38kUYammOgVTFnhMbf0PLjQTzw
         +suComdje8U+DJ0JgROVBFI+YtE6hLpqEAFLeZbvAkFzEMu3XBK+WahQ81IvYH19szEB
         CtSyHd6LFt0IJYZPRDVqkm/S9QyoSVZZ1KjLK58LM/Aecx3motcrgwiiAI2blv5Q0/1u
         gMZA==
X-Gm-Message-State: AGRZ1gIBlR/VLW6aCrGhYm4bzZ3JVBS6OPjvJxkK5u+fARVYNUjhR/QV
        FiLoV9qvYQhBjS92euvrPklWQA==
X-Google-Smtp-Source: AJdET5cDAF7yC1zeh7alHnOPmHy+mDUCKNBzfxr7BwUi7bFARQA+Ksuu5gfJhN0ZBW2vK2MkD8Ttow==
X-Received: by 2002:adf:b211:: with SMTP id u17-v6mr1228105wra.52.1542190780161;
        Wed, 14 Nov 2018 02:19:40 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm19832140wrs.55.2018.11.14.02.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 02:19:39 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings
Date:   Wed, 14 Nov 2018 11:19:24 +0100
Message-Id: <20181114101925.10526-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114101925.10526-1-jbrunet@baylibre.com>
References: <20181114101925.10526-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Libretech aml-s805x-ac board, aka 'La Frite'.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292b833d..203d38e5e271 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -93,6 +93,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p231" (Meson gxl s905d)
 
   - "amlogic,p241" (Meson gxl s805x)
+  - "libretech,aml-s805x-ac" (Meson gxl s805x)
 
   - "amlogic,p281" (Meson gxl s905w)
   - "oranth,tx3-mini" (Meson gxl s905w)
-- 
2.19.1

