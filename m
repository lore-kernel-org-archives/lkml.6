Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E20C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3820657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeIRTBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:01:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeIRTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:01:38 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D684DCE7;
        Tue, 18 Sep 2018 13:28:59 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:28:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jslaby@suse.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
Message-ID: <20180918132856.GA14333@kroah.com>
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906134214.29031-3-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:42:14PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> When mode is set in atmel_config_iso7816() we backup last RS232 mode
> for coming back to this mode if requested.
> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> function as well.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 190 +++++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/atmel_serial.h |   3 +-
>  2 files changed, 181 insertions(+), 12 deletions(-)

This doesn't apply to my tree :(

Also, shouldn't this new ioctl be documented somewhere?

thanks,

greg k-h
