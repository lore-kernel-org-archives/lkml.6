Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85775C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEDqDcKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D13E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeICOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55699 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeICOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so534935wmc.5;
        Mon, 03 Sep 2018 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+HNfr3I0MzGHGd7Aj3LN1rm33wfTbHxswxtDehlIDw=;
        b=gEDqDcKo7iy9T0WsJtmQLxyIP9rtZgMc9YreV4LnDm2vMI3qxoT5/qt/KAPFnFYhuP
         by+38DFjwWf5t0BKdPZ8F2FO65Cq8ZBga4J9kyowCpuGj38qDMS00JgKGm260tXMjzsC
         fVkYwl2A4C5aC6HweijBzuHZmwYUHJ6bASLi/FuA4pGFDn9zxrBQSICcVZLJ7tJyv0yC
         J4sTKmcr4xlRZA+ikai0huBh19pO7bTvyP7juqoyswIusWzsXZA2f8GAd7IP5oOc+eiF
         y6MxfhcAW/Z0hAKMYCVm93mWAXR0y6sf8Lro5eNagQ1vD8hlLqwPVPh4KOLmuP5Gs6Gq
         W7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+HNfr3I0MzGHGd7Aj3LN1rm33wfTbHxswxtDehlIDw=;
        b=q+0AZfah1syJ120oMReV0RYbMCgzfIPMJShHu+gDPIEOI5/SpW6+wZVJWjSKXJKMYw
         su/hvaNzlMHQyJi7ZnLCpw94SmIuYntCKDhahIdjQ2+GH+nFgL480wEiOzrlMwPxPxbR
         OfbtAB/hKCa2bk5/k/W6DbAu0+QHC96nkXbAARGhA+IBL16yadJb9zcChN4oYfrvhoZM
         V1q4seqrqhkC0tugecwqLwxwsB/FeXPHApMtZ0ZNZzDZ8iAa4R952N+aQfQeXodrOjA0
         vNi1mjvGHco2OkFQnTW4FgVyL/moZyLdQd4bD0hIMfdO7qOlYVpW0/DjH2jRWTa5AWjb
         3l/Q==
X-Gm-Message-State: APzg51BjJZ85C3fi6ppxJsAbcScQ5bXVuzeEEgLzM3Hzul8XOQFGCFth
        bg3485SbocTytPtP+8ZT8lM=
X-Google-Smtp-Source: ANB0VdYhlcIdxIk13NqnuVtKSdI2MnJEZ1y776Cx47R3Q6YYuWJ4e0r+t4sXdpC8xJ31nTgyCLrO5Q==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr4496423wmh.22.1535968930273;
        Mon, 03 Sep 2018 03:02:10 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:09 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 3/9] dt-bindings: ata: ahci-platform: document ahci-supply
Date:   Mon,  3 Sep 2018 12:01:55 +0200
Message-Id: <20180903100201.23131-4-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional ahci-supply.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index b88820b4c01e..f495774c8af9 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -33,6 +33,7 @@ Optional properties:
 - target-supply     : regulator for SATA target power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
+- ahci-supply       : regulator for AHCI controller
 - ports-implemented : Mask that indicates which ports that the HBA supports
 		      are available for software to use. Useful if PORTS_IMPL
 		      is not programmed by the BIOS, which is true with
-- 
2.16.4

