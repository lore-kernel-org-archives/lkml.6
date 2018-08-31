Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850F2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/tdT6Py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E850F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHaP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:57:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37740 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHaP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:57:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id d12-v6so5378614pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g6SN1PiioL/Q7SDTOkKJOGII1i4zeTcKr8qpjb9fmU=;
        b=m/tdT6PyPkUO0jHjRVeFpcKO1/d9oF1269fWuMef4n55ujQU1w9pLMOs/1doU/ED5D
         WskjmmtILynmoaF73qWTfUff/WxjkJnr1pSSupaVmHx0DmBl35ILu65JMpzC3c7tIj32
         ERrLxB2rW5pZjO3uo6GSEqeJbGt97Lc8vISFPdouQ5cH1vblnnV625uy+17UJ5Qk44cI
         //92+DnnzcY+QfpMICicN+tjFML4kn34apIuZXXNIzdh++tSMxby5FGZRbTdsnb6KDMJ
         cZ8FBpW8/Q5D04y/j4ii9dKX32WDTrNyNRxgVHWhwsUOQqsFdoOexVbE2F2ihoIBfucn
         X1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g6SN1PiioL/Q7SDTOkKJOGII1i4zeTcKr8qpjb9fmU=;
        b=HLADngXYza949cenUVjCXlLfkAyprEws6k/HQxQyLuQQ8wuW6aLIjzN6tLB1LhF0QM
         JaMa8f2xKtL0Jb3tZI2ncvEiCGeTCpaUFTkuquCdi5yHKn1M7IueZ+1eQVhX/XKUNdlH
         Ps/XBfVPAP0wfcG/NmcXV9A2bCva8OMsZm93wcI2atIuboiV6ZWxpjh5ZbInqjmN0rWH
         1u7QpE5D225NViHgTZ6tftOe9i/L2D5tz4CpPgH7VLsqKEzQshsw9wF116ctD4yhjLC1
         iw62Er9OxuLeNw+yKZACJs3mtnV0EsipT59Vr/ddeXqGIfCzlqK3PSBzX5pfn7DUBExJ
         Eg3w==
X-Gm-Message-State: APzg51CIIjlmSEiFOxxCAD3XwecrH2V99UUJOkoOowf2CiokOiohwuq8
        kF8hZHZC+TVm1FQEqtsE9Vg=
X-Google-Smtp-Source: ANB0VdbAFUHKU0MRMnaf0hTA2Yho3iqff6q23A2mOdE5QrxaULTKsZo/Xdg4Lqz0cP/Jtqdx2tmORQ==
X-Received: by 2002:a17:902:8605:: with SMTP id f5-v6mr14693088plo.271.1535716213182;
        Fri, 31 Aug 2018 04:50:13 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id x24-v6sm13486707pfh.67.2018.08.31.04.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 04:50:12 -0700 (PDT)
Date:   Fri, 31 Aug 2018 21:50:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831215004.0ae58904@roar.ozlabs.ibm.com>
In-Reply-To: <20180831104945.GI24124@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
        <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
        <20180831110054.475a3534@roar.ozlabs.ibm.com>
        <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
        <20180831095417.GF13166@arm.com>
        <20180831101014.GG24124@hirez.programming.kicks-ass.net>
        <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
        <20180831104945.GI24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 12:49:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> > Oh gee, I suppose. powerpc hash is kind of interesting because it's
> > crazy, Aneesh knows that code a lot better than I do. radix modulo
> > some minor details of exact instructions is fairly like x86   
> 
> The whole TLB broadcast vs explicit IPIs is a fairly big difference in
> my book.

That's true I guess. Maybe arm64 is closer.

> Anyway, have you guys tried the explicit IPI approach? Depending on how
> IPIs are routed vs broadcasts it might save a little bus traffic. No
> point in getting all CPUs to process the TLBI when there's only a hand
> full that really need it.

It has been looked at now and again there's a lot of variables to
weigh. And things are also sized and speced to cover various
hypervisors, OSes, hash and radix, etc. This is something we need to
evaluate on radix a bit better.

> 
> OTOH, I suppose the broadcast thing has been optimized to death on the
> hardware side, so who knows..

There are some advantages of doing it in hardware. Also some of doing
IPIs though. The "problem" is actually Linux is well optimised and it
can be hard to notice much impact until you get to big systems. At
least I don't know of any problem workloads outside micro benchmarks or
stress tests.

Thanks,
Nick
