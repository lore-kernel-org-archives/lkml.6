Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630A9208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="epyyuNpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630A9208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHXHOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:14:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42154 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeHXHOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pdD2qG9yHXy+rgoLHwGHLClGqoRRtclBpqor3teUiv4=;
        b=epyyuNpEGQABcmMsuUxtI9yks/5zzBE/wfgehHGG+ihaClkstViL9FcBc88ft2Mzm++pM4MuAVGg0MGreQx2qJuWLA7Lay9ZrPvkn/cY57pJRmZMqBT0xrPuB9YkSqRSnLaPGQoDDiP+qwjVouTlwasfSG7E0Zm/oGJK9ZFXJWg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ft2yN-0007uT-MR; Fri, 24 Aug 2018 05:41:19 +0200
Date:   Fri, 24 Aug 2018 05:41:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Peng Li <lipeng321@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for
 1000M half
Message-ID: <20180824034119.GA29111@lunn.ch>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:42:23AM +0800, Peng Li wrote:
> Hisilicon hip05 and hip06 board network card do not support
> 1000M half configuration. Driver can not config gmac as
> 1000M half.
> 
> Signed-off-by: Peng Li <lipeng321@huawei.com>

Hi Peng

Does the driver remove SUPPORTED_1000baseT_Half from
phydev->supported?  If you do that, the PHY should never negotiate
this speed.

   Andrew
