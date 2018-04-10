Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523355601; cv=none;
        d=google.com; s=arc-20160816;
        b=PB7RbB7RxHV+QPK1aWnV3PW2TMcWCWOw8cOAIjHpmvDSaGqUdlHomWQ66pjjO1ovZu
         B4es9JA+XF8iyoP9wFvzbwKf3tluQWBka9+NnqL06SlpQtJUTljmpiPLT9KLieZtu1vh
         aHyE9nIh8GL7PysrHxSNbHDeQaM7Dxxr96b2ozZ1NJSKDNJhTjEHCMraJf5tBVyEY1e/
         SjRkYlcbyxshNbrbfxdbMx7dEhoA79lP77WbxaTjEssH8CRtztCSf5LmuVxKjkokuPxD
         AMzmSxWnDPPDA94Jw3JVMnoLKINk7X1NZx2QqRetz7bMpzWvnqAgcXZO8OpPW3PM/R8b
         6D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=m/LVKi7NFB+sYyyJyzzrubyeOgEEe1CZRMmMNPYhfJw=;
        b=ciPYZLPDxIqEYQtHUbjPfmBOBSEdymLAAYJM/e7E1NlEKuanSKjMl3K4X/RJFGYJmC
         0xup7IUjoqNlvQasio2ii7XvdRDABpJ9265GbZfhC7ZyX5O8nsGgZQd2eeApXUpF4tNY
         qnCseIehec7HnVgKktA+0ACw5JFuaLDzO5IALIR8R9+YXxbuNvgnP4uYqByxpCJoXHAr
         /aSIuOtGgzwanIxFfFNzGVhvkiov+uz12xJd21TfQM/4pwJfPlpvxPkvBXNAFk/rBACR
         xGaIXY5ehOtGfeTIk2LLaZmeNSytpYYg3M2jCtYeVkFbLCzlpkt5AoTNAOGZLExpH4SI
         FE9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bXlw5Bl1;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bXlw5Bl1;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AIpwx49Juh8DOYX9+cRkO1cOlmqO73fncSX5n7xBkp4x5Us+I6NUtiPesn8VpqFqtizNmPdspnC6K3L8sCUV7xu0J3Y=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180410093022.GA26106@e108498-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com> <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com> <20180409153233.GA4082@hirez.programming.kicks-ass.net>
 <20180409164205.GA3520@e108498-lin.cambridge.arm.com> <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
 <20180410093022.GA26106@e108498-lin.cambridge.arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Apr 2018 12:20:00 +0200
X-Google-Sender-Auth: OkohVfDGrJWtn6bH_WwQtPzaFSs
Message-ID: <CAJZ5v0hCR-X9zoPnw=RUwStTe=8JGcmxS8d_fjC2W0hf1cowLA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1597354122995221016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:31 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Tuesday 10 Apr 2018 at 08:55:14 (+0200), Rafael J. Wysocki wrote:
>> On Mon, Apr 9, 2018 at 6:42 PM, Quentin Perret <quentin.perret@arm.com> wrote:
>> > On Monday 09 Apr 2018 at 17:32:33 (+0200), Peter Zijlstra wrote:
>> >> On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:
>
> [...]
>
>> > I quiet like the first idea from a pure design standpoint, but I could
>> > also understand if maintainers of other archs were reluctant to
>> > have new dependencies on PM_OPP ...
>>
>> Not just reluctant I would think.
>>
>> Depending on PM_OPP directly here is like depending on ACPI directly.
>> Would you agree with the latter?
>
> Right, I see your point. I was suggesting to use PM_OPP only to make the
> OPPs *visible*, nothing else. That doesn't mean all archs would have
> to use dev_pm_opp_set_rate() or anything, they could just keep on doing
> DVFS their own way. PM_OPP would just be a common way to make OPPs
> visible outside of their subsystem, which should be harmless. The point
> is to keep the energy model loading code common to all archs.
>
> Another solution would be to let the archs populate the energy model
> data-structures themselves, and turn the current energy.c file into
> arm/arm64-specific code for ex.
>
> Overall, I guess the question is whether or not PM_OPP is the right
> interface for EAS of multiple archs ... That sounds like an interesting
> discussion topic for OSPM next week,

I agree.

> so thanks a lot for raising this point !

And moreover, we already have cpufreq and cpuidle that use their own
representations of the same information, generally coming from lower
layers.  They do that, because they need to work with different
platforms that generally represent the low-level information
differently.  I don't see why that principle doesn't apply to EAS.

Maybe there should be a common data structure to be used by them all,
but I'm quite confident that PM_OPP is not suitable for this purpose
in general.
