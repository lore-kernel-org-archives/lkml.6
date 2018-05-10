Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964894AbeEJNaT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:30:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:56974 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934693AbeEJNaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:30:18 -0400
Date: Thu, 10 May 2018 07:30:12 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510073012.5902088e@lwn.net>
In-Reply-To: <20180510063805.1859b1aa@vento.lan>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180510083838.GA21846@infradead.org>
        <20180510063805.1859b1aa@vento.lan>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 06:38:05 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> (Peter said):
> > Independent of any philosophical discussion not allowing a setence to
> > end with a single ':' is completely idiotic.  Please fix the tooling
> > instead to allow it, as it is very important for being able to just
> > write understandable comments.  

FWIW, there's no problem with a sentence ending with a single colon.
It's only an issue if you want to flag a special interpretation for the
text that follows that sentence.  Just to be precise.

> Patches are welcome, although I don't see any easy way to solve it.

I could envision some sort of heuristic that would recognize an indented
block containing code.  Probably we could go simpler and force the
"literal block" treatment for any indented block that lacks explicit
enumeration markers.  So:

	this->would_be("a literal block");

but:

  - This would not be

Such a thing would likely be a bit fragile (people feel, rightly, that
they can put anything into normal text) but it might just work well
enough.  For best results, it should probably be done as part of Sphinx
itself, rather than yet another ugly hack in the kerneldoc script.

This particular problem may be solvable, and I'll look into it, but not
right away.  The offline world is being rather insistently obnoxious
these days...

jon
