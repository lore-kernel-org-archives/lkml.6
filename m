Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829CDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D94A208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D94A208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbeGJOTo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:19:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33717 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:19:43 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fctUT-0006uF-ET; Tue, 10 Jul 2018 16:19:41 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fctUS-0004jL-7h; Tue, 10 Jul 2018 16:19:40 +0200
Date:   Tue, 10 Jul 2018 16:19:40 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org
Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
Message-ID: <20180710141940.oed3kwhbplnykl36@pengutronix.de>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:43:25 up 27 days, 15:52, 62 users,  load average: 0.05, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> This is used for i.MX multi core communication.
> e.g. A core to SCU firmware(M core) on MX8.
> 
> Tx is using polling mode while Rx is interrupt driven and
> schedule a hrtimer to receive remain words if have more than
> 4 words.

You told us that using interrupts is not possible due to miserable
performance, we then provided you a way with which you could poll.  Why
are you using interrupts now?

We also suggested a way how the SCU mode could be integrated into the
generic MU support driver Oleksij posted and now you send a driver which
uses the same name as Oleksijs driver, but it only and exclusively works
in SCU mode. This doesn't bring us forward.

We suggested a binding that allows coexisting of the SCU mode and the
generic mode of the MU by putting the mode information into the second
mbox-cell. Why don't you use this?

I don't think it's necessary to rewrite Oleksijs driver, instead it
should rather be extended with the code I already provided as an
example. With that we could make both of us happy since we can both
have a suitable driver and even share most of the MU code.

Regards,
Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
