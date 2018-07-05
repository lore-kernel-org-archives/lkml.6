Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672BEC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ADA2417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ADA2417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGEGDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:03:07 -0400
Received: from ozlabs.org ([203.11.71.1]:46027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbeGEGDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:03:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LnMm2jJCz9s2R;
        Thu,  5 Jul 2018 16:03:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-mm@kvack.org, linuxram@us.ibm.com, shakeelb@google.com,
        shuah@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 234/279] x86/pkeys/selftests: Adjust the self-test to fresh distros that export the pkeys ABI
In-Reply-To: <20180703114241.GA19730@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org> <20180618080618.495174114@linuxfoundation.org> <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz> <20180703114241.GA19730@kroah.com>
Date:   Thu, 05 Jul 2018 16:03:00 +1000
Message-ID: <877emakynf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jul 03, 2018 at 01:36:43PM +0200, Vlastimil Babka wrote:
>> On 06/18/2018 10:13 AM, Greg Kroah-Hartman wrote:
>> > 4.16-stable review patch.  If anyone has any objections, please let me know.
>> 
>> So I was wondering, why backport such a considerable number of
>> *selftests* to stable, given the stable policy? Surely selftests don't
>> affect the kernel itself breaking for users?
>
> These came in as part of Sasha's "backport fixes" tool.  It can't hurt
> to add selftest fixes/updates to stable kernels, as for some people,
> they only run the selftests for the specific kernel they are building.
> While others run selftests for the latest kernel on older kernels, both
> of which are valid ways of testing.

I don't have a problem with these sort of patches being backported, but
it seems like Documentation/process/stable-kernel-rules.txt could use an
update?

I honestly don't know what the rules are anymore.

cheers
