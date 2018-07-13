Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78449ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310DB20843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BD4O1d9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310DB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeGMLRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42274 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbeGMLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so5141857wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+Pr22z7gcwcRrc3DFWtpAwguI36mUCJ8Wp59R42JYw=;
        b=BD4O1d9wpYkAisT1wQQ3Cg6i5g+PBcpG/Qjq/do8Sq445EtLFNXN9+6G/v9F5bp7Ga
         Qt7dZBzbd0G8qIOJrjVnoLdjGnWwLcBJuoFfYYXnT5/x7bf5pBT4Rz051D0SJ4UxBMT0
         HRU1IHPx//Tk1eFriuC3IeVYevMHXHVmXoUrdgqQE461cY0S6A7BWIp1q7vM6cqAY+zW
         dR0j2l9NpLWwrT2baRK11p8vd1SxrSjHfoPI6Ibn5zcqDGzQ61r3IHs+UB3NVaeTvcFQ
         wFaC9ZSNMbJpFYq5cQlrUVmwRvWl9jMZn9Sa/3BWSI01VkjMYazltVWK0dJSeSRe5AyW
         6VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+Pr22z7gcwcRrc3DFWtpAwguI36mUCJ8Wp59R42JYw=;
        b=UT1wgrhMfLAwztp+tz4ZA1Y4c+JnwL6xI9EfrRMJ7qJbBrzZetl2D0zcSN/kYc+3sS
         zazpmvZBd5D3dZq1I3E2l1+DBjnVQpjI7Cle/Rmsz6es3yBj7sgRYcO2rvWydYosdVXd
         K9CFSYE1kIQNsRE9ZtqRa3VKDCT5czx66Y7noDhi6FdhvZEaqJWCXWPb27LAey49H2G+
         odswCMD7ZpWJ7bVhHQB97hCww5HFrIfDt7eLtQMtIxfDyAEerYytuL5ThkdUkdwkcCCp
         Qu6qSARE8840wvFrDVxoyRSSoQL9NakP6nT+Xs5koH1P6MCLfZtfPZ+iL3mlqqhtDbnw
         LCzg==
X-Gm-Message-State: AOUpUlEv7K1ZtB58nQrn/S1cu5K2n2fQfEqUcEzgum4Vrv26mIN5viEn
        o5TbcKdSMEUC4mNeTEGlXtK9PA==
X-Google-Smtp-Source: AAOMgpclcmip+8aOH+SXKtXHKpXzHbS4JqX0h4BIZjV4CJF12JO8hBXrWH8i1+5RWVT6DFw1H3LXjA==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr4407859wrd.218.1531479798143;
        Fri, 13 Jul 2018 04:03:18 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:17 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI reset
Date:   Fri, 13 Jul 2018 11:03:01 +0000
Message-Id: <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional resets for ahci node.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 5f362af2724c..a5281d7557e3 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -34,6 +34,8 @@ Optional properties:
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
 - ahci-supply       : regulator for AHCI controller
+- resets            : phandle to the reset line of AHCI controller
+                      If set, must have a reset-names set as "ahci"
 - ports-implemented : Mask that indicates which ports that the HBA supports
 		      are available for software to use. Useful if PORTS_IMPL
 		      is not programmed by the BIOS, which is true with
-- 
2.16.4

