Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB07C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D35120C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0rKjYRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D35120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHBKfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:35:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kGLR0t9rODv77IGF1qAQLRPm9L4bwQa2XHPP0pVa2C4=; b=n0rKjYRH4sP2XTpIQCvZaWQ7c
        c8UQD8VfhTreXKRyGwLZrajITrYIEzcXTGTfdkdvA6+burZDV9wwpwvCyin/luYangCE85IcSnChF
        ZwfaDA9vDu/YsQyozFQloCrX3u+3gq/2aiaSFJagmJ0anDBMTo2QQMQs6DKiCKVmI/AmlLMTN3w+4
        DdB24Mqzf0R/tDb+nCQ3PbUaxmOxWfbiTspPfPSFrjpRpFLq1SJsxSpvsRLIVqYGUCRrTzP1Z84p6
        oC+eUA9kUV1BMAitkAwZAC3UVzJa9VDTx7MCffmWR16N2XUH5zPf+Ukuszon8Hja4zKCekuIp7RAM
        xfae2AuYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fl9Ek-0004AZ-OT; Thu, 02 Aug 2018 08:45:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E65AE20267E42; Thu,  2 Aug 2018 10:45:32 +0200 (CEST)
Date:   Thu, 2 Aug 2018 10:45:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     mingo@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, isaacm@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
Message-ID: <20180802084532.GJ2494@hirez.programming.kicks-ass.net>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:34:40PM -0700, Sodagudi Prasad wrote:
> the Linux-4.14.56  kernel.

Can you also please run on something recent...
