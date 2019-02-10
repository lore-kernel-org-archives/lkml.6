Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3203C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13020863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH3FvHX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBJUjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:39:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35187 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:39:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so4313640plo.2;
        Sun, 10 Feb 2019 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ArTrIZZhrWlHTpLnvz292rS3KEiXNeIIUmm0L6+dn1g=;
        b=UH3FvHX46BetjXOETJrbsHWLMvDaMrTtGcf4VT0R+fPqxKjLLzPcvpiAaqqkRmve8I
         JRxy0AaftPwnMt87YKKrtDVChR6W3e9/1OlwMVc3JwDgtLgqhmXfJpFpuv9biubZALmT
         EDzh+AWIb52J1cH5yQo+XsWsCZ+JQXhw6WFk0lxZaucp+treF1ePpIU3f+rHrsv9lWAz
         XbetfAjNaiEO6JvtWW4CGevdHwdshVaWzHP12yHfo2H397JJAJJwgsD2gNieE5/VnjWa
         Y8k/xD2d1abaKT677D0OqJVpqXJ+v2zcsBqq8aLWR+wxvFMxGoQyJXWGSK5DYqIwTejj
         yvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArTrIZZhrWlHTpLnvz292rS3KEiXNeIIUmm0L6+dn1g=;
        b=alEakHy9O+zkinTxUUrMG8PdXqotoATkySWWqSs+El6iXMALat2DaexH6Zfc+YjAFP
         uYeSPtpt67RveQiRTBotis1pwKrd2nsRKHaciI/VQdiygqaU5PeDq+PVsxEBqTuBJGON
         pR11Wsaj/+KxTmfXA2IOvplGrrhF8DQ2NrojjQkztcj8fCrvNUCyEEvZ2JOK8sj0+xIc
         GiQ3FLLb24/H7Mh9tcs+nI9GaUk0tczH3BuKzRx52I0/pKiLAKltKlzGRr2HJQ3Iv/Lw
         rmhBwCbQwBW78ZANC95yRSM2tgdVfNyTdvoT1/kic9V2eHGixJXePVZhZ7wc5cul1WWd
         gLqQ==
X-Gm-Message-State: AHQUAuYJNqJmCsatwJrj3SsOMw02olS0Dh91OQz5DsLPaYjMVGYIVfEw
        a3a8b6YWSs/2j74BN7GwHC4=
X-Google-Smtp-Source: AHgI3IapnqpZJwzRVAmOQUdFJ1A46WkXwCRQgFgDkggK+vLyWetdAdNH8MzyLrR1DMC/f0jXzKQCKA==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr34061435plo.96.1549831146771;
        Sun, 10 Feb 2019 12:39:06 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::8c])
        by smtp.googlemail.com with ESMTPSA id t5sm13522205pgo.70.2019.02.10.12.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:39:06 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: vendor-prefix: add prefix for Lite-On Corp.
Date:   Sun, 10 Feb 2019 12:38:13 -0800
Message-Id: <3a4b0255b14d5107a906a39834953f5fa5f33afc.1549828313.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a vendor-prefix for the Lite-On Semiconductor
Corporation.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..e487a5d95ba9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -219,6 +219,7 @@ linaro	Linaro Limited
 linksys	Belkin International, Inc. (Linksys)
 linux	Linux-specific binding
 linx	Linx Technologies
+liteon  Lite-On Semiconductor Corporation
 lltc	Linear Technology Corporation
 logicpd	Logic PD, Inc.
 lsi	LSI Corp. (LSI Logic)
-- 
2.20.1

