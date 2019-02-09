Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8012A20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBIHFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 02:05:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfBIHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 02:05:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 82162149D93E4;
        Fri,  8 Feb 2019 23:05:38 -0800 (PST)
Date:   Fri, 08 Feb 2019 23:05:38 -0800 (PST)
Message-Id: <20190208.230538.156874402966618176.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pablo@netfilter.org, jiri@mellanox.com, ndesaulniers@google.com
Subject: Re: [PATCH net-next] ethtool: Remove unnecessary null check in
 ethtool_rx_flow_rule_create
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190208044652.32166-1-natechancellor@gmail.com>
References: <20190208044652.32166-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Feb 2019 23:05:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu,  7 Feb 2019 21:46:53 -0700

> net/core/ethtool.c:3023:19: warning: address of array
> 'ext_m_spec->h_dest' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>                 if (ext_m_spec->h_dest) {
>                 ~~  ~~~~~~~~~~~~^~~~~~
> 
> h_dest is an array, it can't be null so remove this check.
> 
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
> Link: https://github.com/ClangBuiltLinux/linux/issues/353
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
