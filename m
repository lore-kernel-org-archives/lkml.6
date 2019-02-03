Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE32C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFB32084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmbLeWl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfBCDag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 22:30:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35689 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfBCDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 22:30:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so4794304pgs.2;
        Sat, 02 Feb 2019 19:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IhwZrh8KG3wLPMVgZRFj0uWRKgE0nMItZX7H2lN+yUs=;
        b=MmbLeWl5KImC++p41acG61HIGFFcemopUSbwGonaEYOj6Cch5wfLAEhE00aNsrgLpl
         m+3632j5iSpEmScj0aJfONDnC+h1qcl9hbn2BxxLf5oliyKMHLogU1SJS2HTVXIFoZFE
         Oz+vogXKxh09G8CmQYWHUpy7PQAh38MKFwkIrxzztPU8PCOQMzNzb+39tPsP4EqgDsbx
         ABS/JHewoCykrIzxE/6OOG5MMd5IJdnDdgj2d+zsQZPJ4aqVt9MfkFHLVPQhf4CS6LzU
         +JJ8AM1ua0yG84n0PcnwecP/89djDLDi5mIGKr5w/ePAiyHmgAM3hy1n/MVCwtEq9jVV
         xBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IhwZrh8KG3wLPMVgZRFj0uWRKgE0nMItZX7H2lN+yUs=;
        b=ot8A46R3TqAYrCC+rfyIJjMl7Ic2Gxnj1EwEYtHy2S3u9FqX5We+BZ1tsRmp1shYCk
         ywJdIk/SNqoobe8tCEVFUlYP4EJ1O8Xa8iIHTwXhzJ+IzzMPpa9dwr4C20k+/tPIcWDm
         QMkKzuzjwcMO3QDKUjIeS3HFYojhMegQKpKxWfHlFaLv7iF9I0Xyv1k+IdHteOnDVpSx
         XGyqeEvy3iy9UpmDj8GbAjy4joflP0Hw+eTF+afEdB5ARclbucXtbg4y+qWCkYX9xpN2
         tS/UiyT7W/tQ3w1rCQe9EvWIlzFFTZr7tQGMigVA4c84Zqfxx7POY/It8DDhVhzjpRuh
         YXHQ==
X-Gm-Message-State: AJcUukdJ7n5MJOhRgEeOimn5MF6zDr5j4t2YtxEP59A1nk5mDup82qVr
        YkHH9Mw9OB1vrf9FOow+/uY=
X-Google-Smtp-Source: ALg8bN4mMIB/Ckgsf7R+sTqCynHPchDxv7LYlabHqalYEnYt/m+Q9tyhlQ+CQZb/0xal7Hilg5ZvMA==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr46166253pfb.36.1549164635217;
        Sat, 02 Feb 2019 19:30:35 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id z62sm22276974pfi.4.2019.02.02.19.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 19:30:35 -0800 (PST)
Date:   Sat, 2 Feb 2019 19:30:32 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_uart: Switch pty driver to slave side
 in tty_set_termios()
Message-ID: <20190203033032.GA21013@myunghoj-Precision-5530>
References: <20190202072816.GA15630@myunghoj-Precision-5530>
 <3EC8C1C2-27AE-46B7-A345-860A87B94E6B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EC8C1C2-27AE-46B7-A345-860A87B94E6B@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 01:15:16PM +0100, Marcel Holtmann wrote:
> Hi Myungho,
> 
> > tty_set_termios() should be called with slave side of pty driver. So, If
> > tty driver is pty master, it needs to be switched to ->link.
> > 
> > Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> > drivers/bluetooth/hci_ldisc.c | 27 ++++++++++++++++++++++-----
> > 1 file changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> > index fbf7b4df23ab..0f6e70ea1dc3 100644
> > --- a/drivers/bluetooth/hci_ldisc.c
> > +++ b/drivers/bluetooth/hci_ldisc.c
> > @@ -299,10 +299,21 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> > 	return 0;
> > }
> > 
> > +/* If pty master, return slave side */
> > +static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
> > +{
> > +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> > +	    tty->driver->subtype == PTY_TYPE_MASTER)
> > +		tty->link;
> > +
> > +	return tty;
> > +}
> > +
> > /* Flow control or un-flow control the device */
> > void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> > {
> > 	struct tty_struct *tty = hu->tty;
> > +	struct tty_struct *real_tty;
> > 	struct ktermios ktermios;
> > 	int status;
> > 	unsigned int set = 0;
> > @@ -314,11 +325,14 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> > 		return;
> > 	}
> > 
> > +	/* termios should be set from slave side if tty driver is pty */
> > +	real_tty = hci_uart_get_real_tty(tty);
> > +
> > 	if (enable) {
> > 		/* Disable hardware flow control */
> > -		ktermios = tty->termios;
> > +		ktermios = real_tty->termios;
> > 		ktermios.c_cflag &= ~CRTSCTS;
> > -		status = tty_set_termios(tty, &ktermios);
> > +		status = tty_set_termios(real_tty, &ktermios);
> > 		BT_DBG("Disabling hardware flow control: %s",
> > 		       status ? "failed" : "success");
> > 
> > @@ -350,9 +364,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> > 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
> > 
> > 		/* Re-enable hardware flow control */
> > -		ktermios = tty->termios;
> > +		ktermios = real_tty->termios;
> > 		ktermios.c_cflag |= CRTSCTS;
> > -		status = tty_set_termios(tty, &ktermios);
> > +		status = tty_set_termios(real_tty, &ktermios);
> > 		BT_DBG("Enabling hardware flow control: %s",
> > 		       status ? "failed" : "success");
> > 	}
> > @@ -367,9 +381,12 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
> > 
> > void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> > {
> > -	struct tty_struct *tty = hu->tty;
> > +	struct tty_struct *tty;
> > 	struct ktermios ktermios;
> > 
> > +	/* termios should be set from slave side if tty driver is pty */
> > +	tty = hci_uart_get_real_tty(hu->tty);
> > +
> 
> didn’t we conclude that allowing the HCI line discipline on a PTY master isn't worth the effort? The ptm_unix98_ops doesn’t have the .set_termios and thus, just check that ops->set_termios is present in hci_uart_tty_open and if not fail with EOPNOTSUPP like we do for missing ops->write.
> 
> Regards
> 
> Marcel
> 
Hi Marcel,

I thought there might be some cases that reach here even returning error in
hci_uart_tty_open(). Let me fix it from hci_uart_tty_open.

Thanks,
Myungho

