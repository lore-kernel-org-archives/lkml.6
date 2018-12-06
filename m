Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D9AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E1D21527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E1D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeLFEuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:50:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeLFEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:50:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 658011457DBE2;
        Wed,  5 Dec 2018 20:49:59 -0800 (PST)
Date:   Wed, 05 Dec 2018 20:49:58 -0800 (PST)
Message-Id: <20181205.204958.1878018442106277817.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1544032300.git.pabeni@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Dec 2018 20:49:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed,  5 Dec 2018 19:13:38 +0100

 ...
> This may lead to some uglification around the indirect calls. In netconf 2018
> Eric Dumazet described a technique to hide the most relevant part of the needed
> boilerplate with some macro help.
> 
> This series is a [re-]implementation of such idea, exposing the introduced
> helpers in a new header file. They are later leveraged to avoid the indirect
> call overhead in the GRO path, when possible.
> 
> Overall this gives > 10% performance improvement for UDP GRO benchmark and
> smaller but measurable for TCP syn flood.
> 
> The added infra can be used in follow-up patches to cope with retpoline overhead
> in other points of the networking stack (e.g. at the qdisc layer) and possibly
> even in other subsystems.
 ...

I like this a lot and unless I hear some objections I'm going to apply this
series tomorrow.

Thanks for working on this Paolo.
