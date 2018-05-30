Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754912AbeE3E1u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:27:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46619 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750827AbeE3E1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:27:49 -0400
X-ME-Proxy: <xmx:RCgOW9i0GaW-zd7bBd9kEchIn-P-evAERdEY1j4po2WWEeLaprrIsw>
X-ME-Proxy: <xmx:RCgOW-ANREyhylZBwSu--bgrLlDu3f3e40KE0F2EF9BqHoh-HUsY2A>
X-ME-Proxy: <xmx:RCgOW_R4tCofUAZXyEI_g9jj1G3Md8EHdgzyKXoQ4rzM7Dyduk4gMg>
X-ME-Proxy: <xmx:RCgOWzWYJp-BPn37CToJ6-s3jtMKe3_PoEvekm9qnRSVBFDQmSjAtA>
X-ME-Proxy: <xmx:RCgOW4dBKD7PfdN5Y44CZTO1-4BvYtwthpG8WETr7oGeyR6Ag8FTbw>
X-ME-Proxy: <xmx:RCgOW9yD2LykFjWh7Q0FP7niO9ccrH2KZwGWEorKpblqMqrJZOtCSw>
X-ME-Sender: <xms:RCgOW6k5KmmEBlo_oPZMdUsKgVGmcQi-AI9zXF64NH_iwWFw-kjNjw>
Date: Wed, 30 May 2018 14:27:44 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180530042744.GA14188@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <1527472002-11571-5-git-send-email-me@tobin.cc>
 <fde2cc84-f1d8-b1ee-510b-b3659834874d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde2cc84-f1d8-b1ee-510b-b3659834874d@infradead.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:40:43AM -0700, Randy Dunlap wrote:
> On 05/27/2018 06:46 PM, Tobin C. Harding wrote:
> > Currently printing [hashed] pointers requires enough entropy to be
> > available.  Early in the boot sequence this may not be the case
> > resulting in a dummy string '(____ptrval____)' being printed.  This
> > makes debugging the early boot sequence difficult.  We can relax the
> > requirement to use cryptographically secure hashing during debugging.
> > This enables debugging while keeping development/production kernel
> > behaviour the same.
> > 
> > If new command line option debug_boot_weak_hash is enabled use
> > cryptographically insecure hashing and hash pointer value immediately.
> > 
> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  lib/vsprintf.c                                  | 20 ++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2040d46f095..8a86d895343e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -753,6 +753,15 @@
> >  
> >  	debug		[KNL] Enable kernel debugging (events log level).
> >  
> 
> Hi,
> This is much more readable than the previous version.  Thanks.

Thanks for following up with this one Randy.

	Tobin
