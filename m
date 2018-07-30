Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81785C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECD920857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d1jkLLOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECD920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbeG3UqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:46:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50799 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbeG3UqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=oIdRcrtxJixbdDtaMxZh3ruy/zY1NQN5G8BZo6ddkoY=;
        b=d1jkLLOiBWPj7O0938v/l9y6Yt+FsCKz/HZymevtBokaIYHEA9l3jCt5PeyzBcdrQHqXz3uVuKYk+iALm67V4rzs+pRKc/PI2flI345nhRQvBi9pJ0W1gFvdrUZ0Kh37Hjq4TOObd5OZTwDoPh4vwENxr2k4WtguPkp6PdTUQMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkDY5-0002Zt-AW; Mon, 30 Jul 2018 21:09:41 +0200
Date:   Mon, 30 Jul 2018 21:09:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 10/17] ethtool: implement GET_SETTINGS
 message
Message-ID: <20180730190941.GL2983@lunn.ch>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Response contents:
> +
> +    ETHA_SETTINGS_LINK		(u32)		link state

> +	[ETHA_SETTINGS_LINK]		= { .type = NLA_FLAG },

Is this correct?

The link is either up or down. So a u32 seems a bit big.

    Andrew
