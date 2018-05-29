Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934452AbeE2NKP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934378AbeE2NKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:09 -0400
Date: Tue, 29 May 2018 15:09:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us,
        tklauser@distanz.ch, linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net, linux-api@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org
Subject: Re: [patch v23 1/4] drivers: jtag: Add JTAG core driver
Message-ID: <20180529130948.GC30119@kroah.com>
References: <1527594545-19870-1-git-send-email-oleksandrs@mellanox.com>
 <1527594545-19870-2-git-send-email-oleksandrs@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527594545-19870-2-git-send-email-oleksandrs@mellanox.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 02:49:02PM +0300, Oleksandr Shamray wrote:
> +static int jtag_release(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}

If you do not do anything, then there is no need to have this callback
at all, right?

> +/**
> + * enum jtag_endstate:
> + *
> + * @JTAG_STATE_IDLE: JTAG state machine IDLE state
> + * @JTAG_STATE_PAUSEIR: JTAG state machine PAUSE_IR state
> + * @JTAG_STATE_PAUSEDR: JTAG state machine PAUSE_DR state
> + */
> +enum jtag_endstate {
> +	JTAG_STATE_IDLE,
> +	JTAG_STATE_PAUSEIR,
> +	JTAG_STATE_PAUSEDR,

Be specific with these enums, set them to a value so you know all is
good.  Userspace C compilers can be funny at times.

Otherwise, looks really good, nice work.

greg k-h
