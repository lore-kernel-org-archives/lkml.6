Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA31C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C92086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAujfMeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeKIPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:47:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44989 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKIPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:47:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so434670pff.11;
        Thu, 08 Nov 2018 22:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
        b=YAujfMeZBDiK49TuXnYnJAuAm5X27MPYHr3ARKEs1fpH917SxQKYSSoisf5iE/U0p2
         fJLRq7zzdG+NL3ZQaU/7YjIh1SrZQBGHqmho6L+0Mt+kSnBDF2CL/A2LDmlpWw0Ws041
         6TM+m9nRPaRKsxNMhns8uZ52aClxptk07YymUubrXs4VIAf23bEKBCzTz5J5pESSbLKv
         u3XfR4z2iUK5OrouBrCKoxRaABVJuhNypekipVQSw5mOjRKoviAeM0C5hu4eYbFKaXy4
         9uwunJU1xpUQ8to3i+O3YqQ1pKSOPZtPPovBNkX28s+67/uDzxtB04kKUAD958erTgPn
         HcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gXevU2yLJlZLfcV58lfxfJxApOOyRedeEm2yYSVFiMw=;
        b=rGKZd0hl/x5eCrxpUZbC+2IzUCP9xc1RfHvFl6XLSrrbSdu+kMVRZQUK42jiPYk08H
         6N2Svhe4QLLEllVEPLQF0oafk6N0+PrMSHCWGY/5tWFrVEhh8SPaJZov60lUvgyNHbvQ
         +VjL4F3WyAFealvbApUPP8osW9v/q5qIRdu8bz4cp/yxuRPD3H1HxsZtTYW0WK9QtLFa
         Nt/MUKPP59ORhOQg+LD2US8bdprjQHy9ilsgdv6YakkkgYZjOsN2J87UhxPVs6W0/u2z
         /ecM7JtmWdOCz7jeE5xoWuYoe+JaEHMLN+5HwdD+bSNx9CcoQaxXDRtjvpKuYuiR3I5v
         7BUw==
X-Gm-Message-State: AGRZ1gLuCMx7v1Bo7sY5BRcBDfARfosdhZNhY5UjZecHUycljr+KN6G/
        BUyqsHnp/cX6cgbzBdnpfTU=
X-Google-Smtp-Source: AJdET5cQNyBJ72uuudRNukYEWYSEF50nnZicsd3BCZ0erdA9BtBT8GR3tycpeBXO8o5uzXkrISg47Q==
X-Received: by 2002:a62:b615:: with SMTP id j21-v6mr7756923pff.199.1541743680158;
        Thu, 08 Nov 2018 22:08:00 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:59 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 13/17] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Thu,  8 Nov 2018 22:06:01 -0800
Message-Id: <1541743565-23163-14-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

