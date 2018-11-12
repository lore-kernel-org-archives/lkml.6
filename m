Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33817C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A9208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zfo127XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50A9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeKLMI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:08:56 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59156 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeKLMIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9xAkp/F5iXfWjFdzLySQ7hkSeztX0V8fFYorMbyJ3MQ=;
        b=Zfo127XQEWVTdugArqR400Pd8rsvl0CM+xiUWK9lmnZZXZcPck+YElrMIhiUKhp6I/LQny/h4OMrOYUOTb9sXZWBi8nM3cQaGHfHSl0Bi3VfokDH0kf9HRcdTm252IskzjfPbsN7EF12prNXNvRHiFTXp3nQ84rr9YW5FXwm0Gc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gM1nS-0006Wi-R5; Mon, 12 Nov 2018 03:17:50 +0100
Date:   Mon, 12 Nov 2018 03:17:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: remove set but not used
 variable 'pause'
Message-ID: <20181112021750.GC23571@lunn.ch>
References: <1541987250-18687-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541987250-18687-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:47:30AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/phy/marvell.c: In function 'm88e1510_config_init':
> drivers/net/phy/marvell.c:850:7: warning:
>  variable 'pause' set but not used [-Wunused-but-set-variable]
> 
> It not used any more after commit 3c1bcc8614db ("net: ethernet: Convert phydev
> advertize and supported from u32 to link mode")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
