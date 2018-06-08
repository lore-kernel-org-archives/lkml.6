Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pPjeOTZLGlsmTQAAmS7hNA
	; Fri, 08 Jun 2018 09:36:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB105607DC; Fri,  8 Jun 2018 09:36:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 57C2E60275;
	Fri,  8 Jun 2018 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57C2E60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeFHJgV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:36:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39553 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeFHJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:36:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so2418335wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=44pemS4X4ozOuSBwIJLOA0xpKcVtVrCxErmeUY5xf2Q=;
        b=hLQzKPO5WJUrgUZQ40Djz2SIHUVWNRCKaeZhKQk/In5JqeZpufYpqF8rxrzIl11fnt
         zsn7+PFAdPRHYstjenP29b5RDwU3nGpmdHlrIH2HVvjs48muS4IXnsldR5xBbhXzNnoo
         i8e5J5VYXvR1TOWnlmXXlS1dC1eJstBs9webChfsn8v3/p6ZaaQWPbjRyQrZ32DkcWRy
         blMS1TXWVyZVKoNt5NkEo1SgxJT850MYvVHBmUC78CwHvNoclmJiNml12Rm1HREmGV3G
         XJ6HKaGxTVIoDblvjzhdY2C8dnWqnaKk9xqmnr1Pb9ce+6aQGzIx7wFN1TkFwkniejse
         R/Fg==
X-Gm-Message-State: APt69E2ItXy/9YgojnekqETvQRPCX7c3kFbIvPEs4qfCyGRBUV/jAMKT
        iCq2q3xsIWH4SX1egQAJsj7VhA==
X-Google-Smtp-Source: ADUXVKLKUVj3vTr5DGvmUbvgAVXoZsLGO5gmbeiciloXNCTa/a+Q6co7qxjL5Kz9W2wMrO+2y1t4XA==
X-Received: by 2002:a1c:574b:: with SMTP id l72-v6mr1064275wmb.56.1528450577205;
        Fri, 08 Jun 2018 02:36:17 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id q77-v6sm2052476wmg.25.2018.06.08.02.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 02:36:16 -0700 (PDT)
Date: Fri, 8 Jun 2018 11:36:13 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180608093613.GD658@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 09:25, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Thursday 07 Jun 2018 at 17:55:32 (+0200), Dietmar Eggemann wrote:

[...]

> > IMHO, part of the problem why this might be harder to understand is the fact
> > that the patches show the use of the 2. init call
> > 'em_rescale_cpu_capacity()' but not the 1. one 'em_register_freq_domain()'.
> > I guess that Quentin wanted to keep the set as small as possible.
> 
> Yes, this is confusing. I'm now starting to think that patch 10/10 should
> probably not be part of this patch-set, especially if I don't provide
> the patches registering the freq domains from the CPUFreq drivers. And
> it's the only "Arm-specific" patch in this arch-independent patch-set.
> 
> So I think I'll drop patch 10/10 for v4 ... That part should be
> discussed separately, with the rest of the Arm-specific changes.

Mmm, I would actually vote to at least have one example showing how and
where the em_register_freq_domain() is going to be used. I had to look
at the repo you referenced since I think it's quite fundamental piece to
understand the design, IMHO.
