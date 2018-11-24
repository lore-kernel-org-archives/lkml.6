Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D177C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7362082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7362082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeKXMu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:50:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39476 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeKXMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:50:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E063914D75D3E;
        Fri, 23 Nov 2018 18:04:21 -0800 (PST)
Date:   Fri, 23 Nov 2018 18:04:21 -0800 (PST)
Message-Id: <20181123.180421.2263933715335445413.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     richardcochran@gmail.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ptp: Fix pass zero to ERR_PTR() in
 ptp_clock_register
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181123015455.24228-1-yuehaibing@huawei.com>
References: <20181123015455.24228-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 18:04:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 23 Nov 2018 09:54:55 +0800

> Fix smatch warning:
> 
> drivers/ptp/ptp_clock.c:298 ptp_clock_register() warn:
>  passing zero to 'ERR_PTR'
> 
> 'err' should be set while device_create_with_groups and
> pps_register_source fails
> 
> Fixes: 85a66e550195 ("ptp: create "pins" together with the rest of attributes")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
