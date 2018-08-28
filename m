Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09908C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9B208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRBX6KSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E9B208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH1LqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:46:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1LqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GTCo4COGC2n1FN46QcWI5JflA7OAj2YEP3OnL2pbJCk=; b=iRBX6KSw6xJbFjPWYINlGw2z9
        /hR9K4ZKPvZ5vAWRaGtwv7iiWNSimPbmEuTrNQWsnwmA2MKrGNP+pNiyeDUydbKFWJBmTzw2SD5UC
        rnOiWwtefSkN0128fSzSo++zm1JjemSi/GguyRMPaMVPymLLFewoQuUjb8bBh960yyAhxcfpfwkmL
        vp3LNxo2ioajgNmYca2D0uqKKzUHnYesXz6XvwiTQYQzx/Jhowxs0+/0G4o3YHClp5T+Y48H7shAc
        PmTElfGVM2qoWG4S9Be6oTS5V70andjd/RvFHe+zt7xFcESHsXb53+erG3z4tKjSesgIPQnCkAioH
        Am3iqMFQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuYqi-0007CY-MA; Tue, 28 Aug 2018 07:55:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1066B2024D705; Tue, 28 Aug 2018 09:55:38 +0200 (CEST)
Date:   Tue, 28 Aug 2018 09:55:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] cpu/hotplug: Remove skip_onerr field from cpuhp_step
 structure
Message-ID: <20180828075537.GG24124@hirez.programming.kicks-ass.net>
References: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:24:54PM +0530, Mukesh Ojha wrote:
> When notifiers were there, we were using `skip_onerr` to avoid
> calling particular step startup/teardown callback in CPU up/down
> rollback path, which made the hotplug a bit asymmetric.
> 
> As notifiers are gone now after state machine introduction. So,
> `skip_onerr` field is no longer valid.
> 
> Remove it from the structure and its usage.

There are indeed no users left.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
