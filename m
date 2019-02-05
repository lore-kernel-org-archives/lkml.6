Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE482C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7282083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7qF1HNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfBEPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:35:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfBEPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7AbyJLvDLgkxHEHIHcao1n/A7ylNuEDRyYPazl1hdVk=; b=K7qF1HNI7rFBFZswwwPs2OMuu
        1YQh345d6Q1slCzfvvFH5o/Z8s/U69EpxYjYBLEYsxsE1w7OY6jOQIfw2pUvB++333UM7wF7MivRp
        Er1g8lTt2nhVhpXnqxnOnDfhwJb+lbUnTpEMTL+z9qtqT2LMAu1T2/6bDa0kQpHIVvGH6usoXeOrQ
        Vdjc/ykOy93fxMHoKVH9uKqgzD5IqHwn/NoPG6xPHQr/chwGK6gIDPpSqCHUaRwFH8uMvbkn/RGKH
        LQlgDq+zEDPd/P0Ea1X5miJ48QcGNUxAmMgnXp95t0s5s2/8gBrYqhRAKux5u4jReYLzb1AVrO2Uh
        TzeuegbjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr2kM-0004b7-IH; Tue, 05 Feb 2019 15:34:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F70A2029F1D4; Tue,  5 Feb 2019 16:34:49 +0100 (CET)
Date:   Tue, 5 Feb 2019 16:34:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205153449.GH17564@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204210912.GA70429@romley-ivt3.sc.intel.com>
 <20190205085115.GL17528@hirez.programming.kicks-ass.net>
 <6ff8502f-9d14-0fc6-bffb-e3549fa53a1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff8502f-9d14-0fc6-bffb-e3549fa53a1c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:21:59AM -0800, Dave Hansen wrote:
> On 2/5/19 12:51 AM, Peter Zijlstra wrote:
> > On Mon, Feb 04, 2019 at 01:09:12PM -0800, Fenghua Yu wrote:
> > 
> >> Intel SDM published TODAY does have IA32_CORE_CAPABILITY MSR enumerateion
> >> bit CPUID.0x7.0:EDX[30] now. Please check today's SDM for the bit:
> >> https://software.intel.com/en-us/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4
> > When I click that link I get Nov'18, not Feb'19.
> 
> Try starting from intel.com/sdm.
> 
> It just got released yesterday, so it's entirely possible that some
> caches were out of date when you tried.
> 
> I see "Order Number: 325462-069US January 2019" at the bottom of the
> first page.

Still Nov'18. I suppose I'll have to wait moar...
