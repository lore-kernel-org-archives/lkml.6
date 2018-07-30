Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B01F13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D89A20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uWqDZmSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D89A20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeG3PmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:42:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50471 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeG3PmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=RPcOB4XTS6beROGlTXmWLWJxFVZOYb1ME1IsSbWYPfc=;
        b=uWqDZmSXsD/11A4jAgviGBDhlAh+l92UpDqK2UxnOOyyyvqCPRe81bkfiYOYQ7100aiG66wYfkMoM5dFfBDpPOeBaANgmL4fDtRVvLXDfXdOq4+/AVmpn2mokbCdjg08ffEZ8Sn48/dZsS6hwXsJbpH/iSGClzuEnDOOq6kJFGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8p3-0008Rv-0D; Mon, 30 Jul 2018 16:06:53 +0200
Date:   Mon, 30 Jul 2018 16:06:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Message-ID: <20180730140652.GK13198@lunn.ch>
References: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:01:27PM +0200, Alexander Onnasch wrote:
> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
 
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
