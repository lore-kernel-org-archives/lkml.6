Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35848C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F5420878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F5420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeLFEv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:51:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFEv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:51:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CC21C145A9B38;
        Wed,  5 Dec 2018 20:51:27 -0800 (PST)
Date:   Wed, 05 Dec 2018 20:51:27 -0800 (PST)
Message-Id: <20181205.205127.959001731251775241.davem@davemloft.net>
To:     robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        claudiu.manoil@nxp.com, grygorii.strashko@ti.com, w-kwok2@ti.com,
        m-karicheri2@ti.com, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: Use of_node_name_eq for node name comparisons
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181205195050.4759-16-robh@kernel.org>
References: <20181205195050.4759-16-robh@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Dec 2018 20:51:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  5 Dec 2018 13:50:32 -0600

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Wingman Kwok <w-kwok2@ti.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to net-next, thanks Rob.
