Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41617C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g+i/SEh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeLOPS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:18:28 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35930 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:18:25 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so3486766ybe.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 07:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RnVmA/kb8L4Yz4fb0H81a9TQRGfgVwPZ/JkhxzRPgU=;
        b=g+i/SEh9cZHqNUWg5gf3ZLOdQNwFkh7jlgcXDwSIMm9FqDuLSCXQQUF1Nvdhz0SdAH
         288121am77WfEtHk9JQwnYIwnIn2wSkloCdm4aIzvVoYAv6PVK4WmOwukj/HP4cJ/3Vj
         +Rdy97KqFVDz+hfIgRpJ0Ndi3k0P1jwUhOD8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RnVmA/kb8L4Yz4fb0H81a9TQRGfgVwPZ/JkhxzRPgU=;
        b=FvZptqcnI3EoktJ2dpZ7J3jaXje+yslM0ft17XTt/hW9dBfzAyXQZLVTAdhHNeq2rb
         YO9FbgmNjvJ/7KfilxScCS6GcrTE8M3VSac5IKSVkZ7k2krVbecxG5Lp6WbAyHPUzb6m
         Ex6+ScZZP8AkPvUT6YNmRtKonDm7v9+BVfNYh7SGQc4G3XQwTMKqtcA+11KU1y03eTU/
         fxyvtwxk3DdOcUBnCFkyL+D+4AZgtjDQHRAOlYnMgwLvJWNT2HlYCjhIo2zP0UAlikDX
         nJtLG1p6A0yII2TyLpluZzK8DIs0Qbf0DJBvYYwXOs9bOoN5PPd1i89eWlZ3w9dINAWt
         m0RQ==
X-Gm-Message-State: AA+aEWbMpVZeEYLiIeafDT5SBgg4kpNfIzMXbe4xqH7coh8Ap6o6NO0U
        S2obYIDtAPI6izwPCdKSexPP+w==
X-Google-Smtp-Source: AFSGD/Uoj97klWTZgUmr4LF9/Nhz3cawHt+FRDR0zdk91JA5OM40Zr/O45CJIHoVWo5RGfH37FuD1Q==
X-Received: by 2002:a25:ae60:: with SMTP id g32mr7291451ybe.66.1544887104176;
        Sat, 15 Dec 2018 07:18:24 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id x203sm2855664ywd.41.2018.12.15.07.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:18:23 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document AVDD28-supply property
Date:   Sat, 15 Dec 2018 20:47:59 +0530
Message-Id: <20181215151802.18592-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Goodix CTP controllers are supply with AVDD28 pin.
which need to supply for controllers like GT5663 on some boards
to trigger the power.

So, document the supply property so-that the require boards
that used on GT5663 can enable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..c4622c983e08 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

