Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeEJTkq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:40:46 -0400
Received: from imap.thunk.org ([74.207.234.97]:33170 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeEJTkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:40:45 -0400
Date: Thu, 10 May 2018 15:40:41 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
Message-ID: <20180510194041.GH8335@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, Arnd Bergmann <arnd@arndb.de>
References: <20180510125211.12583-1-dima@arista.com>
 <20180510125211.12583-2-dima@arista.com>
 <20180510181901.GG8335@thunk.org>
 <1525977460.28243.2.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525977460.28243.2.camel@arista.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 07:37:40PM +0100, Dmitry Safonov wrote:
> 
> Ok, then what's the purpose of those messages?
> :        pr_notice("random: %d get_random_xx warning(s) missed "
> :                  "due to ratelimiting\n",
> :                  unseeded_warning.missed);
> :        pr_notice("random: %d urandom warning(s) missed "
> :                  "due to ratelimiting\n",
> :                  urandom_warning.missed);
> 
> I thought you want to print the summary after initializing random,
> not once per second?

Yes, and that's what is happening today.  The "output lines suppressed
due to ratelimiting" message is only printed out by printk_ratelimit()
function, which we are *not* using.

So I'm not sure what you are unhappy about?  What are you trying to fix?

>From my testing, it is *NOT* double-printing ratelimit messages today.
Are you seeing something that I am not?

       	   	     	     	     	     	  - Ted
