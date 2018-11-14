Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9392422360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QteU10a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9392422360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeKOEYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:24:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39733 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeKOEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:24:12 -0500
Received: by mail-yw1-f65.google.com with SMTP id v8-v6so7645416ywh.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2PnyNLjCtP8GYGiWbHVDe8+I7l3wBcDkkkJY3JU8SU=;
        b=QteU10a5PlEeNn8Fw9jnu42Z/Vcwb1DWpC/HRS+4qnH7b0T64PLVjtvQs5DII8eEA3
         SKGBZ1Nxws8YeOfKjhqMZGS0j2PsxE55U0u0GXqDWCQN6PmPUi9Uq/9qMKavgvO9itve
         8vKbuMh6vonYkMar8wR82PLmqGiIn+XGcIqEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2PnyNLjCtP8GYGiWbHVDe8+I7l3wBcDkkkJY3JU8SU=;
        b=VBuh/HCgxWoWgl7ClxLhnDMbQflkpR0rHcfKGL+Vic+M7ah0cwxn3lTNHKzxBcD0xO
         KNymQM29u5Sd+NN4OB5h5LPfpwLJRC2xqvq2y1ta3Zs0Uj5vPdRLkl0owreo5mn06A4E
         MT+UCX91k8ZNQ2kWETt7jkgS0ovdu3UDx/HQOj5tD7xWwf9xbax7VeGzsu29U9hS4r5U
         Dnmof5Gyyu6wJn5VU/TKJI6wZfONrqK61tJWqxhyU64kFmhz7WN2lS2A6AJR+fSybC2O
         u0KZ8u7x5IqxCHt5+p2WDOUHPJ6gB3nOGmqfJiG+4l19z1ws3H+zRamWP9H/cAEG4QP0
         f2rA==
X-Gm-Message-State: AGRZ1gK2hjUtItRXIYdkwIioq28bQ84C8xnWfbUe5A7SRYE3D0c+bQ63
        NUmPC/IyUu+9QxEn+aNcEegEKamIDm5AM2h6cLEObQ==
X-Google-Smtp-Source: AJdET5c565blxZao2Z4fyekpMXD5//JswfWCMRotzSpnQwxGQWAjI7eMNjLF2naabpslgZIoOWw2ERiszw5J75s1Pu8=
X-Received: by 2002:a81:2a57:: with SMTP id q84-v6mr2670636ywq.297.1542219595368;
 Wed, 14 Nov 2018 10:19:55 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain>
In-Reply-To: <20181114180807.6crs7awhvo26ldbr@hawk.localdomain>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 14 Nov 2018 19:19:44 +0100
Message-ID: <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     drjones@redhat.com
Cc:     ahmedsoliman@mena.vt.edu, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        vkuznets@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 at 19:08, Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Nov 14, 2018 at 05:30:28PM +0200, Ahmed Soliman wrote:
> > Hello,
> >
> > KVM Self tests located at tools/testing/selftests/kvm seams to be failing.
> > I have tried:
> >  - dirty_log_test
> >  - x86_64/cr4_cpuid_sync_test
> >  - x86_64/evmcs_test
> >  - x86_64/platform_info_test
> >  - x86_64/set_sregs_test
> >  - x86_64/state_test
> >  - x86_64/sync_regs_test
> >  - x86_64/vmx_tsc_adjust_test
> >
> > All of them triggered the following assert:
> >
> >         ==== Test Assertion Failure ====
> >         lib/kvm_util.c:596: ret == 0
> >         pid=24507 tid=24507 - Invalid argument
> >             1  0x000056360774e468: ?? ??:0
> >             2  0x000056360774e609: ?? ??:0
> >             3  0x00005636077537a0: ?? ??:0
> >             4  0x000056360774d35e: ?? ??:0
> >             5  0x00007f3117571ae6: ?? ??:0
> >             6  0x000056360774d4a9: ?? ??:0
> >         madvise failed,
> >         addr: 0x7f3117350000
> >         length: 0x200000
> >         src_type: 0
> >
> > I have tried the tests on both kvm(next) branch
> > commit 22a7cdcae6a4a3c89748 as well as
> > torvald's master  4.20-rc2.
>
> Hi Ahmed,

Hi Drew, Ahmed,

>
> I couldn't reproduce this on a Westmere. Are you sure you're testing
> a clean compilation? Can you bisect the kernel?

What would be the difference in CONFIG_* fragments that you both have enabled?


Cheers,
Anders
