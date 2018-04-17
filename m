Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523969481; cv=none;
        d=google.com; s=arc-20160816;
        b=hsOUGzELxzi6K+u7THBA7OLxr3KuNVZCI8kjv0t/lQ020s3y6GYC36EjvcExmINKCV
         a6zkiFr7UIl09axRc+seeF0ZJuda3or/p16Dg118RTT6LQ33UVacvFBveoMjCKwkgm/D
         sZacTaKX/VV6Qalk/Ems8lWtgan6nPESTzFaazItN70M/KR9V3nJ+OajZwtpmfr6l+K3
         Q6paTYCTREq90SetuN/8vd0BjMeRMGUFdbjI6XDEYSDeRabw9WNHwsmZGzEUxNApxsOq
         mNndQ1RIj2xxuM5fo9nYBo2I2Dv0CNKf0/Slx1XSWFY2rJTUCSdclD8wwLaI1Jt84aSx
         nilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=TKlv+jBLEX2bX4iPbS9Y//qP2ivv4FVx+Z7saNMZvi8=;
        b=yXNQV+yAqTgoAnALNQSg6+BDejKxI71Y1L03uhVPGhsYx32uUE7sNlKnOIneZ7gefb
         dA8OtxEQ70eC8d2wg5s38UNnZ4KhDlrc2S0u1WRVrcSuowpu/BzNes2G7ygRzkqFYTu4
         AKqc405ZNUSsLmN3j1rHfBEnFf5wxoOFZ2reM4u77sshFBovZL2zQVEKpWCzAKCizY6n
         9qSBASMqg7yaS0eqdUuE5gwbV47LTVal0EMGc2qq1F5zxx3Ag0UzAntvpf+aHxF+hbl8
         0PoxAo2m4Ww6NW+GWdZ22VElCKjiTbiENbsIilQds5YQLFcAYWh1mBZP4Wz0vXSgd5sF
         7Ahw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bPbpgDkG;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bPbpgDkG;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48/vpJow6oY1wFaJQ47/a46lBeMHI+KgGt5DZHtKjr0ugf1P724QLlwrtjUz/HbjuyG76OuGQ==
Date: Tue, 17 Apr 2018 20:50:59 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
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
Subject: Re: [RFC PATCH v2 0/6] Energy Aware Scheduling
Message-ID: <20180417125059.GA18509@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011674695258054?=
X-GMAIL-MSGID: =?utf-8?q?1597997822562794666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dietmar,

On Fri, Apr 06, 2018 at 04:36:01PM +0100, Dietmar Eggemann wrote:
> 1. Overview
> 
> The Energy Aware Scheduler (EAS) based on Morten Rasmussen's posting on
> LKML [1] is currently part of the AOSP Common Kernel and runs on
> today's smartphones with Arm's big.LITTLE CPUs.
> Based on the experience gained over the last two and a half years in
> product development, we propose an energy model based task placement
> for CPUs with asymmetric core capacities (e.g. Arm big.LITTLE or
> DynamIQ), to align with the EAS adopted by the AOSP Common Kernel. We
> have developed a simplified energy model, based on the physical
> active power/performance curve of each core type using existing
> SoC power/performance data already known to the kernel. The energy
> model is used to select the most energy-efficient CPU to place each
> task, taking utilization into account.
> 
> 1.1 Energy Model
> 
> A CPU with asymmetric core capacities features cores with significantly
> different energy and performance characteristics. As the configurations
> can vary greatly from one SoC to another, designing an energy-efficient
> scheduling heuristic that performs well on a broad spectrum of platforms
> appears to be particularly hard.
> This proposal attempts to solve this issue by providing the scheduler
> with an energy model of the platform which enables energy impact
> estimation of scheduling decisions in a generic way. The energy model is
> kept very simple as it represents only the active power of CPUs at all
> available P-states and relies on existing data in the kernel (only used
> by the thermal subsystem so far).
> This proposal does not include the power consumption of C-states and
> cluster-level resources which were originally introduced in [1] since
> firstly, their impact on task placement decisions appears to be
> neglectable on modern asymmetric platforms and secondly, they require
> additional infrastructure and data (e.g new DT entries).

Seems to me, if we move forward a bit for the energy model, we can use
more simple method by generate power consumption:

  Power(@Freq) = Power(cpu_util=100%@Freq) - Power(cpu_util=%0@Freq)

>From upper formula, the power data includes CPU and cluster level
power (and includes dynamic power and static leakage) but this is
quite straightforward for measurement.

I read a bit for Quentin's slides for simplized power modeling
experiments [1], IIUC the simplized power modeling still bases on the
distinguished CPU and cluster c-state and p-state power data, and just
select CPU p-state power data for scheduler.  I wander if we can
simplize the power measurement, so the power data can be generated in
single one testing and the power data without any post processing.

This might need more detailed experiment to support this idea, just
want to know how about you guys think for this?

This is a side topic for this patch series, so whatever the conclusion
for it, I think this will not impact anything of this patch series
implementation and upstreaming.

[1] http://connect.linaro.org/resource/hkg18/hkg18-501/

[...]

> 2.1.1 Hikey960
> 
> Energy is measured with an ACME Cape on an instrumented board. Numbers
> include consumption of big and little CPUs, LPDDR memory, GPU and most
> of the other small components on the board. They do not include
> consumption of the radio chip (turned-off anyway) and external
> connectors.

So the measurement point on Hikey960 is for SoC but not for whole board,
right?

> +----------+-----------------+-------------------------+
> |          | Without patches | With patches            |
> +----------+--------+--------+------------------+------+ 
> | Tasks nb |  Mean  | RSD*   | Mean             | RSD* |
> +----------+--------+--------+------------------+------+
> |       10 |  41.14 |  1.4%  |  36.51 (-11.25%) | 1.6% |
> |       20 |  55.95 |  0.8%  |  50.14 (-10.38%) | 1.9% |
> |       30 |  74.37 |  0.2%  |  72.89 ( -1.99%) | 5.3% |
> |       40 |  94.12 |  0.7%  |  87.78 ( -6.74%) | 4.5% |
> |       50 | 117.88 |  0.2%  | 111.66 ( -5.28%) | 0.9% |
> +----------+--------+-------+-----------------+--------+


> 
> 2.1.2 Juno r0
> 
> Energy is measured with the onboard energy meter. Numbers include
> consumption of big and little CPUs.
> 
> +----------+-----------------+-------------------------+
> |          | Without patches | With patches            |
> +----------+--------+--------+------------------+------+
> | Tasks nb | Mean   | RSD*   | Mean             | RSD* |
> +----------+--------+--------+------------------+------+
> |       10 |  11.25 |  3.1%  |   7.07 (-37.16%) | 2.1% |
> |       20 |  19.18 |  1.1%  |  12.75 (-33.52%) | 2.2% |
> |       30 |  28.81 |  1.9%  |  21.29 (-26.10%) | 1.5% |
> |       40 |  36.83 |  1.2%  |  30.72 (-16.59%) | 0.6% |
> |       50 |  46.41 |  0.6%  |  46.02 ( -0.01%) | 0.5% |
> +----------+--------+--------+------------------+------+
> 
> 2.2 Performance test case
> 
> 30 iterations of perf bench sched messaging --pipe --thread --group G
> --loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

What's the reason to select different loop number for Hikey960 and
Juno? Based on the testing time?

[...]

Thanks,
Leo Yan
