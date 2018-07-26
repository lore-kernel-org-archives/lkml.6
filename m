Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8971C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B2620891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B2620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeGZGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:53:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbeGZGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:53:30 -0400
Received: from localhost (unknown [172.58.43.249])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7247112DE580C;
        Wed, 25 Jul 2018 22:38:22 -0700 (PDT)
Date:   Wed, 25 Jul 2018 22:38:21 -0700 (PDT)
Message-Id: <20180725.223821.2249486672657415594.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     ka-cheong.poon@oracle.com, santosh.shilimkar@oracle.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: send: Fix dead code in rds_sendmsg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180725152227.GA26303@embeddedor.com>
References: <20180725152227.GA26303@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 22:38:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 25 Jul 2018 10:22:27 -0500

> Currently, code at label *out* is unreachable. Fix this by updating
> variable *ret* with -EINVAL, so the jump to *out* can be properly
> executed instead of directly returning from function.
> 
> Addresses-Coverity-ID: 1472059 ("Structurally dead code")
> Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
