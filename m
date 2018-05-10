Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966796AbeEJRp4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:45:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966662AbeEJRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:45:53 -0400
Date: Thu, 10 May 2018 14:45:46 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510144546.1d94b771@vento.lan>
In-Reply-To: <20180510165220.GA9757@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180509084120.GF12217@hirez.programming.kicks-ass.net>
        <20180509084518.247650e2@lwn.net>
        <20180510122335.GA7704@andrea>
        <20180510071559.59dcc8cc@lwn.net>
        <20180510165220.GA9757@andrea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4AHk2mB022367

Em Thu, 10 May 2018 18:52:20 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> escreveu:

> On Thu, May 10, 2018 at 07:15:59AM -0600, Jonathan Corbet wrote:
> > On Thu, 10 May 2018 14:23:35 +0200
> > Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> >   
> > > only
> > > remember that other people (including some developers running into the
> > > "disadventure" of opening an RST doc. from their preferred text editor
> > > and being brought to conclude:  "WTH!  I need to open a web browser, I
> > > guess...") _use_ such doc. and _do care_ about it, and that what might
> > > be an improvement for some people might look as "vandalizing" to others.  
> > 
> > If you have an example of a place where use of a web browser has been
> > made mandatory, please point it out.  Avoiding that was at the top of the
> > list of explicit requirements.  
> 
> That's all I need.
> 
> 
> >Surely an extra colon is not going to
> > force you to run screaming to the protective embrace of Firefox...?  
> 
> Let me put it in these terms: I believe that that extra colon (or the
> "diagram" keywork) is not going to improve/help my use of the doc. ;D

No, it won't improve, but, it won't make it harder for a human
to understand if a "diagram" or "::" is added at the description.

The thing is that we need something that works for the Kernel as
a hole, and not just on a few places.

On some subsystems, just a text is not good enough to describe
things. See, for example:
	https://www.kernel.org/doc/html/latest/media/uapi/v4l/crop.html
	https://www.kernel.org/doc/html/latest/media/uapi/v4l/pixfmt-packed-rgb.html
	https://www.kernel.org/doc/html/latest/media/uapi/v4l/pixfmt-srggb10-ipu3.html
	https://www.kernel.org/doc/html/latest/gpu/drm-kms.html

Images, complex tables, etc are sometimes required to show some things.
Trying to explain just on text is harder to write, longer and worse
for readers. In the past, DocBook was used. ReST made very simple to
write documentation. From where I sit, I'm reviewing documentation
patches from a lot more people than the usage of a markup language.

As a bonus, we can now create cross-references for kernel-doc functions,
with is really great when reading documentation for complex hardware.

>From where I sit at media, the subsystem documentation, if generated
in PDF, becomes a book with more than 1,100 pages, full of long tables,
images and graphs[1], covering uAPI, kAPI and driver-specific
documentation.

[1] https://linuxtv.org/downloads/v4l-dvb-apis-new/media.pdf

As on all subsystems, developers write documentation directly
at .rst or as kernel-doc comments. But for reading it, even developers
prefer to read the docs via the html (or pdf) output, as it better
shows tables and images. It is also faster to follow the dozen
thousands of links inside it.

The point is: we shouldn't enforce everyone to use our own view
about how to navigate through documentation. People are free to
use whatever improves their workflow.

Thanks,
Mauro
