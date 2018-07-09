Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD06DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B27208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B27208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeGIPQO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:16:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7599 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeGIPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:16:13 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="16105598"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jul 2018 08:16:12 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Mon, 9 Jul 2018
 08:16:11 -0700
Date:   Mon, 9 Jul 2018 17:15:04 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Juergen Fitschen <me@jue.yt>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Message-ID: <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180602213513.qv45gaq2kogagju3@katana>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay to answer. I changed my email filters. Unfortunately
there was a bug and I missed message from this mailing list...

On Sat, Jun 02, 2018 at 11:35:13PM +0200, Wolfram Sang wrote:
> On Thu, Nov 09, 2017 at 06:22:29PM +0100, Juergen Fitschen wrote:
> > Slave mode driver is based on the concept of i2c-designware driver.
> > 
> > Signed-off-by: Juergen Fitschen <me@jue.yt>
> 
> I lost the original mail where Ludovic said:
> 
> "I tested it quickly on a sama5d2 xplained board: I used an i2c-gpio
> master and the eeprom driver. It works pretty well. I tried to increase
> the size of the eeprom by adding:
> + { "slave-24c64", 65536 / 8 },"
> 
> That won't work. The comment at the beginning of the file says:
> 
>  * ... It is prepared to simulate bigger EEPROMs with an internal 16 bit
>  * pointer, yet implementation is deferred until the need actually arises.
> 
> So,  no EEPROMs > 256 byte for now.

Sorry for having not catched it. If I remember well, it was the only
issue I had while testing the slave support.

> 
> BTW maybe I asked already and forgot: is this IP core capable of being
> master and slave on the same bus?
> 

No the master and slave modes are exclusive.

Regards

Ludovic
