Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7B20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZRaEE0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeINTNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:13:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42539 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:13:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so7942175lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQCtXaBE3ruBzqa24wI56krTObPub/8ISry1FZjij88=;
        b=gZRaEE0JBFfXCtolMI/0b70dUKcQi2IbMJbp1ehTztB7eLryGSvvVtrYqcpV95U3P+
         U2UVrVa4k/LVNS7pxWR7Cjv+heaJWTCZu20xwGC4IEVpjzZGc+Z3ovHr/TDTrmz35MPe
         aYSxUMbyVGvJYV7RvEgZfCk9J0QUXUgjsvAPkwJdtL1o9egd2Db47GdiLIWIdm+f9g+n
         mhV+8mH4iDEHV9GSiOkIW1w2lS45vxGGOzBOCR0qVV9uPI4IDNJflGuxAhTAk8eNVS0h
         dOtdRt5EjKelDhgmnRCEe2lTZ5O9YxFyV1+okLL21Zekt7FX4e9MEwH/xKBtSpZvaFOh
         rh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQCtXaBE3ruBzqa24wI56krTObPub/8ISry1FZjij88=;
        b=MSoRS730svq5yfKrubAliXWlkUM8z0xb3DDNXW86z70qkEmnqQwnwrw8mhAbNLhK+/
         grO0Fv+NGMlr6RIx0bZ923mGxGtzGjqGSY8w7fY+7Y9l7c5jJJLLw25haSE8Frgi1ZX8
         62GDnKcsuth9RLZ3tUk2XpYVRzaZyOwi1jb7DWNKz4G6q2yrBCUW7jmhh110UYbFYzS/
         ATj8ZCqITc2GRN+m6zcapVlzDagVRuMSFmvhbwtjgGDGKwexgPYp3LEbtSvaIBTxJsAk
         5pHqky9y03nfZrH/NyIhaXSd5Af+6H0hkOX6nhe2UAmL2butMfmDvEMYsxFFpr7nWog8
         Vqvg==
X-Gm-Message-State: APzg51Ck0AXLmo55taW1vw456NXaQNdDw5pZfwz1G5xphE6xFI4u1bCI
        S4GvDodKxSW2xss3tri3YaNMtIr0
X-Google-Smtp-Source: ANB0VdZnYZsvy2TtQYlE+l2s1PeNEk6aXukaELZi+KcFqkdrbDW8JJqU55PHc4pnSJQu4E0Q1XlMnw==
X-Received: by 2002:a19:884:: with SMTP id 126-v6mr8862753lfi.23.1536933521812;
        Fri, 14 Sep 2018 06:58:41 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k4-v6sm1212341ljc.6.2018.09.14.06.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:58:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0ocM-0005ln-Rd; Fri, 14 Sep 2018 15:58:43 +0200
Date:   Fri, 14 Sep 2018 15:58:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/50] io_edgeport: switch to ->get_serial()
Message-ID: <20180914135842.GK1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-23-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-23-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:22AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/usb/serial/io_edgeport.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 97c69d373ca6..4ca31c0e4174 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
 
> @@ -1667,17 +1663,12 @@ static int edge_ioctl(struct tty_struct *tty,
>  					unsigned int cmd, unsigned long arg)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
> -	DEFINE_WAIT(wait);

hmm, why was there no gcc warning about this leftover?

>  	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
>  
>  	switch (cmd) {
>  	case TIOCSERGETLSR:
>  		dev_dbg(&port->dev, "%s TIOCSERGETLSR\n", __func__);
>  		return get_lsr_info(edge_port, (unsigned int __user *) arg);
> -
> -	case TIOCGSERIAL:
> -		dev_dbg(&port->dev, "%s TIOCGSERIAL\n", __func__);
> -		return get_serial_info(edge_port, (struct serial_struct __user *) arg);
>  	}
>  	return -ENOIOCTLCMD;
>  }

Reviewed-by: Johan Hovold <johan@kernel.org>
