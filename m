Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A5621104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4LYDjt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A5621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeKLCH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:07:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58778 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbeKLCH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SC0HJRaeJBoX+QC2Dr3woekI/I7k51jz4WN73CHIMUY=;
        b=R4LYDjt0ViQgJzGQ0A2WtlPIGWd/6ljp5x09DHte3NBGeGcjm3Tzp89N11C8xd15XBdgZN41TP/T5ZQIfU44NEtNbCtcM/52HbQZFa4udDxBn76HDYK6/gOHMmhyGtJx8yzJ08otVJNsZ+eiHF/z2wMkUJoV/gdbyd+Tc1DqNSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gLsRL-0004Do-05; Sun, 11 Nov 2018 17:18:22 +0100
Date:   Sun, 11 Nov 2018 17:18:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "yuvalm@mellanox.com" <yuvalm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to HNS3
 driver
Message-ID: <20181111161822.GC15953@lunn.ch>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109224346.GD5259@lunn.ch>
 <F4CC6FACFEB3C54C9141D49AD221F7F93BF9FC72@FRAEML521-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4CC6FACFEB3C54C9141D49AD221F7F93BF9FC72@FRAEML521-MBS.china.huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed. But what about if we want to expose anything related to
> firmware to user-space using the debugfs, assuming we are presenting
> information in structured way and not as a black-box to some user-space
> application. Is it something which might be discouraged?

Hi Salil

Please take a look at devlink. Mellonex have been adding commands to
it for dumping firmware states.

   Andrew
