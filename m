Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-25873-1527076843-2-9823135990606787047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527076842; b=YVAG5CK32I7n9WX4eoE+L+GnwfLlcfqtHDRQpMyrKRNX4OPell
    j6JqchJUiGeObHEiCukmZLY56IL+bylMHnkQINq3y6H2Ulr9C3TL53oxYIO0IAyT
    sXyZ/0KHs1n2mEqR6vnVxN5b3ayYjUEH5D7W6BpWbH1Cn90LHxnyWtWaFnlWhN4Z
    rw2fDpXQlVGLaQiaJu2SPAzz9XyDrJbWgYh7wv+heMYiBk+mmygewz4r59PANDS0
    oxymhdxHC5aQyKEEGRyqlWMYZ5c++ej18+NBQ5q7oNuFFRLfx4dih3g/LwrndNOb
    /2tKTC5mhpcc+nc7voUCubTtlwwYUNQ+zjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527076842; bh=SYceDP4wzpo8WOdaTzUOcSoxwz09qv
    TJW7ZJCpwiQwc=; b=P/p1QPp1U4pS2o7AmUfdNdkP11aeEZayKxprJ1EIyTx+3k
    1+pei9Z31cSmoUDbNxTbxkU9DvA2edsPvFmGo2EQdGl1UrlhYgIQVE6ElNhCDyg5
    ud1+dfgQ6kjiO4Ir0e+XPH3snT+JeG29kXgYGLciqrpoO+z3aoulohfQ9kSZ159I
    pvYxbrEMTX6HFWuqhSuRZ3Lp4AfCBZdZIopN/oT96/ttHrAHFdS3LYr1YLH3W4OX
    Wkmmewf42y1De5neGzf0GKPeNpuDgp03MR3033JnzCOlO29rIYD4oE9b4EmQFYmp
    FLHo4jNhymQEPLIJXEcqo2pL1yxcYMdwSHLniaUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNlN8PwXqaxVnwAHRYPLH7ZraHz5GZiNOGpoGlb8oMYXn8ENOKt/GOlSCHk4P7y7LlD/5JN/vWM6GqZOQFaSI8gpthccpBPKxzXiHe3bCBT5v+MMOuSo
    izSUVG6pfDmoTHN8eJWkEmuq2tppBlnRptz5p0qTsaGU6wNM8ridqg5GX+jmRG2e8whR9i8LJR76KTliXaRKuQpsjYmz8xTxaM2BmqL/Qz2N2Ucy2G0IUeEy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=meVymXHHAAAA:8
    a=3-bnoIng8rsf4TrQTr8A:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeEWMAl (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 08:00:41 -0400
Received: from foss.arm.com ([217.140.101.70]:54230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932534AbeEWMAk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 May 2018 08:00:40 -0400
Date: Wed, 23 May 2018 13:01:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] thread_info: Add update_thread_flag() helpers
Message-ID: <20180523120103.GD26965@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
 <1524135528-28561-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524135528-28561-2-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:58:43AM +0100, Dave Martin wrote:
> There are a number of bits of code sprinkled around the kernel to
> set a thread flag if a certain condition is true, and clear it
> otherwise.
> 
> To help make those call sites terser and less cumbersome, this
> patch adds a new family of thread flag manipulators
> 
> 	update*_thread_flag([...,] flag, cond)
> 
> which do the equivalent of:
> 
> 	if (cond)
> 		set*_thread_flag([...,] flag);
> 	else
> 		clear*_thread_flag([...,] flag);
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---

Looks sensible to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
