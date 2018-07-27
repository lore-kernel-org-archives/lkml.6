Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4635C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EEC2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OoYefx5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EEC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbeG0OxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:53:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48417 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbeG0OxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=z4JL4dNTY6wQmBKZu5/NuR2o5WOL3AeEGCB7xz6d7NI=;
        b=OoYefx5e77KrtwG0iqaVFaAROYJYyAfA9lwMU47SpicaakcD5iBsMWXfFPF2p57vlFhjziGfrNcUDLV2YLf3O6/9CHLiV/5XRgap0MlJNwZXGQAYy4jmwRMkHbTooy1eLcgxMx2xJokPvsamfmWGSETLYYsFkzqtfIF2A0TAVEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fj2pm-0002Ng-S6; Fri, 27 Jul 2018 15:31:06 +0200
Date:   Fri, 27 Jul 2018 15:31:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell: Replace mdelay() with msleep() in
 m88e1116r_config_init()
Message-ID: <20180727133106.GB8829@lunn.ch>
References: <20180727083425.14481-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727083425.14481-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:34:25PM +0800, Jia-Ju Bai wrote:
> m88e1116r_config_init() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
