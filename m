Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeE2FIi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:08:38 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45433 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeE2FIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:08:35 -0400
X-Google-Smtp-Source: AB8JxZrpkOke98fIUNOdu+SanQjD2uB4pe4nTpYqUbpZ1GKm72P84w7MOQy5Zu8WldI3s0BPDWStcw==
Date: Mon, 28 May 2018 22:08:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        quentin.perret@arm.com, Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180529050833.GA226378@joelaf.mtv.corp.google.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528101234.GA1293@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 12:12:34PM +0200, Juri Lelli wrote:
[..] 
> > +
> > +	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
> > +
> > +	return util;
> 
> Anyway, just a quick thought. I guess we should experiment with this a
> bit. Now, I don't unfortunately have a Arm platform at hand for testing.
> Claudio, Luca (now Cc-ed), would you be able to fire some tests with
> this change?
> 
> Oh, adding Joel and Alessio as well that experimented with DEADLINE
> lately.

I also feel that for power reasons, dl.util_avg shouldn't drive the OPP
beyond what the running bandwidth is, or atleast do that only if CFS tasks
are running and being preempted as you/Vincent mentioned in one of the
threads.

With our DL experiments, I didn't measure power but got it to a point where
the OPP is scaling correctly based on DL parameters. I think Alessio did
measure power at his setup but I can't recall now. Alessio?

thanks,

 - Joel
