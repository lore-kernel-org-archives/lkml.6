Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E80C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39BD2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39BD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeFTAHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:07:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeFTAHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:07:07 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD112145D1803;
        Tue, 19 Jun 2018 17:07:05 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:07:04 +0900 (KST)
Message-Id: <20180620.090704.1841351400456293204.davem@davemloft.net>
To:     daniel.lezcano@linaro.org
Cc:     oliver@neukum.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/usb/drivers: Remove useless hrtimer_active check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529417671-21384-1-git-send-email-daniel.lezcano@linaro.org>
References: <1529417671-21384-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 17:07:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 19 Jun 2018 16:14:30 +0200

> The code does:
> 
>  if (hrtimer_active(&t))
>     hrtimer_cancel(&t);
> 
> However, hrtimer_cancel() checks if the timer is active, so the
> test above is pointless.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied.
