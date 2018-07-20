Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9710DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE375206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE375206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeGTHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:30:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeGTHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:30:13 -0400
Received: from localhost (unknown [172.58.43.55])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6292514810848;
        Thu, 19 Jul 2018 23:43:30 -0700 (PDT)
Date:   Thu, 19 Jul 2018 23:43:29 -0700 (PDT)
Message-Id: <20180719.234329.512279372120817504.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement
 might have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87va9aqv05.fsf@notabene.neil.brown.name>
References: <87fu0kt5m0.fsf@notabene.neil.brown.name>
        <20180719.051440.931407144963903326.davem@davemloft.net>
        <87va9aqv05.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Jul 2018 23:43:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Fri, 20 Jul 2018 16:30:34 +1000

> Does this ruling also apply to the bit-spin-lock changes and the
> per-cpu-counter changes that I have proposed?  These improve
> scalability when updates dominate.  Not having these in mainline
> would mean I need to carry a separate rhashtables implementation for
> lustre, which means code diversion which isn't healthy in the long
> run.

If it helps existing rhashtable users generally, then it is fine,
since it will actually be tested by upstream users.

Thanks.
