Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C35C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCA920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="MHTc5/Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCA920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbeHAIxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:53:45 -0400
Received: from mx1.riseup.net ([198.252.153.129]:34350 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387477AbeHAIxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:53:45 -0400
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 369391A0B20;
        Wed,  1 Aug 2018 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1533107371; bh=3hA//q3GoSxo+jgGXASDBWiSyVH180BuHlEJ2tjXDjc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MHTc5/OiXWYwVLQWZPqmV05C599JVgYTAiX/+MS64JB+gdEhGoctOe5DIOZX/gpmn
         RsPD8OETLMKWXRW1GXoTTP6xxZnODj2CjAEBtfJY3VUhlVA9bd45uNOGBKGr6teQ9c
         z7VtoCAJHiRFlurcd/VDLEXVWG8UspyJyqaLWZCI=
X-Riseup-User-ID: F7FA7D62B7935FED3317FCC8B19686EF705CBC955FDD13808EA233EC14BB1C6C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id 1034E61A98;
        Wed,  1 Aug 2018 00:09:27 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
In-Reply-To: <1533021001.3300.2.camel@suse.cz>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com> <87bmarhqk4.fsf@riseup.net> <20180728123639.7ckv3ljnei3urn6m@techsingularity.net> <87r2jnf6w0.fsf@riseup.net> <20180730154347.wrcrkweckclgbyrp@techsingularity.net> <87lg9sefrb.fsf@riseup.net> <1533021001.3300.2.camel@suse.cz>
Date:   Tue, 31 Jul 2018 23:52:20 -0700
Message-ID: <87pnz2bmu3.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Giovanni Gherdovich <ggherdovich@suse.cz> writes:

> On Mon, 2018-07-30 at 11:32 -0700, Francisco Jerez wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>>=C2=A0
>> > On Sat, Jul 28, 2018 at 01:21:51PM -0700, Francisco Jerez wrote:
>> > > > > Please revert this series, it led to significant energy usage and
>> > > > > graphics performance regressions [1].=C2=A0=C2=A0The reasons are=
 roughly the ones
>> > > > > we discussed by e-mail off-list last April: This causes the inte=
l_pstate
>> > > > > driver to decrease the EPP to zero when the workload blocks on IO
>> > > > > frequently enough, which for the regressing benchmarks detailed =
in [1]
>> > > > > is a symptom of the workload being heavily IO-bound, which means=
 they
>> > > > > won't benefit at all from the EPP boost since they aren't signif=
icantly
>> > > > > CPU-bound, and they will suffer a decrease in parallelism due to=
 the
>> > > > > active CPU core using a larger fraction of the TDP in order to a=
chieve
>> > > > > the same work, causing the GPU to have a lower power budget avai=
lable,
>> > > > > leading to a decrease in system performance.
>> > > >=C2=A0
>> > > > It slices both ways.
>> > >=C2=A0
>> > > I don't think it's acceptable to land an optimization that trades
>> > > performance of one use-case for another,
>> >=C2=A0
>> > The same logic applies to a revert
>>=C2=A0
>> No, it doesn't, the responsibility of addressing the fallout from a
>> change that happens to hurt performance even though it was supposed to
>> improve it lies on the author of the change, not on the reporter of the
>> regression.
>
> The server and desktop worlds have different characteristics and needs, w=
hich
> in this particular case appear to be conflicting. Luckily we can can
> differentiate the two scenarios (as in the bugfix patch by Srinivas a few
> hours ago).
>

I'm skeptical that the needs of the server and desktop world are really
as different and conflicting as this discussion may make them seem.  In
a server environment it can be as much (if not more) of a factor how
many requests the system can process per second rather than the latency
of any individual request (since the latency of the network can easily
be an order of magnitude higher than the latency reduction that can
possibly be achieved by tricking the HWP into reacting faster).  I'm not
convinced about the usefulness of trading the former for the latter in a
server environment, particularly since we could achieve both goals
simultaneously.

>> The task scheduler does go through the effort of attempting to re-use
>> the most frequently active CPU when a task wakes up, at least last time
>> I checked.
>
> Unfortunately that doesn't happen in practice; the load balancer in the
> scheduler is in a constant tension between spreading tasks evenly across =
all
> cores (necessary when the machine is under heavy load) and packing on jus=
t a
> few (which makes more sense when only a few threads are working and the b=
ox is
> almost idle otherwise). Recent evolutions favour spreading. We often obse=
rve
> tasks helplessly bounce from core to core losing all their accrued utilis=
ation
> score, and intel_pstate (with or without HWP) penalizes that.
>

That's unfortunate.  Luckily it's easy enough for the cpufreq governor
to differentiate those cases from the applications that have enough
parallelism to utilize at least one system resource close to its maximum
throughput and become non-CPU-bound.

> On Mon, 2018-07-30 at 11:32 -0700, Francisco Jerez wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>>
>> [...]
>> > One pattern is a small fsync which ends up context switching between
>> > the process and a journalling thread (may be dedicated thread, may be
>> > workqueue depending on filesystem) and the process waking again in the
>> > very near future on IO completion. While the workload may be single
>> > threaded, more than one core is in use because of how the short sleeps
>> > migrate the task to other cores.=C2=A0=C2=A0HWP does not necessarily n=
otice that
>> > the task is quite CPU-intensive due to the migrations and so the
>> > performance suffers.
>> >=C2=A0
>> > Some effort is made to minimise the number of cores used with this sort
>> > of waker/wakee relationship but it's not necessarily enough for HWP to
>> > boost the frequency.=C2=A0=C2=A0Minimally, the journalling thread woke=
n up will
>> > not wake on the same CPU as the IO issuer except under extremely heavi=
ly
>> > utilisation and this is not likely to change (stacking stacks too often
>> > increases wakeup latency).
>> >=C2=A0
>>=C2=A0
>> The task scheduler does go through the effort of attempting to re-use
>> the most frequently active CPU when a task wakes up, at least last time
>> I checked.=C2=A0=C2=A0But yes some migration patterns can exacerbate the=
 downward
>> bias of the response of the HWP to an intermittent workload, primarily
>> in cases where the application is unable to take advantage of the
>> parallelism between CPU and the IO device involved, like you're
>> describing above.
>
> Unfortunately that doesn't happen in practice; the load balancer in the
> scheduler is in a constant tension between spreading tasks evenly across =
all
> cores (necessary when the machine is under heavy load) and packing on jus=
t a
> few (which makes more sense when only a few threads are working and the b=
ox is
> idle otherwise). Recent evolutions favour spreading. We often observe tas=
ks
> helplessly bounce from core to core losing all their accrued utilization
> score, and intel_pstate (with or without HWP) penalizes that.
>
> That's why in our distro SLES-15 (which is based on 4.12.14) we're sporti=
ng a
> patch like this:
> https://kernel.opensuse.org/cgit/kernel/commit/?h=3DSLE15&id=3D3a287868cb=
7a9 which
> boosts tasks that have been placed on a previously idle CPU. We haven't e=
ven
> proposed this patch upstream as we hope to solve those problems at a more
> fundamental level, but when you're supporting power management (freq scal=
ing)
> in the server world you get compared to the performance governor, so your
> policy needs to be aggressive.
>
>>=C2=A0
>> > > > With the series, there are large boosts to performance on other
>> > > > workloads where a slight increase in power usage is acceptable in
>> > > > exchange for performance. For example,
>> > > >=C2=A0
>> > > > Single socket skylake running sqlite
>> > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v4.17=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A041ab43c9
>> > > > Min=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trans=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A02580.85 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A05401.58 ( 109.29%)
>> > > > Hmean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trans=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A02610.38 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05518.3=
6 ( 111.40%)
>> > > > Stddev=C2=A0=C2=A0=C2=A0=C2=A0Trans=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A028.08 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0208.90 (-644.02%)
>> > > > CoeffVar=C2=A0=C2=A0Trans=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A01.08 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A03.78 (-251.57%)
>> > > > Max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trans=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A02648.02 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A05992.74 ( 126.31%)
>> > > > BHmean-50 Trans=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02629.78 (=C2=A0=C2=A0=
=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05643.81 ( 114.61%)
>> > > > BHmean-95 Trans=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02620.38 (=C2=A0=C2=A0=
=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05538.32 ( 111.36%)
>> > > > BHmean-99 Trans=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02620.38 (=C2=A0=C2=A0=
=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05538.32 ( 111.36%)
>> > > >=C2=A0
>> > > > That's over doubling the transactions per second for that workload.
>> > > >=C2=A0
>> > > > Two-socket skylake running dbench4
>> > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v4.17=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A041ab43c9
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A040.85 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A014.97 (=C2=A0=C2=A063.36%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A042.31 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A017.33 (=C2=A0=C2=A059.04%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A053.77 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A027.85 (=C2=A0=C2=A048.20%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A068.86 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A043.78 (=C2=A0=C2=A036.42%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A016=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A082.62 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A056.51 (=C2=A0=C2=A031.60%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0135.80 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0116.06 (=C2=A0=C2=A014.54%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A064=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0737.51 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0701.00 (=C2=A0=C2=A0=C2=A04.95%)
>> > > > Amean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0512=C2=A0=C2=A0=C2=A0=C2=
=A014996.60 (=C2=A0=C2=A0=C2=A00.00%)=C2=A0=C2=A0=C2=A0=C2=A014755.05 (=C2=
=A0=C2=A0=C2=A01.61%)
>> > > >=C2=A0
>> > > > This is reporting the average latency of operations running
>> > > > dbench. The series over halves the latencies. There are many examp=
les
>> > > > of basic workloads that benefit heavily from the series and while I
>> > > > accept it may not be universal, such as the case where the graphics
>> > > > card needs the power and not the CPU, a straight revert is not the
>> > > > answer. Without the series, HWP cripplies the CPU.
>> > > >=C2=A0
>> > >=C2=A0
>> > > That seems like a huge overstatement.=C2=A0=C2=A0HWP doesn't "crippl=
e" the CPU
>> > > without this series.=C2=A0=C2=A0It will certainly set lower clocks t=
han with this
>> > > series for workloads like you show above that utilize the CPU very
>> > > intermittently (i.e. they underutilize it).=C2=A0
>> >=C2=A0
>> > Dbench for example can be quite CPU intensive. When bound to a single
>> > core, it shows up to 80% utilisation of a single core.
>>=C2=A0
>> So even with an oracle cpufreq governor able to guess that the
>> application relies on the CPU being locked to the maximum frequency
>> despite it utilizing less than 80% of the CPU cycles, the application
>> will still perform 20% worse than an alternative application handling
>> its IO work asynchronously.
>
> It's a matter of being pragmatic. You're saying that a given application =
is
> badly designed and should be rewritten to leverage parallelism between CP=
U and
> IO.

Maybe some of them should be rewritten but that wasn't what I was trying
to say -- The point was that the kind of applications that benefit from
boosting on IO wait are necessarily within this category of workloads
that aren't able to take full advantage of any system resource anyway.
It's not like HWP would be "crippling" the CPU for a well-behaved
application.

> But in the field you *have* applications that behave that way, and the OS
> is in a position to do something to mitigate the damage.
>

Even when such a mitigation may actually reduce the performance of the
*same* applications when they are TDP-bound and the parallelism of the
system is limited by its energy usage?  I'm not objecting to optimizing
for latency-sensitive applications a priori, but such optimizations
shouldn't be applied unless we have an indication that the performance
of the system can possibly improve as a result (e.g. because the
application doesn't already have a bottleneck on some IO device).

>>=C2=A0
>> > When unbound, the usage of individual cores appears low due to the
>> > migrations. It may be intermittent usage as it context switches to
>> > worker threads but it's not low utilisation either.
>> >=C2=A0
>> > intel_pstate also had logic for IO-boosting before HWP=C2=A0
>>=C2=A0
>> The IO-boosting logic of the intel_pstate governor has the same flaw as
>> this unfortunately.
>>
>
> Again it's a matter of pragmatism. You'll find that another governor uses
> IO-boosting: schedutil. And while intel_pstate needs it because it gets
> otherwise killed by migrating tasks,

Right, I've been working on an alternative to that.

> schedutil is based on the PELT utilization signal and doesn't have
> that problem at all.

Yes, I agree that the reaction time of PELT can be superior to HWP at
times.

> The principle there is plain and simple: if I've been "wasting time"
> waiting on "slow" IO (disk), that probably means I'm getting late and
> there is soon some compute to do: better catch up on the lost time and
> speed up. IO-wait boosting on schedutil was discussed at
> https://lore.kernel.org/lkml/3752826.3sXAQIvcIA@vostro.rjw.lan/
>

That principle is nowhere close to a universal rule.  Waiting on an IO
device repeatedly is often a sign that the IO device is itself
overloaded and the CPU is running at an unnecessarily high frequency
(which means lower parallelism than optimal while TDP-bound), since
otherwise the CPU wouldn't need to wait on the IO device as frequently.
In such cases IOWAIT boosting gives you the opposite of what the
application needs.

>
> Giovanni Gherdovich
> SUSE Labs

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW2FYpAAKCRCDmTidfVK/
W2OsAQCU4ZmTu9n/WSsGVT1DwYgorVB+FesJTq0JqU44OS/24wEAh7f/krJvE8kG
GQ1VG9enw3fUlvKeiZ6g9opJtrNFwNc=
=ry1/
-----END PGP SIGNATURE-----
--==-=-=--
