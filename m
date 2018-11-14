Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43981C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXI+3x+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C122360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeKNRH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:07:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34067 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeKNRH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=6qhBNzovZ5k4Za+rxPZSZzGsm0ULe0JtjECeOAaC2eo=;
        b=eXI+3x+HiJruBrMbS5b11bnwREniKOy0CrHykrpKC7GlvNOyS5/QKSYJeDt1VCrwf3JTnqKBZlptEyOZfB7ijGsyzHrDxbsaJuyZH/u3F1pfIbUbJlT69QTPbB529RmZevjw7HZUg0cQZAH+ES8EZoLypiDYq9lOkWFwxNBR7as=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gMpEu-0004i8-PV; Wed, 14 Nov 2018 08:05:28 +0100
Date:   Wed, 14 Nov 2018 08:05:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, davem@davemloft.net
Subject: Re: [PATCH v2] net: phy: mdio-gpio: fix access that may sleep
Message-ID: <20181114070528.GD17052@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114063703.13379-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114063703.13379-1-ms@dev.tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 07:37:03AM +0100, Martin Schiller wrote:
> This commit re-enables support for slow GPIO pins. It was initially
> introduced by commit
> 	2d6c9091ab7630dfcf34417c6683ce4764d7d40a
> and got lost by commit
> 	7e5fbd1e0700f1bdb94508f84ec2aeb01eed7b12

Hi Martin

Was it really lost? It looks like _cansleep() just adds an extra check
might_sleep_if(extra_checks), but it does not change any
functionality.

So the change itself is O.K, i'm just not too sure about the commit
message.

	Andrew
