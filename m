Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9BC218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548949411;
	bh=C/UsaAM7EPdEmLTJUhTLIw28ifq7A4V/KFCIx5IiqTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wDEE/8+8fa9y3maCXedBflHKIQFVfFsUZG+iLQqlJqFYV9oo+rVQ2H311dotW6Y8/
	 LgVQ2N8p6GQ5T8r3oiZFYtWI+hLj4JvEfyNJ96kJagFh3y8QP2D/fZ25IRV91CH6SL
	 o7ArzLquVo0LWWZPize4W6kMrZtvkrDFpUMMoRt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfAaPna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:43:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732719AbfAaPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:43:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so2701700lfc.1;
        Thu, 31 Jan 2019 07:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCKruneN1VkYRblWDqLxAh0NhNskDittb059H3QEwZk=;
        b=pTuI3iluPeuhunlZoCsmUp2OttZOay4p9NYoIscezR7LIaHQgb3ENQvG5Ov7hhSRCT
         BKeCZOZeMC7te7d9arVQbaWrP/THQGrPu3GLVMgSeAjtR2FkySjqS8l5+BvAy3kAWtyu
         2dSlv1M1Ge69BKaUlQAeSbmlPX7Wb2zNSwIEA46dmSpyXeWstWqpt9uYPHRtYdUzIGnp
         9NJwPZTp7n3Y2hA4VVa/wE19+SekgscTBVFD+FTd7KArbBWUqHZ3aS/M3HumXydn9KWz
         cP1vE+yZMJ3Md4ykJWEnI5w2gIPHAbm4Q8ePJW0CY81kr2brGE7Z3WmNCJhHxsL8dNIB
         CGRg==
X-Gm-Message-State: AJcUukcMbavNCCaLn2TlPk/rsWtKeb0AHlIMrIbqjOY/eWLEVI+efAig
        cUCsveb5Ofj/2MS2nYDB7Wk=
X-Google-Smtp-Source: ALg8bN6ZVnrArr+wIHcm1EarmxyboeqFZNgO1/KAHO2LFgB5/m6jIK8paR1OJDxDTlVQviw+lRUzUA==
X-Received: by 2002:a19:9508:: with SMTP id x8mr27268001lfd.112.1548949407563;
        Thu, 31 Jan 2019 07:43:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x18-v6sm925807lji.27.2019.01.31.07.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:43:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpEUu-0007Tq-8D; Thu, 31 Jan 2019 16:43:24 +0100
Date:   Thu, 31 Jan 2019 16:43:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Switch pty driver to slave side in
 tty_set_termios()
Message-ID: <20190131154324.GV3691@localhost>
References: <20190128065259.GA2976@myunghoj-Precision-5530>
 <20190130100738.GQ3691@localhost>
 <20190131051352.GB31677@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131051352.GB31677@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:13:53PM -0800, Myungho Jung wrote:
> On Wed, Jan 30, 2019 at 11:07:38AM +0100, Johan Hovold wrote:
> > On Sun, Jan 27, 2019 at 10:53:02PM -0800, Myungho Jung wrote:
> > > tty_set_termios() should be called with slave side of pty driver. So, If
> > > tty driver is pty master, it needs to be switched to ->link.
> > 
> > I'm not sure that's the right solution. PTYs are virtual devices used
> > for IPC and neither end (master or slave) have support for modem
> > control or baud rates.
> > 
> > > Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> > > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > > ---
> > >  drivers/bluetooth/hci_ldisc.c | 20 +++++++++++++++-----
> > >  1 file changed, 15 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> > > index fbf7b4df23ab..90c5ea8c399b 100644
> > > --- a/drivers/bluetooth/hci_ldisc.c
> > > +++ b/drivers/bluetooth/hci_ldisc.c
> > > @@ -299,10 +299,18 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> > >  	return 0;
> > >  }
> > >  
> > > +/* If driver is pty master, return slave side */
> > > +static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
> > > +{
> > > +	return  (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> > > +		 tty->driver->subtype == PTY_TYPE_MASTER) ? tty->link : tty;
> > > +}
> > > +
> > >  /* Flow control or un-flow control the device */
> > >  void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> > >  {
> > >  	struct tty_struct *tty = hu->tty;
> > > +	struct tty_struct *real_tty;
> > >  	struct ktermios ktermios;
> > >  	int status;
> > >  	unsigned int set = 0;
> > > @@ -314,11 +322,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> > >  		return;
> > >  	}
> > >  
> > > +	real_tty = hci_uart_get_real_tty(tty);
> > >  	if (enable) {
> > >  		/* Disable hardware flow control */
> > > -		ktermios = tty->termios;
> > > +		ktermios = real_tty->termios;
> > >  		ktermios.c_cflag &= ~CRTSCTS;
> > > -		status = tty_set_termios(tty, &ktermios);
> > > +		status = tty_set_termios(real_tty, &ktermios);
> > >  		BT_DBG("Disabling hardware flow control: %s",
> > >  		       status ? "failed" : "success");
> > 
> > So instead of these pointless calls to set the slave termios and
> > modem-control state, you might as well bail out early above (and
> > similarly in set_baudrate()).
> > 
> > Using n_hci for a master pty really makes no sense at all, so we could
> > even bail out at ldisc open, but perhaps that can be discussed and
> > addressed later.

> I fixed it to just return -EOPNOTSUPP if NULL in ath_setup().

That was the other fix. For this one you need to bail out if the tty is
a pty master so that tty_set_termios never gets called here or in
set_baudrate(). Possibly you can do that already at open().

This is also being discussed here:

	https://lkml.kernel.org/r/20190130103227.GR3691@localhost

Johan
