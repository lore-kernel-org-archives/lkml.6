Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF04C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709FC204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709FC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeI1WJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:09:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:24134 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbeI1WJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:09:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 08:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="92947929"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2018 08:45:17 -0700
Received: from [10.252.16.219] (abudanko-mobl.ccr.corp.intel.com [10.252.16.219])
        by linux.intel.com (Postfix) with ESMTP id 7335A5801CD;
        Fri, 28 Sep 2018 08:45:13 -0700 (PDT)
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
 <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0feb9867-0040-0306-a95b-4b6df1818312@linux.intel.com>
Date:   Fri, 28 Sep 2018 18:45:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28.09.2018 17:02, Thomas Gleixner wrote:
> Tvrtko,
> 
> On Fri, 28 Sep 2018, Tvrtko Ursulin wrote:
>> On 28/09/2018 11:26, Thomas Gleixner wrote:
>>> On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
>>>
>>> It would be very helpful if you cc all involved people on the cover letter
>>> instead of just cc'ing your own pile of email addresses. CC'ed now.
>>
>> I accept it was by bad to miss adding Cc's on the cover letter, but my own
>> email addresses hopefully should not bother you. It is simply a question of
>> what I have in .gitconfig vs what I forgot to do manually.
> 
> The keyword in the above sentence is 'just'. You can add as many of yours
> as you want as long as everybody else is cc'ed.
> 
>>> I read through the previous thread and there was a clear request to involve
>>> security people into this. Especially those who are deeply involved with
>>> hardware side channels. I don't see anyone Cc'ed on the whole series.
>>
>> Who would you recommend I add? Because I really don't know..
> 
> Sure, and because you don't know you didn't bother to ask around and
> ignored the review request.
> 
> I already added Kees and Jann. Please look for the SECCOMP folks in
> MAINTAINERS.

Thomas, thanks a lot for involving the folks!

> 
>>> For the record, I'm not buying the handwavy 'more noise' argument at
>>> all. It wants a proper analysis and we need to come up with criteria which
>>> PMUs can be exposed at all.
>>>
>>> All of this want's a proper documentation clearly explaining the risks and
>>> scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
>>> then saying 'its their problem to figure it out' is not acceptable.
>>
>> Presumably you see adding fine grained control as diminishing the overall
>> security rather than raising it? Could you explain why? Because incompetent
>> sysadmin will turn it off for some PMU, while without having the fine-grained
>> control they wouldn't turn it off globally?
> 
> I did not say at all that this might be diminishing security. And the
> argumentation with 'incompetent sysadmins' is just the wrong attitude.
> 
> What I was asking for is proper documentation and this proper documentation
> is meant for _competent_ sysadmins.
> 
> That documentation has to clearly describe what kind of information is
> accessible and what potential side effects security wise this might
> have. You cannot expect that even competent sysadmins know offhand what
> which PMU might expose. And telling them 'Use Google' is just not the right
> thing to do.
> 
> If you can't explain and document it, then providing the knob is just
> fulfilling somebodys 'I want a pony' request.> 
>> This feature was requested by the exact opposite concern, that in order to
>> access the i915 PMU, one has to compromise the security of the entire system
>> by allowing access to *all* PMU's.
>>
>> Making this ability fine-grained sounds like a logical solution for solving
>> this weakening of security controls.
> 
> Sure, and this wants to be documented in the cover letter and the
> changelogs.
> 
> But this does also require a proper analysis and documentation why it is
> not a security risk to expose the i915 PMU or what potential security
> issues this can create, so that the competent sysadmin can make a
> judgement.
> 
> And the same is required for all other PMUs which can be enabled in the
> same way for unprivileged access. And we might as well come to the
> conclusion via analysis that for some PMUs unpriviledged access is just not
> a good idea and exclude them. I surely know a few which qualify for
> exclusion, so the right approach is to provide this knob only when the risk
> is analyzed and documented and the PMU has been flagged as candidate for
> unpriviledged exposure. I.e. opt in and not opt out.

If you ask me then, IMHO, unprivileged access to CBOX pmu looks unsafe 
and is now governed by traditional *core* perf_event_paranoid setting.

But *core* paranoid >= 1 (per-process mode) prevents simultaneous perf 
record sampling and perf stat -I reading from IMC, UPI, PCIe and other 
uncore counters.

This kind of monitoring could make process performance observability 
thru Perf subsystem more flexible and better tailored for cloud and 
cluster environments. However it requires fine-tuning control 
capabilities in order to still keep system as secure as possible.

Could i915, IMC, UPI, PCIe pmus be safe enough to be governed by 
a separate perf_event_paranoid settings?

Thanks!
Alexey

> 
> Thanks,
> 
> 	tglx
> 
