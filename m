Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C9C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836E521479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsUqOyUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBBEzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:55:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfBBEzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:55:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7517610ljd.12;
        Fri, 01 Feb 2019 20:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=b8Vll334F3rCjHyxrsD6gX6NXlEadiPEZ1K0Ra/O4Es=;
        b=tsUqOyUuyP4HQOo7GBMx26N7DbG4qZMZLYHRropSclgvK5b3D6dad6IcqUq+45BH+Z
         RBNb3mvcSgADuasBTScTmHO5q8QxoJtTgeNbgaiSmiYPrbhGGeV9+GImwzZh3itMlTfj
         7V0jS+8PhR/E2FH5vT/Gz3Xf3IrTfXoPWDqooWcTgd0E39emjjgqcdzu8LUV2Gfbhqvj
         QI5A5gR2BUeE/dO81g667vodqgz7ZAj8wRbPVNQLO8MFF2w0h18CLIPIRMjovMpH8Vdg
         VYvam1GRfnhaMGcLaDo5eLQ/+sr8qzxadB4Rv3V2b1auPnDWpee7ZusRewg/i7BjOiTv
         NVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b8Vll334F3rCjHyxrsD6gX6NXlEadiPEZ1K0Ra/O4Es=;
        b=EmCwDgI9/6rjCbw53zdaprlIJK/b1PVRgkYKi9PZHmXWxnXZdjthUaMjHS6MbcW6zc
         K581KvMo5zg/Uv/P2hl5x6X0z1CwQLK1ri9t8oVoZeMHwMwxWe+gPh9u2KIGd4rUcZ5a
         e3NMqduQBHvVbQIWV5lZsS+vm/gYPe9ICHD53rNfShb0P3jiyz7q91521UIFTshP2eHb
         3lpwD8BC/QYgsnn4alD4UezKzgJHMGQ+HyqIaNJNm+fuXst2kcUHBtcEfHEkq+6LkUFz
         dFJlCO+fNxdfJTYUQ6lBTBKc4LJr/dyyXqT5j5SQiHT+CEbLje9WJCWAbAnyAryMyI6R
         8q8Q==
X-Gm-Message-State: AJcUukd8a+BuI8Caw+gxIPQo8RVQPbEArkxskLWHtTQUrSQwZqDECqwL
        /dLlKvnX1XaUqTunCWwcaqNEaNxv6EQ=
X-Google-Smtp-Source: ALg8bN4ZEd/6c37NGHRQkRIz0FDSQezaduq87/CygOTWvDkSnoudNtRUwsybBstOcRsNA7aG0wIjpg==
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr30680781ljg.138.1549083333302;
        Fri, 01 Feb 2019 20:55:33 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id m4-v6sm1575342ljb.58.2019.02.01.20.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 20:55:32 -0800 (PST)
Message-ID: <84950aa0d194f28389f3bb209154ddc26e96c6de.camel@gmail.com>
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Jerry.Hoemann@hpe.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Sat, 02 Feb 2019 09:55:29 +0500
In-Reply-To: <20190116022731.GD18342@anatevka>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
         <20190114023617.10656-2-mironov.ivan@gmail.com>
         <20190116022731.GD18342@anatevka>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 19:27 -0700, Jerry Hoemann wrote:
> On Mon, Jan 14, 2019 at 07:36:14AM +0500, Ivan Mironov wrote:
> > Existing code disables watchdog on NMI right before completely hanging
> > the system.
> > 
> > There are two problems here:
> > 
> >  * First, watchdog is expected to reset the system in a case of such
> >    failure, no matter what.
> 
> Documentation/watchdog/watchdog-api.txt
> 
> explicitly allows for pretimeout NMI and generation of kernel crash dumps.
> 
> By removing hpwdt_stop the system will likely fail to crash dump
> as there is only 9 seconds between receipt of a NMI and the iLO
> resetting the system.
> 
> Unfortunately, kdump is not without issues and can also be difficult
> to properly configure either of which can result in failure to dump
> and reset.
> 
> Customers who value availability over kdump collection, the pretimeout
> NMI can be disabled and hardware will not issue the pretimeout NMI
> and will only do reset.
> 
> A middle ground for those who want tombstones but not kdump, would
> be to leave the pretimeout NMI enabled and add "panic=N" to the
> Linux command line.  That way after the panic, the tombstone is
> printed and the system resets after N seconds.
> 
> 

Somehow I missed the whole pretimout thing when reading about the
watchdog API. Thanks for clarification, now code makes much more sense
=).

Still, I do not really understand the point of enabling of kdump
support in hpwdt driver by default while kdump is not enabled by
default.

Also, existing code may call hpwdt_stop() (and thus break watchdog)
even if pretimout is disabled.

Also, "panic=N" option is not providing a way to *not* panic on NMI
unrelated with iLO. This could be circumvented by blacklisting the
hpwdt module entirely, but normal watchdog functionality would be lost
then.

It is possible to rebuild kernel without HPWDT_NMI_DECODING (which is
enabled in Fedora, for example). But it is nearly impossible to come to
this solution without examining the source code, because description of
this option does not mention that it is really about pretimout support
and panics and not about something else...

I would say that current default behavior of hpwd is slightly confusing
in multiple different ways.

> 
> >  * Second, this code has no effect if there are more than one watchdog.
> 
> That is correct.  Hpwdt will not turn off any other WDT.
> 
> I don't see a current method of notifying other watchdogs
> that a given watchdog is going to take the system down.
> 
> The closest I hook see is watchdog_notify_pretimeout, but I don't
> see that notifying other WDT.  Its not clear to me that it should.
> (e.g. the second WDT could be of longer duration and protect against
> kdump hanging. This would need to be thought through.)
> 
> 
> 
> > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index ef30c7e9728d..2467e6bc25c2 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -170,8 +170,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  	if (ilo5 && !pretimeout && !mynmi)
> >  		return NMI_DONE;
> >  
> > -	hpwdt_stop();
> > -
> >  	hex_byte_pack(panic_msg, mynmi);
> >  	nmi_panic(regs, panic_msg);
> >  
> > -- 
> > 2.20.1

