Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE3E2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE3E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJCBQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:16:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:16:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::30d2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC33B14207557;
        Tue,  2 Oct 2018 11:32:15 -0700 (PDT)
Date:   Tue, 02 Oct 2018 11:32:15 -0700 (PDT)
Message-Id: <20181002.113215.1529893358000135773.davem@davemloft.net>
To:     macro@linux-mips.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] declance: Fix continuation with the adapter
 identification message
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.2.21.1810021401530.5483@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810021401530.5483@eddie.linux-mips.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 11:32:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Tue, 2 Oct 2018 14:23:45 +0100 (BST)

> Fix a commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
> continuation lines") regression with the `declance' driver, which caused
> the adapter identification message to be split between two lines, e.g.:
> 
> declance.c: v0.011 by Linux MIPS DECstation task force
> tc6: PMAD-AA
> , addr = 08:00:2b:1b:2a:6a, irq = 14
> tc6: registered as eth0.
> 
> Address that properly, by printing identification with a single call,
> making the messages now look like:
> 
> declance.c: v0.011 by Linux MIPS DECstation task force
> tc6: PMAD-AA, addr = 08:00:2b:1b:2a:6a, irq = 14
> tc6: registered as eth0.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing continuation lines")

Applied.
