Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4/YdxR70qSTg5di3TvuIeFX8ogaMzs5PiBKhs1jRhjMmrg2UMIZR0FtQdy0e+D5WOrYXUlV
ARC-Seal: i=1; a=rsa-sha256; t=1523292195; cv=none;
        d=google.com; s=arc-20160816;
        b=DYSgJCHEW4A5iuwedeItMqc6hd1YEDkucDg15mll3ZbWCzkv7ev7cGJPiHNdTMdDII
         S0pMRuM4hWMKBt49WEXyj5siFXVDiK5r46zcAJ3wKttT21YXOH4WsiLTo5GOB0QGkBnE
         lbMETTHs4bqZP4o4nnB2rDQpbXN7xsEKBuShchzWYzOaUHeWUaGMOC4+OtW3U4W2rmTi
         2h8fi3LSJnbkYRuye+HTY95GH9GyWNBxzosx5BncIm+3DeiTCmfvuKXcCHVOw6yzT/6w
         pIvjk70OTYDvRFjsm2/hJHIMdnJIz0BbDFu1XFcA1db+WPzZBHW6ZHlJsqJMWtVv4cB0
         To3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6//XBUlMtPVBLFaMVJu4Eo8DaR913mRbm62Rg7ILrvw=;
        b=JdaBKMVOKBg2eSdavhET0b2j53FPBwxd7CnMr/EbXIqGWH8Orj0pQ4CiDxuutZ+UNk
         CzrOlTUmwqMxzkkB3RMMGAzunusHk7JCtV6yBN+E2e5qks5nvKP/nXJ8dArCZHQzQht4
         VOI8dVSUYNQ298NIEhLGLQNNMszDpAoTt+d8+6NXtTNVsvK2VUopOEXIAp0VnXDvBNTY
         1p3Xn5oxxvjZ+IEcxYr8Y2sViwpT7k12OEiQVX+80BNjSzaKhYep9jaKqTOHriBl4bXt
         ai8NRBWruI/jxM5YNuyS72ObiFROp1q9HXlujxc4MJAnawLTy6oAud8E7rkl32UZaN3k
         FOpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Mon, 9 Apr 2018 17:43:10 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20180409164310.GB3520@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
 <20180409163029.GJ4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409163029.GJ4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1597287637510728119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Monday 09 Apr 2018 at 18:30:29 (+0200), Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > +		want_energy = wake_energy(p, prev_cpu);
> >  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> > -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> > +			      && cpumask_test_cpu(cpu, &p->cpus_allowed)
> > +			      && !want_energy;
> 
> Could you please fix that and put the operators at the end of the
> previous line?

Will do.
