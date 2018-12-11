Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE4C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EFA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EFA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeLKUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:51:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:52621 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:51:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 12:51:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="97977143"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.157]) ([10.24.14.157])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 12:51:12 -0800
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
 <20181211123404.GC27375@zn.tnic>
 <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
 <20181211185059.GP27375@zn.tnic>
 <e4ef2e81-defd-c5ca-4892-a0361a4528ba@intel.com>
 <20181211204310.GQ27375@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <10fef6af-785e-c76f-d89b-ec115dcf460a@intel.com>
Date:   Tue, 11 Dec 2018 12:51:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181211204310.GQ27375@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/11/2018 12:43 PM, Borislav Petkov wrote:
> On Tue, Dec 11, 2018 at 11:02:08AM -0800, Reinette Chatre wrote:
>> I just wanted to emphasize that it is not the schemata writing that
>> needs to be protected, but instead the pseudo-locking code that runs
>> after schemata programming that needs to run on a particular CPU. The
>> new patch subject could be interpreted to mean the former ... but that
>> is starting to sound like nitpicking by me.
> 
> Nah, that's not nitpicking - it is important that we sort out stuff
> fully before committing.

I really appreciate your patience.

> 
> Now, I'm trying to understand what you're telling me and I believe you
> mean what update_domains() does, yes?

Yes.

> 
> And I guess a more fitting subject in that case could be:
> 
>   x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence
> 
> or so, and then the commit message explains in more detail what that
> title actually means. :)
> 
> Hmmm.

That subject line matches exactly the goal of this patch. Thank you very
much. Would you prefer that I send a new version with this subject line
or would you rather make the change yourself while applying this patch?

Reinette


