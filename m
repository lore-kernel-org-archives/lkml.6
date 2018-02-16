Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032418AbeBPNsd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:48:33 -0500
Received: from osg.samsung.com ([64.30.133.232]:54425 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032299AbeBPNsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:31 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 1/6] doc-guide: kernel-doc: fix example for nested_foobar struct
Date: Fri, 16 Feb 2018 11:48:15 -0200
Message-Id: <25fef501c673f1d1e5e25171b7ce428101cf48fd.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing */ at the end of Kernel docs example.
Even adding it, it will still produce 3 warnings:

	example:33: warning: Function parameter or member 'bar' not described in 'nested_foobar'
	example:33: warning: Function parameter or member 'bar.st1' not described in 'nested_foobar'
	example:33: warning: Function parameter or member 'bar.st2' not described in 'nested_foobar'

So, make the example more complete and add the missing end
of comment there.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/doc-guide/kernel-doc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 2fb7f2bfc245..9fce378dccb2 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -250,10 +250,14 @@ It is possible to document nested structs and unions, like::
        * @memb2: second member of anonymous union/anonymous struct
        * @memb3: third member of anonymous union/anonymous struct
        * @memb4: fourth member of anonymous union/anonymous struct
+       * @bar: non-anonymous union
+       * @bar.st1: struct st1 inside @bar
+       * @bar.st2: struct st2 inside @bar
        * @bar.st1.memb1: first member of struct st1 on union bar
        * @bar.st1.memb2: second member of struct st1 on union bar
        * @bar.st2.memb1: first member of struct st2 on union bar
        * @bar.st2.memb2: second member of struct st2 on union bar
+       */
       struct nested_foobar {
         /* Anonymous union/struct*/
         union {
-- 
2.14.3
