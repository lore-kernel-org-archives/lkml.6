Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946687AbeCBQCB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:02:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:4004 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946669AbeCBQB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:01:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="35004613"
From: Jani Nikula <jani.nikula@intel.com>
To: Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/sphinx: Fix Directive import error
In-Reply-To: <20180302152831.11510-1-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180302152831.11510-1-tiwai@suse.de>
Date: Fri, 02 Mar 2018 18:01:50 +0200
Message-ID: <871sh2v53l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Mar 2018, Takashi Iwai <tiwai@suse.de> wrote:
> The sphinx.util.compat for Directive stuff was deprecated in the
> recent Sphinx version, and now we get a build error.
>
> Let's import from the new place, docutils.parsers.rst, while keeping
> the old sphinx.util.compat as fallback.
>
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: Change the fallback order as Matthew suggested, the new one at first

So this crossed my mind as well... and then I thought it'll probably
succeed on older Sphinx, and the fallback is not needed. The question
is, are these equal? Can we just import from docutils.parsers.rst?

I'm sorry I don't have the time to find the answers to these questions
as well. :(

BR,
Jani.


>
>  Documentation/sphinx/kerneldoc.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 39aa9e8697cc..34396976eb0a 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -37,7 +37,10 @@ import glob
>  from docutils import nodes, statemachine
>  from docutils.statemachine import ViewList
>  from docutils.parsers.rst import directives
> -from sphinx.util.compat import Directive
> +try:
> +    from docutils.parsers.rst import directives, Directive
> +except ImportError:
> +    from sphinx.util.compat import Directive
>  from sphinx.ext.autodoc import AutodocReporter
>  
>  __version__  = '1.0'

-- 
Jani Nikula, Intel Open Source Technology Center
