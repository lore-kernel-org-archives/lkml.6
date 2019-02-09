Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1965C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7023F217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549705368;
	bh=a1NxiUuIjW1lot1PX6sYox3ZwJrB1M2jV3CWj3U1Prc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G5Ul8pq64uzLnoa3YidMX4vpboDBLQNS6vMFkJSxm0nQhB+bDqV4/asknt6dRhM1v
	 RMiH1UtDQ+uEMimMKFBiFkPRLX80rqHwxfVisCcEHPrDVY19cr0NBOSeipKGgwivxl
	 Dy5frZ5AHOsDR5T2owbG9kQqrslDNSeHWOojKyyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBIJmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:42:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfBIJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:42:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so5021904lja.5;
        Sat, 09 Feb 2019 01:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZy9hQ9IGIZVouTPejSUMeig879RML4vqMuudanoN8w=;
        b=lGFd9ng5FWl/yo//yBoNwCRI+uhHn4pd2HGGqhnzcV9FB9u/yhwhEoZNHTzKMUZVtp
         R7nHDLiIp824l1jjRcHSR3k8IEHP/LbhaOys+fhfZYUKksvR1SgsAIziDPjAJiZxrmbM
         4mWbSOIWW1tUSPKBOeHgOS+PeTSyhOmCq/GVjl+Pjl1SL4M6SAWC+Sg/MN1t4kc9deS/
         3HILxWOy+GvrALcLz/heSoI9aCQBbdOqKC36T4aYfVgQUnw9NVei294HX5LvoQgY17/V
         KIGlzSKB68hradtQnsZmTZUwOIHiQ+V2vm75eDAl9Y0ccK8t5+NbGe47p+9IRnCtr2/C
         o+lQ==
X-Gm-Message-State: AHQUAuZIMhBoqsfwnk1c+ABRIkMwYUCsseFUUWgwQM7f5aLGTISSdh5A
        dg14dgFSaeDVSHeZexzqcco=
X-Google-Smtp-Source: AHgI3IbeKM2ID929pyoDcoC8Fvb6DzlOlsHfn6bQyiewi7pbCJRnjzmkAdwvgoKBg5e4K6g4tEXqmA==
X-Received: by 2002:a2e:9c83:: with SMTP id x3-v6mr1958236lji.178.1549705364026;
        Sat, 09 Feb 2019 01:42:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a3-v6sm935557ljd.20.2019.02.09.01.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 01:42:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gsP9j-0007hO-QR; Sat, 09 Feb 2019 10:42:39 +0100
Date:   Sat, 9 Feb 2019 10:42:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] bluetooth: Fix WARNING in tty_set_termios()
Message-ID: <20190209094239.GQ4686@localhost>
References: <20190208230609.23926-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208230609.23926-1-shuah@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:06:09PM -0700, Shuah Khan wrote:
> tty_set_termios() has the following WARN_ON which can be triggered with a
> syscall to invoke TIOCSETD __NR_ioctl.
> 
> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>                 tty->driver->subtype == PTY_TYPE_MASTER);
> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
> 
> "The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty."
> 
> Fix hci_uart_tty_open() to check if tty supports set_termios in addition
> to write and error out, if it doesn't.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..087ec2268744 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -474,10 +474,10 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>  
>  	BT_DBG("tty %p", tty);
>  
> -	/* Error if the tty has no write op instead of leaving an exploitable
> -	 * hole
> +	/* Error if the tty has no write/set_termios ops instead of leaving
> +	 * an exploitable hole.

Why do you think that a tty driver not implementing set_termios() is
exploitable?

Note that tty_set_termios() handles a missing set_termios() callback
just fine without dereferencing a NULL-pointer.

>  	 */
> -	if (tty->ops->write == NULL)
> +	if (!tty->ops->write || !tty->ops->set_termios)
>  		return -EOPNOTSUPP;

I know Marcel asked you do implement things like this, but what you're
really doing is to try to uphold the invariant that tty_set_termios()
should never be called for a pty master. The WARN_ON in that function
was put in place to make sure line-disciplines use the correct ioctl
helpers (and the commit I pointed you to earlier in the paragraph you
quote in the commit message broke that invariant).

I'm afraid this is totally obscured by the above change and misleading
comment update.

Johan
