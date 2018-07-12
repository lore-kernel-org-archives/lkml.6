Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B76213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B76213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeGLPIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:08:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbeGLPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:08:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97603D4F;
        Thu, 12 Jul 2018 14:58:29 +0000 (UTC)
Date:   Thu, 12 Jul 2018 16:58:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jslaby@suse.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485
 or ISO7816 mode
Message-ID: <20180712145827.GB22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711132623.13227-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711132623.13227-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:26:23PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> that is already in place for this purpose.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Did you send this patch twice?

confused,

greg k-h
