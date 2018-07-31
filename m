Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A527EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MzF4WTxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5B2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbeGaNlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:41:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbeGaNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pzONVVjA8H+namoBdBhSKN0b4+oFdGJTlJi15i0RF+s=; b=MzF4WTxRCSeHaaLvHnLW7HFyC
        vuKywovregk7yXDywkcxLU2+rS/AYYRynJ/LLk3k2dvBnCosCnfIs2oS1VlUToaJKnI08367F4s2c
        ppEaZDzexXqZXIgK7i/0i0dsCNF/oj3kHGH6czGPHNa1aKe5E/biYz1rF3iLPzMoHtowLBeUgKxAZ
        Eo7xYjfOyDl9sT39EKDsm+wbNftvWyXHceR4L+yfujMSWca6Ko3bJQIgVNq5TNaDejHkWUBsVLyKf
        dyc/8JIdm3mk+nsbbvVU1gQbbXNJr4rCeE5NZRs4LUUfJfRDhBVIn8vb5gCDhHqNYEFPt/VPnuwlg
        aYvUK0V0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkTKm-0001Gg-9N; Tue, 31 Jul 2018 12:01:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11C8F20174098; Tue, 31 Jul 2018 14:00:58 +0200 (CEST)
Date:   Tue, 31 Jul 2018 14:00:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Message-ID: <20180731120057.GS2476@hirez.programming.kicks-ass.net>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Aside from the first patch, which I posted the change on, I've picked up
until 10. I think that other SD_ASYM patch-set replaces 11 and 12,
right?
