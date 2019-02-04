Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBC6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AAE214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbgvMyei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfBDJEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:04:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36742 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:04:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so6516037plo.3;
        Mon, 04 Feb 2019 01:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5IP7Gd0b96kdpx0TlmqHyk1FdgDMn+M7irorCckpmZI=;
        b=qbgvMyeifCYzxL0u/gL8WoJt5cvt7v6hNjgfAyuMLBEcXH3tBUvH4i1ZaZYr889AFT
         0PVi8D/Bm0fT24RIpxcbCMKHT05a8eMbYzCt1ZOqr27gPoKWGiQ153SyogOddYV7oSGo
         5iWK2pVfBR8jnv1uDRYTClOxxcZYihVjMoMPCskJ53tD+UUrokY2YCZSgwjZuY2succ7
         dXRRENZrpF9xl1N4DbYj3o8zcvoD1/lAy5CejYHOav08ODsNntHgcteA1urOGjTZzOHP
         GnYtjRXyP7nNdO45GgGuZiZGc7wI7Z2vVC2Si3HtN603kJCG/b14GbS5U7cexFUpiohr
         U7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IP7Gd0b96kdpx0TlmqHyk1FdgDMn+M7irorCckpmZI=;
        b=jNwnRahww86zG0xkGLSbT7fr/ArzuDUQ+ySQXJ0pGBwRfNtraRipEPuajEnbA7Z7rm
         rtV7c+AJJH2MW6NX7vAEW5tIn259jb/803VeOa9R5NfRxlAto/F/eoZhN91WSWhIALK3
         JU4kmxEDk7v1DZXWwU28zy3X2Je1Psk6rUG5q9h65LRGJe3bECi/QTj3OgWGR/aJZBTd
         BA0AJjuZ98jL4P7K0e/TbUDdqiixiPNcpXATGBsTvJWurrwqGclDYPZ1J401JZeQnrMI
         ISU3V1dLCkLTGWC2wZtet7rIuJC8PdRgpQWoTHlGHLB6w4k9an+u9Hz8hylSXLlO5FmL
         +LJw==
X-Gm-Message-State: AJcUukfBlhsDaZXUuCxr/aokaDcCZBPkfJ1J6EduWZzpPenbnvG5RsIJ
        QNBsdcPHO4koEaRYeN2cVp4=
X-Google-Smtp-Source: ALg8bN4ZAcjR9qF4PTMH5wpJR+sxaerzO8cHw+xVY/CJMSEz/N0zRzCIRQqJz8VZncWvbpBYq6KMww==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr50355304plv.126.1549271080665;
        Mon, 04 Feb 2019 01:04:40 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id m20sm18077329pgv.93.2019.02.04.01.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 01:04:40 -0800 (PST)
Date:   Mon, 4 Feb 2019 01:04:37 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190204090436.GA3711@myunghoj-Precision-5530>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
 <20190203063823.GA8228@myunghoj-Precision-5530>
 <20190203105323.GA4686@localhost>
 <20190204072859.nrglf7pfj42itzh5@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204072859.nrglf7pfj42itzh5@myunghoj-Precision-5530>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 11:29:00PM -0800, Myungho Jung wrote:
> On Sun, Feb 03, 2019 at 11:53:23AM +0100, Johan Hovold wrote:
> > On Sat, Feb 02, 2019 at 10:38:24PM -0800, Myungho Jung wrote:
> > > On Thu, Jan 31, 2019 at 04:40:00PM +0100, Johan Hovold wrote:
> > > > On Tue, Jan 29, 2019 at 09:39:28PM -0800, Myungho Jung wrote:
> > > > > tiocmget() and tiocmset() operations are optional and some tty drivers
> > > > > like pty miss the operations. We need NULL check to prevent from
> > > > > dereference.
> > > > > 
> > > > > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > > > > ---
> > > > >  drivers/bluetooth/hci_ath.c   | 6 ++++++
> > > > >  drivers/bluetooth/hci_ldisc.c | 4 ++++
> > > > >  2 files changed, 10 insertions(+)
> > > > 
> > > > Ah, you had already submitted a v2.
> > > > 
> > > > I still suggest splitting this one in two patches and that you add a
> > > > Fixes and stable tag to each so that they both get backported to stable.
> > > > 
> > > > Also, when resubmitting, make sure to include a short changelog here
> > > > below the cut-off line (---).
> > > > 
> > > > > 
> > > > > diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> > > > > index d568fbd94d6c..fb9f6323a911 100644
> > > > > --- a/drivers/bluetooth/hci_ath.c
> > > > > +++ b/drivers/bluetooth/hci_ath.c
> > > > > @@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> > > > >  
> > > > >  static int ath_setup(struct hci_uart *hu)
> > > > >  {
> > > > > +	struct tty_struct *tty = hu->tty;
> > > > > +
> > > > >  	BT_DBG("hu %p", hu);
> > > > >  
> > > > > +	/* tty driver should support operations to set RTS */
> > > > > +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
> > > > > +		return -EOPNOTSUPP;
> > > > 
> > > > -ENODEV might be more appropriate.
> > > > 
> > > > Johan
> > > 
> > > I'll split into 2 seperate patches. So, do I need to add stable tag on each
> > > patch like below to be cherry-picked?
> > > 
> > > Cc: <stable@vger.kernel.org> # <hash>: <summary>
> > > 
> > > I looked for a good example from mailing list but didn't find one.
> > 
> > Almost right, the format you use above is actually used to identify
> > dependencies for backports.
> > 
> > You should add a Fixes tag identifying the commit which introduced each
> > bug and a stable-cc tag. If you want you can indicate the version after
> > a # sign, but that can also be inferred from the fixes tag.
> > 
> > For the hci_ldisc fix I think the tags would be:
> > 
> > 	Fixes: 2a973dfada2b ("Bluetooth: hci_uart: Add new line discipline enhancements")
> > 	Cc: stable <stable@vger.kernel.org>     # 4.2
> > 
> > You can use git blame to track down the offending commits.
> > 
> > This should all be explained here:
> > 
> > 	https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > 
> > Johan
> 
> Thank you for the explanation. I'll carefully read the page and submit the next
> patch.
> 
> Thanks,
> Myungho

Hi Johan,

I have one more question. The title of new patches should be version 3 like
this?
[PATCH v3] Bluetooth: hci_ath: ...
[PATCH v3] Bluetooth: hci_ldisc: ...

Or newly start with [PATCH]?

Thanks,
Myungho

