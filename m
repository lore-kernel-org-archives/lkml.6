Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B93C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD252086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSbgr9om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD252086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeLJQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:26:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33214 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:26:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so5488434plo.0;
        Mon, 10 Dec 2018 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zbmStDBNmYRujmWOzPMjCrtqy+G4MLvgr+sv4jD/SdA=;
        b=QSbgr9om9u5opOgTyTZhKtKqHSXcep7JiYFmz3zpcY4S2L/qGGhwXRxsel/D67ndVx
         OOumnuhs2kZho6BVTmN1eqm9xmqsJDDTiSwFInOdFL1Vd1/TMmISEqGg5D4Jj/iQ/cJW
         08Qp/BvedocA5i89Utit4K77JW6yC2XI+YNmyUrlMIqUKhynkEiC0cy9dqWEktSSnOfQ
         TriqCIYoNqUKH3jyS4y6pVWEb4RXoE5eGkFLQadDiNn8H+O0jqeXrF1mO65urbFnw+P4
         vXerdqqWZbrPCUKeKh5b6wZTAuNje+QqnZr7p3vUD56qpkfcU7fZzrcubwaF2DyQsyOS
         sgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zbmStDBNmYRujmWOzPMjCrtqy+G4MLvgr+sv4jD/SdA=;
        b=PjH8b9dOAQ4bASXyqql4lU1NZmQ2IbWIICur/nCHw6La4qAtHrlkKkiCD0dWhNSxxZ
         18VGc17wpcgJbFbThdZG3CDkZs10NTjAWJpQ3JUoTUld+lxWOl10U9B2G198qXRnWVPz
         GyE9RfUOV8e5OhJCi53FN2UOIM3XSJ/wrvz2y40BFW0vZsiz+E52F2qF1uS/ubsr8Th8
         ajRJqUD8eVhWULY6ryebN16g/B3XPDXdp5/yrRANCfFRV2cRt8M6bGWm5Aj7bSm7Hmgw
         2Rq/9VY/E8WrhXIZz9oexQQA1aFtQ6ffRpEzplxrTKLnioVzk6SqDpCHy9ecMojLW+Kk
         L1PQ==
X-Gm-Message-State: AA+aEWYRhI/v8K9JuSUk8VWo/QDiueN+7i8pSulGB7ST3jkNXLCm/0yD
        +7LtY+EEel2SRjNpPA+zzGQ=
X-Google-Smtp-Source: AFSGD/XPYD3BN+bTIY5M/hlctqELfsTaJAEUf1sroItPS9sBMTlo8kq1Ia6DRr0RAdeuFZcc1d2Ljg==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr12157224plp.69.1544459204050;
        Mon, 10 Dec 2018 08:26:44 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q199sm19875892pfc.97.2018.12.10.08.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 08:26:43 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org,
        rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
Date:   Mon, 10 Dec 2018 11:26:41 -0500
Message-Id: <20181210162641.21029-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v4:
-update tile
-refactor code,suggested by Daniel
---
 drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..b44476a1b7ad 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
 {
 	int ret;
 	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match_id;
 
 	if (!root)
 		return -ENODEV;
@@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	match_id = of_match_node(compatible_machine_match, root);
+
+	of_node_put(root);
+
+	if (!match_id)
 		return -ENODEV;
 
 	if (!mcpm_is_available())
-- 
2.17.0

