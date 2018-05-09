Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756630AbeEIONF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:13:05 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54640 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756555AbeEIONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:13:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 09 May 2018 16:12:59 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jacky Bai <ping.bai@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
In-Reply-To: <HE1PR04MB3113135433766196E708685887990@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
 <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
 <HE1PR04MB3113135433766196E708685887990@HE1PR04MB3113.eurprd04.prod.outlook.com>
Message-ID: <ae5b239a57bd7e3f3e62cc23a1c3788e@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         TO_DN_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.2018 03:26, Jacky Bai wrote:
>> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
>>
>> Quoting Stefan Agner (2018-05-08 06:20:03)
>> > On 08.05.2018 09:32, Jacky Bai wrote:
>> > >
>> > > I have tried two 6ULL board, I don't meet such issue. System can
>> > > boot up successfully with commit 6f9575e55632 included.
>> > > Anyway, the change in this patch is ok for me. it is no harm to the
>> > > BUS clock change flow.
>> >
>> > Hm, that is interesting, maybe it is because we use a different SKU?
>> > Or maybe bootloader?
>> >
>> > I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL
>> > using U-Boot 2016.11.
>> >
>>
>> I'll throw this into fixes today because it fixes something to be useful. It's still
>> interesting to see what's different between the two setups though.
> 
> Thanks. 
> 
> I will find some 800MHz parts and have a try with different bootloader later.
> Will let you know, when I have some results.
> 

FWIW, I tried two SKUs here:
MCIMX6Z2DVM05AA (528Mhz)
MCIMX6Z2CVM08AA (800MHz)

Both run at 396MHz in U-Boot, and both freeze and the same location.

--
Stefan
