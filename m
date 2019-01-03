Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5E2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8kD1cHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfACP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:26:08 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38136 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfACP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:26:08 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so43045103ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiDM7JY1fCEcSXF3UuKvhmYtvGr6agvR/KhJ8MooMgo=;
        b=Z8kD1cHh2FGHS+QcgxgLxe2KlJD/s3p4Zm0FdhZhpWlUaUu7880FcV/SrVDe/ULPpl
         U4DCa13hgswEFdFyyKNGuNDdyel//H0ZzEnKWUS7nz8Aq+ZeuLjJY9X9TJ5oXXpTIb6O
         wLjx/5lzAL6vLWT2o44poDmwY14nPbDI+i2gBUkyx1Vc96IyHM8HhgFhg0qtuto37LTj
         th4T+mHCBIHBbd50yRb41GpFlDpUtzqlmo9XvEzLjt2OCtDQ4Gg5wyMb76z5WaIfpu2V
         QFsnSwtq85e0M7RA8iFz7k+oqob8Cg1TsSvaLKW5XJNbwcIZ3LJSi3+IokcjSF9jYY9R
         mpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiDM7JY1fCEcSXF3UuKvhmYtvGr6agvR/KhJ8MooMgo=;
        b=rizNmb5vbCqHar7UETR9k0DBfIhi4bEL7N+xTHZOQ3AR7pJrQzaIYGbEM/S/mOJhHa
         +oLUBNjAFN8Yv2UkYwImeAViTDZrffXL3gtKLgbutuTFqzFplIqeFFzGRDFxG8INcmHj
         3VT1czElIRLllH0VWNIPXSledb02lW7GBpfHP5kqnbLQYY8gaXPqtXLxXrF/lPSTtnKU
         jC53MP5b+7YYgFrmVQGJZCXULHUmJMB//UlI8+wruWIMy122Z6OwazUMgJ6mhVQQ/XSA
         LYomtjHohbUTG1EKvyiw2nsN8K1cTVQJXYZ/Rcv/zYnLBgiRAGDZO+GG0DvB1KP0HkGk
         GYew==
X-Gm-Message-State: AA+aEWYhkA6Tfh8Pzgvbn9e3RmAEOUp0Dhb78OHvb08MOP8paIS6bE69
        MfQFw6ax9urxpZBtfkW5NBKdQ5mqV4SOqwltKK8vePOb
X-Google-Smtp-Source: AFSGD/XQ+5bl3OhGxgCPf0PRyO46p2cvlDdNYc80yNd0m8ZVrbG8/jyBMcBcVl358HWF5vy+GUD+nIZaZaAV97OSqc4=
X-Received: by 2002:a02:7b09:: with SMTP id q9mr32264558jac.39.1546529167280;
 Thu, 03 Jan 2019 07:26:07 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com>
In-Reply-To: <5C2DC132.9050103@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Jan 2019 07:25:55 -0800
Message-ID: <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 11:55 PM Wei Wang <wei.w.wang@intel.com> wrote:

> Right, thanks. Probably better to change it to below:
>
> msr_info->data = 0;
> data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
> if (vcpu->kvm->arch.lbr_in_guest)
>      msr_info->data |= (data & X86_PERF_CAP_MASK_LBR_FMT);
>

This still breaks backwards compatibility. Returning 0 and raising #GP
are not the same.
