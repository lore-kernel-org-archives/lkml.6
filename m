Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF543C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F43214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd0w+f14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBDH3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:29:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42040 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfBDH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:29:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so6356698pfr.9;
        Sun, 03 Feb 2019 23:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RUkqMHnNmtHb0Im8JUQwGSer0RH9yyUW825U9IQLPp4=;
        b=pd0w+f14zffQ5A6RyTEfG1eh+YFD9yvhAlB1IDC3CQBgMLTeH1H//9LhEV7Shkr2qE
         b3BmtueKi5mJ3viaeafJF78bEX4XjfLhPWJa9XYNJOUZBNcbmr9Koq/aTYZNweedKabK
         puT9Yl4EVP93vCiV2UAt/S+bHmAelqMp+LpGqSByaaeo2ut96OdwUluqpOzigEy8l6Nf
         hIFosxts47cfdbIvPgFR6IZhVTd9ODJyMe3bImOP2WRm860UArXr6AED1SAt6ZUNlczZ
         InjkY+CpoD8iq9GJa9ZhmaF2anYIy8C5O25kh4+9ft2qXoHtXYp6WTatr7M94EA/XpOG
         KlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUkqMHnNmtHb0Im8JUQwGSer0RH9yyUW825U9IQLPp4=;
        b=ByCZgorvtNWGZ1tAECbBGXRy3yEfYuB+Jb1qYICqWSTQHtgaJ5bqFKL3fRd5SLp4u7
         4X8Dk/B854G5H9xOkkrSSPge4ZmEh5M4x8UwFhVIC+CK9BmXQ5yDUQhpp+dXXDaLiGpz
         /acFYEXQrKiwekULB6kntpVtwXI+2afFri1b6pFzba8FqIu1mGuWguzcGOA5UmebRoU9
         +lbfX1SPZxindK4DhHMTAJIcGN3XSQlcYkcuy+1MxwgwBF38ud9dA+L2m97JnWsAGnlk
         CLzZnxQqEoz2+a44T85VbXel3cDTytGF7T8nXUTVKE+LP3LB9H18oGwzUvhZYC5yiM0g
         4J2g==
X-Gm-Message-State: AHQUAuZ/mpeJFlDF5w66YG0/3g/e+7pdwe1GM6GX+b3hwN/3+fatVSLS
        VZfKUW7WiHwbGw4VJmuZCowowYde
X-Google-Smtp-Source: AHgI3Ibt3c6WFVXApe6VIyX6BEtwZQ3t9mIXdtqJX8RgGnpWRGknQe2HAf8D1Lnd4jYbgUI/muW03g==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr9340396pgv.31.1549265343925;
        Sun, 03 Feb 2019 23:29:03 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id c9sm34969206pfc.92.2019.02.03.23.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:29:03 -0800 (PST)
Date:   Sun, 3 Feb 2019 23:29:00 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190204072859.nrglf7pfj42itzh5@myunghoj-Precision-5530>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
 <20190203063823.GA8228@myunghoj-Precision-5530>
 <20190203105323.GA4686@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203105323.GA4686@localhost>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 11:53:23AM +0100, Johan Hovold wrote:
> On Sat, Feb 02, 2019 at 10:38:24PM -0800, Myungho Jung wrote:
> > On Thu, Jan 31, 2019 at 04:40:00PM +0100, Johan Hovold wrote:
> > > On Tue, Jan 29, 2019 at 09:39:28PM -0800, Myungho Jung wrote:
> > > > tiocmget() and tiocmset() operations are optional and some tty drivers
> > > > like pty miss the operations. We need NULL check to prevent from
> > > > dereference.
> > > > 
> > > > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > > > ---
> > > >  drivers/bluetooth/hci_ath.c   | 6 ++++++
> > > >  drivers/bluetooth/hci_ldisc.c | 4 ++++
> > > >  2 files changed, 10 insertions(+)
> > > 
> > > Ah, you had already submitted a v2.
> > > 
> > > I still suggest splitting this one in two patches and that you add a
> > > Fixes and stable tag to each so that they both get backported to stable.
> > > 
> > > Also, when resubmitting, make sure to include a short changelog here
> > > below the cut-off line (---).
> > > 
> > > > 
> > > > diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> > > > index d568fbd94d6c..fb9f6323a911 100644
> > > > --- a/drivers/bluetooth/hci_ath.c
> > > > +++ b/drivers/bluetooth/hci_ath.c
> > > > @@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> > > >  
> > > >  static int ath_setup(struct hci_uart *hu)
> > > >  {
> > > > +	struct tty_struct *tty = hu->tty;
> > > > +
> > > >  	BT_DBG("hu %p", hu);
> > > >  
> > > > +	/* tty driver should support operations to set RTS */
> > > > +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
> > > > +		return -EOPNOTSUPP;
> > > 
> > > -ENODEV might be more appropriate.
> > > 
> > > Johan
> > 
> > I'll split into 2 seperate patches. So, do I need to add stable tag on each
> > patch like below to be cherry-picked?
> > 
> > Cc: <stable@vger.kernel.org> # <hash>: <summary>
> > 
> > I looked for a good example from mailing list but didn't find one.
> 
> Almost right, the format you use above is actually used to identify
> dependencies for backports.
> 
> You should add a Fixes tag identifying the commit which introduced each
> bug and a stable-cc tag. If you want you can indicate the version after
> a # sign, but that can also be inferred from the fixes tag.
> 
> For the hci_ldisc fix I think the tags would be:
> 
> 	Fixes: 2a973dfada2b ("Bluetooth: hci_uart: Add new line discipline enhancements")
> 	Cc: stable <stable@vger.kernel.org>     # 4.2
> 
> You can use git blame to track down the offending commits.
> 
> This should all be explained here:
> 
> 	https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Johan

Thank you for the explanation. I'll carefully read the page and submit the next
patch.

Thanks,
Myungho
