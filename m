Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4901DC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73620869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbnB9x9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A73620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJPK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:28:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33766 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeJPK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id 78-v6so8272593pfq.0;
        Mon, 15 Oct 2018 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=sbnB9x9bvtv7VDSSAMjGXcvQrF/l5xTHVstk6hAqmIcw9mpARCvX+OSlzY+cTE4Mma
         KMS4zR9x4FmFVDJbdrcV0X/GNMauQwLPdWKTne2JC5vP7p90HgWviUHwTT1y0BR1alBK
         VZpkPZmiV/8TnDwQnAO6RGFeBtaMPw7dy9kdXbl7p53JOUCFYuu6PSINQKYFi5vgNar5
         LpXEQC+MMbhR5Zo6Hb6Gqao0AwgKg9DiysMQDx6VzLtLrkgijOaat+k7kmMI/rQu60vY
         msULaOcHlWZh3Hlzr/bop9t/+HfHVn3nizZioIcXc94bw6K9n/vgaB9TrjdlP+AIu4gf
         1hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=Ub898HN4Ci4ED2fSZEJnb1ax6oPK4hA6UB7yS8ZKfKFOdQhjYsajl9uXP1E/Q8xBAb
         iAq1OXS+AClSTn0UzEJLTJWhdNJcBrX/KG1+9PvivbuQvyxbgwZthE0GNIREBSRR3GSU
         ayrOtokXG+p6h5GHcpGJpg/TaxXmfXeBt9H4cLfRIfeQooR4kmH5eMVwOGH4f27GnUW7
         yx0dKTZFtoV9I0GS9Nf9p8EpfjPqE8DCOCMZMvIbW6kfjUVYftmYzlmAXkJTWhwyYo9W
         ayOLBI5z0dU1u9EAbPDgPjP3knXNdkLXVqxWUMMk4TSqYQHzd18fHuxoGQuVOn1fXm//
         cVpg==
X-Gm-Message-State: ABuFfohu7ZopGmt/Dm997J0tgmv1xVAkacj5NhCnclfhzUnSrh3/X6/Q
        XvZKONmYuCHkxO1jQmMb2jvkVWeM
X-Google-Smtp-Source: ACcGV60FD4fY0+Jn0o7r8yLIuM412dd62zBkLv/B/k5hkURgwi0u29Z2lyncfamSUpkqJziuE7nGZw==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr20045355pfn.46.1539657568819;
        Mon, 15 Oct 2018 19:39:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:28 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 14/18] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Mon, 15 Oct 2018 19:37:34 -0700
Message-Id: <1539657458-24401-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

