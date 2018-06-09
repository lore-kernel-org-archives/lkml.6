Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YDN4IVGMG1vQaAAAmS7hNA
	; Sat, 09 Jun 2018 08:14:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7455B608B8; Sat,  9 Jun 2018 08:14:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E37816089E;
	Sat,  9 Jun 2018 08:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E37816089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeFIIOG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:14:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39857 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeFIIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:14:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so15451115wrn.6;
        Sat, 09 Jun 2018 01:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuomcKTeqmTpd9H6dPHgxZUSzs1HuVnZsV9schEjAaE=;
        b=MGjurQGdYl11MTS43HzF9f54ERmxdkQWt697H2wwGK2SmMNDGK/8XH1kcI6btToxLt
         cjYP0QA/6g4lZ91py9OYL9dUfFwzd4OpbE2GVv2bm+XixeI8Ga//w4NPHd+AoCdbefMJ
         1qJBMxznkBb9OzDPn2mQe9IMTBQ7plU9XXERXb2OI1XjJYBHFS655cHoQDmog5uj8hP3
         r0oFGpd7hPn3wocb92pyyqyJg4MZtOHy0ojp//pxc2CEdzd/oPpTPiu9bKu93xpb9SiC
         BxkRfEXn/gXPaB2gyVwh38GHUf+ig3eyvP+5o+yqntiHMOcTxixcTfUU0EVsf9zy7ifX
         /0uQ==
X-Gm-Message-State: APt69E2UpjgAtzeL6LkenzmRIfgEWLpz27dOO4+fxPD4dOIbuUR4WsG3
        RAPbYk0CCjgYkqJgr2KW3w==
X-Google-Smtp-Source: ADUXVKJI7lNq1ogTwpIV5RYotvyI/znKUWAuBQv+Q8hxkgyAc1rJyiwlOWUpZk+qLpeVm3p9GssqLw==
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr7816669wrg.139.1528532040933;
        Sat, 09 Jun 2018 01:14:00 -0700 (PDT)
Received: from tesla (2.154.108.25.dyn.user.ono.com. [2.154.108.25])
        by smtp.googlemail.com with ESMTPSA id q81-v6sm5604856wmd.14.2018.06.09.01.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 01:13:59 -0700 (PDT)
Received: from javi by tesla with local (Exim 4.91)
        (envelope-from <javi@tesla>)
        id 1fRZ0X-0006CO-Um; Sat, 09 Jun 2018 10:13:57 +0200
Date: Sat, 9 Jun 2018 10:13:57 +0200
From: Javi Merino <javi.merino@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180609081357.GC4359@tesla>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <20180607160419.GD3311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607160419.GD3311@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 06:04:19PM +0200, Juri Lelli wrote:
> On 07/06/18 16:19, Quentin Perret wrote:
> > Hi Juri,
> > 
> > On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > > On 21/05/18 15:24, Quentin Perret wrote:
> 
> [...]
> 
> > > > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > > > +{
> > > > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > > > +	int max_cap_state = cs_table->nr_cap_states - 1;
> > >                  ^
> > > You don't need this on the stack, right?
> > 
> > Oh, why not ?
> > 
> 
> Because you use it only once here below? Anyway, more a (debatable)
> nitpick than anything.

The compiler optimizes that for you because it knows that it is used
only once.  It doesn't put it in the stack, it uses a register.  As it
is, it's more readable so I'd rather keep it.

For reference, this is the code gcc 7.3 generates for arm64 for
fd_update_cstable() (which is inlined in em_rescale_cpu_capacity():

x27 holds the address to cs_table

 1ac:	b9400b63 	ldr	w3, [x27, #8]   ; w3 = cs_table->nr_cap_states
 1b0:	b9406fa4 	ldr	w4, [x29, #108] ; w4 = 0x18 (sizeof(struct em_cap_state))
 1b4:	f9400362 	ldr	x2, [x27]       ; x2 = &cs_table[state]
 1b8:	51000461 	sub	w1, w3, #0x1    ; w1 max_cap_state = cs_table->nr_cap_states - 1
[...]
 1cc:	9b240821 	smaddl	x1, w1, w4, x2  ; x1 = &cs_table->state[max_cap_state]
[...]
 1d4:	f9400427 	ldr	x7, [x1, #8]    ; x7 fmax = cs_table->state[max_cap_state].frequency
[...]                                           ; calculates cmax * cs_table->state[i].frequency in x0
 200:	9ac70800 	udiv	x0, x0, x7      ; x0 = x0 / fmax
                                                ; x0 is then stored to cs_table->state[i].capacity
