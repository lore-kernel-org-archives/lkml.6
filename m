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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55738C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E9E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtdGkXHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbeLSIgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:36:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39880 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeLSIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:36:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so14373847lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=u/IPvlpX4q39KHWDadnNBhpueEpjrqHV1t52A2ssKUs=;
        b=mtdGkXHKNiXyhE3k4nwHNL58oPt93odgwUqdYYV1auYBT0ptbgc93Tj6aX7YzpBnY0
         hq1Ct1r94QTIGWzY/xdcgoUSKPH76toQ7wOgbR+GS75vOf5YUgeWZMtBZ8pKrrWm+QYt
         0oJ03P2QYC2hKjoxckDdvto3TfdN3QdHcQT2MIpBxVUReK3XdnW6sG5qksApXWqQLKCo
         vNfvnjHVUydwpzUdV6y7oZX4bdmO1tc+pkaejHYBUbrqM+q4gfwuIQWRVFEwjMROfJrS
         8MGDVbaxFsbyIepfsY7WBx5L7HSne2g00YO3i7u96FwyhcUaUrruwomtzmdfQwRPhY7J
         VqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=u/IPvlpX4q39KHWDadnNBhpueEpjrqHV1t52A2ssKUs=;
        b=ExGLayJspZKfpAo6qX6uF4lVrntj5jQyr6RD6i4nrVyluWGr9YDQ7XiqO11n32dNZ4
         LlnQKYYrFHDG4lRzR2OVp39l2X8JUkROYN4QJQcG+w0YlgxAVzTRGwDgrb4UZI98RXII
         HR+4eH5NJbUIQmeFDOd9DQ9WglLkKCQfoKJq3lKshBIYtnU8/g/mjvQMrZ4Lp/6vQJ+1
         RZMZU5fJXFxIz2g5DS/43S1sBfCUaNqra483I3i+hO3KTdzROnOIi/xpRZT/0jpEXvWn
         P49I/wTVGTDCm7ojzgpOQAI4FzZ0arAsY79t4wwhEwmPVFXww0zDwQBky5J3Ab5dxX7P
         yVvw==
X-Gm-Message-State: AA+aEWZq8SnmFuHh60ESkVFlPdkQY9mTWX1cQQR0ynrAAZU03QJ0VlSM
        UClYl4wX3kzshu9P1F0I9Yo=
X-Google-Smtp-Source: AFSGD/UnHjTl390mQWX2r4KojSVDRpAVuPtXQyHZ9YiMTh4ymyYUE2YypM1P4xjgEnodQ0PVvL1T9Q==
X-Received: by 2002:a19:aace:: with SMTP id t197mr11666613lfe.7.1545208592513;
        Wed, 19 Dec 2018 00:36:32 -0800 (PST)
Received: from localhost.localdomain (91-159-62-171.elisa-laajakaista.fi. [91.159.62.171])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3496790ljf.67.2018.12.19.00.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:36:31 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
Date:   Wed, 19 Dec 2018 10:35:59 +0200
Message-Id: <20181219083559.30985-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
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
CC: linux-kernel@vger.kernel.org
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c883ec55654f..e255f0423cca 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2931,7 +2931,8 @@ sub process {
 			}
 			if ($is_start && $is_end && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a paragraph (" .$min_conf_desc_length . " lines)" .
+				     " that describes the config symbol fully\n" . $herecurr);
 			}
 			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
-- 
2.19.1

