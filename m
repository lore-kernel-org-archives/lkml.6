Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3CAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404AA204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2DiCyxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404AA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeKGHfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37326 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbeKGHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so8809957lja.4;
        Tue, 06 Nov 2018 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0oCYK7L5NJFwm1Z3WalSGQRB9n5Xjvb00dQG1zHWUao=;
        b=t2DiCyxyMEELY7uYy7oTSD661bD542h53+usdkVvD9sRGLWZ44eb8bbQWxnyZoZZ56
         V6hArNkPxgmrpzA+XGjGODZbvSxw0FDDUf1W8p7Ik/4wXaFThMMpLDcEnzsvBnokJHwQ
         PY/jCRFMlHHv+sXxOG9RPlDlsYbXD4Thb7nxU9mqWwH4xpWR3dcGhPbw6gUB5v8c/Yai
         oFWXHjz21U2OaM5CduVahCI5sFpzmiyZK5qi0NE4C7nZxMTwra72iuVtWtATJAZX4BP8
         hsHV5gyQNhzM9bImvh9xLN93t2nSNI7m2721HiFI1FKOPqU8J2YBiVaiDU+LGuWAf0zI
         5kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0oCYK7L5NJFwm1Z3WalSGQRB9n5Xjvb00dQG1zHWUao=;
        b=taY7u7zMX8QNqtz1vlPGLIgGnbCP3hMoWgq+bMkrs5oApQEW7ZFtQUt4JFOG47p7He
         651dibvx/Wcb4gH+k3DXCzIAkLSNbQPkalRbHVvw/gAy38IS8lHT+pB4pBuO3B58UPgM
         AC61gRYDm+ggPy4jZs4ATZwBMCmeuJ9vNQXbXUGgVozutcaje5Tk+x+JR/uw61gKJb0n
         WhZqBuihMvWD0yi2aeNBqQ1s4oGws/4R6afLUIvjXElfSFczTo6OsBEUYA/agFKU+t7y
         9Dqiq+PYGGCzIGhj8vDHCRjhuqdWnmrlEPCfYPL/E4fYrPjVN1Acxv8b8k5INb6dn0A4
         xjUA==
X-Gm-Message-State: AGRZ1gLjUaAcCNkYtRFQcqZuJOG1mi6OiGrytth2NwhJpFImhULg0zts
        bTECB5sVazL6Z/i29YXCedinMQ0h
X-Google-Smtp-Source: AJdET5fqj1XZ2nh65gmxUchy91cNGNgrTrkCTtS9GiPHRxqzvtqMbiX6bhvU3/F/sjWnuRWhi0UFyg==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16-v6mr9415924ljj.164.1541542073899;
        Tue, 06 Nov 2018 14:07:53 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:53 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 05/24] dt-bindings: sc27xx-blt: Add function and color properties
Date:   Tue,  6 Nov 2018 23:07:13 +0100
Message-Id: <1541542052-10081-6-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
index dddf84f..5177479 100644
--- a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
+++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
@@ -14,7 +14,9 @@ Required child properties:
 - reg: Port this LED is connected to.
 
 Optional child properties:
-- label: See Documentation/devicetree/bindings/leds/common.txt.
+- function: See Documentation/devicetree/bindings/leds/common.txt.
+- color: See Documentation/devicetree/bindings/leds/common.txt.
+- label: See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 Examples:
 
@@ -25,17 +27,17 @@ led-controller@200 {
 	reg = <0x200>;
 
 	led@0 {
-		label = "red";
+		color = "red";
 		reg = <0x0>;
 	};
 
 	led@1 {
-		label = "green";
+		color = "green";
 		reg = <0x1>;
 	};
 
 	led@2 {
-		label = "blue";
+		color = "blue";
 		reg = <0x2>;
 	};
 };
-- 
2.1.4

