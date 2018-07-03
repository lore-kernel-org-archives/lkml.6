Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5329CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1FC22427
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1FC22427
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeGCOXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:23:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43436 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGCOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:23:12 -0400
Received: from localhost (unknown [220.83.184.29])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E2C2144FF9CA;
        Tue,  3 Jul 2018 07:23:09 -0700 (PDT)
Date:   Tue, 03 Jul 2018 23:21:29 +0900 (KST)
Message-Id: <20180703.232129.1258523191108623986.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac_tc: use 64-bit arithmetic instead of 32-bit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180702120932.GA13079@embeddedor.com>
References: <20180702120932.GA13079@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Jul 2018 07:23:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 2 Jul 2018 07:09:32 -0500

> Add suffix UL to constant 1024 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned) and  following expressions are currently
> being evaluated using 32-bit arithmetic:
> 
> qopt->idleslope * 1024 * ptr
> qopt->hicredit * 1024 * 8
> qopt->locredit * 1024 * 8
> 
> Addresses-Coverity-ID: 1470246 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1470248 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1470249 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
