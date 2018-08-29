Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D54C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A05205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Na/n+GF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A05205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeH2ULK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:11:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37001 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH2ULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:11:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20-v6so1677279edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TW9QhLN1YOcmGH6k8eOSn2nxDQIdVy0iid+XvYemJL0=;
        b=Na/n+GF0rsIQemSZyTS/WfAq4e+rVyWlib7V32lqu+NOF2Cr2/VwsMOeuPGtjhJgg0
         ocpNxDuyF/1hipE7taKF1oXl1yzIXJPHeniSzgM/p24k3H2pVE4fYVnuQme84c9BpWAn
         qNO1J+a2HbjrPymc0jAIDQ5NcwFhx6Z4PZl0ZDhNVSSnX4TYOOnRt8dE5uTym6v/NeE3
         7QDr4Y7Tr12BmePZ1uJGDtt4jAalt7iB5MuL326BvswqCuc9W/iA8Vj2IUza4hwIVcIS
         E5Fd/5u522QEM1UFg3+ZCFmo40kXGtJuG56JKlCnHKrS6KxZBW7hdmOOTTFt1uJymnwX
         C6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TW9QhLN1YOcmGH6k8eOSn2nxDQIdVy0iid+XvYemJL0=;
        b=brrPGVIJoRWfGUeNzmP1TuzWSarwaQXcoJ4Iznzu9mBk3dTOC3JmRVfOafEnvmaiwa
         2zSJY3CEHUDUjv39t3UpUpcv/w29eG7sBS82RBiVVAYaDUVTRRXoYO0TCFwZnu2atClZ
         PTOSottlY96DLKigf5noYsWroMwW5W8IxAc3wwUSbCKJ0XBarHBmwJ16bWauuygK1STu
         sDo7//FCimZjk5rVoM01BbxrzJR9BMUVKWY4rkGtdXpcR7gP/MWtZDQiYjKdIA3AXG/c
         O7fbR8l1qOeK4qTK/gbjHmxO6IBztKC1pVQtJB3kaFeA/T7mqS6eIkSOyvkAnWcX7Cbb
         S9uA==
X-Gm-Message-State: APzg51DiciXuvFbDT2NJ4t4wXMxo8+UurEZ7ZhclHsh1UufNBdNE58rp
        pbQT2hA1kaHiGSaDVNTDOjZtYfx/kM0=
X-Google-Smtp-Source: ANB0VdY0tOUYyZXYBT8HvroT6306hMHJYLGuXJDweUdjhCssxlP1g/Z4GvXtOBWR2Jybf7AFwbLtFw==
X-Received: by 2002:aa7:c881:: with SMTP id p1-v6mr8565440eds.295.1535559210717;
        Wed, 29 Aug 2018 09:13:30 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1914814edc.57.2018.08.29.09.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:13:29 -0700 (PDT)
Message-ID: <1535559207.23560.55.camel@arista.com>
Subject: Re: [PATCH 1/4] tty: Drop tty->count on tty_reopen() failure
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>, stable@vger.kernel.org
Date:   Wed, 29 Aug 2018 17:13:27 +0100
In-Reply-To: <cbedde00-a0f4-6714-f7f4-a180dca15ce0@suse.cz>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-2-dima@arista.com>
         <cbedde00-a0f4-6714-f7f4-a180dca15ce0@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 16:38 +0200, Jiri Slaby wrote:
> On 08/29/2018, 04:23 AM, Dmitry Safonov wrote:
> > In case of tty_ldisc_reinit() failure, tty->count should be
> > decremented
> > back, otherwise we will never release_tty().
> > Never seen it in the real life, but it seems not really hard to
> > hit.
> 
> I did see it. And this fixes it.

Thanks, I'll add your tested-by, if I'll have to resend.

> 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  drivers/tty/tty_io.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 32bc3e3fe4d3..5e5da9acaf0a 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -1255,6 +1255,7 @@ static void tty_driver_remove_tty(struct
> > tty_driver *driver, struct tty_struct *
> >  static int tty_reopen(struct tty_struct *tty)
> >  {
> >  	struct tty_driver *driver = tty->driver;
> > +	int retval;
> >  
> >  	if (driver->type == TTY_DRIVER_TYPE_PTY &&
> >  	    driver->subtype == PTY_TYPE_MASTER)
> > @@ -1268,10 +1269,14 @@ static int tty_reopen(struct tty_struct
> > *tty)
> >  
> >  	tty->count++;
> >  
> > -	if (!tty->ldisc)
> > -		return tty_ldisc_reinit(tty, tty->termios.c_line);
> > +	if (tty->ldisc)
> > +		return 0;
> >  
> > -	return 0;
> > +	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
> > +	if (retval)
> > +		tty->count--;
> 
> I would just do:
>   if (!retval)
>     tty->count++;
> here. Nobody from ldiscs should rely on tty->count.

I thought about that and probably should have described in commit
message why I haven't done that: I prefer to keep it as was as I did Cc
stable tree - to keep the chance of regression to minimum.

I agree that your way is cleaner, but probably it may be done as
cleanup on top for linux-next..

-- 
Thanks,
             Dmitry
