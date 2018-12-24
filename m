Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B271C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0D21738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLXWjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:39:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:39:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EB48A100AF102;
        Mon, 24 Dec 2018 14:39:46 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:39:46 -0800 (PST)
Message-Id: <20181224.143946.1890079755062380899.davem@davemloft.net>
To:     clabbe.montjoie@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: sungem: device driver frees DMA memory with wrong
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181223193821.GA24922@Red>
References: <20181223193821.GA24922@Red>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 14:39:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Sun, 23 Dec 2018 20:38:21 +0100

> During a boot on a qemu machine, I hit the following problem:
 ...
> After some pr_info, I found that the function triggering this is the pci_unmap_page() in gem_tx().
> So clearly this WARNING() is strange since it says "unmapped as single".

I also went through the code paths and this makes no sense to me either.
