Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936624AbeCBQem (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:34:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936591AbeCBQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:34:16 -0500
Date: Fri, 2 Mar 2018 08:34:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/sphinx: Fix Directive import error
Message-ID: <20180302163412.GA31400@bombadil.infradead.org>
References: <20180302152831.11510-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302152831.11510-1-tiwai@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 04:28:31PM +0100, Takashi Iwai wrote:
>  from docutils.parsers.rst import directives
> -from sphinx.util.compat import Directive
> +try:
> +    from docutils.parsers.rst import directives, Directive

We also don't need 'directives' on this line as it was imported on the
previous line.

> +except ImportError:
> +    from sphinx.util.compat import Directive
>  from sphinx.ext.autodoc import AutodocReporter
>  
>  __version__  = '1.0'

Here's what I tested on Debian:

+++ b/Documentation/sphinx/kerneldoc.py
@@ -37,7 +37,10 @@ import glob
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives
-from sphinx.util.compat import Directive
+try:
+    from docutils.parsers.rst import Directive
+except ImportError:
+    from sphinx.util.compat import Directive
 from sphinx.ext.autodoc import AutodocReporter
 
 __version__  = '1.0'
