Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032660AbeBPNtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:49:39 -0500
Received: from osg.samsung.com ([64.30.133.232]:40593 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032303AbeBPNsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:30 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4/6] scripts: kernel-doc: support in-line comments on nested structs/unions
Date: Fri, 16 Feb 2018 11:48:18 -0200
Message-Id: <a4f7680bf956e6c98f612bcfc7aa817c344ebdab.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser at kernel-doc rejects names with dots in the middle.
Fix it, in order to support nested structs/unions.

Tested-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fee8952037b1..06d7f3f2c094 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -363,7 +363,7 @@ my $doc_sect = $doc_com .
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
-my $doc_inline_sect = '\s*\*\s*(@[\w\s]+):(.*)';
+my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
-- 
2.14.3
