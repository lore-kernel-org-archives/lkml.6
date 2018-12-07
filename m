Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DCC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305D42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERfc6a36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305D42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLGK6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39161 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLGK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so2703234lfh.6;
        Fri, 07 Dec 2018 02:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hU25609CTMwaZL7M276wpeBmUwTI5685ZpsMHwHFloA=;
        b=ERfc6a36IX4ymThyajYuTYb4IV4AKP8KDgn+DMNKhc91iBDztnwLGKiXpd3oITtezP
         CH5Nk+U92gsdRjmthkAvwCtg3T7kiynGW8pdrqrQyfNsFON+adr55J87JNl8etKGt1Vp
         QQ4ObIX1MbtekNlaRZsD5lctaaj9Vx6kVvjZ5vJTg2/T7U3qRvYNhS8ktCN8D2W0FWKy
         03O2wlyWhfIDf4JcNnQH6WKMvkwUIT5b8HraK49VCho1nlOX9qydGaySeTb7+HwLKHD2
         L2M8OM7qtSMll+EUMciFAN0+SsnBuaIzd+dSZf2l+eVfomNOOK/6XcryRumnhdA9bFrU
         AN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hU25609CTMwaZL7M276wpeBmUwTI5685ZpsMHwHFloA=;
        b=klTkexfs6T5vayOOx11pFYMb6Jz2BYynFYeatYUN0MISfzlvAxHhD49+IV2uYe/Ore
         D+4AEtRMKVoNoZW3IKQNHfKX6D/01JAROW6uHN0mM+/wEfg4dXa4q5a9khFSnUpCCih7
         Iv+wLFl0fRvYVk+Tx4FupWtMCU+2jiV/7eF2Xf6v9cr4d8HN2xDJFnpv2rJAumCLmqgH
         YKfAVoU+6DKkOsmZA/vSxxYfmWNpZvZcTrikTrOrvEiAxDYDFSYxIM7jdl9acj7TtChG
         jl3BsiOfZWV5B9yHMGo4xrBIyeopFeGjE0i6Op/57Bp8hfeXPdhrlMxLrSDweYlFeV9d
         /4nw==
X-Gm-Message-State: AA+aEWbSdRvObAfQ/CO1cV2rLE3OPVDKmNgGVmDIZxHOLi78LGWq5x9f
        mwSKDlIvQdeQfxeOqNg3HKQ=
X-Google-Smtp-Source: AFSGD/W80DoRSLcZ4id9JccYo5RbZOQgrClq+v+O8EbzS1VIL/NAbYAq5NKSIOJ4VmOrM4wr8Ib59A==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr1080137lfi.19.1544180308024;
        Fri, 07 Dec 2018 02:58:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:27 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 6/8] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date:   Fri,  7 Dec 2018 11:58:09 +0100
Message-Id: <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
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
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index dfb3b9f0ee40..3b54d997b8de 100644
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
+			keycodes = /bits/ 8 <KEY_PHONE KEY_BACK>;
 		};
 	};
-- 
2.17.1

