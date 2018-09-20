Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD207ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973C21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8973C21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeITVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:35:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbeITVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:35:06 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 485C7146FE6EB;
        Thu, 20 Sep 2018 08:50:58 -0700 (PDT)
Date:   Thu, 20 Sep 2018 08:50:55 -0700 (PDT)
Message-Id: <20180920.085055.1188796939437872993.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dmitry.tarnyagin@lockless.no, wg@grandegger.com,
        mkl@pengutronix.de, michal.simek@xilinx.com,
        hsweeten@visionengravers.com, madalin.bucur@nxp.com,
        pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com,
        leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net,
        ralf@linux-mips.org, nico@fluxnic.net,
        steve.glendinning@shawell.net, f.fainelli@gmail.com,
        grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com,
        t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu2@citrix.com,
        paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-omap@vger.kernel.org, linux-hams@vger.kernel.org,
        devel@linuxdriverproject.org, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org, dev@openvswitch.org
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Sep 2018 08:50:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Sep 2018 20:32:44 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.

I would advise you not to send so many of these changes as a group.

If one of the patches needs feedback addressed, which is already the
case, you will have to resubmit the entire series all over again with
the fixes.
