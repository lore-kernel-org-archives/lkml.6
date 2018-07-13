Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A25ECDFB3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A320871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F1wxKGd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39A320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeGMLRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55861 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeGMLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id v128-v6so8376049wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIrLCVk3WV7PfwjgVa3iXAVs17yODr8EjHYzi7ivObo=;
        b=F1wxKGd6xKcYvrKG5B6sBUNPtH0LVPAGKOsyncIGxamHRWtXOw7GxCAFjOTUM/nyQO
         uPs22aGRu1kE8aPWLu6LWSPMK8th8cAtYsOyyWSBC4QOq/jhvMc1rjBSXUnpKCOVs3qc
         DiQDmbiu9+jfCCDmB1VPC1MkvsApHKfPYu8YSqDWgoyUSmOdTtbMIXzZ8Ch5Vu04IqAk
         GgB9xlXQzDRim5ucvn+3C5lm7WWcRKnuvnUNWKX3OrFb04tXS05AI2tQ/0sBijERswXq
         mhe0mxXQXiQQKOXc+eutc840PHeZ+wzeKLTq9coAMmHNS5O+NGkSRHvJHUsm3n+KwQv/
         AXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIrLCVk3WV7PfwjgVa3iXAVs17yODr8EjHYzi7ivObo=;
        b=gSeHDeujU9cNl92Dm1j2PnY4wfrOFd/r9hYNZ8R48r+0juy/bPYVaIzmciIQ567BSI
         U5cJA8+Y16O116t7ykWvseVlMdOenNqKcL8Mx6GIFFbrO684IBuOGa/8yRk1Z0stMstf
         Nj7otQt08d9ad0dY56TrtYW29+Su1tzu/0XmhUv6ga8ATqIGm8oQCZ3XIwsxJ4+jQUe6
         G0kPZZ0R0bLkY9PVxR4Ev+S7FQjbHA0FY0/7OAWQ6H0SRuG630/UnkkjbZQhE9PrJvaj
         y2it0pgS4YUi9ce2vAjxHotsj8bZvx2ecgCJvK0N1eq834lR1aJHmh13FQq8rJ5ZW5aq
         1RBQ==
X-Gm-Message-State: AOUpUlEzXhPmzQt71VoPBcAUU+WDJKQVBWxm2tmjI2+MK9qVTmBi6+WV
        8bQ6YoMp2w011phA8T5rs1NHMA==
X-Google-Smtp-Source: AAOMgpc+hN7TjdWDyb27fHqHavLY0x5wEoVE1Sj2FgyrFKcjMx9wUZp9X7ksJ1X7c297/F7Bgjq/qg==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr1346359wmb.16.1531479799007;
        Fri, 13 Jul 2018 04:03:19 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 5/9] dt-bindings: ata: ahci-platform: fix indentation of target-supply
Date:   Fri, 13 Jul 2018 11:03:02 +0000
Message-Id: <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the indentation of target-supply's ':'.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index a5281d7557e3..47652521a6ed 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -50,7 +50,7 @@ Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
-- target-supply    : regulator for SATA target power
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4

