Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA99C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F642086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfANOjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:39:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:45789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfANOjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:39:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 06:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="118113579"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.251.20.134]) ([10.251.20.134])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2019 06:39:34 -0800
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations
To:     Jiri Kosina <jikos@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181228103437.4c03c181@lwn.net>
 <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com>
 <20190113231001.GB18710@amd>
 <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
 <20190114120157.GB21544@amd>
 <nycvar.YFH.7.76.1901141305220.6626@cbobk.fhfr.pm>
 <20190114130153.GC21544@amd>
 <nycvar.YFH.7.76.1901141403550.6626@cbobk.fhfr.pm>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <5907b2bc-8498-2f28-eb90-13627d492496@linux.intel.com>
Date:   Mon, 14 Jan 2019 06:39:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1901141403550.6626@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/2019 5:06 AM, Jiri Kosina wrote:
> On Mon, 14 Jan 2019, Pavel Machek wrote:
> 
>> Frankly I'd not call it Meltdown, as it works only on data in the cache,
>> so the defense is completely different. Seems more like a l1tf
>> :-).
> 
> Meltdown on x86 also seems to work only for data in L1D, but the pipeline
> could be constructed in a way that data are actually fetched into L1D
> before speculation gives up, which is not the case on ppc (speculation
> aborts on L2->L1 propagation IIRC). That's why flushing L1D on ppc is
> sufficient, but on x86 it's not.

assuming L1D is not shared between SMT threads obviously :)

> 

