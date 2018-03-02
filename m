Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165152AbeCBS2i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:28:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162994AbeCBS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:28:36 -0500
Date: Fri, 2 Mar 2018 10:28:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/sphinx: Fix Directive import error
Message-ID: <20180302182831.GF31400@bombadil.infradead.org>
References: <20180302152831.11510-1-tiwai@suse.de>
 <871sh2v53l.fsf@intel.com>
 <20180302164254.GB31400@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302164254.GB31400@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 08:42:54AM -0800, Matthew Wilcox wrote:
> On Fri, Mar 02, 2018 at 06:01:50PM +0200, Jani Nikula wrote:
> > On Fri, 02 Mar 2018, Takashi Iwai <tiwai@suse.de> wrote:
> > > The sphinx.util.compat for Directive stuff was deprecated in the
> > > recent Sphinx version, and now we get a build error.
> > >
> > > Let's import from the new place, docutils.parsers.rst, while keeping
> > > the old sphinx.util.compat as fallback.
> > >
> > > Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > v1->v2: Change the fallback order as Matthew suggested, the new one at first
> > 
> > So this crossed my mind as well... and then I thought it'll probably
> > succeed on older Sphinx, and the fallback is not needed. The question
> > is, are these equal? Can we just import from docutils.parsers.rst?
> 
> I found a github page which implies that docutils.parsers.rst.Directive
> was added 12 years ago (!) so we're probably safe to rely on it:
> 
> https://github.com/docutils-mirror/docutils/commit/9649abee47b4ce4db51be1d90fcb1fb500fa78b3
> 
> Again, I'm no pythonista, so I may have muddled this.

I spent some time delving through the Sphinx codebase.  The compat
version was added so you could use Directive with docutils 0.4 onwards.
docutils 0.5 onwards has Directive.  So as long as we're comfortable
mandating docutils from 2009, we're fine ;-)
