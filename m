Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4F320817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4F320817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKSOpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:45:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33090 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKSOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:45:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8AC39148BE69B;
        Sun, 18 Nov 2018 20:22:44 -0800 (PST)
Date:   Sun, 18 Nov 2018 20:22:41 -0800 (PST)
Message-Id: <20181118.202241.429922823390869323.davem@davemloft.net>
To:     herbert@gondor.apana.org.au
Cc:     neilb@suse.com, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH] rhashtable: detect when object movement between tables
 might have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181119040634.qlvsrviznd5npiek@gondor.apana.org.au>
References: <20181119035415.yavhqymqiqp3mmcl@gondor.apana.org.au>
        <20181119035635.2tizfk3vrmxfrr6e@gondor.apana.org.au>
        <20181119040634.qlvsrviznd5npiek@gondor.apana.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 20:22:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 19 Nov 2018 12:06:34 +0800

> On Mon, Nov 19, 2018 at 11:56:35AM +0800, Herbert Xu wrote:
>>
>> I take that back.  Because of your shift which cancels out the
>> shift in NULLS_MARKER, it would appear that this should work just
>> fine with RHT_NULLS_MARRKER(0), no? IOW, it would appear that
>> 
>> 	RHT_NULLS_MARKER(0) = RHT_NULLS_MARKER(RHT_NULLS_MARKER(0))
> 
> My emails to Neil are bouncing:
> 
> 	neilb@suse.com
> 	  host smtp.glb1.softwaregrp.com [15.124.2.87]
> 	  SMTP error from remote mail server after RCPT TO:<neilb@suse.com>:
> 	  550 Cannot process address

Yeah this just started happening 2 days ago.
