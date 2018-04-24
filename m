Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758145AbeDXN43 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:56:29 -0400
Received: from imap.thunk.org ([74.207.234.97]:51114 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933570AbeDXN4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:56:24 -0400
Date: Tue, 24 Apr 2018 09:56:21 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180424135621.GD4189@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 01:48:16PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> w
> Since Linux 4.17-rcX, Linux spams a lot of `random: get_random_u32 called
> from` messages. I believe, this setting should be reverted by default as
> otherwise a lot of other messages are not seen.

Can you tell me a bit about your system?  What distribution, what
hardware is present in your sytsem (what architecture, what
peripherals are attached, etc.)?

There's a reason why we made this --- we were declaring the random
number pool to be fully intialized before it really was, and that was
a potential security concern.  It's not as bad as the weakness
discovered by Nadia Heninger in 2012.  (See https://factorable.net for
more details.)  However, this is not one of those things where we like
to fool around.

So I want to understand if this is an issue with a particular hardware
configuration, or whether it's just a badly designed Linux init system
or embedded setup, or something else.  After all, you wouldn't want
the NSA spying on all of your network traffic, would you?  :-)

    	       	      	      	      - Ted
