Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CBB272E7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AoFBS2M2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CBB272E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeF1Lql (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:46:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeF1Lqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aw2IrcO7PRQ8o09+DAWOBQ63MV8cecmHVLuU68kAh6c=; b=AoFBS2M2ypSbukC+ROQWfrVuo
        SGmTShYQaowOQuyO18skrkzP1/uCORnJ62aeFGVRxYGCR3+YQiOZCWyxwzeJ6BZqtGpkZoLyMVOrh
        NkSjAf1LCOE9pwbRCxIuljR82+xN9U/7K/iSmh2nCmV6tLF50tbrhDWCpDQuLFZutcaxkAXkFHU6F
        BjHAIDpygwXC94cEhaDJ7BJ7k797JqfYk1kUZG6ZK/57FJ2sJn5kkTfg4sJFXdURviYEcrM0tWDf0
        D3CdT54P2qAqXci7vO67yVXZWs4KUvtalmc2RPLQbdbg5KuTBgXpSuzDqoDBET+FMrkeS6q1ysQyL
        xGwUuWJrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYVNj-0005MG-2R; Thu, 28 Jun 2018 11:46:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7840B20289CE5; Thu, 28 Jun 2018 13:46:32 +0200 (CEST)
Date:   Thu, 28 Jun 2018 13:46:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        boqun.feng@gmail.com
Subject: Re: [PATCHv2 07/11] atomics: add common header generation files
Message-ID: <20180628114632.GG2494@hirez.programming.kicks-ass.net>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-8-mark.rutland@arm.com>
 <20180628105829.ywuywj2f6yuqstj2@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628105829.ywuywj2f6yuqstj2@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:58:29AM +0100, Mark Rutland wrote:
> Peter, I assume that your ack holds with that change.

Of course :-)
