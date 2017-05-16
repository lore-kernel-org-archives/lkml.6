Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ClQ5JFkBGFudbQAAmS7hNA
	; Wed, 06 Jun 2018 15:45:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AEB74607E5; Wed,  6 Jun 2018 15:45:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 230426083E;
	Wed,  6 Jun 2018 15:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 230426083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=s-opensource.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbeFFPpL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:45:11 -0400
Received: from osg.samsung.com ([64.30.133.232]:50746 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932139AbeFFPpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 36CDA3B816;
        Wed,  6 Jun 2018 08:45:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VN-VriEIT1Kj; Wed,  6 Jun 2018 08:45:06 -0700 (PDT)
Received: from smtp.s-opensource.com (177.43.29.180.dynamic.adsl.gvt.net.br [177.43.29.180])
        by osg.samsung.com (Postfix) with ESMTPSA id 0AECC3B80D;
        Wed,  6 Jun 2018 08:45:06 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.87)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1dAbPD-0000yg-6A; Tue, 16 May 2017 09:16:47 -0300
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
        linux-mtd@lists.infradead.org,
        Markus Heiser <markus.heiser@darmarIT.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 53/53] kernel-doc: describe the ``literal`` syntax
Date: Tue, 16 May 2017 09:16:45 -0300
Message-Id:
 <5d47c31b59f6c2c7ddce0fcb1be0f85ad39a56fe.1494935649.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20170516121645.9a1P2Zpw1pU97VTnkKKyNgtf75KbbTZy7ZiCdteNvFs@z>

changeset b97f193abf83 ("scripts/kernel-doc: fix parser
for apostrophes") added support for ``literal`` inside
kernel-doc, in order to allow using the "%" symbol inside
a literal block, as this is used at printk() description.

Document it.

Fixes: b97f193abf83 ("scripts/kernel-doc: fix parser for apostrophes")
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/doc-guide/kernel-doc.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index b32e4813ff6f..b24854b5d6be 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -149,6 +149,16 @@ Domain`_ references.
 ``%CONST``
   Name of a constant. (No cross-referencing, just formatting.)
 
+````literal````
+  A literal block that should be handled as-is. The output will use a
+  ``monospaced font``.
+
+  Useful if you need to use special characters that would otherwise have some
+  meaning either by kernel-doc script of by reStructuredText.
+
+  This is particularly useful if you need to use things like ``%ph`` inside
+  a function description.
+
 ``$ENVVAR``
   Name of an environment variable. (No cross-referencing, just formatting.)
 
-- 
2.9.3
