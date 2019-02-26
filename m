Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA31213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DfXlNEUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfBZGCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:02:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33427 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:02:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so5703782pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ts+gw7kSFMO+AcwOSg4xR5ZxcHxVFhftHYNFvGSUC4o=;
        b=DfXlNEUmqzEWf2OGimMIod8UcHRGp9NFyfSJ7t33nN+Ax6t3TpUByM/RJVWhrNU7w1
         y9GYbRUd33VYa4Vc/p11Trgea1CbL3iNFnIYlSQvP2Nrw5Z08HWCOaPGbOo3J+BxJST6
         K39gK1wc6gUS/uwyxwPhHL9hL4zd2bj4wNl6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ts+gw7kSFMO+AcwOSg4xR5ZxcHxVFhftHYNFvGSUC4o=;
        b=LISWyzjBnnKYutIKQBs5VAQQbUhymrauM373sjhmCLEIDHXyJcyYurTettHe5F3rok
         DLsyTCVAz1SiTszLlVG4p4gxi/aNfX10BbBBQo0jRV44I3JamdFCEFfl0ZoOV8xfQses
         uorjF9n6aZiFgjfgWCldnoBJIta9d+E+xdFM8LBTZxEW8wL8ME6LaB++HmuFVTQDsBW+
         WpCPkquM6g3yejar+oBm4q6sCeKZHE2/ecnJr7SoMLhAPpuWQxBT0hc7JRktuhjUV799
         +5qrMl28M+YDKF1Akra9JIyi02zuidc97OcQJajXoaJRpO3kVvJw0950z6HtzSednKbn
         Ggzg==
X-Gm-Message-State: AHQUAuYp2xY45oWpO+EL5Z8Sd1oP2dzR+NEKCv765RxvaI5T1KkALyus
        DHrms6g4SzZ2Vwc1J39kV/KaA+oFnCB1Zg==
X-Google-Smtp-Source: AHgI3IZaSSiywoY6Knnsw3CZAaqPceMk0S1UuklAerlE5MyYgWoJBPb0gK+7mip0wCgBMByXlN1uSQ==
X-Received: by 2002:a62:1b92:: with SMTP id b140mr10536064pfb.159.1551160973116;
        Mon, 25 Feb 2019 22:02:53 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm18976940pfa.75.2019.02.25.22.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:02:52 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix for oceanic
Date:   Tue, 26 Feb 2019 11:32:39 +0530
Message-Id: <20190226060240.8783-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add oceanic vendor prefix.

Oceanic Systems (UK) Ltd design and manufacture world-class marine
systems for control and monitoring vessels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f42e12eb9d64..5b551407f487 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -285,6 +285,7 @@ nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
 nvidia	NVIDIA
 nxp	NXP Semiconductors
+oceanic	Oceanic Systems (UK) Ltd.
 okaya	Okaya Electric America, Inc.
 oki	Oki Electric Industry Co., Ltd.
 olimex	OLIMEX Ltd.
-- 
2.18.0.321.gffc6fa0e3

