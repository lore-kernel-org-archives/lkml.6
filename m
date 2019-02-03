Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0879F21773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549191212;
	bh=cDpnie/3NA++qMFM47vqJHjQyKNvp8KoXNI7C7oa4PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eq7di+/IiaSJglueyZIjycC5B6h99c1Jz7EdWApase4++ratyj2xDWt22SjtzWgfi
	 R5S2EO4BrrP0METFhmoQPvkwKqx0TgpV4xVsEu2xJO+0H1g2o6D1Es3Yn5SGebzdNo
	 DK64Eupd1ehwuQ3rgDFU/Ytbq7btwhwkohyR5aSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBCKx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 05:53:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfBCKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 05:53:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so8189491lfe.11;
        Sun, 03 Feb 2019 02:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mevyq5vjK3YVqqJp1vTJff90i2EWe2ZEZND8e2Khv3Y=;
        b=ZqQjTXQLj97fnS56vYav5oPziAbKVYLUTb+QP70tz+xxtysL3VxA7wS/S/dVDurHCo
         LE6Aw4HILI4u9du9T9JQvm712f3Gcnsyyv/tXOZXWIx5D3kc6yqqUl/gP9CSxnorOWv4
         FAPzpVm/ahH12PIBxGShg2hDWakgJyFJWSpWvX2gXBOJCV/7Uk4CwCrsbvFL4CKhAJ+Z
         WvtU4Kr4zGsy/3f7oZun3oYx+yKyOp4rgzP/nHaqPgMYc4m6N6qUE3ye6059BlfsHC2h
         8kQsuZbKEktogfQAw1gxtUKxfPLUJ/s55UlsnC6cNfr3Pt7dSZta7r4eB2ffMZHtSVxW
         g+gA==
X-Gm-Message-State: AHQUAuZ8c0+RaAJ9KWCOPQwUg7wSYTFBhHcpYkLFu4524SyxwOzSQB70
        1n33TX5FTiA5oBqDuKNGhDPAsJVv
X-Google-Smtp-Source: AHgI3IYvffEjPVmJrnXNBO4tcR1PIGgr0l8J9wPR1E7WKm6XExCLy/cAP8Vq8zAq6or3yeRQq+Tbtg==
X-Received: by 2002:a19:5601:: with SMTP id k1mr14860890lfb.99.1549191205108;
        Sun, 03 Feb 2019 02:53:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g20sm687226lfh.33.2019.02.03.02.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 02:53:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gqFOt-0005Vm-KB; Sun, 03 Feb 2019 11:53:23 +0100
Date:   Sun, 3 Feb 2019 11:53:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190203105323.GA4686@localhost>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
 <20190203063823.GA8228@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203063823.GA8228@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 10:38:24PM -0800, Myungho Jung wrote:
> On Thu, Jan 31, 2019 at 04:40:00PM +0100, Johan Hovold wrote:
> > On Tue, Jan 29, 2019 at 09:39:28PM -0800, Myungho Jung wrote:
> > > tiocmget() and tiocmset() operations are optional and some tty drivers
> > > like pty miss the operations. We need NULL check to prevent from
> > > dereference.
> > > 
> > > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > > ---
> > >  drivers/bluetooth/hci_ath.c   | 6 ++++++
> > >  drivers/bluetooth/hci_ldisc.c | 4 ++++
> > >  2 files changed, 10 insertions(+)
> > 
> > Ah, you had already submitted a v2.
> > 
> > I still suggest splitting this one in two patches and that you add a
> > Fixes and stable tag to each so that they both get backported to stable.
> > 
> > Also, when resubmitting, make sure to include a short changelog here
> > below the cut-off line (---).
> > 
> > > 
> > > diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> > > index d568fbd94d6c..fb9f6323a911 100644
> > > --- a/drivers/bluetooth/hci_ath.c
> > > +++ b/drivers/bluetooth/hci_ath.c
> > > @@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> > >  
> > >  static int ath_setup(struct hci_uart *hu)
> > >  {
> > > +	struct tty_struct *tty = hu->tty;
> > > +
> > >  	BT_DBG("hu %p", hu);
> > >  
> > > +	/* tty driver should support operations to set RTS */
> > > +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
> > > +		return -EOPNOTSUPP;
> > 
> > -ENODEV might be more appropriate.
> > 
> > Johan
> 
> I'll split into 2 seperate patches. So, do I need to add stable tag on each
> patch like below to be cherry-picked?
> 
> Cc: <stable@vger.kernel.org> # <hash>: <summary>
> 
> I looked for a good example from mailing list but didn't find one.

Almost right, the format you use above is actually used to identify
dependencies for backports.

You should add a Fixes tag identifying the commit which introduced each
bug and a stable-cc tag. If you want you can indicate the version after
a # sign, but that can also be inferred from the fixes tag.

For the hci_ldisc fix I think the tags would be:

	Fixes: 2a973dfada2b ("Bluetooth: hci_uart: Add new line discipline enhancements")
	Cc: stable <stable@vger.kernel.org>     # 4.2

You can use git blame to track down the offending commits.

This should all be explained here:

	https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Johan
