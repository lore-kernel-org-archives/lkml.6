Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4316AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111832085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUjx7LlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfAGSyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46226 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfAGSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so1218679ljh.13;
        Mon, 07 Jan 2019 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDHMr/fiYRXHunVviW84NpOBn4IvlCGGXSsFuynM5YY=;
        b=MUjx7LlYA3CmLu1+6uDKq8/02Cz388/IhEAw4lX7xrpO+JJmihZrCRHrdTkgO89naM
         50tf1Fd/pSeFSDf/t/uj+AJiCiSPKDEbPN82WSnR6SFe/3MjoT6yfCiQKTzq/0k/oHtV
         GbWWB6uOfbrJBXwGwWB8+HkORR1kQY2JubgptuXCeKRP/egZqvcxBBsSqLRqwTWyUna+
         apabiBykcC30nn+gSGIHcAJnrLSo9PmccLloO0u9pLAE9LT3F8eeuvVONIvIx40NA2st
         fL2vPOfLsY7qBg84ztunF+wRzyWpJxQCZkjjjr/AtB2LLTctOtdYaq16Dh0Af+LVo+8E
         dNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDHMr/fiYRXHunVviW84NpOBn4IvlCGGXSsFuynM5YY=;
        b=pJ/C0TfycbUXGmyPCtP26+9FZeXCzYYhuPvII/CqG8j69cBc9KthTJMpYnuvAraaDr
         Hsos/VrBThRlgNOuAQ4zvHMS1eMgmOVmD8v9r+lP0IFKoRb1zRlxxZ8G0fMk6LwgtCIp
         2VoH5n9/VB6RpCs0Kyy5g3Q4DKCThBWvVasEDxLyy+H6AhkdoxkLr+hS9kX1BWlaPfJM
         qLbaqSEpsJOiFkZ4SdTaaNPck4XVMckXtwP7aw7tzyHH5koAK7PBYnRrf+Ns7r3/Cb/6
         QTSZmQvNP9awaCkB7td6sYC2yILs57d2Hf3JFAHipAFVJYbThvwqlV22RzLKREooJLpa
         /UgQ==
X-Gm-Message-State: AJcUukeKMIMhaufzE0spIkGNc5z4f+ytcQ/31a8G1UC6Rmq6yIsQggiM
        TKHw7iFoDOFIVidsckjeYRI=
X-Google-Smtp-Source: ALg8bN6jymLTId+oLs5XuW1fhzw+GHD7NNJCYuiWbTP9PgU06np0XNegP7VMENDyklVLT7UeWlA7UQ==
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr33064543ljf.129.1546887252979;
        Mon, 07 Jan 2019 10:54:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:12 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 5/7] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date:   Mon,  7 Jan 2019 19:53:44 +0100
Message-Id: <20190107185346.30184-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v2:
  - Change property name from keycodes to linux,keycodes

Changes from v1:
  - Because key codes could be bigger than 255, use ints for keycodes
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index dfb3b9f0ee40..8ef1517c0220 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -10,6 +10,9 @@ Required properties:
 - vcc-supply : internal regulator output. 1.8V
 - vdd-supply : power supply for IC 3.3V
 
+Optional properties:
+- linux,keycodes: array of keycodes (max 4), default KEY_PHONE and KEY_BACK
+
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Example:
@@ -23,5 +26,6 @@ Example:
 			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 			vcc-supply=<&ldo32_reg>;
 			vdd-supply=<&ldo33_reg>;
+			linux,keycodes = <KEY_PHONE KEY_BACK>;
 		};
 	};
-- 
2.17.1

