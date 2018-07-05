Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D02405C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rk/udOxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D02405C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeGEJpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:45:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35712 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeGEJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JrqNzbbPYqif05botNXeNCkIYiAqnIyHpNeOW6RCj3c=; b=rk/udOxNsKcY9xd0r+usYG7ld
        ffFgpIj34UlbBSHob1OjI7HIw7nRu8a3efaSWLTXXd+ngd74fzWWfqnoLqaSQBJ1GO/N/6+Lx/DYf
        xWSYTMPm5KKl25Log702Ul2L9NGcwexg0TgUMtVpEJyuACLLD9xB1dGLFlIycUfOSSEnfNMpPyYYj
        chFlNmfK8Zy/KvVW6Bj/GjfS35N1iV9ubia/MimESkIcx/HQ8ya5AbLIH+B8kz5KNELSZYbCrH7Y/
        vLjqNddgMSsxrLve2z/PXXAtDXkO4SfkjRcBEMEIKnPCwq7K9dNn4HLJYi6Th+ovvc72sQvyelJZk
        ozo59RRxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb0pO-0004QY-1z; Thu, 05 Jul 2018 09:45:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DC5920291063; Thu,  5 Jul 2018 11:45:27 +0200 (CEST)
Date:   Thu, 5 Jul 2018 11:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, patrick.bellasi@arm.com
Subject: Re: [PATCH v2] sched/fair: Fix util_avg of new tasks for asymmetric
 systems
Message-ID: <20180705094527.GK2458@hirez.programming.kicks-ass.net>
References: <20180612112215.25448-1-quentin.perret@arm.com>
 <20180705075349.GC9366@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705075349.GC9366@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:53:50AM +0100, Quentin Perret wrote:
> Is there anything else I should do for this patch ?

Pinging me was the right thing. Have it now, much thanks!
