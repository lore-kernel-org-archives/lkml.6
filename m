Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269D720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269D720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJZCIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:08:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55320 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeJZCIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:08:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E90114786F34;
        Thu, 25 Oct 2018 10:34:52 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:34:50 -0700 (PDT)
Message-Id: <20181025.103450.1966639999117342457.davem@davemloft.net>
To:     linux@stwm.de
Cc:     netdev@vger.kernel.org, fw@strlen.de, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com, gregkh@linuxfoundation.org
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2766296.15tpkxTHJV@stwm.de>
References: <20181002213536.sgjansduqenps2md@breakpoint.cc>
        <1729915.dWWxddREcQ@stwm.de>
        <2766296.15tpkxTHJV@stwm.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Oct 2018 10:34:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfgang Walter <linux@stwm.de>
Date: Thu, 25 Oct 2018 11:38:19 +0200

> there is now a new 4.19 which still has the big performance regression when 
> many ipsec tunnels are configured (throughput and latency get worse by 10 to 
> 50 times) which makes any kernel > 4.9 unusable for our routers.
> 
> I still don't understand why a revert of the flow cache removal at least for 
> the longterm kernels is that a bad option (maybe as a compile time option), 
> especially as there is no workaround available.

You do know that the flow cache is DDoS targettable, right?

That's why we removed it, we did not make the change lightly.

Adding a DDoS vector back into the kernel is not an option sorry.

Please work diligently with Florian and others to try and find ways to
soften the performance hit.

Thank you.
