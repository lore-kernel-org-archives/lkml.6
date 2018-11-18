Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B8A2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B8A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKSJ0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:26:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:1421 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeKSJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:26:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 15:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,250,1539673200"; 
   d="scan'208";a="105671857"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.249.73.243]) ([10.249.73.243])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2018 15:04:22 -0800
Subject: Re: Re: STIBP by default.. Revert?
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
 <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
 <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <51127fd4-5dcc-b2b9-4873-72098d2a77d9@linux.intel.com>
Date:   Mon, 19 Nov 2018 07:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 6:00 AM, Linus Torvalds wrote:
> On Sun, Nov 18, 2018 at 1:49 PM Jiri Kosina <jikos@kernel.org> wrote:
>>
>>> So why do that STIBP slow-down by default when the people who *really*
>>> care already disabled SMT?
>>
>> BTW for them, there is no impact at all.
> 
> Right. People who really care about security and are anal about it do
> not see *any* advantage of the patch.

In the documentation, AMD officially recommends against this by default, and I can
speak for Intel that our position is that as well: this really must not be on by default.

STIBP and its friends are there as tools, and were created early on as big hammers because
that is all that one can add in a microcode update.. expensive big hammers.

In some ways it's analogous to the "disable caches" bit in CR0. sure it's there as a big hammer,
but you don't set that always just because caches could be used for a side channel

Using these tools much more surgically is fine, if a paranoid task wants it for example,
or when you know you are doing a hard core security transition. But always on? Yikes.

