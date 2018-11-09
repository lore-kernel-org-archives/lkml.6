Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A1E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PDY5+AdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A1E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeKJI0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:26:33 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57466 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbeKJI0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=EzFDfscO7ArE0l4+hRyzQdtdt/n0WbddkgLAohOs3RM=;
        b=PDY5+AdCRO3uQrirtviJH9hdOwLdTgtKymiCtFLyJffY53DcxahE3YKHS929bvMz1+uETHdI2NiP5b8VhX9K3WK5VpzQBYWeKoOHRv1yN1SitZD7cL8y6Ta4iLGbf/ZJcgAkXh7UdhEiUyiB3KjeQcp3rHDnycdCQfq4xY16bZs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gLFVC-0003wP-7L; Fri, 09 Nov 2018 23:43:46 +0100
Date:   Fri, 9 Nov 2018 23:43:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     davem@davemloft.net, yuvalm@mellanox.com, leon@kernel.org,
        yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to HNS3
 driver
Message-ID: <20181109224346.GD5259@lunn.ch>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109220743.10264-1-salil.mehta@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Debugfs looks more unstructured unlike sysfs. Is there any
>    de-facto standard of the user-api or drivers are allowed to
>    use it in any way to expose the information from kernel.

Hi Salil

You don't really have a user api using debugfs, because debugfs is
unstable. Anything can change at any time. Any user tools which use
debugfs can be expected to break at any time as the information in
debugfs changes. debugfs is for debug, not to export an API. And in
production systems, it is often not mounted.

As much as possible, you are recommended to use existing APIs,
ethtool, devlink, etc.

	Andrew
