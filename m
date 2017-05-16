Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YW9CLXMBGFswbwAAmS7hNA
	; Wed, 06 Jun 2018 15:45:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B54D60764; Wed,  6 Jun 2018 15:45:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3816607E1;
	Wed,  6 Jun 2018 15:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3816607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=s-opensource.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbeFFPpF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:45:05 -0400
Received: from osg.samsung.com ([64.30.133.232]:53420 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbeFFPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:45:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 7B7C23B804;
        Wed,  6 Jun 2018 08:45:02 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iu59dCkwZ-Wc; Wed,  6 Jun 2018 08:45:01 -0700 (PDT)
Received: from smtp.s-opensource.com (177.43.29.180.dynamic.adsl.gvt.net.br [177.43.29.180])
        by osg.samsung.com (Postfix) with ESMTPSA id 4BBED3B7FB;
        Wed,  6 Jun 2018 08:45:01 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.87)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1dAbPD-0000yb-5f; Tue, 16 May 2017 09:16:47 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        linux-mtd@lists.infradead.org, Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 52/53] docs-rst: get rid of Documentation/sphinx/tmplcvt script
Date: Tue, 16 May 2017 09:16:44 -0300
Message-Id:
 <fd74809e73be1192f2455d39932a94dfa6fb0e83.1494935649.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20170516121644.i9AZOJ2rSZJ0cQ03lA2oxdvtVIz0yf_mYph-qEzC8ss@z>

As everything was converted to ReST, we don't need this
script anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/sphinx/tmplcvt | 28 ----------------------------
 1 file changed, 28 deletions(-)
 delete mode 100755 Documentation/sphinx/tmplcvt

diff --git a/Documentation/sphinx/tmplcvt b/Documentation/sphinx/tmplcvt
deleted file mode 100755
index 6848f0a26fa5..000000000000
--- a/Documentation/sphinx/tmplcvt
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/bash
-#
-# Convert a template file into something like RST
-#
-# fix <function>
-# feed to pandoc
-# fix \_
-# title line?
-#
-set -eu
-
-if [ "$#" != "2" ]; then
-	echo "$0 <docbook file> <rst file>"
-	exit
-fi
-
-DIR=$(dirname $0)
-
-in=$1
-rst=$2
-tmp=$rst.tmp
-
-cp $in $tmp
-sed --in-place -f $DIR/convert_template.sed $tmp
-pandoc -s -S -f docbook -t rst -o $rst $tmp
-sed --in-place -f $DIR/post_convert.sed $rst
-rm $tmp
-echo "book writen to $rst"
-- 
2.9.3
