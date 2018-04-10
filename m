Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+fPVovTEsW5zQO6BGB9Lx52CHMxzpLwUp5IpZLLOKuJcE1z4rolDgFC0KyqX1tJppILv+1
ARC-Seal: i=1; a=rsa-sha256; t=1523352703; cv=none;
        d=google.com; s=arc-20160816;
        b=wufRRDV6dBP/3dcpfiB83vQ6AeJEAKRzg5wmN9EKL6epk+fQZAqxelhCZUBoaA1Nq1
         YTNxF1sRHwE+OWplbSFJXk6p30zujd1fIYgvYg3oFldeuH3jZjeBL3Si2tVe43iFuJmd
         TYd8xONK338birg9Vk3kbzRmJf2YXaZqg+/7C3l4fr+WztiKm0dJ2uoQNPDi9/h8BU4l
         bLNkrRsW6GuUB2TlRF77LbWMA2UyU+uHUzOD11YT4DO4BykgVIKzFv0cDDxAyZLafj6w
         hWHGr4f7ZXhWbhF/4ns5sO6xhDiBI+q1WzSskVCZLgA1QcrVSHZ12SwR1mL0jxW55IST
         ruPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=tuLy75nsiq1if3SJquuF4l++9xHECosVC/CJpP0bp0Y=;
        b=nAkmoWNCn9zfVsSVubAssrvkUY/zGVkp1LHWRoJrMxOByWxcJMgFmXmxWA+Jop4sbx
         ZwPKYFXMINBq7JyVko1ToMp/1CYIZmibJnX6sT4Yft2xiYHxMqNE+9GVrFJ1fgBaZYkv
         JfUF9N9W4N2WDZ/9OXNFANccD9QuG0xsuE4cpGtCVvWRZVJk7Ts0SlmRurHIBZAEqvpH
         HpseEHSj5nFFpq+SPVDKQfHD9lnvrrV5TFbY1Iw4Hb/FLuhqCGV44ft4km1IR7dNSZo6
         5qobsBp4FCciJFp7wjqZaJkH7HTO9h36+zky4ptrux67BHYpkbfwUTyIAVF+fV7wAZDv
         6K/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Tue, 10 Apr 2018 10:31:35 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180410093022.GA26106@e108498-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
 <20180409153233.GA4082@hirez.programming.kicks-ass.net>
 <20180409164205.GA3520@e108498-lin.cambridge.arm.com>
 <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1597351084270325004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 10 Apr 2018 at 08:55:14 (+0200), Rafael J. Wysocki wrote:
> On Mon, Apr 9, 2018 at 6:42 PM, Quentin Perret <quentin.perret@arm.com> wrote:
> > On Monday 09 Apr 2018 at 17:32:33 (+0200), Peter Zijlstra wrote:
> >> On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:

[...]

> > I quiet like the first idea from a pure design standpoint, but I could
> > also understand if maintainers of other archs were reluctant to
> > have new dependencies on PM_OPP ...
> 
> Not just reluctant I would think.
> 
> Depending on PM_OPP directly here is like depending on ACPI directly.
> Would you agree with the latter?

Right, I see your point. I was suggesting to use PM_OPP only to make the
OPPs *visible*, nothing else. That doesn't mean all archs would have
to use dev_pm_opp_set_rate() or anything, they could just keep on doing
DVFS their own way. PM_OPP would just be a common way to make OPPs
visible outside of their subsystem, which should be harmless. The point
is to keep the energy model loading code common to all archs.

Another solution would be to let the archs populate the energy model
data-structures themselves, and turn the current energy.c file into
arm/arm64-specific code for ex.

Overall, I guess the question is whether or not PM_OPP is the right
interface for EAS of multiple archs ... That sounds like an interesting
discussion topic for OSPM next week, so thanks a lot for raising this
point !

Regards,
Quentin
