Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B819C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11BD21C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11BD21C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeHIEhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:37:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIEhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:37:18 -0400
Received: from localhost (75-164-152-201.ptld.qwest.net [75.164.152.201])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17394141DAED2;
        Wed,  8 Aug 2018 19:14:54 -0700 (PDT)
Date:   Wed, 08 Aug 2018 19:14:53 -0700 (PDT)
Message-Id: <20180808.191453.882749744399950889.davem@davemloft.net>
To:     ubraun@linux.ibm.com
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net/smc: fixes 2018-08-08
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180808121321.516-1-ubraun@linux.ibm.com>
References: <20180808121321.516-1-ubraun@linux.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Aug 2018 19:14:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed,  8 Aug 2018 14:13:18 +0200

> here are small fixes for SMC: The first patch makes sure, shutdown code
> is not executed for sockets in state SMC_LISTEN. The second patch resets
> send and receive buffer values for accepted sockets, since TCP buffer size
> optimizations for the internal CLC socket should not be forwarded to the
> outer SMC socket. The third patch solves a race between connect and ioctl
> reported by syzbot.

Series applied, thank you.
