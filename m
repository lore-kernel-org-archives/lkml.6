Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62625C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22104208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22104208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeFLEaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:30:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:60877 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752665AbeFLEaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:30:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C4TaCq006159;
        Mon, 11 Jun 2018 23:29:37 -0500
Message-ID: <71cfc192be06d07e79bfdfe43a566d3260e19cd6.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 14:29:36 +1000
In-Reply-To: <87o9gxcono.fsf@linux.intel.com>
References: <20180525160729.92026-1-arnd@arndb.de>
         <87o9gxcono.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 15:29 +0300, Felipe Balbi wrote:
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > Without that option, we run into a link failure:
> > 
> > drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> > hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
> > 
> > Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Greg, can you send this to Linus asap ? Some people are hitting build
breakages upstream because of this.

Thanks !

Cheers,
Ben,


