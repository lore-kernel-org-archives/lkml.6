Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C06C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGSLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:50:12 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:57498 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeGSLuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:50:12 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w6JB75e8029809;
        Thu, 19 Jul 2018 12:07:06 +0100
Date:   Thu, 19 Jul 2018 12:07:05 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jslaby@suse.com>,
        <arnd@arndb.de>, <richard.genoud@gmail.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Message-ID: <20180719120705.4a2fde04@alans-desktop>
In-Reply-To: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
        <20180711131638.12622-2-ludovic.desroches@microchip.com>
        <20180712145808.GA22502@kroah.com>
        <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   
> > > +	if (!port->iso7816_config)
> > > +		return -ENOIOCTLCMD;  
> > 
> > Why this error value?
> >   
> 
> It was a mimic of RS485.

Which is what you want - it means the upper tty layer knows to offer the
ioctl to other places and then return appropriately.

Alan
