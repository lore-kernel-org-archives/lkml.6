Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CC8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBE2255B8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nbNEe3pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBE2255B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeFYITb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:19:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38764 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeFYIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:19:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so12669334wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GNG260OkDXPjmyQRiH2aSXewZVLsNT3b73BSDZZ5sBY=;
        b=nbNEe3pFFAZfSWXxMWdr25y1l+Q9lpVpBZaV7BqU/1/rzlkiaNsqVfTWyc1cn+Ib+N
         ZRf++pTSnjqwvhBndhXdX4eM5mTfI1kaaXEHFQ2JqROqOD0ArR1UuLHHz0Q72m+OpUAV
         7+/BtOyQ3hg5yKclCyBqZlKaJ+vUb/zWrAjKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNG260OkDXPjmyQRiH2aSXewZVLsNT3b73BSDZZ5sBY=;
        b=afj/rcG0wgeGbnMhBreyKPNN1asrvON8sRlm8GNXMacIOH6QvXJTpYmQkQkU6lbaNK
         f9ZO9yP3n2tDxk9LOlRq++pPq7SduSaacjjWALRX8NHwJetppzfuKzDohJ4hbU8/8xRf
         LzYIMRD1lASxdX/gMlwtZPwnYCogasD8wvGyYGTr0sf8eYa5JljTnUl2rgjoKUWDfAZf
         YkrTSMKU0Qu+yjdPM8y7CwOlPD+rnuzkdyexs5BBWwpE7rAHkC49EIeHh6ahUgillknw
         lL2B+w+KBTfqWReFLHMghmG/Cg2e33B1IDMNKt+kZc5BnmjJ5+dQnZxUqF4Defk9XiKW
         a1oQ==
X-Gm-Message-State: APt69E3sw63lsjWBSnFnxFytx/5+Wlt5eixbJ+/hNB+NiQ7c64i8QksY
        fm/N7vQVRiUT9hEu24B3HS5PXw==
X-Google-Smtp-Source: AAOMgpf77i74z1hA3e4csxIcFld+sLRr8hnrpmmUQXTGIvgQgFKuuTeP2VGwHkQ6GZ+2KZMXn2WMHA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr9137570wrn.33.1529914767824;
        Mon, 25 Jun 2018 01:19:27 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id c10-v6sm14032311wrs.6.2018.06.25.01.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 01:19:27 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:19:20 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180625081920.GA5619@andrea>
References: <20180622080928.GB7601@arm.com>
 <Pine.LNX.4.44L0.1806221337440.1454-100000@iolanthe.rowland.org>
 <20180622183007.GD1802@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622183007.GD1802@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > I think the second example would preclude us using LDAPR for load-acquire,

> I don't think it's a moot point. We want new architectures to implement
> acquire/release efficiently, and it's not unlikely that they will have
> acquire loads that are similar in semantics to LDAPR. This patch prevents
> them from doing so,

By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
consider, e.g., the two litmus tests below: what am I missing?

  Andrea


C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce

{}

P0(int *x, int *y)
{
	WRITE_ONCE(*x, 1);
	smp_wmb();
	WRITE_ONCE(*y, 1);
}

P1(int *x, int *y, int *z)
{
	r0 = READ_ONCE(*y);
	smp_store_release(z, 1);
	r1 = smp_load_acquire(z);
	r2 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)


AArch64 MP+dmb.st+popl-rfilq-poqp
"DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
Generator=diyone7 (version 7.49+02(dev))
Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
Com=Rf Fr
Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
{
0:X1=x; 0:X3=y;
1:X1=y; 1:X3=z; 1:X6=x;
}
 P0          | P1            ;
 MOV W0,#1   | LDR W0,[X1]   ;
 STR W0,[X1] | MOV W2,#1     ;
 DMB ST      | STLR W2,[X3]  ;
 MOV W2,#1   | LDAPR W4,[X3] ;
 STR W2,[X3] | LDR W5,[X6]   ;
exists
(1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
