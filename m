Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320321848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H2cpbeCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfBSKQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:16:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfBSKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:16:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so5187829pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmCAQkrM3/OELxKaTZyIowffx998WPjdycggg3eSGMI=;
        b=H2cpbeCwfhQTIUv38zu6s2pBSuogVLWOWgqhYDLCeB3cA2FZnuhWUPlg7eCU+Wk6xH
         Lv1f3QQ/AcAH2WL28qxqo38YV0G9iQz3dt7GMS0eVMtT4NlItY1hroIiuFjedmybdaWI
         68pggjNwv2HdHfeV9gyfGCavM1ai9UXICwRvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmCAQkrM3/OELxKaTZyIowffx998WPjdycggg3eSGMI=;
        b=T9HrvEloZz+9UBT4kdfn+Z0bT+l5c4QO0/AEtFJNnUnDLgqQ+HB8dPKN6HDcjF652z
         UsJBBZRMB96k+SL8oDol4fPJvjQQeHQT/1UPtlOqe2T+7f3mVZ7ADt7rPswE8jiFdGvq
         zy38yp/+syt93ibhzX+pUkUmpUKAR1DYXMlBVWMe+wexYHDVegvHYETpdhBr/Wx+qzRC
         o3tugjcXtUu736znuNPTboMHhm5aQYuFXIaN5pNDsFU5wd4TeRIqlFGNuCBUsF+kGM/x
         VE5/uHjR+cyR6uqIdI4IZO+/dmP+qx37eEKCziraB+lP1veD7KL4AFoiDm9aRwgFWJJ4
         bdwg==
X-Gm-Message-State: AHQUAuYmZHm8JETU5SUIb4k34//0I0oZwPMpeM4h3FbFQB9ScbwsSW0Z
        1TmeeYXFMwHv9CYd61WTAWFHXw==
X-Google-Smtp-Source: AHgI3IZbnFzVs/Cf3JDP7goVyO8p66u/u3/zJdkShckeSL0NSq2lMuDl0VcnjNTulqdww4PXk4PrTg==
X-Received: by 2002:a17:902:1022:: with SMTP id b31mr29818832pla.141.1550571406160;
        Tue, 19 Feb 2019 02:16:46 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g10sm21324011pgo.64.2019.02.19.02.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:16:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date:   Tue, 19 Feb 2019 15:46:26 +0530
Message-Id: <20190219101629.15977-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Out of which AVDD28 and VDDIO regulators are required in few goodix CTP
chips during power-on sequence.

AVDD22, DVDD12 regulators have no relevant functionality described from
datasheet [1].

So, document both AVDD28, VDDIO regulators into optional properties since
few of the goodix chip do work without these regulator power-on sequence.

[1] GT5663 Datasheet_English_20151106_Rev.01

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..b9b8f196dc90 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,8 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

