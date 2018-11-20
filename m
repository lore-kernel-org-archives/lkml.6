Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D52E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbeKTN0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:26:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKTN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:26:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE06114D73C21;
        Mon, 19 Nov 2018 19:00:00 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:00:00 -0800 (PST)
Message-Id: <20181119.190000.791259337031857840.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: =?utf-8?B?562U5aSNOg==?= [PATCH 1/4] net-next/hinic:replace
 multiply and division operators
From:   David Miller <davem@davemloft.net>
In-Reply-To: <DACA750462785649825D7529120E85A808A65AFC@dggemm521-mbs.china.huawei.com>
References: <20181119061234.12839-1-xuechaojing@huawei.com>
        <20181119.150142.777293649598457239.davem@davemloft.net>
        <DACA750462785649825D7529120E85A808A65AFC@dggemm521-mbs.china.huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 19:00:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xuechaojing <xuechaojing@huawei.com>
Date: Tue, 20 Nov 2018 02:21:31 +0000

> This wqebb size is 32 in rx and in tx is 64, so the value is a power
> of two.

You know this.

I know this.

But developer in the future may not and try to use non-power-of-2.

Please add the necessary checks.  I will not ask another time.
