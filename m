Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7CC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B14C20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14C20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeG3ItY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:49:24 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61714 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeG3ItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:49:24 -0400
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="14257813"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 00:15:49 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Mon, 30 Jul 2018
 00:15:49 -0700
Date:   Mon, 30 Jul 2018 09:14:43 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <me@jue.yt>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Message-ID: <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180720224141.lawanibd7v4hmbym@ninjato>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 12:41:41AM +0200, Wolfram Sang wrote:
> > [Ludovic Desroches]
> > Changes in v3:
> >  - rebase (cherry-pick was enough)
> 
> Thanks for the rebase. I wonder, though, I recall to had more
> complicated issues. However...
> 
> >  - fix checkpatch errors
> >  - tests:
> >    - hangs with a SAMA5D4 (master and slave on different busses) after about
> >    100 transfers. It's the firs time I do this test.
> >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> >    I don't know if it's a regression. I don't remember having seen this
> >    behavior previously.
> >    I think it's worth taking those patches even if there are some possible
> >    bugs. It'll allow to get more people using it and so to consolidate the
> >    slave mode support.
> 
> I really want to see those patches go upstream, too. But I am also not a
> big fan of delivering the user something with known issues. Especially
> not when they affect the main feature to be added. My rationale here is
> that someone who is able to fix the issues remaining will also be able
> to pick up and apply patches.
> 
> Maybe, maybe if it was to be enabled by a special
> I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> think twice about that, though.
> 

I understand your point. The experimental mentionning could be a good
trade-off. Let me know once you make up your mind.

> Speaking of Kconfig, I think this series needs to place a
> 
> 	select I2C_SLAVE
> 
> somewhere.
> 

Ok I'll update it if we go further with this set of patches.

Regards

Ludovic
