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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C185CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B12B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+z9H0/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAGSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46231 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAGSyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so1218798ljh.13;
        Mon, 07 Jan 2019 10:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t705wjl/OuJqESix5qpnaG3nZBnidSIcHveU5yicvAM=;
        b=i+z9H0/vLgwaOxNSAfQPaYYVipVrcgDKztGEOswsgqQQAEY/PVRC2o0lJ02CNpakow
         6Ql+usoSxk2IkJKrOgyjFUoRuuA8VCMa9EgYV/cXtzpisBPJYuy9ju336kYexW+zyOTr
         kOYO5jJui/+4S1Q/K4/B+PEGrJO2wjc+3Jl7Z9b7mY5vnTmDaq9ElF79iBMoeJalxbeM
         Lbfx5Nnm0FciH7Hme3J/gXZFhOhz2TZATC8R4WIxNfVh1y5CXsivr5xQD0d0OTg+GHKf
         iNZlV6K3y7hYUN44yE3QXZsha9gwFMxzHEr4D16nN/MuAx2rxZGeFoDKs27np8uwGos1
         knpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t705wjl/OuJqESix5qpnaG3nZBnidSIcHveU5yicvAM=;
        b=fxCWrqzms9G2jDn86eI75H/QDKjMmm+7H98msP6BOY+KZrAfBwTALfjJXWZpmxCiCE
         9UJO2csAXNBlB84C1UTG799kV2u17fUd2HuFEbPCMh7/XhfTvXhANw2q/S6HY63NdNie
         ZdjPTSG16LFiJaPdrXjCg+Jb1kkdBzmcrRveoYCaZ2j5L9RkSKo+4ZVLeNLOcoSvlMcM
         3q7ZYBI/PMpMXhk8DNNlRXyaXLt6ElsMDMSQlJz1qj+mLzcRf4BovDQdsGIpOL7YHUNl
         29Q9MOW2uG/Wifg+naloA8890XMKO6GmT8jGclOMmZ6Sj/e0+gYNJEPfY8jg3amdOSVI
         Oh/A==
X-Gm-Message-State: AA+aEWaeasskzGQB03fNwy5ttuxGcwL93QNJfN9hF3dZSulQZtGnmHIe
        OR9poS1T+H5xRNMyzNQXKGo=
X-Google-Smtp-Source: ALg8bN4ORBfmxaHjZ6qfzVy95hYXCeMuc7a3bObI4a0A6rlkb120H8SNlwy/fsGDzoiFGXWsE3yt6Q==
X-Received: by 2002:a2e:9a84:: with SMTP id p4-v6mr33589514lji.73.1546887255780;
        Mon, 07 Jan 2019 10:54:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:15 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 7/7] Input: dt-bindings: tm2-touchkey: Add support for aries touchkey
Date:   Mon,  7 Jan 2019 19:53:46 +0100
Message-Id: <20190107185346.30184-8-pawel.mikolaj.chmiel@gmail.com>
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

Document compatible for aries touchkey.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
  - Added Reviewed-by
---
 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 8ef1517c0220..ef2ae729718f 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:
     * "cypress,tm2-touchkey" - for the touchkey found on the tm2 board
     * "cypress,midas-touchkey" - for the touchkey found on midas boards
+    * "cypress,aries-touchkey" - for the touchkey found on aries boards
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
 	binding[0]).
-- 
2.17.1

