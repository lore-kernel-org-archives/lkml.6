Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA8BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AAE21E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AAE21E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeHIXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:17:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36668 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:17:07 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so2294479itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kl4g/fu6WNL5teFrR4Ny26N/hx6O3ysJPMLOjof6RI4=;
        b=PmZbeI3rk3yLpUXInPolEPV3oP9ZZgCS2qijfXPJv7meCuzh4fUi/zOVLUNu3xIp4p
         ePue8OwhCTaukHfp+fW778w4PBujsMBbtcph+lYcKMQZs6jHWy+ASOM9zanFatSsM8Gg
         0DvYd0gk4Gix4s+3jyuKQChZpLs3iq0KiRqkcak4mbPiLHVznhvMU3Dxb+rQOAQmvO38
         jY95ZM5+jwStumEQP1OKv25yBIv8i3Iab/X4BYO4Nx9sianpL0L72ykab51MQYjmsCP1
         AEl2ay43G+qGHjItTCRBb2IDO8e/PHHR2IAmRvDMqy+J1k8qkhxsZXiXl5WsM2txTHz2
         q2yg==
X-Gm-Message-State: AOUpUlHE+/05XHHWqj4UzUUtpWFU2KKDGor2cZ+lHqrapvQhN56dgfUx
        Lku1fGktEYwtXX49MkW7Rw==
X-Google-Smtp-Source: AA+uWPxcIPSzj1whpF3UMQHHgyl8bNTOKIHDt85zv0rwRm10fseij3rbeQ9aDD7j1ilvFqZyknv+1Q==
X-Received: by 2002:a02:9d38:: with SMTP id n53-v6mr3362178jak.39.1533847833962;
        Thu, 09 Aug 2018 13:50:33 -0700 (PDT)
Received: from localhost.localdomain ([24.51.61.72])
        by smtp.googlemail.com with ESMTPSA id w193-v6sm250057ita.11.2018.08.09.13.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:50:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH] checkpatch: DT bindings should be a separate patch
Date:   Thu,  9 Aug 2018 14:50:32 -0600
Message-Id: <20180809205032.22205-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree bindings should be their own patch as documented in
Documentation/devicetree/bindings/submitting-patches.txt section I.1.
This is because bindings are logically independent from a driver
implementation, they have a different maintainer (even though they often
are applied via the same tree), and it makes for a cleaner history in
the DT only tree created with git-filter-branch.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/checkpatch.pl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c05506e325..20547c109ccd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2236,6 +2236,7 @@ sub process {
 	our $clean = 1;
 	my $signoff = 0;
 	my $is_patch = 0;
+	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $has_commit_log = 0;		#Encountered lines before patch
@@ -2485,6 +2486,27 @@ sub process {
 				$check = $check_orig;
 			}
 			$checklicenseline = 1;
+
+			if ($realfile !~ /MAINTAINERS/) {
+				my $mixed = 0;
+				if ($realfile =~ /(Documentation\/devicetree|include\/dt-bindings).*/) {
+					if ($is_binding_patch == 0) {
+						$mixed = 1;
+					}
+					$is_binding_patch = 1;
+				} else {
+					if ($is_binding_patch == 1) {
+						$mixed = 1;
+					}
+					$is_binding_patch = 0;
+				}
+
+				if ($mixed == 1) {
+					WARN("DT_SPLIT_BINDING_PATCH",
+					     "DT binding docs and includes should be a separate patch\n");
+				}
+			}
+
 			next;
 		}
 
-- 
2.17.1

