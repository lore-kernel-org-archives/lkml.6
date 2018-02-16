Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032508AbeBPNsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:48:36 -0500
Received: from osg.samsung.com ([64.30.133.232]:48914 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032356AbeBPNsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:32 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 5/6] doc-guide: kernel-doc: add examples about nested union/structs
Date: Fri, 16 Feb 2018 11:48:19 -0200
Message-Id: <2629d8c4efede896db674159f643d7a54bd96a1b.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps to give some examples about how to use in-line
comments also when nested union/structs are present. So add it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/doc-guide/kernel-doc.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 1ddfe35c0e78..c6c329708d8a 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -286,8 +286,17 @@ on a line of their own, like all other kernel-doc comments::
          * Here, the member description may contain several paragraphs.
          */
         int baz;
-        /** @foobar: Single line description. */
-        int foobar;
+        union {
+                /** @foobar: Single line description. */
+                int foobar;
+        };
+        /** @bar2: Description for struct @bar2 inside @foo */
+        struct {
+                /**
+                 * @bar2.barbar: Description for @barbar inside @foo.bar2
+                 */
+                int barbar;
+        } bar2;
   };
 
 Typedef documentation
-- 
2.14.3
