Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9EDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="alSOQM/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A134820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLDLcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:32:39 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60457 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbeLDK4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=akao7bDqVnOLFAOjTa5OelMU9PLw3ZKO17jDS0SylgI=;
        b=alSOQM/mP2Hnu80S2eHan2WTuLJAlTUhMnT0G5AqeCMaCsb4K+w1oshPyumvj8n44n/rSaqG3K2jfZ8zuCGlvjrgqjkQXl9Cjv1ma6GpFGAf4uiJpftFmy1yrfQJHXg6f5hQZClUQGrSBfgP6Hx6k6A2ve/LHhKjMhJh857GS30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gU8Ms-0000W0-CM; Tue, 04 Dec 2018 11:55:54 +0100
Date:   Tue, 4 Dec 2018 11:55:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Liuzhongzhu <liuzhongzhu@huawei.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [RFC net-next 3/9] net: hns3: Add "port vlan table" information
 query function
Message-ID: <20181204105554.GD741@lunn.ch>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
 <20181202230933.15560-4-salil.mehta@huawei.com>
 <20181203151222.6e56efcd@cakuba.netronome.com>
 <20181203.151253.1348214769326219632.davem@davemloft.net>
 <F4CC6FACFEB3C54C9141D49AD221F7F93C06855D@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4CC6FACFEB3C54C9141D49AD221F7F93C06855D@FRAEML521-MBX.china.huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Adding debugfs files for basic switch concepts like MAC and VLAN tables
> > > seems like a bit of a stretch to me.  I wonder what others think.
> > 
> > Agreed.
> 
> 
> I was wondering how other vendors are solving this? One way I could 
> understand is to use "Switchdev" framework which in turn will expose
> entries to the kernel using the switch driver. In our NIC we don't
> have a proper switch and it cannot learn/age entries.

Your hardware is there to accelerate what linux can do in software.
How do we manage the software version of this feature?

> Also, on-SoC NIC contains other tables which might not have any standard
> user-space interface at all. What are your suggestions regarding that?

How are these tables map to software features the Linux stack
implements?

	Andrew
