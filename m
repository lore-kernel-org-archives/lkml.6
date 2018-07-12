Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A91A208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A91A208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeGLPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:34:54 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1964 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeGLPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:34:53 -0400
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="13496163"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jul 2018 08:24:51 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Thu, 12 Jul 2018
 08:24:51 -0700
Date:   Thu, 12 Jul 2018 17:23:41 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-arch@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <richard.genoud@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <jslaby@suse.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485
 or ISO7816 mode
Message-ID: <20180712152341.p4lmjyldujv6et56@M43218.corp.atmel.com>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, alexandre.belloni@bootlin.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jslaby@suse.com, linux-arm-kernel@lists.infradead.org
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711132623.13227-1-ludovic.desroches@microchip.com>
 <20180712145827.GB22502@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180712145827.GB22502@kroah.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:58:27PM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 03:26:23PM +0200, Ludovic Desroches wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> > Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> > calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> > that is already in place for this purpose.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > ---
> >  drivers/tty/serial/atmel_serial.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Did you send this patch twice?
> 
> confused,

Yes sorry, as I didn't receive patch 3/3, I resend it. At the end, it
was sent twice.

Regards

Ludovic

> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
