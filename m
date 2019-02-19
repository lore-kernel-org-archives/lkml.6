Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CA22173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfBSBkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:40:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfBSBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:40:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BF007108DE85D;
        Mon, 18 Feb 2019 17:40:07 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:40:07 -0800 (PST)
Message-Id: <20190218.174007.481602281794068390.davem@davemloft.net>
To:     jose.abreu@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH net] net: stmmac: Fix a race in EEE enable callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <fb866bb5dd8a11326fab8e6d393f2a37eed5073f.1550496861.git.joabreu@synopsys.com>
References: <fb866bb5dd8a11326fab8e6d393f2a37eed5073f.1550496861.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 17:40:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>
Date: Mon, 18 Feb 2019 14:35:03 +0100

> We are saving the status of EEE even before we try to enable it. This
> leads to a race with XMIT function that tries to arm EEE timer before we
> set it up.
> 
> Fix this by only saving the EEE parameters after all operations are
> performed with success.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Fixes: d765955d2ae0 ("stmmac: add the Energy Efficient Ethernet support")

Applied and queued up for -stable, thanks.
