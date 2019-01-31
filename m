Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753E920870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfAaFh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:37:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfAaFh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:37:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BAFA114F48D6C;
        Wed, 30 Jan 2019 21:37:25 -0800 (PST)
Date:   Wed, 30 Jan 2019 21:36:54 -0800 (PST)
Message-Id: <20190130.213654.1749307877004861657.davem@davemloft.net>
To:     martink@posteo.de
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        manfred.schlaegl@ginzinger.com, martin.kepplinger@ginzinger.com
Subject: Re: [PATCH] ipconfig: make the wait for carrier timeout
 configurable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190128113005.7683-1-martink@posteo.de>
References: <20190128113005.7683-1-martink@posteo.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Jan 2019 21:37:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martink@posteo.de>
Date: Mon, 28 Jan 2019 12:30:05 +0100

> From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> 
> commit 3fb72f1e6e61 ("ipconfig wait for carrier") added a
> "wait for carrier" policy, with a fixed worst case maximum wait
> of two minutes.
> 
> This makes the wait for carrier timeout configurable (0 - 240 seconds).
> 
> The informative timeout messages introduced with
> commit 5e404cd65860 ("ipconfig: add informative timeout messages while
> waiting for carrier") were adapted. Message output is done in a fixed
> interval of 20 seconds, just like before (240/12).
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

I would prefer that this be implemented using a kernel command line
parameter.

That way you don't need to rebuild the kernel to adjust the value.

Thanks.
