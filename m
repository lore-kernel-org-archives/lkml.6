Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D89DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D51222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQv6mU69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392574AbfBMQSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:18:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42632 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbfBMQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:18:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so1372446plp.9;
        Wed, 13 Feb 2019 08:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbTfhUIu6Oyoh22iP232uSJlyM0cx8pJKYFnXz3wBoM=;
        b=aQv6mU69TSKYLY5TRB4bpC6x0xWBlCj9f97fmPHwdt2/Kmu+AVsOHgzU/uJ2NtIFGo
         NX1Fz11C2gOlce/xTHWL1rT9vcc4ME6zTCdxl08i8vMoHAF9KIv9LquydRTmcCe1hNg4
         X6E890hfaEm0eoB9psTGeW1sKMCqiByS7lWD1aemysykCeJAgixV8C6RLq2tjGOI3iWv
         8sipk+1u6zrsvthvhcbYQuW3dzBqGmSj2X1Cw1Ugnbh3W3iHxeeE6XXij9AacA6ZrEh6
         Gg0opLOkwiDcx3v/QeC2PE+MPAd6f/mqpsAQQ/GA1076EY+1r8xP9GdyaH+4ptZX4Y3g
         qDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbTfhUIu6Oyoh22iP232uSJlyM0cx8pJKYFnXz3wBoM=;
        b=iRL+NIDhRhAzhC1cNqJTvFRVXA9VbMKsaSShA27uY8fBcNLfzvdeTbJvTJQAyhPEih
         HKFmGvzNlcFcqxGC7mXYF+qJtx+HBtZ+KfI0DoDBrT25SIPyi1ZvUGwjfX023VuVMeEa
         Dn3pNFplqwi4iOXsTvzD+XERajQxbnPw08zgN+rXp1zEzWOul4tXbHK7We73htA1ql+d
         5n3R74dnFIbpS81rPNq69qXfwlkXsqpmzznOz6FJ1yz31gnsuXxI/skJmsoIU89DMwiS
         6/4Va/ki21r3w43z+IZYIxpRHyuAaXBRd4qUTF24S7ly4M3HhmR28RWEJEtOl5FhoQ17
         l5YQ==
X-Gm-Message-State: AHQUAuZyTuqOLNJjLnO0OrB2gxntarL5gj9W8SIB5HdnbkWGyUV5Y3Av
        4ONYhLajtRZenrtw0BrB9FY=
X-Google-Smtp-Source: AHgI3Ia47VJ2CfOyckQHHcb1XzdPLJ7BiWVXvMnXzzrmA8nIUGAbqc9bNgNSNsS+tWQRAMypp/L1+w==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr1299576plr.25.1550074679244;
        Wed, 13 Feb 2019 08:17:59 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::72a1])
        by smtp.gmail.com with ESMTPSA id z127sm27486659pfb.80.2019.02.13.08.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 08:17:58 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:18:03 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190213161803.GA21057@bobby.localdomain>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
 <20190211212734.01909e62@archlinux>
 <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
 <20190212204730.16864802@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212204730.16864802@archlinux>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:47:30PM +0000, Jonathan Cameron wrote:
> On Mon, 11 Feb 2019 17:30:18 -0500
> Sven Van Asbroeck <thesven73@gmail.com> wrote:
> 
> > On Mon, Feb 11, 2019 at 4:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > Agreed.  Or potentially just use regmap_bulk_read and rely on
> > > the regmap internal locking to do it for you.  
> > 
> > Neat solution. But it may only work correctly iff regmap_bulk_read()
> > reads the low
> > address first. I'm not sure if this function has that guarantee. If
> > somebody changes
> > the read order, the driver will break. But I think I'm being overly
> > paranoid here :)
> 
> Good question on whether it is guaranteed to read in increasing register
> order (I didn't actually check the addresses are in increasing order
> but assume they are or you would have pointed that out ;)
> 
> That strikes me as behaviour that should probably be documented as long
> as it is true currently.
> 
> > 
> > > So yes, it's more than possible that userspace won't get the same number
> > > of events as samples taken over the limit, but I don't know why we care.
> > > We can about missing a threshold being passed entirely, not about knowing
> > > how many samples we were above it for.  
> > 
> > I suspect that we run a small risk of losing an event, like so:
> > 
> > PS (12.5 ms)
> > --> interrupt -> iio event  
> More interesting if this one never happened, so we got a one off proximity
> event missed.
> 
> > ALS (100 ms)
> > --> interrupt -> iio event  
> > PS (12.5 ms)
> > --> interrupt ========= no iio event generated  
> > ALS (100 ms)
> > --> interrupt -> iio event  
> > 
> > To see why, imagine that the scheduler decides to move away from the
> > threaded interrupt
> > handler right before ap3216c_clear_int(). Say 20ms, which I know is a
> > loooong time,
> > but bear with me, the point is that it _could_ happen as we're not a RTOS.
> > 
> > static irqreturn_t ap3216c_event_handler(int irq, void *p)
> > {
> >         /* imagine ALS interrupt came in, INT_STATUS is 0b01 */
> >         regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
> >         if (status & mask1) iio_push_event(PROX);
> >         if (status & mask2) iio_push_event(LIGHT);
> > 
> >         /* imagine schedule happens here */
> >         msleep(20);
> >         /* while we were not running, PS interrupt came in
> >            INT_STATUS is now 0b11
> >            yet no new interrupt is generated, as we are ONESHOT
> >         */
> >         ap3216c_clear_int(data);
> >         /* clears both bits, interrupt line goes low.
> >             knowledge that the PS interrupt came in is now lost */
> > }
> > 
> > Not sure if that's acceptable driver behaviour. In real life it
> > probably wouldn't matter much,
> > except for occasional added latency maybe ?
> Good point, I'd missed that a single clear was clearing both bits
> rather than just the one we thought had fired.
> 
> If we clear just the right one, (which I think we can do from
> the datasheet
> "1: Software clear after writing 1 into address 0x01 each bit#"
> However the code isn't writing a 3 in that clear, so I'm not
> sure if the datasheet is correct or not...
> 
> and it is a level interrupt (which I think it is?) then we would
> be safe against this miss.
> 
> If either we can only globally clear or it's not a level interrupt
> there isn't much we can do to avoid a miss, it's just a bad hardware
> design.

This totally makes sense, obviously something I had missed.  
I think you are right, if each INT bit is cleared individually,
then that second event won't be lost.

I'll take a closer look at the ideas put forth by you and Sven here on
using mutex on some of the other cases (such as the write_event_config
vs event_handler race condition) and put those into v2.

Thanks again for all the constructive feedback.

-Bobby
