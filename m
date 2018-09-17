Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF35ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA02146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="m428lJVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFA02146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIRDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:12:03 -0400
Received: from mx1.riseup.net ([198.252.153.129]:45141 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRDMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:12:03 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id B58741A04A0;
        Mon, 17 Sep 2018 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1537220572; bh=FvTuj44QpliE3LH5GQcy4ie1qiSA6octuwiPOeBOASU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m428lJVyPGV/l+7dCD9VXL9HF/UchmImyybxqorwC/cCYOefF1CeGtwpd67SICSFb
         KSNkdKjk5PnQACpxCuBaVLEADGWOGuz4+nHlBcHsxRo0KFMUJ8/agaLfTWPUXfeaNv
         9F9bQvXSLlV6medQLl53/r4M3QPkwWufzCN3hnZ4=
X-Riseup-User-ID: 4A9E97FB5342850DFD105BB98AADE5C1C14598003111489B755CD6677512A6AE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id 1E7554E200;
        Mon, 17 Sep 2018 14:42:50 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        eero.t.tamminen@intel.com, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
In-Reply-To: <CAJZ5v0j5TWT-6+PcbQ3ohbfA4rNkJ83PO-YxRG9hK1q61=C4EA@mail.gmail.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <23293649.J1qzPCXian@aspire.rjw.lan> <87in3c7x9o.fsf@riseup.net> <2646540.WJ9HbOajLd@aspire.rjw.lan> <87pnxf6zhe.fsf@riseup.net> <CAJZ5v0j5TWT-6+PcbQ3ohbfA4rNkJ83PO-YxRG9hK1q61=C4EA@mail.gmail.com>
Date:   Mon, 17 Sep 2018 14:23:34 -0700
Message-ID: <87lg7z7r8p.fsf@riseup.net>
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

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Sat, Sep 15, 2018 at 8:53 AM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>
>> > On Tuesday, September 11, 2018 7:35:15 PM CEST Francisco Jerez wrote:
>> >>
>> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >>
>> >> > On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
>> >> >
>> >> >> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>> >> >>=20
>> >> >> > [...]
>> >> >> >
>> >> >> >> > >=3D20
>> >> >> >> > > This patch causes a number of statistically significant
>> >> >> >> > > regressions
>> >> >> >> > > (with significance of 1%) on the two systems I've tested it
>> >> >> >> > > on.  On
>> >> >> >> > > my
>> >> >> >> >=3D20
>> >> >> >> > Sure. These patches are targeted to Atom clients where some of
>> >> >> >> > these
>> >> >> >> > server like workload may have some minor regression on few watts
>> >> >> >> > TDP
>> >> >> >> > parts.
>> >> >> >>=3D20
>> >> >> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
>> >> >> >> nor
>> >> >> >> the 10% regression of warsaw qualify as small.  And most of the test
>> >> >> >> cases on the list of regressions aren't exclusively server-like, if
>> >> >> >> at
>> >> >> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
>> >> >> >> benchmarks -- Latency is as important if not more for interactive
>> >> >> >> workloads than it is for server workloads.  In the case of a conflict
>> >> >> >> like the one we're dealing with right now between optimizing for
>> >> >> >> throughput (e.g. for the maximum number of requests per second) and
>> >> >> >> optimizing for latency (e.g. for the minimum request duration), you
>> >> >> >> are
>> >> >> >> more likely to be concerned about the former than about the latter in
>> >> >> >> a
>> >> >> >> server setup.
>> >> >> >
>> >> >> > Eero,
>> >> >> > Please add your test results here.
>> >> >> >
>> >> >> > No matter which algorithm you do, there will be variations. So you have
>> >> >> > to look at the platforms which you are targeting. For this platform=3D=
>> >> 20
>> >> >> > number one item is use of less turbo and hope you know why?
>> >> >>=20
>> >> >> Unfortunately the current controller uses turbo frequently on Atoms for
>> >> >> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
>> >> >> boosting simply exacerbated the pre-existing energy efficiency problem.
>> >> >
>> >> > My current understanding of the issue at hand is that using IOWAIT boosti=
>> >> ng
>> >> > on Atoms is a regression relative to the previous behavior.
>> >>
>> >> Not universally.  IOWAIT boosting helps under roughly the same
>> >> conditions on Atom as it does on big core, so applying this patch will
>> >> necessarily cause regressions too (see my reply from Sep. 3 for some
>> >> numbers), and won't completely restore the previous behavior since it
>> >> simply decreases the degree of IOWAIT boosting applied without being
>> >> able to avoid it (c.f. the series I'm working on that does something
>> >> similar to IOWAIT boosting when it's able to determine it's actually
>> >> CPU-bound, which prevents energy inefficient behavior for non-CPU-bound
>> >> workloads that don't benefit from a higher CPU clock frequency anyway).
>> >
>> > Well, OK.  That doesn't seem to be a clear-cut regression situation, then,
>> > since getting back is not desirable, apparently.
>> >
>> > Or would it restore the previous behavior if we didn't do any IOWAIT
>> > boosting on Atoms at all?
>> >
>> >> > That is what Srinivas is trying to address here AFAICS.
>> >> >
>> >> > Now, you seem to be saying that the overall behavior is suboptimal and the
>> >> > IOWAIT boosting doesn't matter that much,
>> >>
>> >> I was just saying that IOWAIT boosting is less than half of the energy
>> >> efficiency problem, and this patch only partially addresses that half of
>> >> the problem.
>> >
>> > Well, fair enough, but there are two things to consider here, the general
>> > energy-efficiency problem and the difference made by IOWAIT boosting.
>> >
>> > If the general energy-efficiency problem had existed for a relatively long
>> > time, but it has got worse recently due to the IOWAIT boosting, it still
>> > may be desirable to get the IOWAIT boosting out of the picture first
>> > and then get to the general problem.
>> >
>>
>> IMHO what is needed in order to address the IOWAIT boosting energy
>> efficiency problem is roughly the same we need in order to address the
>> other energy efficiency problem: A mechanism along the lines of [1]
>> allowing us to determine whether the workload is IO-bound or not.  In
>> the former case IOWAIT boosting won't be able to improve the performance
>> of the workload since the limiting factor is the IO throughput, so it
>> will only increase the energy usage, potentially exacerbating the
>> bottleneck if the IO device is an integrated GPU.  In the latter case
>> where the CPU and IO devices being waited on are both underutilized it
>> makes sense to optimize for low latency more aggressively (certainly
>> more aggressively than this patch does) which will increase the
>> utilization of the IO devices until at least one IO device becomes a
>> bottleneck, at which point the throughput of the system becomes roughly
>> independent of the CPU frequency and we're back to the former case.
>>
>> [1] https://patchwork.kernel.org/patch/10312259/
>
> I remember your argumentation above from the previous posts and I'm
> not questioning it.  I don't see much point in repeating arguments
> that have been given already.
>
> My question was whether or not there was a regression related
> specifically to adding the IOWAIT boosting mechanism that needed to be
> addressed separately.  I gather from the discussion so far that this
> is not the case.
>

There possibly was some slight graphics performance regression when i915
started doing IO waits, but i915 didn't have support for any BXT+
devices back then, which are the ones most severely hurt by it, so it
probably didn't cause a significant drop in most available benchmark
numbers and went unnoticed.

Regardless of whether there was a regression, I don't see the need of
fixing the IOWAIT issue separately from the other energy efficiency
issues of the active mode governor, because they both admit a common
solution...

> Thanks,
> Rafael

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW6AbVwAKCRCDmTidfVK/
Wx0QAP9aC5nZh2ERxmLQSu2/IcJ3jscAwU47UStUkr7ExEeFKAEAktkWngC5xmBP
m5QoZShVKOp6FoEBHC5Npghxm77g5Co=
=FLqz
-----END PGP SIGNATURE-----
--==-=-=--
