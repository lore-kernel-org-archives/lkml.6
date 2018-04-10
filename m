Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx48XfTBZrQNuhOzgFAohdPpqpYBZlZsRMqma5OJsCRm2PMgFoIryTpqqu/t4jzDbNac6etAK
ARC-Seal: i=1; a=rsa-sha256; t=1523361812; cv=none;
        d=google.com; s=arc-20160816;
        b=iKzo9HXFLxfb4hEW1wrf9HQChm1myuYmjsA6KwEso4J6N3mlzgoQv6lg5Wnu+ji2zi
         ztKr12CMn2VvKjK20utNSjdBnn9GFywyZ0vg9dPQubADGr+BwwpILJAwmFfEn7x4C+lU
         D0PInXvJZdIX8i1vQKz8byHPzov+xBLAd27Of5+TBsuLWH8iHGueXK9+0VqD1xdNcuOn
         r682lUg/Tr/5yQyAyRD4IqIfk3vCVq61IbEsGe0SPanVvY9ICKJhyVwdYjfWsJ15own2
         YVk1Fv5Lij4OXBHTG9hZaEaYPN7iJjxvwYRAQLbD0Hr3WpwUJBm4OV08flzF7rp87lWW
         1isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=8rC8o5CTTVpcH9+Oit7h7urY7qdn+bu4K+pHaozfUkU=;
        b=rgGJJ/qbuB50iOWkZTMB5NEy3jViu5Pftof2mWXq4aMD45++aj+IbrXN+QOCEHzsmn
         iBavm66axsddk7GwH6e+apYJLNWHvfVp6hq1rMrpQ/IAf8HakxEJV3MPvI2dKtcznDUC
         ocw1+QiyY3bQeDM9avgl44CRQyqa0RoavnxCRYan/0Iq1DizWvLHzJ7VmDEyL7tBsn/i
         OSPR7kvamqNxJ/Rn9crpXtFYZIXgmqsgbGzt1rAYMgoygUqusnEAJCMZXCvMUtHg7h7U
         x6dCA87AiZOYh65aahKcJKooIcjyYoIKNfsqJ1l1Oa4APEj1PQwOxIEGYWMnHjWil1Ko
         zmCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>,
 Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
 <20180410115457.GB4043@hirez.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2e35ede9-0926-836b-4068-8d12b6296597@arm.com>
Date: Tue, 10 Apr 2018 14:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410115457.GB4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011681114649781?=
X-GMAIL-MSGID: =?utf-8?q?1597360636408984538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 01:54 PM, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:36:03PM +0100, Dietmar Eggemann wrote:
>> +		/*
>> +		 * Build the energy model of one CPU, and link it to all CPUs
>> +		 * in its frequency domain. This should be correct as long as
>> +		 * they share the same micro-architecture.
>> +		 */
> 
> Aside from the whole PM_OPP question; you should assert that assumption.
> Put an explicit check for the uarch in and FAIL the init if that isn't
> met.
> 
> I don't think it makes _ANY_ kind of sense to share a frequency domain
> across uarchs and we should be very clear we're not going to support
> anything like that.
> 
> I know DynamiQ strictly speaking allows that, but since it's insane, we
> should consider that a bug in DynamiQ.

Totally agree! We will add this assert. One open question of the current 
EAS design solved ;-)
