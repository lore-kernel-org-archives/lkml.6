Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76190C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31120831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNDRHd9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D31120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeKUCos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:44:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33419 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeKUCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:44:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so1116120pgu.0;
        Tue, 20 Nov 2018 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=icG4bmiET/r/7w70hgZxOnB5CF+WQudUNNBCnkqQen8=;
        b=TNDRHd9/xDKOUVPUah0iUJUSHs5IqJdqh/1nvWB6IMuq8zQ/+PXeRc7kt65VUR/znY
         jCJLAIar59VsQ9bCwXz7eMUYeiIsodbIAaFRSq5uu+s8fHiezT0EvlWPucBs+kvRRpea
         DHeL+dNJjwHsa3NkwIsI/qaT7OM3etdiKMcl2vvcpQ3PDvSSMvTv/EGteYlSniO5fxw8
         8IuKpzfmVMnhG9M7NMPBhIdyLQyVm7qGRFtIIaqZEBJh1m3lot2DMi83NAADKrY4aDaF
         1iI5bEAbN6aO5XPxaskv2t5KqGU464HCJzRccJzHeRJHKm9dIHTvxwoARgUfk758Asss
         tksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=icG4bmiET/r/7w70hgZxOnB5CF+WQudUNNBCnkqQen8=;
        b=TazSgnMbkSLj/+gzrNqlsFhIUapsBykq/3oMHCMK8zmujERrUZxTHoaUqH5tmK5NyV
         OqiFnlBC0LLcr4DtVs1apjNMe9baEWiCXXA1/pfA2a5jx5JbF08CXC5gswaRnTq2G+s/
         zeg0vZP7cDzuLc7mUQhwlCoVHCgBJF1mKe4E/2ZmfUybztEsP9u5v1Fwwz6Z6BfgbYsj
         iYxJuLajueseX3VoplNsBDGLS2pVxEEUR0sSqYiYXF8QbI3/LGHwc3SLKJhZb9czmdi2
         vwGij5fJ7UtGk6/mYTovDcDjKT0ZTpLj0n1oxo7PXKoKJG+8FDGufOlQInI0M0ixGOp6
         llRg==
X-Gm-Message-State: AA+aEWZsSc7JtnL4F3aK8gsDnhM32oD+48arL7+uwNOiwpoUCrMlBXQP
        YSLIUODNP+vR1y/oMnMeGJQ=
X-Google-Smtp-Source: AFSGD/WtM73/BJgnSCAROjbR2b6hNKqMQ/HLyAZ5mbBGWUso4hk3o11xBXD2rHsD4zkU+VFclA/gPw==
X-Received: by 2002:a63:4d:: with SMTP id 74mr2528264pga.248.1542730494065;
        Tue, 20 Nov 2018 08:14:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b2sm64565196pfm.3.2018.11.20.08.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 08:14:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        lorenzo.pieralisi@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date:   Tue, 20 Nov 2018 11:14:51 -0500
Message-Id: <20181120161451.21149-1-tiny.windzz@gmail.com>
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
Changes in v3:
-update changelog
---
 drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..650f063ef809 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	if (!of_match_node(compatible_machine_match, root)){
+		of_node_put(root);
 		return -ENODEV;
+	}
+
+	of_node_put(root);
 
 	if (!mcpm_is_available())
 		return -EUNATCH;
-- 
2.17.0

