Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A404C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2292243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2292243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeKOEM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKOEM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:12:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26D0B83F3E;
        Wed, 14 Nov 2018 18:08:15 +0000 (UTC)
Received: from hawk.localdomain (unknown [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 736A860BF6;
        Wed, 14 Nov 2018 18:08:10 +0000 (UTC)
Date:   Wed, 14 Nov 2018 19:08:07 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: KVM selftests are failing
Message-ID: <20181114180807.6crs7awhvo26ldbr@hawk.localdomain>
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 14 Nov 2018 18:08:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:30:28PM +0200, Ahmed Soliman wrote:
> Hello,
> 
> KVM Self tests located at tools/testing/selftests/kvm seams to be failing.
> I have tried:
>  - dirty_log_test
>  - x86_64/cr4_cpuid_sync_test
>  - x86_64/evmcs_test
>  - x86_64/platform_info_test
>  - x86_64/set_sregs_test
>  - x86_64/state_test
>  - x86_64/sync_regs_test
>  - x86_64/vmx_tsc_adjust_test
> 
> All of them triggered the following assert:
> 
>         ==== Test Assertion Failure ====
>         lib/kvm_util.c:596: ret == 0
>         pid=24507 tid=24507 - Invalid argument
>             1  0x000056360774e468: ?? ??:0
>             2  0x000056360774e609: ?? ??:0
>             3  0x00005636077537a0: ?? ??:0
>             4  0x000056360774d35e: ?? ??:0
>             5  0x00007f3117571ae6: ?? ??:0
>             6  0x000056360774d4a9: ?? ??:0
>         madvise failed,
>         addr: 0x7f3117350000
>         length: 0x200000
>         src_type: 0
> 
> I have tried the tests on both kvm(next) branch
> commit 22a7cdcae6a4a3c89748 as well as
> torvald's master  4.20-rc2.

Hi Ahmed,

I couldn't reproduce this on a Westmere. Are you sure you're testing
a clean compilation? Can you bisect the kernel?

Thanks,
drew
