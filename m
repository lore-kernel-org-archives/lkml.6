Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C70C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9633208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz2VwsMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9633208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLGK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:59:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38285 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so3180838lja.5;
        Fri, 07 Dec 2018 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fLoiTVe1PGD4LFoFRq2Qv/NjAagyuB4tnQwb7zM8mU=;
        b=jz2VwsMBWb5hlNiLzcPHyV0V3ZkNOQfTivPsceawtsb77KnNBPmTdgK9ypS+JwZCs8
         pC5Enzfcg5bCmBWn9SmZ0JttUtLO5f64B4Hbge1jGrKZJUVePZUWVDJQhTbZoT6T6bhy
         twxhf2xfZvDsykOeaP0MQybTwgaCj51syHibQ8ngcK85s5YRJKS3mPS9ciLhUoPS8UQU
         aI3Y6g+ZrEB7d/qkJ2bn0j2kpdr2SIGgwAmjIEjz/h0FS3sRpLy7vfytBS6re9KY3h1z
         gSMwNY3w85ZLNYnKWYhe8IrxopWGkt569JvTh/MPxAAD5EKjmD9Ll9GjZw2J+aLn0ESm
         kCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fLoiTVe1PGD4LFoFRq2Qv/NjAagyuB4tnQwb7zM8mU=;
        b=MeRBqVskgLULx3thZ9cRKRMCAQi5OHmp54UFnfl6kxEDUiae9dv5WEHcfiOMu2lGpI
         k2dvBimj+Oc/2VDmWjqMBSS3FhtpP6mn8ypP/umrREXKXwW4YfHEfK7wfuk0EveiJg5T
         RJQ4ZIfKpaRJ5T3QedfZsoH70Fp54oPNfc0L8DGby4JYmKueJnie/vDpTINvw5EX7V/C
         gwQNfl7aWryio6kBuQaFa/ioPhi0loPhXNeUzFW6WMQFY37Hk/BsEUtrWqgdmEQatMYZ
         rPY06Q6E2F1FP/ZjGCgEMPTiNdoj+WuSrk0wnQg7OcdYKviTlvffxYvpl8rHnUwXk78X
         3++g==
X-Gm-Message-State: AA+aEWaXEWtHrju8Q1xyoOwW22ddQE/FBBGc4l0hQUGk3Rlkdhs9JFaf
        20yg7CBIs0If6srDuCT/f4s=
X-Google-Smtp-Source: AFSGD/Wp3twNS6KmHvKQqanoVkO+Bpca1OYp/kk4YFerTEt8UoDLUwDydymm1lkloM1/tEKjA8nXQw==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr1163887ljl.3.1544180302504;
        Fri, 07 Dec 2018 02:58:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:21 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 2/8] Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
Date:   Fri,  7 Dec 2018 11:58:05 +0100
Message-Id: <20181207105811.1831-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

Document compatible for midas touchkey.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 0c252d9306da..dfb3b9f0ee40 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -1,7 +1,9 @@
 Samsung tm2-touchkey
 
 Required properties:
-- compatible: must be "cypress,tm2-touchkey"
+- compatible:
+    * "cypress,tm2-touchkey" - for the touchkey found on the tm2 board
+    * "cypress,midas-touchkey" - for the touchkey found on midas boards
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
 	binding[0]).
-- 
2.17.1

