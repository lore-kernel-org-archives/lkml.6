Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5149220883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5149220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeKIKAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:00:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeKIKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:00:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 501401475C6D1;
        Thu,  8 Nov 2018 16:22:02 -0800 (PST)
Date:   Thu, 08 Nov 2018 16:22:01 -0800 (PST)
Message-Id: <20181108.162201.360454923619072769.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: return correct value 'ret'
 from bcmgenet_power_down
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541642923-81463-1-git-send-email-yuehaibing@huawei.com>
References: <1541642923-81463-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 16:22:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Nov 2018 02:08:43 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/broadcom/genet/bcmgenet.c: In function 'bcmgenet_power_down':
> drivers/net/ethernet/broadcom/genet/bcmgenet.c:1136:6: warning:
>  variable 'ret' set but not used [-Wunused-but-set-variable]
> 
> bcmgenet_power_down should return 'ret' instead of 0.
> 
> Fixes: ca8cf341903f ("net: bcmgenet: propagate errors from bcmgenet_power_down")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
