Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42739C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7D208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D7D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeH0UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:02:39 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:35094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbeH0UCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:02:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 431E78E49;
        Mon, 27 Aug 2018 16:15:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: iron28_4bd73ad2d3438
X-Filterd-Recvd-Size: 1996
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Aug 2018 16:15:21 +0000 (UTC)
Message-ID: <5905126e70b0ed1781e49265fd5c49c5090d0223.camel@perches.com>
Subject: [PATCH] checkpatch: Add optional static const to blank line
 declarations test
From:   Joe Perches <joe@perches.com>
To:     Jyri Sarha <jsarha@ti.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Valkeinen, Tomi" <tomi.valkeinen@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Aug 2018 09:15:20 -0700
In-Reply-To: <2ead4f42-3524-e4d5-dada-1c6dd8af82e8@ti.com>
References: <2ead4f42-3524-e4d5-dada-1c6dd8af82e8@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a static const struct definition as part of
a series of declarations produces a false positive
"Missing a blank line after declarations" for code like:

WARNING: Missing a blank line after declarations
#710: FILE: drivers/gpu/drm/tidss/tidss_scale_coefs.c:137:
+       int inc;
+       static const struct {

So fix it.

Reported-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5219280bf7ff..b4caee6e269c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3311,7 +3311,7 @@ sub process {
 			# known declaration macros
 		      $sline =~ /^\+\s+$declaration_macros/ ||
 			# start of struct or union or enum
-		      $sline =~ /^\+\s+(?:union|struct|enum|typedef)\b/ ||
+		      $sline =~ /^\+\s+(?:static\s+)?(?:const\s+)?(?:union|struct|enum|typedef)\b/ ||
 			# start or end of block or continuation of declaration
 		      $sline =~ /^\+\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
 			# bitfield continuation

