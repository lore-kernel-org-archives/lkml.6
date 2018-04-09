Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/THAliwObalrhxiPc7Yj1fVlOaRaVIGuthmz3jYQUn6QIvtbSLAlo+/mMfB69CjdsEuJSk
ARC-Seal: i=1; a=rsa-sha256; t=1523291436; cv=none;
        d=google.com; s=arc-20160816;
        b=Zi4RT/XH4emPPr/NkGq0BRxBG3XFVg/yeXeNyd2AiHRU3VPr3uKbNPWJCiYl9t1pgk
         d0ToiWFUg2dTyLiu8AmucpcVbyMnL0nJcKa79kRFg8RmSJSICQ2STq/0pCAoM/ynHLgh
         MOfHhjmvdReqs+yFSrowUkAz8Q2EmBHnS57vVb/+mzu2X6gFW2koIKs0walqAVgKBl70
         iiI07QSwggBEOgmHWADDGEhM+Gv9tT6abICcLMpyaIjb1yrOlRezadaFgiac3EzyImDN
         VtzKI7jQnru6CjJo2+lqCcaaq2QbubSY+6jmN8ZDWJg/eI5zpWLVg/8aNcV0aD9VjQEP
         Lcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PtBCOs+qRd1NZzzIbGzzdrgGu7FnkikpnoDjZKPqOZg=;
        b=pGp6iNXfxFq1lpXWs3ZO129lOQjiNqgQz9Sbu04/SIRK4dd9GpSAzSgancreGzo+a5
         z3ftY2cEi8n888gqXeVcnSX7uJlHQhGhf4hizMBd3h/EkvheHj2NpITds16xRwJAiAD9
         nZCcivoq2+CkOildDHCR0IOHmCRb7VFgt9FIJcA8VTc6TySjHbW4TLHUHPMk6A+cGWjJ
         e3wnXW1VWuGXG+xqpz6qA7XDUUHlaDaADZwxbmH5yQ+xxVnHCdR3OENIjfza+OpbRHmc
         8NJXYuiuzQ5Nc5bELXRG7aIkN5u0mtpgig1Pn0upJTVH5BtGGPY5TcgUpHk67RJ7NoMm
         OuQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yFy00EKn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yFy00EKn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 18:30:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180409163029.GJ4064@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-6-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1597286841748900531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> +		want_energy = wake_energy(p, prev_cpu);
>  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> +			      && cpumask_test_cpu(cpu, &p->cpus_allowed)
> +			      && !want_energy;

Could you please fix that and put the operators at the end of the
previous line?
