Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686F921927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeLUQQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:16:56 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:50456 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLUQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:16:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="24678281"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Dec 2018 09:16:51 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Fri, 21 Dec 2018
 09:17:08 -0700
Date:   Fri, 21 Dec 2018 17:16:51 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <me@jue.yt>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Message-ID: <20181221161651.5n4zzapliyxzb76l@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
 <20181211192805.qsxptzkmczmm5vlz@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181211192805.qsxptzkmczmm5vlz@ninjato>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Dec 11, 2018 at 08:28:05PM +0100, Wolfram Sang wrote:
> Hi Ludovic,
> 
> > > >  - fix checkpatch errors
> > > >  - tests:
> > > >    - hangs with a SAMA5D4 (master and slave on different busses) after about
> > > >    100 transfers. It's the firs time I do this test.
> > > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > > >    I don't know if it's a regression. I don't remember having seen this
> > > >    behavior previously.
> > > >    I think it's worth taking those patches even if there are some possible
> > > >    bugs. It'll allow to get more people using it and so to consolidate the
> > > >    slave mode support.
> > > 
> > > I really want to see those patches go upstream, too. But I am also not a
> > > big fan of delivering the user something with known issues. Especially
> > > not when they affect the main feature to be added. My rationale here is
> > > that someone who is able to fix the issues remaining will also be able
> > > to pick up and apply patches.
> > > 
> > > Maybe, maybe if it was to be enabled by a special
> > > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > > think twice about that, though.
> > > 
> > 
> > I understand your point. The experimental mentionning could be a good
> > trade-off. Let me know once you make up your mind.
> > 
> > > Speaking of Kconfig, I think this series needs to place a
> > > 
> > > 	select I2C_SLAVE
> > > 
> > > somewhere.
> > > 
> > 
> > Ok I'll update it if we go further with this set of patches.
> 
> Ok, I give in. If you:
> 
> * add 'select I2C_SLAVE'
> * make slave support selectable by I2C_AT91_SLAVE_STAGING or
>   _EXPERIMENTAL or something alike (default n)
> * and add to the help text of that symbol the above known issues
>   and 'not for production' and 'help wanted' and where to get more
>   info and all that
> 
> then I'll apply this series soonish. Promised!

Ok I will handle these requests and resend it.

Thanks

Ludovic
