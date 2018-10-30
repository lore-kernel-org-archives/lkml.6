Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeJ3Wkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:40:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ3Wkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:40:46 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1gHUMK-0008EU-OL; Tue, 30 Oct 2018 14:47:04 +0100
Date:   Tue, 30 Oct 2018 14:47:04 +0100
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
Message-ID: <20181030134704.l673d7pm5mwysx2o@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030120831.GC27873@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030120831.GC27873@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Oct 30, 2018 at 01:08:31PM +0100, Andrew Lunn wrote:
> On Tue, Oct 30, 2018 at 10:31:37AM +0100, Kurt Kanzenbach wrote:
> > Hi,
> >
> > the Xilinx mdio wait functions may return false positives under certain
> > circumstances: If the functions get preempted between reading the corresponding
> > mdio register and checking for the timeout, they could falsely indicate a
> > timeout.
>
> Hi Kurt
>
> I wonder if it would be possible to add a readx_poll_timeout() which
> passes two parameters to op()?

actually I was thinking about using readx_poll_timeout(). But as you
already pointed out, it expects only one parameter for op(). I'm not
sure about adding a new readx_poll_timeout() macro.

>
> I keep seeing this basic problem in various drivers, and try to point
> people towards readx_poll_timeout(), but it is not the best of fit.
>
> Otherwise, could you add a axienet_ior_read_mcr(lp), and use
> readx_poll_timeout() as is?

I guess that would work.

I'll use readx_poll_timeout() for both wait functions and send a v2.

Thanks,
Kurt
