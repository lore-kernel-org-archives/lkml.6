Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA6C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfA2XiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:38:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37398 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2XiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:38:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C98EB14F0DC02;
        Tue, 29 Jan 2019 15:38:10 -0800 (PST)
Date:   Tue, 29 Jan 2019 15:38:10 -0800 (PST)
Message-Id: <20190129.153810.493942539151548676.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190129.151026.358327408932275252.davem@davemloft.net>
References: <20190128.225444.1929870241029842289.davem@davemloft.net>
        <20190129175145-mutt-send-email-mst@kernel.org>
        <20190129.151026.358327408932275252.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Jan 2019 15:38:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 29 Jan 2019 15:10:26 -0800 (PST)

> Yeah the CVE pushed my hand a little bit, and I knew I was going to
> send Linus a pull request today because David Watson needs some TLS
> changes in net-next.

I also want to make a general comment.... for the record.

If I let patches slip consistently past 24 hours my backlog is
unmanageable.  Even with aggressively applying things quickly I'm
right now at 70-75.  If I do not do what I am doing, then it's in the
100-150 range.

So I am at the point where I often must move forward with patches that
I think I personally can verify and vet on my own.
