Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA38920874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkai7HLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeLSXYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:24:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46995 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbeLSXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:24:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so18864499ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=xQ+wvIUk4MreQgtdhcLZZ3N78uPPrSR/+q4rSdxYLbQ=;
        b=mkai7HLtSL7aPnbG6yNPiWYDGBGbDP7ycKJSEfsKDku+KobS/QsNYE6VGthz+OHHgU
         rBUlwVcGFmDk4KMTasUL75X+AVyNeL6evPGO1ZKz7ET/ZNTMXue967ytjdptxKSmY0F6
         rlm6Dkfps+kSUfT2jJqU6PPYP/n0Pyr+HGl0dQmzuaZfZ4wN6iPpw9QgZOg7czGaE+9j
         zCzAVaAF+/YUXOWc1QpOcRxFmPgQkb0SCUyzEcCUBORAZD/fwXvAwHShNYn082W2y2qI
         2ie/R5938b3HoCzyE7qOiIpkPpE5ZzNzS0kJXH54LwQI3WjNAC0rEFnzCB4RpQMxQ3dq
         6igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=xQ+wvIUk4MreQgtdhcLZZ3N78uPPrSR/+q4rSdxYLbQ=;
        b=M/2YwuXbN/t1uZRBf1ZffRByeBpdiVRvd8AahXrH0anuST54JwKbNIstTb/GHnCb4O
         7mWMZ8TBex5rr00cGp18gd/LNl+22jv0AmXFypRGxV/JU7jgrnm3udAekOQ4x2muQaM9
         iLDh5uIf6DIAtUCCEmfri0qjVzEFri3qsDp4YdyohC8TjZkTjvPkz9efNvkw54F1DxRZ
         IMTwUKdYTRflEnFsbXzkbavhKDaJQTfzoD+Tq35Yuh+K+qId1USUdfsi25uaQ70h9ccj
         oyyE4GYRUCXghQ3ya/71j/zgT6/VH7B3KePtfo1jgxR0pfqjfyfKihcrycSnGLHOITiZ
         lX2Q==
X-Gm-Message-State: AA+aEWZTeXI1YGZLXLnThJrTOIHfXwQHanCpAG06I2OsLSa8pR4KGEMm
        LXD6QUBZ+oEs/WKpb0pO6GA=
X-Google-Smtp-Source: AFSGD/UenWRlZFuu9Z6isN9HxTihKzUvNLvQhMIfVxPsULYRqU42Vui7CFsg14jsL0zHdTAeuA464A==
X-Received: by 2002:a2e:82d7:: with SMTP id n23-v6mr3034489ljh.143.1545261843982;
        Wed, 19 Dec 2018 15:24:03 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id u12-v6sm3775627ljk.79.2018.12.19.15.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:24:03 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
Date:   Thu, 20 Dec 2018 01:23:42 +0200
Message-Id: <20181219232342.31569-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <ad8b075efc39ef10727b118ed292f3353311c6db.camel@perches.com>
References: <ad8b075efc39ef10727b118ed292f3353311c6db.camel@perches.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checkpatch.pl script complains when the help section of a Kconfig
entry is too short, but it doesn't really explain what it is looking
for. Instead, it gives a generic warning that one should consider writing
a paragraph.

But what it *really* checks is that the help section is at least
.$min_conf_desc_length lines long.

Since the definition of what is a paragraph is not really carved in
stone (and actually the primary descriptions is "5 sentences"), make the
warning less ambiguous by expliciting the actual test condition, so that
one doesn't have to read checkpatch.pl sources, to figure out the actual
test.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Andy Whitcroft <apw@canonical.com>
CC: Joe Perches <joe@perches.com>
CC: Andi Kleen <ak@linux.intel.com>
CC: linux-kernel@vger.kernel.org
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c883ec55654f..818ddada28b5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2931,7 +2931,7 @@ sub process {
 			}
 			if ($is_start && $is_end && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "expecting a 'help' section of $min_conf_desc_length or more lines\n" . $herecurr);
 			}
 			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
-- 
2.19.1

