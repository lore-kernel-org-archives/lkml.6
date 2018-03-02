Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428060AbeCBTBG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:01:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:51210 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424211AbeCBTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:01:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="35047675"
From: Jani Nikula <jani.nikula@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/sphinx: Fix Directive import error
In-Reply-To: <20180302184014.GG31400@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180302152831.11510-1-tiwai@suse.de> <20180302184014.GG31400@bombadil.infradead.org>
Date: Fri, 02 Mar 2018 21:00:53 +0200
Message-ID: <87tvtyti8q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Mar 2018, Matthew Wilcox <willy@infradead.org> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Sphinx 1.7 removed sphinx.util.compat.Directive so people
> who have upgraded cannot build the documentation.  Switch to
> docutils.parsers.rst.Directive which has been available since
> docutils 0.5 released in 2009.
>
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

I think this is the best approach.

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 39aa9e8697cc..fbedcc39460b 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -36,8 +36,7 @@ import glob
>  
>  from docutils import nodes, statemachine
>  from docutils.statemachine import ViewList
> -from docutils.parsers.rst import directives
> -from sphinx.util.compat import Directive
> +from docutils.parsers.rst import directives, Directive
>  from sphinx.ext.autodoc import AutodocReporter
>  
>  __version__  = '1.0'

-- 
Jani Nikula, Intel Open Source Technology Center
