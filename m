Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD320879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL0gFa9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbeL1Pqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46540 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeL1PqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so18997438ljh.13;
        Fri, 28 Dec 2018 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8jyxKx8vnHBFlSEptO9LtSbLRa4isvh4Gt7pzfTqTo=;
        b=NL0gFa9CGJyWzE0cTvarNXFxqNvjf5nlx61P4cJphxcK5iz22Tt4AN0mSrSBMT6RxI
         /rtgWvmQiS5ELtb7BR5Q9mDhaw55aPObxVlGqpuvtcrUaN0xDm50TMx/bcaV3AHlW9do
         hBKuqH2yLLKHOY/AebKXZsbh+U1p7vOaObydWPO8Q01D/KaU4AHtbr6e6mHkUOIgXsy2
         i6nzm7PYSTjBjzjSb7GolbtutcawUVX/T8LHxA6GUOIogScbshyPaKX6UTjVDoXjatpb
         HjkqHngZfAYwFgoPM6QZY+ogjjixHyPGTIuPl7Dx59dFTWq0e+MnKfSp2wr0yghoaNP0
         hjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8jyxKx8vnHBFlSEptO9LtSbLRa4isvh4Gt7pzfTqTo=;
        b=pbQaqadt+n4mDAVwehQKK2jVaer9mMp8RceW0wBNTC4ksrdNr03jTl9U+yDQg8wZZO
         nU+HWVP58W854y8EQd2hv3om8GzqRpNX0uKJ0cDI5Z/npT1MngvH5Cw9sPSWucfaTBrn
         Hj28M3dFya8uWHA+cgv867FtVqu09L7pYl2ExQYBELAcY+iFTLu9lZBAEnBq5kz6/7wW
         ln55/VSh6PxS9bxZeGM7H2hOdh23AynLV5W8Cw5LT8E15PTyT0ow/XEx1LkQR8ZCx0fH
         WjyMMAsPB9nYGKyS+GzgaX/QyPNz31TckEPbxNG+WleejRvij8p20hhPw8HfnaTQChva
         X0fQ==
X-Gm-Message-State: AJcUukdaYJtmOK6illlZRlc/0fwMc8uEHgWGrvKC+H3sz+ZBnnVp4ZCd
        lejGNq9ja6ADiD1pEe72LZk=
X-Google-Smtp-Source: ALg8bN7+OlDz5GeRHMiC+4+mvgYRg44dmi7CjJSBEblhmePH0dnL8rsKC8qdISOF2JH6DwFuZA7yfg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr16396278lji.112.1546011983464;
        Fri, 28 Dec 2018 07:46:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:22 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date:   Fri, 28 Dec 2018 16:46:07 +0100
Message-Id: <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document new optional property for setting custom keycodes.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Because key codes could be bigger than 255, use ints for keycodes
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index dfb3b9f0ee40..15d4bf4f307e 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -10,6 +10,9 @@ Required properties:
 - vcc-supply : internal regulator output. 1.8V
 - vdd-supply : power supply for IC 3.3V
 
+Optional properties:
+- keycodes: array of keycodes (max 4), default KEY_PHONE and KEY_BACK
+
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Example:
@@ -23,5 +26,6 @@ Example:
 			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 			vcc-supply=<&ldo32_reg>;
 			vdd-supply=<&ldo33_reg>;
+			keycodes = <KEY_PHONE KEY_BACK>;
 		};
 	};
-- 
2.17.1

