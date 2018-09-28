Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E98FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADDE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2IdWCEZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1VmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:42:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48725 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeI1VmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=5n1xoPPNMSxuYRMOrn1UUGIPY5EDLmggeL5YKEoFjHw=;
        b=2IdWCEZRpI5KJst25CDxGLtta6RTAUe6QGHfrz2gTpYkE3EWuuEp41AvV/GcEMHHvptIYNJl5Wl8T0UaTC4/mNtvcNMK2R3IfyB+KM5fpSSniJlWeAhjy+pS4QnllSRbAUXGQptwTJTem720QBU5C+Ak2s8YNOtOi2Fl6hL6uT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5uWc-0005Uh-UG; Fri, 28 Sep 2018 17:17:50 +0200
Date:   Fri, 28 Sep 2018 17:17:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Message-ID: <20180928151750.GD19396@lunn.ch>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > struct dprtc_cmd_get_irq - Putting pad at the beginning of a struct seems very
> > odd. And it is not the only example.
> 
> [Y.b. Lu] This should depended on MC firmware and APIs I think. Once the MC improves this, the APIs could be updated to fix this.

That is going to be hard to do. Ideally the driver should work with
any firmware version. You don't really want to force the user to
upgrade the driver/kernel and the firmware at the same time. So you
cannot for example remove this pad. What you might be able to do in
newer versions is actually use the space. But you have to be sure the
current code is correctly ignoring it and setting it to zero.

	Andrew
