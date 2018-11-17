Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2F20854
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD2F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeKQOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:47:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbeKQOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:47:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D886913FD234C;
        Fri, 16 Nov 2018 20:32:00 -0800 (PST)
Date:   Fri, 16 Nov 2018 20:32:00 -0800 (PST)
Message-Id: <20181116.203200.1638720313402188457.davem@davemloft.net>
To:     starnight@g.ncu.edu.tw
Cc:     afaerber@suse.de, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, dollar.chen@wtmec.com, ken.yu@rakwireless.com,
        linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: Re: [PATCH V3 2/7] net: lorawan: Add LoRaWAN socket module
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181114160126.4445-3-starnight@g.ncu.edu.tw>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
        <20181114160126.4445-3-starnight@g.ncu.edu.tw>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 20:32:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Thu, 15 Nov 2018 00:01:23 +0800

> +#define	lrw_get_mac_cb(skb)	((struct lrw_mac_cb *)skb->cb)

Please make this a static inline function.  If the identifier is all lowercase
programmers expect it to be real code not a CPP macro.

> +#define	LORAWAN_MODULE_NAME	"lorawan"
> +
> +#define	LRW_DBG_STR(fmt)	LORAWAN_MODULE_NAME": "fmt
> +#define	lrw_info(fmt, ...)	(pr_info(LRW_DBG_STR(fmt), ##__VA_ARGS__))
> +#define	lrw_dbg(fmt, ...)	(pr_debug(LRW_DBG_STR(fmt), ##__VA_ARGS__))

Just define "pr_fmt()" appropriately and you don't need to play these kinds
of games.

Set pr_fmt() and call pr_info() and pr_debug() directly.
