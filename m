Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeD3QLs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:11:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:45544 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754631AbeD3QLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:11:47 -0400
Date: Mon, 30 Apr 2018 12:11:43 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180430161143.GA20585@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
 <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
 <20180429224928.teg6zyfjxndbcnsn@sultan-box>
 <20180430001106.GS5965@thunk.org>
 <20180430043445.t7wkykxzkhex2isi@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430043445.t7wkykxzkhex2isi@sultan-box>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 09:34:45PM -0700, Sultan Alsawaf wrote:
> 
> What about abusing high-resolution timers to get entropy? Since hrtimers can't
> make guarantees down to the nanosecond, there's always a skew between the
> requested expiry time and the actual expiry time.
> 
> Please see the attached patch and let me know just how horrible it is.

So think about exactly where the possible causes of the skew might be
coming from.  Look very closely at the software implemntation.  The
important thing here is to not get hung up on the software
abstraction, but to look at the *implementation*.  (And if it's an
implementation in architecture specific code, we need to look at all
architectures.)

This applies on the hardware level as hard, but that gets harder
because there many possible hardware implemntations in use out there.
Remember that that on many systems there may be only single clock
crystal, and all other hardware timers maybe derived from that clock
using frequency dividers.  (At least for everything on the mainboard.)

      			       	     	 	    - Ted
