Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7694521738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfAITGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:06:55 -0500
Received: from muru.com ([72.249.23.125]:32846 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAITGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:06:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8F8ED80C5;
        Wed,  9 Jan 2019 19:06:59 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:06:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rex Chang <rchang@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Regression in v4.20 with net phy soft reset changes
Message-ID: <20190109190650.GT5544@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
a regression where suspend resume cycle fails to bring up Ethernet on at
least cpsw on am437x-sk-evm.

Keerthy noticed this may not happen on the first resume, but usually
happens after few suspend resume cycles. The most working suspend resume
cycles I've seen with the commit above is three.

Any ideas what might be going wrong?

Note that unrelated to the commit above, there may be other issues too
as the cpsw phy LED seems to come on only after about five seconds with
about total of 10 seconds before the Ethernet is up again.

Regards,

Tony
