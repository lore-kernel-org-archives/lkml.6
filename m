Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B191C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A116208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UETYYIZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfACQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:16:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34507 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbfACQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:15:55 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so7734632ior.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FI5dMVj3tVJ/HnNRmD/cwNxqVCNld8wLx/kY05U8OFs=;
        b=UETYYIZltEzb2BQwuqdIgU0SRoJcMbjMU5y7ihyGwTcsxyy08AbIGyamSoit4Z7chF
         bZOJYS/9ieNyPD0g0gq82Ij1HBZ3XsGqL83E/b6Jvw2rXJOCCd91Li68EGjMdv5Mekqy
         AYp0b/R8UeGyZxN882zu0QlNwIMvOdJH+9YOrcqCI5BL16y/0rIS51R6ttwsoEg0KzZp
         SAdQsNJftsmNs9bNP0bHr4nZbga/7X7NZ0z7+ElXoIZ6+D3apPSSx5S6l7LI/L5zXqvC
         vymwPdTMSJTqPkFbwK9CCojmGOqL8cc3opd6nRvBvbrE30M003wB7Y8lQkRI9B+wwOlK
         xYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FI5dMVj3tVJ/HnNRmD/cwNxqVCNld8wLx/kY05U8OFs=;
        b=ftLduwzuC0Pmcix06C6yE6+55PxXRkcdEm7iHUusAOLyof08atkq/D/NTsbD8Qgjph
         2eenI4dCW7Fz9gtsJqLR2BI87cKFCC196QhtY20vsqYbUYxiF+29rzfAvy3qSrMpZ31/
         BxolnTVxCjPbbBoXjDMqJ9e/veZDkBvbV0+Xi4OBdp8p9Qv+/RwwOPmSqpMrVmx8cvmn
         AEJvsJ+emcgntcgVKgrlnSeOwiVWuRoFilGBprVyS3ONKjELg9sq0upDNEMmcOg31hhI
         BjdT1L2BAEUsSKQU3eG/GDJXX7ZZY56WX99TCCgdrKhVZt0+kokudY1XZUjRi3LDa5dg
         RoTQ==
X-Gm-Message-State: AJcUukfzYUP5zRHSmgQMw59BtHez9HSMXYmRCgeSybQtwtv5CvrNE4Vu
        2wdntmy5Mnt6CuFmoG6hW4c=
X-Google-Smtp-Source: ALg8bN7ZJ0VRPsOItB3/WFfJBgIvedgspehKE5UIK+CwDjA8GC44mLrkx8lM2oaW9Q4Z0lMf6e5sfA==
X-Received: by 2002:a6b:dd0b:: with SMTP id f11mr28770051ioc.45.1546532154697;
        Thu, 03 Jan 2019 08:15:54 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id d11sm6018423ioq.31.2019.01.03.08.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:15:54 -0800 (PST)
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
Subject: [PATCH fieldbus v6 5/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Thu,  3 Jan 2019 11:15:37 -0500
Message-Id: <20190103161538.20637-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190103161538.20637-1-TheSven73@googlemail.com>
References: <20190103161538.20637-1-TheSven73@googlemail.com>
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
index 4b1a2a8fcc16..f0db65d642b2 100644
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

