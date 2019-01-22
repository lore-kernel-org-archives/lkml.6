Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D21217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQmTYnmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfAVPVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:21:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39168 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfAVPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:21:28 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so20543124itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdw8UPVdfG3/Kwvp8nIa34/XhSgFhH0hqh0UmtcW3KY=;
        b=tQmTYnmrNFgN6FfFhDOKFiBziixHhQupfRP07T0wxm7nPHPlpcCiBvVfLZoYug6y2Y
         K88lGqlred5JlmqfoKjEPWgLZ01dATQJUr/5VavoGmnUu/klJ1jw49YpcMG4eN5cLLr2
         mUdeOfrbplydraaRL175Di/91jRgU/DZUdZ6Sujh5sqD86udKx5Tuw9Zd1u2tTSbdBk1
         ZSOsIwp/U+GswumWDLVVt6p4aJ51ki8c46ZYc1YCP6PDqibuLmWeZgS46Na4OLIcxQvT
         zg9CzKIyRzjgMPOQksSBad2X5ZCIiN25YwJkMOfwhk0xkhkJphR/HQhgb6PI91755OuC
         NGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdw8UPVdfG3/Kwvp8nIa34/XhSgFhH0hqh0UmtcW3KY=;
        b=ZRGEXir3RjBq4QBdJfpHKkMmF2/U2t03lUrD09amk+UZii6tH/vQYUQGZOLVTEkBlb
         fDM+j1/610bYLEUPD+LLYivLpFYMilqSoL8BDHodoGWzTXqJiuqsGeonpo/qTAQq2hH7
         NHnFpptF2iadcEg8YjlzvCThguXAcGm9cArDmzs0ScI2HnCL0IIkm2N3hcrBQtJtd3WH
         R/WblL89W4lYMi7MEMA4eOcDkkt+iCRdVMkhel4TgBYfNjX5vNm7XqhlhfMdjI5GYcYX
         /ekXVPyJbs8Xic22ehGoBYZM897VscZSXAndRwasGlm4MtCZCWDakJIT3C90Wv+m2tXc
         6C/Q==
X-Gm-Message-State: AJcUukdSyGNlR788djW1p3mCUGmvyI3/Of4BgDrsvZTWYBtwCLGI5PYg
        CDpmbaUN9/hbbLYdA0LgGB4=
X-Google-Smtp-Source: AHgI3IYyq68EcEfL+FMoDwyYzxpYl4/RxQTOvteRpkKP9l7roG0g3bBfUhyZQn0bLJkpig3E0VEp3g==
X-Received: by 2002:a05:660c:4c5:: with SMTP id v5mr2470987itk.104.1548170487610;
        Tue, 22 Jan 2019 07:21:27 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id b192sm7658509itb.12.2019.01.22.07.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 07:21:27 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Tue, 22 Jan 2019 10:21:08 -0500
Message-Id: <20190122152109.30488-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122152109.30488-1-TheSven73@googlemail.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..7c84df526018 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	arcx Inc. / Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

