Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4734F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxKKrtON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAaFN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:13:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:13:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so952948plr.4;
        Wed, 30 Jan 2019 21:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGCyb3jEk8HZWIH52FnaNnYunQZQ/C84AsHyCYpT0Yo=;
        b=PxKKrtON4an60EfsUF4wXv5hX3l23d6iqObZTc9DvAoZCSECI+PUHObSXY97fLFaN/
         7aNCZ5hh1A7EwHWMHYWZc8NRjAPx68MKvSsiVeCKyynjR+IfwK2joKTR7Nt3MhCQe/uv
         rERJzPXH5erWYo+s1uFSYkFh1XD8Yek+go1WnlijTDlE034fHsZhhpotufzR+ptNYevj
         NdgGZd7xF4WSC/Es8nH63VVw22ufgtiY3dvZ8C76c8TyZEiBXV6ScTDpo6LzOQZZ6OQM
         qt5dSXq6PRFkfw71fw+vf0Z0Nwa+M42+fpxaox2eAsMv/mm/Re1ipoF7KyOHppH059gp
         f3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGCyb3jEk8HZWIH52FnaNnYunQZQ/C84AsHyCYpT0Yo=;
        b=TNxMG9XCDoUujyhWGKE4aeLT2Z7t5/o6pzCmAEOMyERWXejrzr8RmElNEeOa2vPmqy
         HyKsEOkf7kfnUmR/sqAOUxcDB3FSPdVNBBdBaSIlhbLleKxGXYXGGmiTRF8qxzysamyh
         Vq8DwYFO46m4/nEPyvWlbT3vIo8697+oEL1gz4qyqpn/uFvCtb8JHwO4EMfSIUixmBGQ
         jBDYGJ3sIWEBn9SsLPQeQAYvo2m6BxpAoqcf4H20M9SKwIaxyLB4uvNJbsX+eluXEy2H
         BhyDQnI93W7yElqHUskESXY9Uh2KreOgOKAoyFckGa6nS9Nts+7zI/KQO99QIscBtrvU
         HOsA==
X-Gm-Message-State: AJcUukdixOdGSzwuqM9Ry/Ukts59bvHa10f94o1wjwkPTCSdcp4nYIaA
        KjPvnCW2g9hCs21t2XJQtXg=
X-Google-Smtp-Source: ALg8bN6SlZ2Owiz72SD7MhDGVMabXR+z6s8A9SjJ7YFOKJMogMCyJKC4AKwrAltaWwnjbkA8Ac6ziQ==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr32503360plo.123.1548911636414;
        Wed, 30 Jan 2019 21:13:56 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id x27sm8859067pfe.178.2019.01.30.21.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 21:13:56 -0800 (PST)
Date:   Wed, 30 Jan 2019 21:13:53 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Switch pty driver to slave side in
 tty_set_termios()
Message-ID: <20190131051352.GB31677@myunghoj-Precision-5530>
References: <20190128065259.GA2976@myunghoj-Precision-5530>
 <20190130100738.GQ3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130100738.GQ3691@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:07:38AM +0100, Johan Hovold wrote:
> On Sun, Jan 27, 2019 at 10:53:02PM -0800, Myungho Jung wrote:
> > tty_set_termios() should be called with slave side of pty driver. So, If
> > tty driver is pty master, it needs to be switched to ->link.
> 
> I'm not sure that's the right solution. PTYs are virtual devices used
> for IPC and neither end (master or slave) have support for modem
> control or baud rates.
> 
> > Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  drivers/bluetooth/hci_ldisc.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> > index fbf7b4df23ab..90c5ea8c399b 100644
> > --- a/drivers/bluetooth/hci_ldisc.c
> > +++ b/drivers/bluetooth/hci_ldisc.c
> > @@ -299,10 +299,18 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >  	return 0;
> >  }
> >  
> > +/* If driver is pty master, return slave side */
> > +static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
> > +{
> > +	return  (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> > +		 tty->driver->subtype == PTY_TYPE_MASTER) ? tty->link : tty;
> > +}
> > +
> >  /* Flow control or un-flow control the device */
> >  void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> >  {
> >  	struct tty_struct *tty = hu->tty;
> > +	struct tty_struct *real_tty;
> >  	struct ktermios ktermios;
> >  	int status;
> >  	unsigned int set = 0;
> > @@ -314,11 +322,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> >  		return;
> >  	}
> >  
> > +	real_tty = hci_uart_get_real_tty(tty);
> >  	if (enable) {
> >  		/* Disable hardware flow control */
> > -		ktermios = tty->termios;
> > +		ktermios = real_tty->termios;
> >  		ktermios.c_cflag &= ~CRTSCTS;
> > -		status = tty_set_termios(tty, &ktermios);
> > +		status = tty_set_termios(real_tty, &ktermios);
> >  		BT_DBG("Disabling hardware flow control: %s",
> >  		       status ? "failed" : "success");
> 
> So instead of these pointless calls to set the slave termios and
> modem-control state, you might as well bail out early above (and
> similarly in set_baudrate()).
> 
> Using n_hci for a master pty really makes no sense at all, so we could
> even bail out at ldisc open, but perhaps that can be discussed and
> addressed later.
> 
> Johan

Hi Johan,

I fixed it to just return -EOPNOTSUPP if NULL in ath_setup().

Thanks,
Myungho
