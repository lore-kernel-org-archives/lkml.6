Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924ADC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAC3218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeLaRKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:10:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:32314 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeLaRKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:10:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 09:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,423,1539673200"; 
   d="scan'208";a="131938813"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.251.20.124]) ([10.251.20.124])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2018 09:10:32 -0800
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations
To:     Ben Greear <greearb@candelatech.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
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
 <1c7923ec-70aa-25d4-3de1-f1b1768bb80b@candelatech.com>
 <fdf4e1cd-9b28-75c7-6846-6d0f5b816936@linux.intel.com>
 <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <caf93e93-0112-9026-5277-f3b7b4a986c2@linux.intel.com>
Date:   Mon, 31 Dec 2018 09:10:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/2018 8:22 AM, Ben Greear wrote:
> 
> 
> On 12/21/2018 05:17 PM, Tim Chen wrote:
>> On 12/21/18 1:59 PM, Ben Greear wrote:
>>> On 12/21/18 9:44 AM, Tim Chen wrote:
>>>> Thomas,
>>>>
>>>> Andi and I have made an update to our draft of the Spectre admin guide.
>>>> We may be out on Christmas vacation for a while.  But we want to
>>>> send it out for everyone to take a look.
>>>
>>> Can you add a section on how to compile out all mitigations that have anything
>>> beyond negligible performance impact for those running systems where performance
>>> is more important than security?
>>>
>>
>> If you don't worry about security and performance is paramount, then
>> boot with "nospectre_v2".  That's explained in the document.
> 
> There seem to be lots of different variants of this type of problem.  It was not clear
> to me that just doing nospectre_v2 would be sufficient to get back full performance.
> 
> And anyway, I would like to compile the kernel to not need that command-line option,
> so I am still interesting in what compile options need to be set to what values...

the cloud people call this scenario "single tenant".. there might be different "users" in the uid
sense, but they're all owned by the same folks


it would not be insane to make a CONFIG_SINGLE_TENANT kind of option under which we can group thse kind of things
(and likely others)
