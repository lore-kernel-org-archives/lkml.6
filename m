Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AD9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BCE20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BCE20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeH3AAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:00:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42482 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH3AAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:00:50 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so5272979oib.9;
        Wed, 29 Aug 2018 13:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6acmOIf814fWqqK/f7NGrp54JZdrio6ld6qbrfdmrXo=;
        b=VaPCRhrByb6TaflxTLtJp0Cgm9hbPEj92JLwHkSciCwi1b/Z0VFbgPofu+SA5mmi2c
         jqENhng89Mg9YG5ppvXDiKgJCz/ohSt8TOGiNh+BQJwmInBraBh+XdGYGhRY5OMaBP6t
         oc6nBXtejJs+oRa1368089sMaoJDk4HfE3qoI78vMffAV6baa+cR3HeXH+9fK0+vJp6q
         7Pw59hPc93xTM6FvZpuGBBHKWvjnB2MgScdBT5JJbs04+5pMXj/sCQVGwRM0fOO6EJK5
         MgsrTR46nLFuGpz60hrSs+p+9jz0FZP7jhmAXbc8l9VP3JSLMyfKTNtILRBUow9G+6X6
         kdLw==
X-Gm-Message-State: APzg51DgIpbhpoaKkYoc+2IpMDYQ4mejsRd62FQjpAClfGHOXBOa0XVt
        a+5KDLO8tC7NnQWfa+0laQ==
X-Google-Smtp-Source: ANB0VdbreRNum0TvQWesyki5FZwzT51vPvMHQbnosI3xVJ78KMeaoxlELhspYt1AzEqS1GRqDWNmSA==
X-Received: by 2002:aca:e30b:: with SMTP id a11-v6mr4442626oih.303.1535572942865;
        Wed, 29 Aug 2018 13:02:22 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n84-v6sm3002331oif.23.2018.08.29.13.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:02:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] hwmon: drop unnecessary OF name NULL checks
Date:   Wed, 29 Aug 2018 15:02:21 -0500
Message-Id: <20180829200221.13492-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the child node names is pointless as the DT node name can
never be NULL, so remove it.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-hwmon@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ibmpowernv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 4935897f1527..0ccca87f5271 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -458,9 +458,6 @@ static int populate_attr_groups(struct platform_device *pdev)
 	for_each_child_of_node(opal, np) {
 		const char *label;
 
-		if (np->name == NULL)
-			continue;
-
 		type = get_sensor_type(np);
 		if (type == MAX_SENSOR_TYPE)
 			continue;
@@ -589,9 +586,6 @@ static int create_device_attrs(struct platform_device *pdev)
 		const char *label;
 		enum sensors type;
 
-		if (np->name == NULL)
-			continue;
-
 		type = get_sensor_type(np);
 		if (type == MAX_SENSOR_TYPE)
 			continue;
-- 
2.17.1

