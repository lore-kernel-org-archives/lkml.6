Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E63AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3450320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3450320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeGWRpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:45:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbeGWRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:45:40 -0400
Received: from localhost (unknown [172.58.43.225])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 35D39108CF57A;
        Mon, 23 Jul 2018 09:43:34 -0700 (PDT)
Date:   Mon, 23 Jul 2018 09:43:32 -0700 (PDT)
Message-Id: <20180723.094332.1263746631250670875.davem@davemloft.net>
To:     shubhrajyoti.datta@xilinx.com
Cc:     netdev@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: axienet: Fix double deregister of mdio
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532335127-10683-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1532335127-10683-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 09:43:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Date: Mon, 23 Jul 2018 14:08:47 +0530

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> index 16c3bfb..757a3b3 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> @@ -218,6 +218,7 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
>         ret = of_mdiobus_register(bus, np1);
>         if (ret) {
>                 mdiobus_free(bus);
> +               lp->mii_bus = NULL;
>                 return ret;
>         }

Your patch was corrupted by your email client, in particular it has transformed TAB
characters into SPACEs.

Please fix this, email the patch to yourself as a test, and please do
not send the patch here to the list again until you can successfully
apply the patch you receive in that test email.

> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

This is inappropriate for postings to this mailing list, please disable this footer
if you would like to post here.

Thank you.
