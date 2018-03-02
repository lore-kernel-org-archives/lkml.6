Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424021AbeCBP2j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:28:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:40727 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422665AbeCBP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:28:37 -0500
From: Takashi Iwai <tiwai@suse.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@intel.com>, Jiri Slaby <jslaby@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation/sphinx: Fix Directive import error
Date: Fri,  2 Mar 2018 16:28:31 +0100
Message-Id: <20180302152831.11510-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sphinx.util.compat for Directive stuff was deprecated in the
recent Sphinx version, and now we get a build error.

Let's import from the new place, docutils.parsers.rst, while keeping
the old sphinx.util.compat as fallback.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Change the fallback order as Matthew suggested, the new one at first

 Documentation/sphinx/kerneldoc.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 39aa9e8697cc..34396976eb0a 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -37,7 +37,10 @@ import glob
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives
-from sphinx.util.compat import Directive
+try:
+    from docutils.parsers.rst import directives, Directive
+except ImportError:
+    from sphinx.util.compat import Directive
 from sphinx.ext.autodoc import AutodocReporter
 
 __version__  = '1.0'
-- 
2.16.2
