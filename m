Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D28205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbfAPPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:18:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36460 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbfAPPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:18:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0AFAE207B2; Wed, 16 Jan 2019 16:18:56 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA3A720758;
        Wed, 16 Jan 2019 16:18:55 +0100 (CET)
Date:   Wed, 16 Jan 2019 16:18:55 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
Message-ID: <20190116161855.1d01e083@windsurf>
In-Reply-To: <20190116144829.GC25731@lunn.ch>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
        <20190116144829.GC25731@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 16 Jan 2019 15:48:29 +0100, Andrew Lunn wrote:

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> However, i wounder if it makes sense to add a label before the
> existing device_del() at the end of the function, and convert this,
> and the case above into a goto? That might scale better, avoiding the
> same issue in the future?

That's another option indeed.

Hmm, now that I looked at it, I think we should use device_unregister()
instead. device_unregister() does both device_del() and put_device().

According to the comment above device_register(), put_device() should
always be called: "Always use put_device() to give up the reference
initialized in this function instead.".

What do you think?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
