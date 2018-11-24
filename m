Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9846C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7896D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5P5HdVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7896D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeKYBlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:41:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41855 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeKYBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:41:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so4192742pgh.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dTUZi6rTdpQ1F5N9zxpSCRC4SoFmApcq+FhlMANmNOQ=;
        b=B5P5HdVC5at+pZRIZHGOLNzhJEQpK0IMbfJQb9s/KtmFyTXT8rhVCyXjjkx3SFKaxz
         ZUuC2OHqTI0t8ioak5E/VX9KmCmVOiVuMpv5SDYtNjXcmwjqqQJanAvwoj8UG+JxeVJU
         NQnrfn/0jUzHnM6ulEUvmokcQEwjJsqXRCVfl2plbNU0PDqyHBOZQPfwJLXlMr46/V4n
         xOcpOadmTd3IH3endb2lTQh2wNO3VuSgW0iafRvbbxH16MrJJIxSiquuyEBCBPD8+kfA
         Z2Gv13hwkADoqa590GGMprXEm+R55xKSlRXorDrwmbsStTdbSS2KSOPHluaEf3sXX2qW
         yVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dTUZi6rTdpQ1F5N9zxpSCRC4SoFmApcq+FhlMANmNOQ=;
        b=gw9UI2YZEFVUgtPUAs0P54XItisB7NqbJkYYt9Y0RyRapSl4u/dHmW0X2E4iL6BETn
         U/tgTz9gmAybdEu90X9+G6BKDqQB/aNxzy2QdUVWBkHjzoJmtOXZAxlQbVzjfRbjbqXp
         3X/4X6xJDx0lG6OXGhPfxeXGiX31KRnck35QgaDQFv/VXc3RHXZZowbKG8NOsy7gdLLX
         Hqr7TeT/Qu0nXCqGTYEybeYGkBLOpreodzjy5i3VbzzNLRymVm+/0r9B60dXjKSlbBnD
         bz4xv08QpiefshGjFceQ1nSBAnqUNcBMYraW0Kqh3g5+Q8yUO73oaDQMG/a/2r0Q6E+W
         WbGA==
X-Gm-Message-State: AA+aEWYE14ROWzXVftdJ6enbkRQ91mVvfQ6AaiSxxFfzBujoMGRahNMO
        /+2nm9rEdVoE9+2OMDdgmQ8=
X-Google-Smtp-Source: AFSGD/Wbf7esdOVICA07BmEF954p5ECitMyLPwor+yW+W7dwl/5hOkzMYw7pGZOx7cd3Po/cuHnDKg==
X-Received: by 2002:a63:d301:: with SMTP id b1mr18206246pgg.61.1543071151621;
        Sat, 24 Nov 2018 06:52:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h7sm62476146pfa.105.2018.11.24.06.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 06:52:30 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        treding@nvidia.com, olof@lixom.net, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node reference
Date:   Sat, 24 Nov 2018 09:52:23 -0500
Message-Id: <20181124145223.29208-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_brcmstb()
doesn't do that, so fix it.

[treding: slightly rewrite to avoid inline comparison]

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-update changelog
-slightly rewrite to avoid inline comparison
---
 drivers/soc/bcm/brcmstb/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 14185451901d..bf9123f727e8 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
 
 bool soc_is_brcmstb(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	match = of_match_node(brcmstb_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
 
 u32 brcmstb_get_family_id(void)
-- 
2.17.0

