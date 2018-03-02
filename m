Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965322AbeCBSkW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:40:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967965AbeCBSkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:40:17 -0500
Date: Fri, 2 Mar 2018 10:40:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation/sphinx: Fix Directive import error
Message-ID: <20180302184014.GG31400@bombadil.infradead.org>
References: <20180302152831.11510-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302152831.11510-1-tiwai@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Sphinx 1.7 removed sphinx.util.compat.Directive so people
who have upgraded cannot build the documentation.  Switch to
docutils.parsers.rst.Directive which has been available since
docutils 0.5 released in 2009.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 39aa9e8697cc..fbedcc39460b 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -36,8 +36,7 @@ import glob
 
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
-from docutils.parsers.rst import directives
-from sphinx.util.compat import Directive
+from docutils.parsers.rst import directives, Directive
 from sphinx.ext.autodoc import AutodocReporter
 
 __version__  = '1.0'
