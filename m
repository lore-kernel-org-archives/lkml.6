Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11480C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE36120875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE36120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeGKH57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:57:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57249 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeGKH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:57:58 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd9xg-0000NC-Kr; Wed, 11 Jul 2018 09:54:56 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd9xg-000316-8f; Wed, 11 Jul 2018 09:54:56 +0200
Date:   Wed, 11 Jul 2018 09:54:56 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
Message-ID: <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:35:51 up 28 days, 16:44, 55 users,  load average: 0.29, 0.13,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > Sent: Tuesday, July 10, 2018 10:20 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi Brar
> > <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org; Oleksij Rempel
> > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo@kernel.org
> > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> > 
> > Hi,
> > 
> > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > > This is used for i.MX multi core communication.
> > > e.g. A core to SCU firmware(M core) on MX8.
> > >
> > > Tx is using polling mode while Rx is interrupt driven and schedule a
> > > hrtimer to receive remain words if have more than
> > > 4 words.
> > 
> > You told us that using interrupts is not possible due to miserable
> > performance, we then provided you a way with which you could poll.  Why
> > are you using interrupts now?
> > 
> 
> Because mailbox framework does not support sync rx now, I think we do not
> need to wait for that feature done first as it's independent and  separate
> features of framework.

You can wait forever for this feature, nobody will add it for you. It's
up to you to add support for that feature. Who else should add this
feature if not you? And when will you add that feature if not now when
you actually need it?
It is common practice that you adjust the frameworks to your needs
rather than working around them.

> 
> So for now, we're just using the common way in kernel as arm scpi and ti sci. 
> When framework supports it, we can easily switch to it.
> 
> I optimized the performance a bit by removing the unnecessary memcopy
> between tx/tx messages. The test result of booting time shows there's no
> obvious regressions. I'm not sure whether it's due to we're booting a minimum
> system or the extra cost is very minor to be noticed due to not too much cmds
> sent during booting.

Your boot time argument seems to be a very weak one. unnecessary memcpys
of a few bytes only take a fraction of the time interrupt latencies
introduce.

> (Copy Peng to comments more as he tried and reported that performance drop
> with vendor tree)
> 
> From the time measurement of sc_call_rpc, we can see that most rpc command
> In polling mode can finish within 10us and very rare ones over 20us.
> If switched to irq mode, those 10us cmds will change to about 20us. 
> 
> But the overall booting time did not increase much. Maybe the irq mode
> also saves some CPU MIPS to execute other works in parallel?
> 
> > We also suggested a way how the SCU mode could be integrated into the
> > generic MU support driver Oleksij posted and now you send a driver which
> > uses the same name as Oleksijs driver, but it only and exclusively works in
> > SCU mode. This doesn't bring us forward.
> > 
> 
> Can Oleksij's patch be implemented against this one?
> As I remember you said we've still not determined whether Oleksij's approach
> is the most suitable way and it's still under discussion.
> (Actually TI's approach looks better which is more simiar as SCU way?)
> 
> Furthermore, from this patch, you will notice that Oleksij's patch almost
> did not work for SCU at all. I have to totally rewrite one for SCU.

You are kidding. You have to rewrite it because you didn't follow my
suggestion to implement polling in the mailbox framework.

> So I did not write against his patch as it does not help.
> And Oleksij's patch is quite simple while the SCU one is much complicated
> than his one. So we probably better get SCU done first.
> 
> > We suggested a binding that allows coexisting of the SCU mode and the
> > generic mode of the MU by putting the mode information into the second
> > mbox-cell. Why don't you use this?
> > 
> 
> You mean this?
> +#define IMX_MU_CHANNEL0		0
> +#define IMX_MU_CHANNEL1		1
> +#define IMX_MU_CHANNEL2		2
> +#define IMX_MU_CHANNEL3		3
> +#define IMX_MU_CHANNEL_IMX8_SCU 4

Yes.

> 
> It's hard for me to believe it's correct and it's over abstract to HW.
> So I thought using mbox-cells to distinguish seems to be better.

The MU has four rx registers, four tx registers and four interrupts.
What else should this be than four channels? The number of channels the
MU has is obviously defined by the software running at the other end
of the MU. Yes, the SCU makes one channel from it, in other cases it's
four channels.

> 
> > I don't think it's necessary to rewrite Oleksijs driver, instead it should rather
> > be extended with the code I already provided as an example. With that we
> > could make both of us happy since we can both have a suitable driver and
> > even share most of the MU code.
> 
> As I said above, I even can't reuse 90%+ code of Oleksijs driver. So I can't
> see the meaning to demo the code on top of this driver. We can review
> the SCU implementation directly with this driver which is more easy.
> Then we can decide how to merge them together.

You can only not share the code because the mailbox framework does not
support polling. And yes, I even provided some code which implements SCU
mode ontop of Oleksijs driver.

Honestly, what I expect from you is no rocket science and we would
already be there if we didn't spend our time discussing this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
