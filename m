Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935676AbeEJOiY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:38:24 -0400
Received: from osg.samsung.com ([64.30.133.232]:50825 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935660AbeEJOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:38:22 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 1/2] scripts/kernel-doc: Auto-detect common code-blocks
Date: Thu, 10 May 2018 10:38:16 -0400
Message-Id: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments that end with a comma and have certain keywords
should be presented as code-blocks

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/kernel-doc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 0057d8eafcc1..8ce2d0f54369 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -803,7 +803,8 @@ sub output_highlight_rst {
 	#
 	if (! $in_literal) {
 	    $block .= $line . "\n";
-	    if (($line =~ /$sphinx_literal/) || ($line =~ /$sphinx_cblock/)) {
+	    if (($block =~ s/(code|example|artwork|flow|diagram)([^\:]*:)\n/$1$2:\n/) ||
+	        ($line =~ /$sphinx_literal/) || ($line =~ /$sphinx_cblock/)) {
 		$in_literal = 1;
 		$litprefix = "";
 		$output .= highlight_block($block);
-- 
2.17.0
