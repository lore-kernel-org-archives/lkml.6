Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BFCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD12156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FK0Ucavr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBD12156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeI0OaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:30:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40237 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0OaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:30:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so4214294edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pekQ5WX6k8csmXLYb5a3CSizRD09mcOqT4091Kime8c=;
        b=FK0UcavrMBDz5r/T21/i7zwcbLrNVoXbj1rGkihBbOMFNYo6I7qbq94Jq9EZZxfafY
         D0ri+ve6vlXNdE0oXtzjCLBJlmyimjUAjoPM2S8ZYrBSK6rgsoYKKjPUicZ+cBTJcvcn
         MKAYkamolqrgQqs0B8Arl6C2vobzv3fUliH1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pekQ5WX6k8csmXLYb5a3CSizRD09mcOqT4091Kime8c=;
        b=WhG1ecIXg4e4TUE7UuFWH2hhi5z69fRaUtCoIj7J7zdTrJou42cMLhiw7yZ10zu90l
         3uUOFxAG/6w8JB5Y2SPaYyffoZFeJ/G2ipJdzBLkm3ClAGQdIfE0Z28ZebbdQEK08hTv
         4X3wCkAVSiZXd1bNme4zInKhH6FGYz69jXRqa5p/lkbT/naGM8vjGCStbUaRjWLiNqgz
         /VStrqaQujWlKOnxmK3E63kQ2TnkmfmD2wfZ/2BfVXDNvFL7FPFu0X9QTvoHimZziwWg
         wbqYJlNt9up+qWaa23HW9VOYyyIS5MUmvQtPkfCikKzPBb4JVc4T0ld0XtY9prSA0neG
         6X6g==
X-Gm-Message-State: ABuFfog5+elCqkyl7L4DDOtMXk4glcfdAZyYaj3xB8M7PzIniK1Q6jLF
        +6PwoLVZfRjisaGSJtI4fV3teA==
X-Google-Smtp-Source: ACcGV60iayI95zMGdho4uQDIAI3vIzC9Mab+HZSY6gEDmuqM6Ck0j25hKzv5Sy++VXiX80U17SvcKA==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr15716539edy.99.1538036001321;
        Thu, 27 Sep 2018 01:13:21 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id w23sm437624edv.30.2018.09.27.01.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 01:13:20 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:13:15 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927081314.GA8285@andrea>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20180926205208.GA4864@andrea>
 <20180927071747.GD5254@hirez.programming.kicks-ass.net>
 <20180927074748.GA7939@andrea>
 <20180927075935.GA4889@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927075935.GA4889@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:59:35AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 27, 2018 at 09:47:48AM +0200, Andrea Parri wrote:
> > > LKMM in particular does _NOT_ deal with mixed sized atomics _at_all_.
> > 
> > True, but it is nothing conceptually new to deal with: there're Cat
> > models that handle mixed-size accesses, just give it time.
> 
> Sure, but until that time I must not rely on (and thus not use) LKMM for
> qspinlock things.

This is way too generic to be agreed ;D


> 
> So while your argument about coherence might be true -- I'll have to
> think about it; litmus tests are out the window.

You trimmed the litmus test I gave you.

  Andrea
