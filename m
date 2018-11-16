Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ADC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998582087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998582087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbeKPXtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:49:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbeKPXtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:49:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18793723D9;
        Fri, 16 Nov 2018 13:37:00 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A17AA5C6A5;
        Fri, 16 Nov 2018 13:36:55 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>
Subject: Re: KVM selftests are failing
In-Reply-To: <CANBxJ=FDOpySC7w1fVbWCOy+ASO=A7WcsFiDJEcGtzWbYM6NqQ@mail.gmail.com>
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com> <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com> <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com> <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com> <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com> <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com> <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com> <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com> <87efbmqore.fsf@vitty.brq.redhat.com> <CANBxJ=FDOpySC7w1fVbWCOy+ASO=A7WcsFiDJEcGtzWbYM6NqQ@mail.gmail.com>
Date:   Fri, 16 Nov 2018 14:36:54 +0100
Message-ID: <8736s1qh3d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 16 Nov 2018 13:37:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Soliman <ahmedsoliman@mena.vt.edu> writes:

> Hello once again,
>
> I noticed that there is still more problems with kvmself test (at
> least on my machine)
>
> Any test that would successfully reach the guest's code immediately
> VMexit by a shutdown.
>
> $ ./vmx_tsc_adjust_test
> ==== Test Assertion Failure ====
>  x86_64/vmx_tsc_adjust_test.c:156: run->exit_reason == KVM_EXIT_IO
>  pid=8499 tid=8499 - Success
>     1  0x00005604f07bd36c: ?? ??:0
>     2  0x00007f5c0dc53ae6: ?? ??:0
>     3  0x00005604f07bd4b9: ?? ??:0
>  Got exit_reason other than KVM_EXIT_IO: 8 (SHUTDOWN)
>

Hm, this is weird. Do other KVM users, e.g. qemu work on this host? Are
you sure this happens on the first VCPU_RUN invocation?

Could you try doing 

trace-cmd record -e kvm  ./x86_64/vmx_tsc_adjust_test && trace-cmd report 

to see if there's anything suspicious?

-- 
Vitaly
