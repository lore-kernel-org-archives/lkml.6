Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BCEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51154208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LnhFKrdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51154208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeK0PlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:41:08 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50257 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbeK0PlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Zogi0x6ENR6YU2erh4r9qm7S4R20/8wToVvmIFrlt2k=;
        b=LnhFKrdhFytPI2SSfSJ8QUw/S08qt0oCKbD3Amtf8KhGVEpXXSSM0gMTuMfv1XO40LIZcki/g9Mh+mHnzxxaMag6Y4IK4f3m6mzmnSihGKNuywfZSdGhSDIcmDj8TWEiSpvlEFH4p4ytr6vSUUbMUOVZcqn6IKmDgxfH/kdy9wY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRVEa-0000zo-Od; Tue, 27 Nov 2018 05:44:28 +0100
Date:   Tue, 27 Nov 2018 05:44:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alacn <alacn1@gmail.com>
Cc:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mv88e6060 station roaming
Message-ID: <20181127044428.GC3181@lunn.ch>
References: <CAMbhjvMAe5UbRPAdyahqvu24muJP3K6n63q3ahxG8aae3NPNsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMbhjvMAe5UbRPAdyahqvu24muJP3K6n63q3ahxG8aae3NPNsA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:31:02PM -0200, Alacn wrote:
> hello,
> 
> I'm sending a patch for Marvell 88e6060 driver.
> 
> Problem description:
> Multiple APs with inter-AP roaming connected to different ports,
> when station moves from one AP on one port to another AP on another port,
> traffic flow breaks down because the learning table is not updated.
> 
> 
> When Marvell's mac learning is enabled it drops all frames that
> arrive from a MAC address that is on a different port at learning table.
> It doesn't update learning table and breaks station roaming.
> 
> 
> This patch disable Marvell 88E6060 hardware level mac learning and let it
> be handled by the kernel.

Hi Anderson.

Please take a look at
https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html

In particular the text about Signed-off-by:.

Also, the complete contents above going into the commit message, so
please make the text formal. No hello, etc.

   Andrew
