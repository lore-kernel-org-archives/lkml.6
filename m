Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6FCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580382083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpT+a9Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580382083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeINTR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:17:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40202 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:17:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so7964859lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hoefdy4zT+ZZqI+Mq9+ZS67kAssdgAXngJdXIb/iJdc=;
        b=MpT+a9ZwEVvmnR7epyp+3gjG2DhsOtNUfJrqE8e63cTsBF7DHFzcdgt5wytk7PzN/r
         A1VQ1XI8HvYF5EkIhCejb8+V99//lF9gys0pYjaIh9auXOSKeiqr+0+/D5s4TenbBLwq
         CzXoFW5B03Ch22Pv9MR6StK6YkVp1UoLwnRIVY6+hVGByK0YjeLsOLDr0AmwolItbbwX
         +tf57wvTsC4qc8O/yZCNnjgH9gRvP8eyx0NVtyuISe+J4DWXYA356utgmaMqVCdk/AvY
         hrcVOKLe7d0+hzvxuettoEZouqm5Z0ZRH/tRoCbIO7a/9Clikl/b+L6bEFskJXjjdNFF
         k2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoefdy4zT+ZZqI+Mq9+ZS67kAssdgAXngJdXIb/iJdc=;
        b=ZU1JcaUuYEe7SPT87tszM1riMd9G/Q/2fo7V/vWPtKkyezrQ7UIXjwkF17Gw2ao6C9
         BLXD8RlydbuO87Liadyvn/pp6Csi0ddAN3jxN/UY5JbG64zUyt3dBd0t96v2rwHmFz2K
         A4CT3LioGQl9/Q+rqSJkIFqavBq7LmhkxiBMzya1C54id8+pfWvSOJco2Fv3OFsPGIbi
         LhoplwlvRQaBnIt0VF8ejG33Arw0OSspGoRDr93clCD8GPEamIhBeIc/3iUJpq9wCSNy
         anRCPZ5noEMCQzh4GLxqvCNUpySJr46jfxxa+vgpgKS3Sn1/xooj8niyJhlPILO/eIoc
         HIrQ==
X-Gm-Message-State: APzg51AeIhdLhVl7axl38GiGy3dVUMyMAOf51JvKuvFohJUmeu3ONNT9
        jxIRtxB1y3gR0OJY3GBUpy0=
X-Google-Smtp-Source: ANB0VdY4FM05fPkFLwTq5RJ3BerML9K69d/2PGGqoBxPJn8zVhqlMeYZA5vWaPOGFYLcYPNs566dwg==
X-Received: by 2002:a19:c513:: with SMTP id w19-v6mr172218lfe.113.1536933766838;
        Fri, 14 Sep 2018 07:02:46 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d4-v6sm1207858lfc.57.2018.09.14.07.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:02:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0ogJ-0005nl-W1; Fri, 14 Sep 2018 16:02:48 +0200
Date:   Fri, 14 Sep 2018 16:02:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/50] mos7720: switch to ->get_serial()
Message-ID: <20180914140247.GM1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-25-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-25-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:24AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/usb/serial/mos7720.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 4c06357b3ef8..451fca707e04 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -1786,24 +1786,22 @@ static int mos7720_tiocmset(struct tty_struct *tty,
>  	return 0;
>  }
>  
> -static int get_serial_info(struct moschip_port *mos7720_port,
> -			   struct serial_struct __user *retinfo)
> +static int get_serial_info(struct tty_struct *tty,
> +			   struct serial_struct *ss)
>  {
> -	struct serial_struct tmp;
> -
> -	memset(&tmp, 0, sizeof(tmp));
> -
> -	tmp.type		= PORT_16550A;
> -	tmp.line		= mos7720_port->port->minor;
> -	tmp.port		= mos7720_port->port->port_number;
> -	tmp.irq			= 0;
> -	tmp.xmit_fifo_size	= NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
> -	tmp.baud_base		= 9600;
> -	tmp.close_delay		= 5*HZ;
> -	tmp.closing_wait	= 30*HZ;
> -
> -	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
> -		return -EFAULT;
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct moschip_port *mos7720_port;

Newline please.

> +	mos7720_port = usb_get_serial_port_data(port);
> +	if (mos7720_port == NULL)
> +		return -ENODEV;

And no need to check for NULL, even if the current ioctl does so...

> +	ss->type		= PORT_16550A;
> +	ss->line		= mos7720_port->port->minor;
> +	ss->port		= mos7720_port->port->port_number;
> +	ss->irq			= 0;
> +	ss->xmit_fifo_size	= NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
> +	ss->baud_base		= 9600;
> +	ss->close_delay		= 5*HZ;
> +	ss->closing_wait	= 30*HZ;
>  	return 0;
>  }

Reviewed-by: Johan Hovold <johan@kernel.org>
