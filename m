Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDDB208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDDB208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407763AbeHATRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:17:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49888 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406684AbeHATRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:17:11 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2DA98100A39AC;
        Wed,  1 Aug 2018 09:51:36 -0700 (PDT)
Date:   Wed, 01 Aug 2018 09:51:35 -0700 (PDT)
Message-Id: <20180801.095135.79911181296177212.davem@davemloft.net>
To:     jcline@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Subject: Re: [PATCH] netlink: Fix spectre v1 gadget in netlink_create()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180731211316.12971-1-jcline@redhat.com>
References: <20180731211316.12971-1-jcline@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 09:51:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>
Date: Tue, 31 Jul 2018 21:13:16 +0000

> 'protocol' is a user-controlled value, so sanitize it after the bounds
> check to avoid using it for speculative out-of-bounds access to arrays
> indexed by it.
> 
> This addresses the following accesses detected with the help of smatch:
> 
> * net/netlink/af_netlink.c:654 __netlink_create() warn: potential
>   spectre issue 'nlk_cb_mutex_keys' [w]
> 
> * net/netlink/af_netlink.c:654 __netlink_create() warn: potential
>   spectre issue 'nlk_cb_mutex_key_strings' [w]
> 
> * net/netlink/af_netlink.c:685 netlink_create() warn: potential spectre
>   issue 'nl_table' [w] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Applied and queued up for -stable, thanks.
