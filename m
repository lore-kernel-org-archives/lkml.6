Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524643889; cv=none;
        d=google.com; s=arc-20160816;
        b=zAUElQ8JZ15N5BwtSNdFt9+gBfZf0f0lJXpTtOzerXy2BBnmGFr1nB58H28I8jU5nW
         TpGNFnFL5FLNzg+CLZxlcnxrC5kfd0UeHFfBF7TpyeDh3arVrEL+b0aQsIVMALUVmqVI
         J5gGc6v3stFDu23GIB0oA+GfglR+c62tCqpB51cwjjt6RQkY0/66+lhzMT09EEA0czaW
         Q/ja9awZwNL6xNGHBEc1pX9/S2jzNAB/x8yOyEzDd3tXPm2y73XTX3dgFteHIbxIlGQO
         FyJ2z9H4XtLcB7Sp8E8kwCvTCkMFLgm/DSkZRAGrgbQkGiG2/FuRvctopSzeDFXsXRmo
         IJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=M8JvaPmKcblmUmCMw1ce19k9BgYiDZt/WODktpuKX6s=;
        b=h5MPcZxNvQiDw41Ta/FZGaNkr6kJVMLh0XfU4duRwyE90dMkrkT9/xll/pa3M9JNep
         K+oSN/rKvPW1I4/QnbFFqAVXGeQnMgxZqs07Mf67FDDg6bDJCVFNm9CGzHJhZVY/4Umv
         Mt2Tx58TIeaFg5/vP/lhCSou6DfH7+3DJKNJaZdRfWiemvFHiZAaSeOWAy0HynKd6fPX
         s7nmVS+sMGG+KK6VjBMmgTETv+liF29wom0NhgaDcdulcaFv1J5RK8BYUGQA7LyD6B3F
         EEBYpNrPp4Thz4RhAEzhGbqCly4UgUY+G0dZVNJZQV//Y+VTbOdwqzgPY41M+vPnVtrv
         qFpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HkIqYKxl;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HkIqYKxl;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZp0fnKMY4bhGgEJgV0eTSHOnfnoA7Za24m7SPZoNYiIMQvG2lVNySoEIBBpFj3z5+DBuBp4eQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 10:11:20 +0200
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425081120.GL4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <31CF06C6-D6ED-4930-8D81-12256A518059@goldelico.com>
 <20180424175050.GG4615@localhost>
 <8F4FAF5B-AAA9-4D46-A022-99B96C74ABFA@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F4FAF5B-AAA9-4D46-A022-99B96C74ABFA@goldelico.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598704990815496707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 09:44:08PM +0200, H. Nikolaus Schaller wrote:

> > Am 24.04.2018 um 19:50 schrieb Johan Hovold <johan@kernel.org>:

> > I think it should be done the other way round (if I understand you
> > correctly), that is, by adding support for configurations were WAKEUP is
> > left not connected to the sirf driver instead.
> 
> Hm. Yes, the w2sg00x4 is a Sirf based chip.
> 
> > I had that use-case in mind when implementing
> 
> s/implementing/reinventing/
> 
> > the driver, and some ideas of how it should be
> > done, but did not get around to actually implement it yet.
> 
> What do you need ideas for? We have that function working and
> submitted year after year, but it was always rejected for API
> reasons.
> 
> You could have simply reused what we have proposed [1] and just
> adapt it to the new API instead of writing a new driver (which
> is missing some features for us).

Your code was broken or needed to be updated in several ways as I
pointed out in the thread you refer to.

It also did not support all those systems that use the same family of
chips, but which has the WAKEUP signal connected.

> "proof-of-concept" is misleading if you expect this to become
> *the* Sirf driver and we are just invited to add some features
> to that. Making our own work and proposals completely obsolete.
> 
> What I find really strange and foul play is that we are in the
> review process and then comes a hidden counter-proposal by the
> reviewer.

Dude, in the very same thread you refer to above, after being asked to
reiterate your proposal to find and appropriate abstraction level you
reply:

	"Yes, please feel free to write patches that implement it that
	way."

Now I've done just that for you, and then you whine about that too.

SiRF is a very common chip and I wanted to make sure that the common
setup with WAKEUP connected was supported from the start. I'll get to
your configuration in time too.

Johan

> [1]: https://patchwork.ozlabs.org/cover/843392/
