Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5136DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B45A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfAQWFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:05:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:32984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfAQWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:05:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 55EFD14B96DC1;
        Thu, 17 Jan 2019 14:05:38 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:05:35 -0800 (PST)
Message-Id: <20190117.140535.53390428469930875.davem@davemloft.net>
To:     johan@kernel.org
Cc:     linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: realtek-smi: fix OF child-node lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190116102708.30608-1-johan@kernel.org>
References: <20190116102708.30608-1-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 14:05:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Wed, 16 Jan 2019 11:27:08 +0100

> Use the new of_get_compatible_child() helper to look up child nodes to
> avoid ever matching non-child nodes elsewhere in the tree.
> 
> Also fix up the related struct device_node leaks.
> 
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Cc: stable <stable@vger.kernel.org>     # 4.19: 36156f9241cb0
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied and queued up for -stable.
