Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07412C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73C82081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF1RoKj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73C82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeKFAr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbeKFArY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so4362569pgp.13;
        Mon, 05 Nov 2018 07:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
        b=RF1RoKj9b56ji/qE+jG0GKgkmnP7aOu7eVCDxnQ0rLdSFWIaWvnGAY8USxdBEU1pnc
         BkuE9qRekDrGO/mHsnr6F9N2Zo4EGVqyDBBe/cusQy0NNgxJzRy00M9D9bFIxGNe5aDm
         J3AOYsrdcW91VY8D9FJ3bPydS6lVjuuyKWccrU4IBW0BQfOYAt8TcX52kqauKx8MDLyf
         B24wiPHCMcQuTKjXAiwZ3NEld0QO9c3HnJ9bydglZne3pY8T7pXKbdhBSinCqRmgtMM9
         LGnbm0GAxGdNfrkmpPbNuiDBCq51Zo8l+HKoM2VwKTkIB/n1FRM8RXtFwLcPoOZb5GxI
         nzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
        b=V1M9s6ruMXFhTFyIbluiAe6NSp0ONnTrqmu1KHQtxv8A3uOR6X2PqIFxFgWMoKwoSi
         mUTJDOgAvbc1camoFhJkChSmvN74K0XW0D2jh1Zuf0Wq/RsEl2yfhl/UkWKUBF/LOif+
         MJ9QpiQMDX7gpa0xgEe26j/4OG78TSQdEiFDpTnhi6AXAaw9EwWIXltVvu/zW9GYRN3C
         bwpnYePO9l6lItgMxk0ghHo8XMDJ4ci1npgez3yrxHQIEaJ99sO9kfXadotCLk5j0xyg
         bu5ydlB39rfyJ/FJKhAj8KVGDroQV2SHnw1/4GQUCE+kAQVs6xJls8qZ+quE2RsATtpr
         Gs5g==
X-Gm-Message-State: AGRZ1gKxTopYlFL4Akvu8w8wlXO393sE10H6yDdPls3lVHsZ5uUTPTKM
        gUY3iyq3+yPB6rwYEvK1YyM=
X-Google-Smtp-Source: AJdET5eSZaBPAahA5SnMhMZpjrw1UXLfaCpcvEZlSpPiO0D+S/eTKf/7Y2/Rbq/90PSkrl6vx69otg==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr20519904pgb.56.1541431631103;
        Mon, 05 Nov 2018 07:27:11 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:10 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 14/18] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Mon,  5 Nov 2018 07:25:11 -0800
Message-Id: <1541431515-25197-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Argument unittest_nr is not used in of_unittest_apply_overlay(),
remove it.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f0139d1e8b63..14838b21ec6a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1433,8 +1433,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1467,7 +1466,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1503,7 +1502,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

