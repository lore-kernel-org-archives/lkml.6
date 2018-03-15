Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-124355-1521116388-2-16212616155545443464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521116387; b=MPIY7lz8b43olYI3JnIMOlmU51Ydl31nF5brwRkE8xWycb8
    iQw6cZjLXy1ejJ0ilEf6mOyzUCSqZNkq8ukujlAh7y8kv2gS4kYRO3WbbgdATmx4
    CIRjIC0Z5gWUWyOPBdG05sUbIhbLxKyvAehn9xqQ4AHT6TX2HFPX7vm43WYp/EkX
    P7u4o8L5DlZGw//wEZbDAVUIMttRj/kTeeeyviIJZOiUcLNCwoJ8Z/msGUajE/xF
    T1JfnDnc9udQUIe56vSvCi8Ggk8IHoTHqZhtE6Imsthd47xDExkaofm/84zYweqN
    5OoaPz/vX2cHWu6g1PVSSzsss6QS5yVNda+kGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521116387; bh=rIgJAZf2aCEHBOK79/g2k1Y+/O
    L0QUjaUqD0IbYrc2k=; b=pK5ed88XHUBtThxBH8yjiKmhIcrH4XwylsBs3JHgX+
    iUb22VXSyYA8Pmt06e38A7oYgQ6F+8gOMtvkzucKb1O819mq4y9ig/D6kNOndZGu
    +7pmaZf89kF9YHHHUqssJbzVuQ65CF6bjD5tfCehZSXcS7ytj02zazE4Wm+fduC/
    cg+1R/gWMA6wcdx0ShtL14a/3G/+dshbqo6lzrowMU+9fAnbk/svC6JUTXfXDbB6
    ahqpIG8/BJBF+mBN0Oanakv5bj9XUIAb14sHW4JE/ZXFJzH0VedOg3r+peteVkhJ
    v6DHCgUSJoa4f+nAYFIZUQrNZBJAB7w4wfYqmqoVMzUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=axis.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=axis.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=axis.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=axis.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCOMTU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 08:19:20 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:58102 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOMTQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Mar 2018 08:19:16 -0400
Date: Thu, 15 Mar 2018 13:19:11 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 40/47] serial: remove cris/etrax uart drivers
Message-ID: <20180315121911.GR17177@axis.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-41-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-41-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:53PM +0100, Arnd Bergmann wrote:
> The cris architecture is getting removed, so we don't need the
> uart driver any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  .../bindings/serial/axis,etraxfs-uart.txt          |   22 -
>  drivers/tty/serial/Kconfig                         |   11 -
>  drivers/tty/serial/Makefile                        |    2 -
>  drivers/tty/serial/crisv10.c                       | 4248 --------------------
>  drivers/tty/serial/crisv10.h                       |  133 -
>  drivers/tty/serial/etraxfs-uart.c                  |  960 -----
>  6 files changed, 5376 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
>  delete mode 100644 drivers/tty/serial/crisv10.c
>  delete mode 100644 drivers/tty/serial/crisv10.h
>  delete mode 100644 drivers/tty/serial/etraxfs-uart.c
> 
> diff --git a/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt b/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
> deleted file mode 100644
> index 048c3818c826..000000000000
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3682fd3e960c..f6e09326042d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1114,17 +1114,6 @@ config SERIAL_VT8500_CONSOLE
>  	depends on SERIAL_VT8500=y
>  	select SERIAL_CORE_CONSOLE
>  
> -config SERIAL_ETRAXFS
> -	bool "ETRAX FS serial port support"
> -	depends on ETRAX_ARCH_V32 && OF
> -	select SERIAL_CORE
> -	select SERIAL_MCTRL_GPIO if GPIOLIB
> -
> -config SERIAL_ETRAXFS_CONSOLE
> -	bool "ETRAX FS serial console support"
> -	depends on SERIAL_ETRAXFS
> -	select SERIAL_CORE_CONSOLE
> -
>  config SERIAL_NETX
>  	tristate "NetX serial port support"
>  	depends on ARCH_NETX
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 842d185d697e..c21835dc16b2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -51,8 +51,6 @@ obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
>  obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
>  obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
>  obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
> -obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
> -obj-$(CONFIG_SERIAL_ETRAXFS) += etraxfs-uart.o
>  obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
>  obj-$(CONFIG_SERIAL_SC16IS7XX_CORE) += sc16is7xx.o
>  obj-$(CONFIG_SERIAL_JSM) += jsm/
> diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
> deleted file mode 100644
> index c9458a033e3c..000000000000
> diff --git a/drivers/tty/serial/crisv10.h b/drivers/tty/serial/crisv10.h
> deleted file mode 100644
> index 79ba2bc95d3d..000000000000
> diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
> deleted file mode 100644
> index 24bf6bfb29b4..000000000000
> -- 
> 2.9.0

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
