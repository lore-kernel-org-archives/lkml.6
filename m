Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E455C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0162921748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0162921748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeI1QuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:50:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbeI1QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:50:03 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5pz2-0005eY-Ti; Fri, 28 Sep 2018 12:26:53 +0200
Date:   Fri, 28 Sep 2018 12:26:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tvrtko Ursulin <tursulin@ursulin.net>
cc:     LKML <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko,

On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:

It would be very helpful if you cc all involved people on the cover letter
instead of just cc'ing your own pile of email addresses. CC'ed now.

> For situations where sysadmins might want to allow different level of
> access control for different PMUs, we start creating per-PMU
> perf_event_paranoid controls in sysfs.
> 
> These work in equivalent fashion as the existing perf_event_paranoid
> sysctl, which now becomes the parent control for each PMU.
> 
> On PMU registration the global/parent value will be inherited by each PMU,
> as it will be propagated to all registered PMUs when the sysctl is
> updated.
> 
> At any later point individual PMU access controls, located in
> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> fine grained access control.
> 
> Discussion from previous posting:
> https://lkml.org/lkml/2018/5/21/156

This is really not helpful. The cover letter and the change logs should
contain a summary of that discussion and a proper justification of the
proposed change. Just saying 'sysadmins might want to allow' is not useful
at all, it's yet another 'I want a pony' thing.

I read through the previous thread and there was a clear request to involve
security people into this. Especially those who are deeply involved with
hardware side channels. I don't see anyone Cc'ed on the whole series.

For the record, I'm not buying the handwavy 'more noise' argument at
all. It wants a proper analysis and we need to come up with criteria which
PMUs can be exposed at all.

All of this want's a proper documentation clearly explaining the risks and
scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
then saying 'its their problem to figure it out' is not acceptable.

Thanks,

	tglx

