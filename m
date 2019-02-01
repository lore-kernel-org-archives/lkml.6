Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87418C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549013331;
	bh=ZWSrzGqGcDkzsCbxMSKqo+i1CxyzmnGBYGBHhGUQSIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uhzLmN9Hon0wi7UF220E64lOuMSehFEeX3fHzVOJ31gXQA3d6xTp++eODHRffMhh1
	 loJhUlJJiEJ2sutgQy+Ls0mLVH0EVQyVUqSGfZSaCbtl1Lh3WsNbHy+Lb5V84R1NB0
	 /dnEtjvCtPl3cN3kBK6C304AJU3rhTj46BJB1TwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfBAJ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:28:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44692 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:28:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so4505613lfe.11;
        Fri, 01 Feb 2019 01:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Orb4/Yh0tNK7GyrHjtzMrneVREVx94xbAQgC4293Qrw=;
        b=Mj127OWb2OhFkEywJBKQl3vb1ybPv9MA9r+a1ApJi/9R58PEFsrDmwcluSX6FO0ofl
         1paj53N8GQckxtDEuQnQNZ1Ewr6AeYlsyNIgl5mLyTITLX55lZl+mdNwPD+EmebL/VRH
         YX1hRXdVMpnIKvWvfXQZKVxwsCCgvANTnpp7T598SJITQux9QkX3nI/ZnovfbPtkq4mg
         KF2gLwX1iRLi9ofk9ViAdRpfkmX6f9Z+cWcXtStTWfwBsB+1EQztLXeQUQjsMti1cUK5
         aKOa5R5Wl+ppNhKUvizIDyE6fxeC2ncHDhjsts4c0At8QyB8vbNZtnQtT0qOkGXBeM3c
         Dg6Q==
X-Gm-Message-State: AHQUAuaZDipTV1LUjDqYmpMFHs30GqrHeG5HhD0KmRp/gAtgggiUEYh3
        5BZqUN4pggtTM88V9I1fKIk=
X-Google-Smtp-Source: AHgI3IYYU66OXqs7dxrjf/0bmMmPTTxWRMMvM6yRoP7vZ4OYTk3HZzZty0Wyw2p+5YY6NjOFIGCkKQ==
X-Received: by 2002:a19:760a:: with SMTP id c10mr383123lff.53.1549013326855;
        Fri, 01 Feb 2019 01:28:46 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f1sm1268806lfm.22.2019.02.01.01.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:28:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpV7r-0003R8-1l; Fri, 01 Feb 2019 10:28:43 +0100
Date:   Fri, 1 Feb 2019 10:28:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
Message-ID: <20190201092843.GA3691@localhost>
References: <20190131232359.27948-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131232359.27948-1-shuah@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:23:59PM -0700, Shuah Khan wrote:
> tty_set_termios() has the following WARN_ON which can be triggered with a
> syscall to invoke TIOCSETD __NR_ioctl.

That's the only way to set the hci line discipline. And it's the
consequent ioctl that sets the uart protocol that triggers the warning,
but only if the tty is a pty master, as I mentioned before.

> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>                 tty->driver->subtype == PTY_TYPE_MASTER);
> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
> 
> The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty.

Please always include reviewers on CC, and especially if you end up
citing them directly as you do here. Perhaps add quotation marks or at
least a reference to the discussion where this solution was suggested.

> Fix the problem by preventing setting the HCI line discipline for PTYs
> from hci_uart_setup() and hci_uart_set_flow_control().

This makes no sense. You've already set the line discpline, you're just
making the uart protocol ioctl fail when it tries to register the hci
device.

> The reproducer is used to reproduce the problem and verify the fix.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..ce84ca91ca70 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>  		return;
>  	}
>  
> +	/* don't set HCI line discipline on PTYs */
> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +	    tty->driver->subtype == PTY_TYPE_MASTER)
> +		return;

I don't think you can ever end up here with the below change.

> +
>  	if (enable) {
>  		/* Disable hardware flow control */
>  		ktermios = tty->termios;
> @@ -384,11 +389,17 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  static int hci_uart_setup(struct hci_dev *hdev)
>  {
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct tty_struct *tty = hu->tty;
>  	struct hci_rp_read_local_version *ver;
>  	struct sk_buff *skb;
>  	unsigned int speed;
>  	int err;
>  
> +	/* don't set HCI line discipline on PTYs */
> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +	    tty->driver->subtype == PTY_TYPE_MASTER)
> +		return -EINVAL;

This is too late for what your patch claim that you try to do. This
would fail the hci device registration when setting the uart protocol,
but the line discipline has already been set.

> +
>  	/* Init speed if any */
>  	if (hu->init_speed)
>  		speed = hu->init_speed;

Johan
