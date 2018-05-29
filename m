Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966936AbeE2UwE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:52:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:42068 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966652AbeE2UwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:52:01 -0400
Date: Tue, 29 May 2018 16:51:44 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Coly Li <colyli@suse.de>, Ciaran Farrell <ciaran.farrell@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        linux-bcache@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonas Oberg <jonas@fsfe.org>
Subject: Re: PostgreSQL licensed code on Linux
Message-ID: <20180529205143.GB7381@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Coly Li <colyli@suse.de>, Ciaran Farrell <ciaran.farrell@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        linux-bcache@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonas Oberg <jonas@fsfe.org>
References: <CAB=NE6XGCM0nZqvq74JPnSKgvL37Nkwvr3H3cAQ=ooTYJt7Rdg@mail.gmail.com>
 <20180529192643.GA3487@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529192643.GA3487@kmo-pixel>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:26:43PM -0400, Kent Overstreet wrote:
> > That seems to indicate that we've had already PostgreSQL licensed code on
> > Linux since Kent's addition of bcache to Linux in 2013. The portion of code
> > is rather small though, to me it seems to cover only crc_table[],
> > bch_crc64_update(), and bch_crc64().
>
> > As silly as it may be we should split out the PostgreSQL licensed code from
> > drivers/md/bcache/util.c into its own file and while at it clarify the
> > license.

While we're at it maybe we should move the crc-64 code to lib and/or
crypto, alongside our support for crc-8, crc-16, and crc-32
algorithms?  That way if there are other potential users for crc-64,
they will be less likely to re-invent the wheel....

     	     	  	    	      	  - Ted
