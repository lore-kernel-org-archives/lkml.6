Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeBVAhz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:37:55 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42993 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeBVAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:37:52 -0500
X-Google-Smtp-Source: AH8x224ht6O8IidyYa9JFWu9Ke8KWW0ZoZSMbKStK+ZfGufAQSYB6IhJrdPImaNvVCGZ+9mKnMttpQ==
Date: Wed, 21 Feb 2018 16:37:50 -0800
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
Message-ID: <20180222003749.GA4724@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recently pointed out by Linus, "Root-caused-by" is a good tag to include
since it can indicate significantly more work than "just" a Reported-by.
This adds it and "Suggested-by" (which was also missing) to the documented
list of tags. Additionally updates checkpatch.pl to match the process docs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/5.Posting.rst | 7 +++++++
 scripts/checkpatch.pl               | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 645fa9c7388a..2ff01f76f02a 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -234,6 +234,13 @@ The tags in common use are:
    people who test our code and let us know when things do not work
    correctly.
 
+ - Suggested-by: names a person who suggested the solution, but may not
+   have constructed the full patch. A weaker version of `Co-Developed-by`.
+
+ - Root-caused-by: names a person who diagnosed the root cause of a
+   problem. This usually indicates significantly more work than a simple
+   `Reported-by`.
+
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..a1ab82e70b54 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -464,9 +464,11 @@ our $logFunctions = qr{(?x:
 our $signature_tags = qr{(?xi:
 	Signed-off-by:|
 	Acked-by:|
+	Co-Developed-by:|
 	Tested-by:|
 	Reviewed-by:|
 	Reported-by:|
+	Root-caused-by:|
 	Suggested-by:|
 	To:|
 	Cc:
-- 
2.7.4


-- 
Kees Cook
Pixel Security
