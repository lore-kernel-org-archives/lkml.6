Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDQTFo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:05:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60212 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeDQTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:05:41 -0400
Date: Tue, 17 Apr 2018 15:05:39 -0400 (EDT)
Message-Id: <20180417.150539.348388784309198242.davem@davemloft.net>
To: mschiffer@universe-factory.net
Cc: netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] ipv6: provide Kconfig switch to
 disable accept_ra by default
From: David Miller <davem@davemloft.net>
In-Reply-To: <b39b1b4304524c43dfd83280aea4cfb4e8ac97f5.1523959377.git.mschiffer@universe-factory.net>
References: <b39b1b4304524c43dfd83280aea4cfb4e8ac97f5.1523959377.git.mschiffer@universe-factory.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Tue, 17 Apr 2018 12:04:50 +0200

> Many distributions and users prefer to handle router advertisements in
> userspace; one example is OpenWrt, which includes a combined RA and DHCPv6
> client. For such configurations, accept_ra should not be enabled by
> default.
> 
> As setting net.ipv6.conf.default.accept_ra via sysctl.conf or similar
> facilities may be too late to catch all interfaces and common sysctl.conf
> tools do not allow setting an option for all existing interfaces, this
> patch provides a Kconfig option to control the default value of
> default.accept_ra.
> 
> Using default.accept_ra is preferable to all.accept_ra for our usecase,
> as disabling all.accept_ra would preclude users from explicitly enabling
> accept_ra on individual interfaces.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

This kind of Kconfig option makes an irreversible behavior choice at
compile time, which satisfies one set of users whilst completely
precluding another set.

So no matter what setting a distribution chooses, one set of users are
basically out of luck.

For that reason I consider this a poor approach.

I hate module options, but at least with that the user can choose
regardless of what the distribution maker decided to do with their
kernel.

This is essentially how we handle "disable_ipv6"

I'm not applying this, because it is as much of a step backwards as
it is a step forward, sorry.
