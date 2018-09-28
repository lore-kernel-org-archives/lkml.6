Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFECC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5BF21580
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5BF21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeI1Tp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:45:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:25931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeI1Tp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:45:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 06:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="266762049"
Received: from tursulin-mobl.ger.corp.intel.com (HELO [10.252.0.58]) ([10.252.0.58])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2018 06:22:08 -0700
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tursulin@ursulin.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Message-ID: <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
Date:   Fri, 28 Sep 2018 14:22:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 28/09/2018 11:26, Thomas Gleixner wrote:
> Tvrtko,
> 
> On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
> 
> It would be very helpful if you cc all involved people on the cover letter
> instead of just cc'ing your own pile of email addresses. CC'ed now.

I accept it was by bad to miss adding Cc's on the cover letter, but my 
own email addresses hopefully should not bother you. It is simply a 
question of what I have in .gitconfig vs what I forgot to do manually.

>> For situations where sysadmins might want to allow different level of
>> access control for different PMUs, we start creating per-PMU
>> perf_event_paranoid controls in sysfs.
>>
>> These work in equivalent fashion as the existing perf_event_paranoid
>> sysctl, which now becomes the parent control for each PMU.
>>
>> On PMU registration the global/parent value will be inherited by each PMU,
>> as it will be propagated to all registered PMUs when the sysctl is
>> updated.
>>
>> At any later point individual PMU access controls, located in
>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>> fine grained access control.
>>
>> Discussion from previous posting:
>> https://lkml.org/lkml/2018/5/21/156
> 
> This is really not helpful. The cover letter and the change logs should
> contain a summary of that discussion and a proper justification of the
> proposed change. Just saying 'sysadmins might want to allow' is not useful
> at all, it's yet another 'I want a pony' thing.

Okay, for the next round I will expand the cover letter with at least 
one concrete example on how it is usable and summarize the discussion a bit.

> I read through the previous thread and there was a clear request to involve
> security people into this. Especially those who are deeply involved with
> hardware side channels. I don't see anyone Cc'ed on the whole series.

Who would you recommend I add? Because I really don't know..

> For the record, I'm not buying the handwavy 'more noise' argument at
> all. It wants a proper analysis and we need to come up with criteria which
> PMUs can be exposed at all.
> 
> All of this want's a proper documentation clearly explaining the risks and
> scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
> then saying 'its their problem to figure it out' is not acceptable.

Presumably you see adding fine grained control as diminishing the 
overall security rather than raising it? Could you explain why? Because 
incompetent sysadmin will turn it off for some PMU, while without having 
the fine-grained control they wouldn't turn it off globally?

This feature was requested by the exact opposite concern, that in order 
to access the i915 PMU, one has to compromise the security of the entire 
system by allowing access to *all* PMU's.

Making this ability fine-grained sounds like a logical solution for 
solving this weakening of security controls.

Concrete example was that on video transcoding farms users want to 
monitor the utilization of GPU engines (like CPU cores) and they can do 
that via the i915 PMU. But for that to work today they have to dial down 
the global perf_event_paranoid setting. Obvious improvement was to allow 
them to only dial down the i915.perf_event_paranoid setting. As such, 
for this specific use case at least, the security is increased.

Regards,

Tvrtko
