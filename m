Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA47C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B0F213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLlaLOh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfBZSyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:54:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kNYeYXCXWBFDwmPOvY2axj4GFZnVGhLB8wgAc6JGEBM=; b=NLlaLOh22ihRcz3Jv0M3sXKn6
        iUycc4Vbhr3nrRg0sfb6zDSq6jMLitHza5ulBfugSGZ/k2Cuftub591Rj5VoclMbL16+7SitvCWpc
        VMUC+JpPT4t/vGpjal4TpRxSzjjV3tOa0WNGtHSxEZq/CpzCEBSn0lGxQ13/zgz1OFR4zrZwgfzYP
        XOaULw/G0ddjmxaZuPjzAzwWEXOQXrV0msgZbkzVZYlPi/L+XIj7pgBlz4Hvd3wL/uyWWfhSipzAD
        CCx+ZLbtAG1lZJhal6NN0dYLdLwLkVSKpji0ZZPRq1UwfPRAe00CzShevpsm2PcDiLiBCa9v5Wz5p
        JVE5+tzUw==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyhrc-000608-Fx; Tue, 26 Feb 2019 18:54:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97B8F984351; Tue, 26 Feb 2019 19:53:58 +0100 (CET)
Date:   Tue, 26 Feb 2019 19:53:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
Message-ID: <20190226185358.GQ2861@worktop.programming.kicks-ass.net>
References: <20190226062012.23746-1-lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226062012.23746-1-lenb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> Added sysfs package_threads, package_threads_list
> 
> 	Added this attribute to show threads siblings in a package.
> 	Exactly same as "core_siblings above", a name now deprecated.
> 	This attribute name and definition is immune to future
> 	topology changes.
> 
> 	Suggested by Brice.
> 
> Added sysfs die_threads, die_threads_list
> 
> 	Added this attribute to show which threads siblings in a die.
> 	V1 had proposed putting this info into "core_siblings", but we
> 	decided to leave that legacy attribute alone.
> 	This attribute name and definition is immune to future
> 	topology changes.
> 
> 	On a single die-package system this attribute has same contents
> 	as "package_threads".
> 
> 	Suggested by Brice.
> 
> Added sysfs core_threads, core_threads_list
> 
> 	Added this attribute to show which threads siblings in a core.
> 	Exactly same as "thread_siblings", a name now deprecated.
> 	This attribute name and definition is immune to future
> 	topology changes.
> 
> 	Suggested by Brice.

I think I prefer 's/threads/cpus/g' on that. Threads makes me think SMT,
and I don't think there's any guarantee the part in question will have
SMT on.
