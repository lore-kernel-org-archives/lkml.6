Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42CDECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6501720866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feiwn75i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6501720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJSGwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38511 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeJSGvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so11890769pll.5;
        Thu, 18 Oct 2018 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=feiwn75iOpLnPIxs4gwngqeqa/j467bmhlB2Z3uiZc+9axbLGlQhWWo1/6fZWU8ICv
         12+8OEffuHNDqGZLDFi7OgTPxddu/jLyY4SF4vrQMxBEnZQAQKPzLgqacySUHlfQIIRE
         LE6mtjBy3MrJEjCchhPX4zITZi0tJGSvTtJ4XgQqFyVQIHUzcNV05faKh2SrXGbe+Rpz
         nZIY7xucyuDVkLbGW2z0ZNIQNLG/hF1qPbFPdA3u0YtSel3Bga+33KT+3n88rgOaEKNi
         wreGa02i6qGfuXn6ceV25RTr9FflMrpZnbgj9im5D4rzA5HzIZWCu/sY48qbzeLuIhyD
         EEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=rX/kWN3hZOneG5jj5mlYOv0VAxsyBco8w+rKrhwGX8wnYg0PZC35YRaPlElrZYppFf
         klWmXF1yLHL5xBIMfaL7pZXLWvU5NbhhupsqGITllda5exaYezNUVASt66NjuwuJbO7N
         Hc83VIAWDCYL8NYzYMyGSOB4aVxlujZ3qHCC70thEo6BiF9b4cPqHUtxyEzw7YKxsjid
         teu5ejb9PrR9IgVGi+zRCC7CFrBJN+ShbtqmsnWJJtM07vLxFALcYPVEVOXFUKMNowHS
         fgRncNVP19K04L7oG/RUY1JZVsDdecCeu5KyyP+vnZx6mt432Tv5uZCnx18NdmFdr833
         LRPQ==
X-Gm-Message-State: ABuFfog4aWUSMX1PxD8z8iKzbQDDeVewq5tiN0Thy7ySgfrmT9482WX1
        I32iiryWlyMLLnK2o700IVc=
X-Google-Smtp-Source: ACcGV62Y4tBdznBiKteTNtZjqmdZPyj36bkUeDWr8tFt7RnWlFCWjtWwgfBdAQeny6esRrZYO/SyWQ==
X-Received: by 2002:a17:902:5993:: with SMTP id p19-v6mr31533651pli.260.1539902901231;
        Thu, 18 Oct 2018 15:48:21 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:20 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 14/18] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Thu, 18 Oct 2018 15:46:32 -0700
Message-Id: <1539902796-8382-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

