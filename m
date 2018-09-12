Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A353820833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A353820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeILLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:10:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57034 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeILLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:10:13 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 066F012DE57F3;
        Tue, 11 Sep 2018 23:07:16 -0700 (PDT)
Date:   Tue, 11 Sep 2018 23:07:16 -0700 (PDT)
Message-Id: <20180911.230716.1048852895308106303.davem@davemloft.net>
To:     igor.stoppa@gmail.com
Cc:     igor.stoppa@huawei.com, huangdaode@hisilicon.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ethernet: hnae: drop adhoc assert() macros
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180908150142.27976-1-igor.stoppa@huawei.com>
References: <20180908150142.27976-1-igor.stoppa@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Sep 2018 23:07:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Stoppa <igor.stoppa@gmail.com>
Date: Sat,  8 Sep 2018 18:01:42 +0300

> Replace assert() with a less misleading test_condition() using WARN()
> Drop one check which had bitrotted and didn't compile anymore.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

I'm still kind of not happy about this.

Make the driver use kernel interfaces like WARN_ON_ONCE()
etc. directly instead of defining alias CPP macros private to the
driver.

If it needs to be conditional upon DEBUG, we have pr_debug() and
the likes as well.

Thank you.
