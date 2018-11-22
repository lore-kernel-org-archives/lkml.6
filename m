Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4302080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4302080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeKVK6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:58:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeKVK6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:58:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 82DEE14913158;
        Wed, 21 Nov 2018 16:21:19 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:21:18 -0800 (PST)
Message-Id: <20181121.162118.2250773796794960530.davem@davemloft.net>
To:     claudiu.manoil@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.marginean@nxp.com, catalin.horghidan@nxp.com
Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542737734-21756-2-git-send-email-claudiu.manoil@nxp.com>
References: <1542737734-21756-1-git-send-email-claudiu.manoil@nxp.com>
        <1542737734-21756-2-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Nov 2018 16:21:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>
Date: Tue, 20 Nov 2018 20:15:31 +0200

> diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
> index 3b4ff08..20e5c2f9 100644
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_FSL_FMAN) += fman/
>  obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
>  
>  obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
> +obj-$(CONFIG_NET_VENDOR_FREESCALE) += enetc/

The driver enable Kconfig option should guard traversing into the
driver subdirectory, not the vendor enable Kconfig knob.
