Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A91FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42042086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="araiZIVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42042086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeKTCtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:49:39 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40725 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbeKTCtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rdekz2H73urYUl46tjJrWPKjwUS/lIfEs52H5sjj36Q=;
        b=araiZIVi1P73XEaIUBHuKiOWgqN1773W+hEnDCzf361tFM0IRyNQAAlzFTol1d+7XEUvaIVYLMA10zvTPSdzEDzqNHXmrVBce4KSqnQgrupCFzicF57WTO048ycv6cO4MfInBhJrKV3bNvjbuivXDoutYPVTZ690vYPfCsnfsdI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOmMb-0008Lk-Ug; Mon, 19 Nov 2018 17:25:29 +0100
Date:   Mon, 19 Nov 2018 17:25:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181119162529.GA31955@lunn.ch>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
 <20181119151057.GC26852@lunn.ch>
 <mvm4lcdaynt.fsf@suse.de>
 <20181119152830.GE26852@lunn.ch>
 <20181119154005.GA8367@piout.net>
 <mvmzhu59idl.fsf@suse.de>
 <20181119161204.GC2393@lunn.ch>
 <mvmva4t9h8x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmva4t9h8x.fsf@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:14:38PM +0100, Andreas Schwab wrote:
> On Nov 19 2018, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Could you turn on lockdep and see if it reports a deadlock.
> 
> How do I "turn on lockdep"?

make menuconfig
Kernel hacking
Lock Debugging (spinlocks, mutexes, etc...) 
Lock debugging: prove locking correctness

It has changes its name at some point. it used to be called
CONFIG_LOCKDEP, for locking dependencies. Anybody who has been kernel
hacking for a while still calls it lockdep.

	Andrew
