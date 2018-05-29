Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeE2GcF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:32:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38583 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2GcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:32:03 -0400
X-Google-Smtp-Source: AB8JxZq535M1lWnQddh2c+/URPZOFHNU3z0TuaS81MwZCTtBzj+1kE2cD9FWC1HVwNbbBzP6HjSGyw==
Date: Tue, 29 May 2018 08:31:58 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        quentin.perret@arm.com, Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180529063158.GB8985@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain>
 <20180529050833.GA226378@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529050833.GA226378@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/18 22:08, Joel Fernandes wrote:
> On Mon, May 28, 2018 at 12:12:34PM +0200, Juri Lelli wrote:
> [..] 
> > > +
> > > +	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
> > > +
> > > +	return util;
> > 
> > Anyway, just a quick thought. I guess we should experiment with this a
> > bit. Now, I don't unfortunately have a Arm platform at hand for testing.
> > Claudio, Luca (now Cc-ed), would you be able to fire some tests with
> > this change?
> > 
> > Oh, adding Joel and Alessio as well that experimented with DEADLINE
> > lately.
> 
> I also feel that for power reasons, dl.util_avg shouldn't drive the OPP
> beyond what the running bandwidth is, or atleast do that only if CFS tasks
> are running and being preempted as you/Vincent mentioned in one of the
> threads.

It's however a bit awkward that we might be running at a higher OPP when
CFS tasks are running (even though they are of less priority). :/

> With our DL experiments, I didn't measure power but got it to a point where
> the OPP is scaling correctly based on DL parameters. I think Alessio did
> measure power at his setup but I can't recall now. Alessio?

I see. Thanks.
