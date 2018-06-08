Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IXTTLBSHGlsHBAAAmS7hNA
	; Fri, 08 Jun 2018 13:39:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9AFD4607DC; Fri,  8 Jun 2018 13:39:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 077F960590;
	Fri,  8 Jun 2018 13:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 077F960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHNjs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:39:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeFHNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:39:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so2469799wmc.1;
        Fri, 08 Jun 2018 06:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=75zzACS/0rRypiMM9ImfK1Nj7kkCBB0e3y/sW1Grccg=;
        b=qRsTmMES/KSwYBejpTflOXxvTBPtw7TOE4mdcpw2llgXK84z29MYovpGW/IePrMH5c
         iS+ghtPBXqbNoASRW8EDCnGxiDikAFF+WfWzKKl14c4xLpl/VyDf0tRftqJu/12hOAG/
         JXdjyv/mLx7/szPT2piM1S81O6AXx7X75YNH8rOWTEKr7qddBF9WlqRrlxh/CCLLEEIw
         5bHRwu75e5T5pqWTQBZ3vo3tlkb1RWYb4G3CFfawxRy6rywughj+fXY38dEGQbv4YFTa
         LGVfvJsmnIaklYqX5THyhHu4gySTqwFKWVnO34xEwgxPMSTsO1osUukmLJ86nuaGQft7
         uKXg==
X-Gm-Message-State: APt69E3qZdVkpMDyV69ATNVShDWsujzOq2cHcZZ/xXrNUC+8hRbr7kIA
        aQxamsCnSIv6iwep2pVkbA==
X-Google-Smtp-Source: ADUXVKIZlpEBnre3RpoJcbQxaDKYHZmBx8vN/366Ngze04xz7xMMH4pRQ/Ly8cj8Io+3uXoBS9W9dw==
X-Received: by 2002:a1c:630a:: with SMTP id x10-v6mr1798715wmb.93.1528465185446;
        Fri, 08 Jun 2018 06:39:45 -0700 (PDT)
Received: from tesla ([217.140.96.141])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm2426631wmw.0.2018.06.08.06.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 06:39:44 -0700 (PDT)
Received: from javi by tesla with local (Exim 4.91)
        (envelope-from <javi@tesla>)
        id 1fRHcF-00024n-0H; Fri, 08 Jun 2018 14:39:43 +0100
Date: Fri, 8 Jun 2018 14:39:42 +0100
From: Javi Merino <javi.merino@kernel.org>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180608133942.GB4359@tesla>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
 <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
 <20180606152000.GB15894@localhost.localdomain>
 <20180606152950.GH10870@e108498-lin.cambridge.arm.com>
 <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:26:47PM +0100, Quentin Perret wrote:
> On Wednesday 06 Jun 2018 at 16:29:50 (+0100), Quentin Perret wrote:
> > On Wednesday 06 Jun 2018 at 17:20:00 (+0200), Juri Lelli wrote:
> > > > > This brings me to another question. Let's say there are multiple users of
> > > > > the Energy Model in the system. Shouldn't the units of frequency and power
> > > > > not standardized, maybe Mhz and mW?
> > > > > The task scheduler doesn't care since it is only interested in power diffs
> > > > > but other user might do.
> > > > 
> > > > So the good thing about specifying units is that we can probably assume
> > > > ranges on the values. If the power is in mW, assuming that we're talking
> > > > about a single CPU, it'll probably fit in 16 bits. 65W/core should be
> > > > a reasonable upper-bound ?
> > > > But there are also vendors who might not be happy with disclosing absolute
> > > > values ... These are sometimes considered sensitive and only relative
> > > > numbers are discussed publicly. Now, you can also argue that we already
> > > > have units specified in IPA for ex, and that it doesn't really matter if
> > > > a driver "lies" about the real value, as long as the ratios are correct.
> > > > And I guess that anyone can do measurement on the hardware and get those
> > > > values anyway. So specifying a unit (mW) for the power is probably a
> > > > good idea.
> > > 
> > > Mmm, I remember we fought quite a bit while getting capacity-dmpis-mhz
> > > binding accepted, and one of the musts was that the values were going to
> > > be normalized. So, normalized power values again maybe?
> > 
> > Hmmm, that's a very good point ... There should be no problems on the
> > scheduler side -- we're only interested in correct ratios. But I'm not
> > sure on the thermal side ... I will double check that.
> 
> So, IPA needs to compare the power of the CPUs with the power of other
> things (e.g. GPUs). So we can't normalize the power of the CPUs without
> normalizing in the same scale the power of the other devices. I see two
> possibilities:
> 
> 1) we don't normalize the CPU power values, we specify them in mW, and
>    we document (and maybe throw a warning if we see an issue at runtime)
>    the max range of values. The max expected power for a single core
>    could be 65K for ex (16bits). And based on that we can verify
>    overflow and precision issues in the algorithms, and we keep it easy
>    to compare the CPU power numbers with other devices.
> 
> 2) we normalize the power values, but that means that the EM framework
>    has to manage not only CPUs, but also other types of devices, and
>    normalized their power values as well. That's required to keep the
>    scale consistent across all of them, and keep comparisons doable.
>    But if we do this, we still have to keep a normalized and a "raw"
>    version of the power for all devices. And the "raw" power must still
>    be in the same unit across all devices, otherwise the re-scaling is
>    broken. The main benefit of doing this is that the range of
>    acceptable "raw" power values can be larger, probably 32bits, and
>    that the precision of the normalized range is arbitrary.
> 
> I feel like 2) involves a lot of complexity, and not so many benefits,
> so I'd be happy to go with 1). Unless I forgot something ?

>From the thermal point of view, the power values don't need to have
any given unit, as long as the values are comparable to each other.
Do we need to normalize anything in the kernel though?  Can't we just
assume that whatever the platform is telling us is correct?  Quentin
mentioned it earlier: sometimes absolute values are considered
sensitive and we only get ones that are correct relative to the rest
of the system.

(This reminds me that the units in
Documentation/thermal/cpu-cooling-api.txt are wrong and I need to fix
it :-X )

Cheers,
Javi
