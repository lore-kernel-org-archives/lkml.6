Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F5120856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms/AL1db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F5120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeICOVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53667 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeICOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so547090wme.3;
        Mon, 03 Sep 2018 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6iCbW8J+KgHVaSl644rAO8j84rXqhGHUryoNJ+DbzA=;
        b=Ms/AL1dbSwu/6OkcCoXkniJHuTppTg1eS/iAfsbHlJ4Igfren9etlHtyrmUz46G8v1
         m5sOK4cOjhvE5gmLsm4B/yx/f3y8G9pf6oL9/JibL4a3Uw+ivm0U1VeQb9/JdawLRP3t
         23ryPujptKghn7ly2mJ2FmLVXW2Mxm8oPKa9RJPLyvLxOH6wBNFC70TDFW7Nu/P1qD5G
         6r2iRj8e7ZLKZKHgtqt/pW9+W+pC4jH+X9QgbL0W5eUesmDNFFOqyj3v5hCkdnu1DwYN
         ovhbadxfujnJSB6IHyflzPjmAvD/b140Z24hhQx+VgQU83T/MPPI01E0V3h6dBo1u5wv
         YOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6iCbW8J+KgHVaSl644rAO8j84rXqhGHUryoNJ+DbzA=;
        b=aq3hjJlWlApXFzFrzHghEss1izgGzH985Q/9hk+kHGFjxODHfywmLp/rcVpYBc/uOB
         i2oFewibkMKRagIL2rsrQmLfKYVhr4vzNHDRVkRTF+RhoSNKpPzExaQFsZcmw+n5YeOc
         K2mbd2sa24V2dxJzzJM2zUJiDHmPKfEkAYJpBQZtT/YQVrJZ+bLGU9AY+cEPv4Qm4sJ0
         6wN+ldzRyy/oTehHqV+7UDEioDZOpdaxnRrsm+ZmGPRh3bfP/yRtTQbY8IDujLigxFCd
         9jUoErjQA29m38+iykZk4TzizOfqJQvns8ra2rckrMl1f77//fXzS/Acw+L7pesSHDVH
         lLmw==
X-Gm-Message-State: APzg51Ajw+EvzC+3bwo8eDhLd3M6d2WOUXiHCSzr++jLGasVzq2pn9fl
        m41VpSs/x0uyeH8UCZ1vfF0=
X-Google-Smtp-Source: ANB0VdYyEQP9p7oEOTJkZmuWF9IdDN1AzCi5TwwUnzPJub8vTSwG4ac49aFeYlkOajQT/IDi45yZLg==
X-Received: by 2002:a1c:8145:: with SMTP id c66-v6mr3739310wmd.139.1535968927560;
        Mon, 03 Sep 2018 03:02:07 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:06 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 1/9] dt-bindings: ata: ahci-platform: fix indentation of target-supply
Date:   Mon,  3 Sep 2018 12:01:53 +0200
Message-Id: <20180903100201.23131-2-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the indentation of target-supply's ':'.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 5d5bd456d9d9..b88820b4c01e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -47,7 +47,7 @@ Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
-- target-supply    : regulator for SATA target power
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4

