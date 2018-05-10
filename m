Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbeEJMUl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:20:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756741AbeEJMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:20:40 -0400
Date: Thu, 10 May 2018 14:20:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510122036.GD12217@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
 <20180510083838.GA21846@infradead.org>
 <20180510063805.1859b1aa@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510063805.1859b1aa@vento.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 06:38:05AM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 10 May 2018 01:38:38 -0700
> Christoph Hellwig <hch@infradead.org> escreveu:
> 
> > >   * Use either while holding wait_queue_head::lock or when used for wakeups
> > > - * with an extra smp_mb() like:
> > > + * with an extra smp_mb() like::  
> > 
> > Independent of any philosophical discussion not allowing a setence to
> > end with a single ':' is completely idiotic.  Please fix the tooling
> > instead to allow it, as it is very important for being able to just
> > write understandable comments.

That is exactly my point; the whole rst stuff detracts from normal text.
It makes both reading and writing harder than it needs to be.

> Patches are welcome, although I don't see any easy way to solve it.
> 
> In English, the common case is that a line with ends with a colon is
> followed by a list. E. g.

(google) Dictionary says:

"a punctuation mark (:) used to precede a list of items, a quotation, or
an expansion or explanation."

An enumeration (list) is just one of many possible uses of the colon.

> However, in this specific case, it is followed by an ascii artwork. 
> The double colon is a notation that tells Sphinx to not parse the
> lines at the next block, placing the contents of it inside a literal
> block. It is used also when the next lines contain a code example,
> in order to avoid parsing things like @, () and * inside the code 
> block.
> 
> The kernel-doc tool might eventually have some parsing logic that
> would replace something to a '::' before sending it to Sphinx.

I think typically there will be an 'empty' line between the colon ending
and the 'example/explanation'. This seems true for a number of comments
I found in drm using the '::' nonsense.

Simple regexes don't do multi-line patterns, but maybe the kerneldoc
thing can parse it differently.
