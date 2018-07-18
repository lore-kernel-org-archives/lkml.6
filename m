Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D841ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5664E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5664E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeGRVHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:07:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42928 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbeGRVHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:07:46 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 23F4A1479C5FF;
        Wed, 18 Jul 2018 13:28:13 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:28:12 +0900 (KST)
Message-Id: <20180719.052812.1808217805356135440.davem@davemloft.net>
To:     dave@stgolabs.net
Cc:     herbert@gondor.apana.org.au, akpm@linux-foundation.org,
        tgraf@suug.ch, linux-kernel@vger.kernel.org, dbueso@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH resend -next] lib/rhashtable: consider param->min_size
 when setting initial table size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180716202613.u6f3l3adrgjvs4wk@linux-r8p5>
References: <20180714062516.30433-1-dave@stgolabs.net>
        <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
        <20180716202613.u6f3l3adrgjvs4wk@linux-r8p5>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:28:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>
Date: Mon, 16 Jul 2018 13:26:13 -0700

> rhashtable_init() currently does not take into account the user-passed
> min_size parameter unless param->nelem_hint is set as well. As such,
> the default size (number of buckets) will always be HASH_DEFAULT_SIZE
> even if the smallest allowed size is larger than that. Remediate this
> by unconditionally calling into rounded_hashtable_size() and handling
> things accordingly.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> Resending per Herbert's request with Cc to netdev.

Applied and queued up for -stable, thanks.
