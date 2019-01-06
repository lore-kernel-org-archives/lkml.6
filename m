Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D8C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F233B20868
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXDKvf0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAFRQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:16:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46173 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAFRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:16:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so9579988lfg.13;
        Sun, 06 Jan 2019 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7JWeLUeT7sxEWWIvTYhc8xoC2LgbFZ8DAHrT37FOBM=;
        b=dXDKvf0HkSA3PkPwlIwPHbhaf/ZP+YrQjJPu9BSKAbF82c9lyr4ENOdKjB0CdeRYrQ
         g48SG/w2y9Q2LGBVhKVHpSAE4jD3SnGxeqNX+u2KSLY6MQNOrH69APNljNkeGASaKIUn
         ZHclA6FgJlQRp5/MZxIlucfQf8yHkxr3M6wIR1Qxsnh/IDiJAcOEUx5twmxmcue6bHV1
         qTEFHFyHGZL0jqddDeT1i55QXTWWgNF9X4CYEJLQXV0rXSW1DMKkbAAko/+mYrd0SEqg
         wZSmYhGfGfGze+LK+VGScHwHFaG1Y3CuHH1M7PvLzjKdOhfpGd/8sCcGsMCsxPqoyfxv
         B8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7JWeLUeT7sxEWWIvTYhc8xoC2LgbFZ8DAHrT37FOBM=;
        b=U8VvRa1bl760JITzOpo0vXhn/l42i8MbRoYzAazX/kJqpaJ7J3n7bTCuGwPqr/9pLN
         GhNKdUQd1jU5ILisrKgobFDFmbQ/6yOXo07UVL8zta1P90iw5J8GSCFYwhE8BnGPyC4f
         4gqTv8MsJyZphlrSiWVz/nGjWtViujBSuxsal5cQv4XA29v5qdn+1uib3C5N0+vyxYhN
         EauqwNP8jM5tGeXu36A6OwdHiAEeiG1u68tG/1vorkpBz0fghR5kNtKgrEYtZoq0C9GS
         Qo+1o2NbGrD7hS8FtgLcgxXcXsfx0D/ySm98uH1fJFFu49ZN46v/NoOBuVreN+3UfFHt
         Y7iA==
X-Gm-Message-State: AA+aEWYfY8tNznXaa1v4QJjiV5KVNCJkxc63BCmSqoExUooJfPsDcRLo
        +lanqcz1MszWkDCqDG3Qe42uDwH5
X-Google-Smtp-Source: AFSGD/W9pC+vumO3A8fEAJm0WRwv2YTCCUYmv0TQF4GgnpzzolQuHPPFVzLO1q3DA2Umsa4QSVV20Q==
X-Received: by 2002:a19:690d:: with SMTP id e13mr28871487lfc.84.1546795005391;
        Sun, 06 Jan 2019 09:16:45 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id b17sm12339409lfc.21.2019.01.06.09.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:16:44 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/3] dt-bindings: add Plantower to the vendor prefixes
Date:   Sun,  6 Jan 2019 18:16:13 +0100
Message-Id: <20190106171614.12615-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190106171614.12615-1-tduszyns@gmail.com>
References: <20190106171614.12615-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Plantower to the vendor prefixes.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3cfe0c8b8250..fa391a650f3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -300,6 +300,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
--
2.20.1

