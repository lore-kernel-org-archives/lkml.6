Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46989C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1414220870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1414220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeKXMI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:08:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38904 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKXMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:08:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C087414D75873;
        Fri, 23 Nov 2018 17:21:58 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:21:58 -0800 (PST)
Message-Id: <20181123.172158.1646655822759438209.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     aviad.krawczyk@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] net: hinic: fix null pointer dereference on
 pointer hwdev
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181122100501.15906-1-colin.king@canonical.com>
References: <20181122100501.15906-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 17:21:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 22 Nov 2018 10:05:01 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer hwdev is being dereferenced when declaring hwif , however, later
> on hwdev is being null checked, hence we have dereference before null
> check error. Fix this by assigning hwif and pdef only once hwdev has
> been null checked.
> 
> Detected by CoverityScan, CID#1485581 ("Dereference before null check")
> 
> Fixes: 4a61abb100c8 ("net-next/hinic:add rx checksum offload for HiNIC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
