Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492EA20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MbeEc0Gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492EA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeKSHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:38 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33293 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeKSHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:37 -0500
Received: by mail-wr1-f54.google.com with SMTP id u9-v6so29936615wrr.0;
        Sun, 18 Nov 2018 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDG6cqRycRzCFwic/B2Il8324dwPbu/CMN+slyIzPK4=;
        b=MbeEc0GqLLbdJeeE1f88bsjlaNYb2cBCD06VfRnBu7YWYFvfekOD3zBeNxkHey3PxK
         trlIB2lRGcXKLLyOxgm5Y1pnqh5NSHKKEdU3oSdaiU0Oq8Sk+T94p5v98qhUsWGFXBF6
         +4mrchg4Yfc/fumT8Ea1amn8Id0B5OtX+GxWwwGgv6g1OXiiK/pRNz71wN0q+x5ZstNe
         1gmCsnwPrFIjc7VLGw/Llg+7NPI8XHJBWvTJZLUPS2LnNvC3jef3scdSiNF7mHSyc+Fn
         B3jhXnGODx7MmbuT2lXelpH9xqc5hP59arwoR5wvM0Pr74A9fqdm3kvw35AerOpAfzFr
         3Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDG6cqRycRzCFwic/B2Il8324dwPbu/CMN+slyIzPK4=;
        b=O6RpMkiwAka9Nxt/FJ8+ppZ8lWTClKEycruVI6pXk5fS0rKJbC23fzGrQFQ0DLehq/
         PO/h0jwhxVhXi7S2pFRzD7jMycZHn6WuHTOBy7GW7KiTniiO7fAdZPxyjcViFmXVx/Nx
         mYuDzrmhvxEIV/zNjo8FFV/WFcCQcqngF1nZBXQKtjStRBiaFm/Y/NHyIr/XCOOd+BxM
         vaXVO31vgEUxBqUCEWY+o4JUlua3yi4kTsH6Qtx0etJNE65BzuKyIOAcXiscYoBsvKVX
         zWD3iz/hYKA91vzb7+Puh0tTmcSjjKH+qMzfeSMKZXW/B0vBzSIEJKCCSEDLzG7u+Q3g
         L4nA==
X-Gm-Message-State: AGRZ1gLePYkeja754s6eILEN3aS5IzMLfWi2LfQMM0lECrKD9+x6pi+u
        Adsv8cAjdgQ5a4fnjENBCC0jqxT3Hck=
X-Google-Smtp-Source: AJdET5dAf0WCLPtwTG+086srWz+yIZ8JzsAoaJ1TziRmIlj615pXHJ0e+GAs8aTOndSR41AJ4MGTBw==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr16507464wrg.24.1542576253066;
        Sun, 18 Nov 2018 13:24:13 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:12 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/7] dt-bindings: vendor-prefix: add prefix for IC Plus Corp.
Date:   Sun, 18 Nov 2018 22:23:53 +0100
Message-Id: <20181118212359.32414-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IC Plus Corp. has various Ethernet related products such as Ethernet
transceivers, Ethernet controllers, Ethernet switches, etc.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..cc6b2c0d3b49 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -170,6 +170,7 @@ holtek	Holtek Semiconductor, Inc.
 hwacom	HwaCom Systems Inc.
 i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
+icplus	IC Plus Corp.
 idt	Integrated Device Technologies, Inc.
 ifi	Ingenieurburo Fur Ic-Technologie (I/F/I)
 ilitek	ILI Technology Corporation (ILITEK)
-- 
2.19.1

