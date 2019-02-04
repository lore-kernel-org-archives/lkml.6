Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6900720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xu5ymkwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfBDQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:41:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfBDQl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:41:28 -0500
Received: from zn.tnic (p200300EC2BC6E200ECEE10EFADD37342.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:ecee:10ef:add3:7342])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34D471EC0345;
        Mon,  4 Feb 2019 17:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549298487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VLtX9rQYs3GJpxOjm054p23u/jDklfYWy6XeGItIPqI=;
        b=Xu5ymkwmiguq57zX3Ujf0RWR8Bx3kngqCVK6bdrGF+ooCcZouN56L5sXwBCd+K4Aqzl4Ce
        GTTnEmriPoQ/iPLBB4FPMgUPG1QHM5A2kD37Ca5h2Pe15XdLg610zGoUC92h5avll2q5SO
        SJqwTUjYC4o8d07b41taeRL7PjWWheA=
Date:   Mon, 4 Feb 2019 17:41:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204164121.GG29639@zn.tnic>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204160454.GE29639@zn.tnic>
 <f67d228e-c65d-479c-30ec-ee532833d8f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f67d228e-c65d-479c-30ec-ee532833d8f9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:23:13AM -0500, Liang, Kan wrote:
> I mean that the microcode version number is irrelevant between stepping.
> Let's use SKL server as an example.
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
> +	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
> 
> We need the function to check the min microcode version number for each
> stepping.

So you need to say "ignore stepping". I.e., X86_STEPPING_ANY.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
