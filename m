Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1088223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1088223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHKBWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:22:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54208 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:22:44 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so4732759itw.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 15:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zQ6EOvgaEThJ1QWToMEFmPIu7C+sFD+nq5QvF1R68pg=;
        b=lAkDSiQOdbbxX9idELCOOBEF3BP9WGMkMkTJMo5WsRn5qCv+Asq7n4VnZmka+g+TK2
         8DLrCypXnrc4IHn4FNNQ0EQS/Z0ih20iFp60AxKGlq8cCkXW8FPA5LjbsBnkQP+dqlLd
         IgR7r2t01uX5/sUadDP3v5FIyvqoP54MXKUpwdDaQNMETUEiXGUn1Xuws2AckOUV/G6E
         trKnrcJmfa9XDirPDCeiTgVcM2KItmreMqoxteIcWxFgzOjcA8Uf5LZ06frzEdNZT1bS
         h4xjrbYHR9AJbcHtn23ss6lDqUUmaRjJ3AD6CIHO5PMKYikBVeIeW3veCM5YCvInLsSM
         QQJQ==
X-Gm-Message-State: AOUpUlGqcf++4Z+zj6uOuKsi8c4JyCX7tG28twrrvYbru1JuNj3MCqHY
        JcWjJoCKAddIwc9sq5dpQg==
X-Google-Smtp-Source: AA+uWPyshdZ/tXZGRWBRWvdYKANmVQmhXeKYX4YY1qdfLr5kaGuVOcRiFoXz+5WHaeqj5Iz96bh4XQ==
X-Received: by 2002:a02:891b:: with SMTP id o27-v6mr7781304jaj.23.1533941451086;
        Fri, 10 Aug 2018 15:50:51 -0700 (PDT)
Received: from localhost.localdomain ([24.51.61.72])
        by smtp.googlemail.com with ESMTPSA id j78-v6sm1766399itj.44.2018.08.10.15.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:50:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v3] checkpatch: DT bindings should be a separate patch
Date:   Fri, 10 Aug 2018 16:50:49 -0600
Message-Id: <20180810225049.20452-1-robh@kernel.org>
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
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c05506e325..fa9b50d6f3d4 100755
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
@@ -2485,6 +2486,19 @@ sub process {
 				$check = $check_orig;
 			}
 			$checklicenseline = 1;
+
+			if ($realfile !~ /^MAINTAINERS/) {
+				my $last_binding_patch = $is_binding_patch;
+
+				$is_binding_patch = () = $realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@;
+
+				if (($last_binding_patch != -1) &&
+				    ($last_binding_patch ^ $is_binding_patch)) {
+					WARN("DT_SPLIT_BINDING_PATCH",
+					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt\n");
+				}
+			}
+
 			next;
 		}
 
-- 
2.17.1

