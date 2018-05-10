Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757415AbeEJSTG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:19:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:59842 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756741AbeEJSTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:19:05 -0400
Date: Thu, 10 May 2018 14:19:01 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
Message-ID: <20180510181901.GG8335@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, Arnd Bergmann <arnd@arndb.de>
References: <20180510125211.12583-1-dima@arista.com>
 <20180510125211.12583-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510125211.12583-2-dima@arista.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:52:10PM +0100, Dmitry Safonov wrote:
> Currently "suppressed" messages will be printed once in a second for
> unseeded/urandom warnings, but there is already custom message which
> says how many warnings are missing. So, let's skip suppressed messages
> until crng_init == 2.

I'm not sure what you are trying to fix?  The whole point of the
ratelimit system is to nly allow no more than <burst> packages in a
particular time interval.  Once that time interval has expired,
messages allowed again until they exceed the burst limit.  So printing
messages once a second is, in fact, working as intended.

	      	       	      	    	    - Ted
