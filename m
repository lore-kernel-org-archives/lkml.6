Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EFF81828
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA64217BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA64217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIMWdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:33:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51296 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeIMWdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:33:32 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0338E13FFEA0A;
        Thu, 13 Sep 2018 10:23:05 -0700 (PDT)
Date:   Thu, 13 Sep 2018 10:23:05 -0700 (PDT)
Message-Id: <20180913.102305.939671149040995911.davem@davemloft.net>
To:     fw@strlen.de
Cc:     linux@stwm.de, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
        <3448099.9yk84El3Sa@stwm.de>
        <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 10:23:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Thu, 13 Sep 2018 18:38:48 +0200

> Wolfgang Walter <linux@stwm.de> wrote:
>> What I can say is that it depends mainly on number of policy rules and SA.
> 
> Thats already a good hint, I guess we're hitting long hash chains in
> xfrm_policy_lookup_bytype().

I don't really see how recent changes can influence that.

And the bydst hashes have been dynamically sized for a very long time.

I might have missed something...
