Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88273C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C13A2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 06:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrNXccpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBCGi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 01:38:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34702 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfBCGi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 01:38:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so5317879pfg.1;
        Sat, 02 Feb 2019 22:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HfheAJSIQlHyMRAytqF17V6asDCHPQD+Fbosi3E3DQ=;
        b=IrNXccpE5kRnoRTzacGNFflnnYaDQNE3KeFSbH3yi3DkB+Ny1u17rS6E8pMdtfRT+0
         3j4ocdAl7la8XQcep4K+Cv53i2KkknRixzWozkrNi3ZvoKPM81MlgnmcBklU2q3+0BS4
         rxOTUgiyVax7ncXTX5FNXYgNBSPIE9QebmLYeeOXArZIaech3tO4fb0VZlxQQTG7EiHz
         HdkjtOMznrrcXJjGWuIEhSXJkeQylXQvxjIcQVELX0J2JJMeNkoDyy8dplTaVywPLgv+
         Q+r1pIAAf2qHcTlICJGASrEermXlUx1h7Bsd9gn3h6c4Z82qkstaFcyM9sjc5gdlisHo
         xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HfheAJSIQlHyMRAytqF17V6asDCHPQD+Fbosi3E3DQ=;
        b=g55FqLR53Np6mKZ3U/Dxip1T2eLgaff4SWvZqS6vTfCWyjAul1PacWMzFeK9Y+Epzd
         BrUuHV4AEhLLg/uRQCGRXCvFkTl8n3WcbSzGMCw858r6THBP0oVgg5twKVQFWZKws6Am
         5YCgM4LU8oCs5ohHTrTUk0JZyUDlY7i6UVA95CQMFCdMrd75auGY5SBQXzpG0cTSwR4E
         M7GXblChl+UEUAKGWW0bNCyiTAnibr4/sm1IZEVBgjQQWe/k5PYOJOgiwbvcYVlj7D0p
         YtQQFekzXX2GWmaNA6vVjobqAe08wzXKcUXr8kq41CBHrLKQzyoL/13zZMKFhVvjdF8u
         hLDg==
X-Gm-Message-State: AHQUAuZdG3BTt+bsBWGLz3/4ofo3IpksRuSuCIN/fFT8UuxIqHw560Sv
        moQzYWZQc0SdNnowt0BlGDs=
X-Google-Smtp-Source: AHgI3IYDzNC8hrRow1G/ctS2WuXubWXkd1FPw3cD4NKvM9duIIsErqkVhYPNRDjPwKsn4WFG1TNG7A==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr8663200pgk.397.1549175907854;
        Sat, 02 Feb 2019 22:38:27 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id s84sm21704138pfi.15.2019.02.02.22.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 22:38:27 -0800 (PST)
Date:   Sat, 2 Feb 2019 22:38:24 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190203063823.GA8228@myunghoj-Precision-5530>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131154000.GU3691@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:40:00PM +0100, Johan Hovold wrote:
> On Tue, Jan 29, 2019 at 09:39:28PM -0800, Myungho Jung wrote:
> > tiocmget() and tiocmset() operations are optional and some tty drivers
> > like pty miss the operations. We need NULL check to prevent from
> > dereference.
> > 
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  drivers/bluetooth/hci_ath.c   | 6 ++++++
> >  drivers/bluetooth/hci_ldisc.c | 4 ++++
> >  2 files changed, 10 insertions(+)
> 
> Ah, you had already submitted a v2.
> 
> I still suggest splitting this one in two patches and that you add a
> Fixes and stable tag to each so that they both get backported to stable.
> 
> Also, when resubmitting, make sure to include a short changelog here
> below the cut-off line (---).
> 
> > 
> > diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> > index d568fbd94d6c..fb9f6323a911 100644
> > --- a/drivers/bluetooth/hci_ath.c
> > +++ b/drivers/bluetooth/hci_ath.c
> > @@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> >  
> >  static int ath_setup(struct hci_uart *hu)
> >  {
> > +	struct tty_struct *tty = hu->tty;
> > +
> >  	BT_DBG("hu %p", hu);
> >  
> > +	/* tty driver should support operations to set RTS */
> > +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
> > +		return -EOPNOTSUPP;
> 
> -ENODEV might be more appropriate.
> 
> Johan

I'll split into 2 seperate patches. So, do I need to add stable tag on each
patch like below to be cherry-picked?

Cc: <stable@vger.kernel.org> # <hash>: <summary>

I looked for a good example from mailing list but didn't find one.

Thanks,
Myungho

