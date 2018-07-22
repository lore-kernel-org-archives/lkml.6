Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D689CECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 04:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE720856
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 04:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FE720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeGVFjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 01:39:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49334 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeGVFjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 01:39:24 -0400
Received: from localhost (unknown [172.58.46.180])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DAB812128E39;
        Sat, 21 Jul 2018 21:44:07 -0700 (PDT)
Date:   Sat, 21 Jul 2018 21:44:05 -0700 (PDT)
Message-Id: <20180721.214405.519016522016153008.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, netdev@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] TX used ring batched updating for vhost
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 21:44:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jul 2018 08:15:12 +0800

> This series implement batch updating of used ring for TX. This help to
> reduce the cache contention on used ring. The idea is first split
> datacopy path from zerocopy, and do only batching for datacopy. This
> is because zercopy had already supported its own batching.
> 
> TX PPS was increased 25.8% and Netperf TCP does not show obvious
> differences.
> 
> The split of datapath will also be helpful for future implementation
> like in order completion.
> 
> Please review.

Jason, I really like the way you composed this patch series, it was
very easy to read and understand. :-)

Michael, please review.
