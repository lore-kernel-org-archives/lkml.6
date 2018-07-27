Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A81C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A293520891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A293520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeG0FpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:45:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52122 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeG0FpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:45:05 -0400
Received: from localhost (unknown [172.58.35.173])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF5A2108C58B9;
        Thu, 26 Jul 2018 21:25:07 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:25:07 -0700 (PDT)
Message-Id: <20180726.212507.209809359488602241.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hisax: config: Replace GFP_ATOMIC with GFP_KERNEL
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727024828.2107-1-baijiaju1990@gmail.com>
References: <20180727024828.2107-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 21:25:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 10:48:28 +0800

> hisax_cs_new() and hisax_cs_setup() are never called in atomic context.
> They call kmalloc() and kzalloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.
