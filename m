Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757455AbeEJShp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:37:45 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:51175 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbeEJShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:37:43 -0400
X-Google-Smtp-Source: AB8JxZqWr59qzyULewTbnhC/GV9AjoTCdtejdGvoOD5C8aARcozls5GqtFK8t1S05en2XPHDEqSDFA==
Message-ID: <1525977460.28243.2.camel@arista.com>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
From: Dmitry Safonov <dima@arista.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 May 2018 19:37:40 +0100
In-Reply-To: <20180510181901.GG8335@thunk.org>
References: <20180510125211.12583-1-dima@arista.com>
         <20180510125211.12583-2-dima@arista.com> <20180510181901.GG8335@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 14:19 -0400, Theodore Y. Ts'o wrote:
> On Thu, May 10, 2018 at 01:52:10PM +0100, Dmitry Safonov wrote:
> > Currently "suppressed" messages will be printed once in a second
> > for
> > unseeded/urandom warnings, but there is already custom message
> > which
> > says how many warnings are missing. So, let's skip suppressed
> > messages
> > until crng_init == 2.
> 
> I'm not sure what you are trying to fix?  The whole point of the
> ratelimit system is to nly allow no more than <burst> packages in a
> particular time interval.  Once that time interval has expired,
> messages allowed again until they exceed the burst limit.  So
> printing
> messages once a second is, in fact, working as intended.


Ok, then what's the purpose of those messages?
:        pr_notice("random: %d get_random_xx warning(s) missed "
:                  "due to ratelimiting\n",
:                  unseeded_warning.missed);
:        pr_notice("random: %d urandom warning(s) missed "
:                  "due to ratelimiting\n",
:                  urandom_warning.missed);

I thought you want to print the summary after initializing random,
not once per second?

-- 
Thanks,
             Dmitry
