Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F73C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9904F204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laCzalge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9904F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJMMbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:31:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43478 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeJMMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:31:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so6807710plb.10;
        Fri, 12 Oct 2018 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=laCzalgeYZJRzC6FMlo4fpiPie/6r4Hc6a54c2Uj5Hy4Tm/eJIIPeV8VYqS8RF6hra
         O6Sd6K448eGR9X3uAylMFx1KvM71hnf2ozfenx51hRbBkSAJ6Qci6OR0lVnD2LgXg+b+
         XyRzB+Zu2fsCRgO1McEDf2qQaMo946NU8/B3R6XxQkuzlm+5YptElzE0cowc83msF67f
         dHgEKVPRvqBhwepF8w3OLN65+hVj95YJgOghfwuvh7f6V5qGd8cj5RgkD8GCgomwVsD5
         B8HnEls8H+wOP44MonWpzw2cWxSk4YCeeyOrx9iCnZjtOsmkKPATNgrwwc72c7Kj8geJ
         btuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=INrLImIBHql1pXnmCCIHjaV8l0ddvv10dqM56eWdnik4tw85mcXaxOUypJDsWgLkXv
         hZZ9/XOxqGLZilZtJlDP7IZWBnsxrU3xNr1vkmSXUoZskKzMsIFoGAEAh5zOWJfAnhKU
         azzaJIDaC0RufSfluo5fL8U61ZH9kko9vK9oqQZnOjKsXswZOZHa6Ry9wNj+DgyEOjS/
         kcaT++QrFMg2u+rsVM3BhTu03oALmevFfjJvqGglBZMbdjC5AWRdBE0wae+K8pb4tfyj
         egzpKwbBphvACkzA97s4z75Niy4UyaVoaxq23bZNxqZupzMcPddvGb9+zheUf+VtvRXB
         z7mA==
X-Gm-Message-State: ABuFfohreOOP+w3+mNtubi01NBCah96H63Af6I52qMF9B1mStCL67Q8b
        yobpnhnb9tlQPLCDnc7gUJNihHAE
X-Google-Smtp-Source: ACcGV60a+yR4EpG1SMpmYOMGAUCaS10lPN9HlFu3ryMd+1zTThUgX1zRE5ZfZNkndCb0PyND3ZFxhg==
X-Received: by 2002:a17:902:6903:: with SMTP id j3-v6mr4683450plk.74.1539406522244;
        Fri, 12 Oct 2018 21:55:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:21 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 14/18] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Fri, 12 Oct 2018 21:53:34 -0700
Message-Id: <1539406418-18162-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Argument unittest_nr is not used in of_unittest_apply_overlay(),
remove it.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index efd9c947f192..6d80f474c8f2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1419,8 +1419,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1453,7 +1452,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1489,7 +1488,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

