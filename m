Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89608C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA32080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBMPfxa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfABX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:27:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38731 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfABX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:27:09 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so40691882ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 15:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxlb00yXd4iinTkVLhy1QF9aoqxxUYJBNn8i+UuGVXM=;
        b=vBMPfxa8lp64v4EVumWD8KiZugAg7LLOgO8c9mBLn/Xam0gGJ0BwNR2V0w8GlmDTlx
         WUOrAFGkDlIJ1B5ygQrETaySozK7ggOZzYG1nvy9D0sJ8kROC7fvvidyUXA3hw7UVu7L
         RG2KACDgRS9TRTOegbWD4rwKNCyYjDnmYQI/Iy3Z2qSsmWJaAcwLfj2m5epKcqbont7F
         EB/AyeSxT+PZxV3LYr0NWyi011ySgs2OlK4FpKotVNkG3Sr1hnZ2PMv6F6XQfqCsI7Yc
         HGS7zYxUrHgD7EPjFACHJXL996WQ50/rHKCjpHYbQx34s7ftkHPd/lm4lbYgjTOK1+Fq
         xdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxlb00yXd4iinTkVLhy1QF9aoqxxUYJBNn8i+UuGVXM=;
        b=rmZrv6o3BQzKTXzKgxwsDqHN1gKbuprTEFW3HiY/k3PKmQvZmuFLe8KTog6nkXOhO2
         CEgJecmKt7o+Zv/RyLtJsbErvHGF16k2YChHbHhjWb3UlptTKJE2H1BehBAEAeeEczg/
         xGRTTj5eDPhUDaHzk/ouqddI5P4UGU6TmULWi56G9Xih6t0mWbOHIxWOIYTut4qZW8wv
         V9uwU2VmyT3BIfkLLhmjAnTWQ2ScgOjo5w3HcmuBTfmMOXamDOwrp2WxgIIcRqRFuHMC
         KDxiAmU3fIj9a5e3zTd26vIwDyUuv6lsyYnXOEAf3IkChvcxWUjeQ7RYhD6v3gO9vlU3
         4QqQ==
X-Gm-Message-State: AA+aEWaGKv6obchFGK8eqtXs9hWBNRWMLY2FJC4yE4tspx49acXhNDHH
        yn78OyyVNNNWmBv6LSExSDr9ovMGbHnPyxoMKCfynbmREpM=
X-Google-Smtp-Source: AFSGD/VZ1Dm0Hgjw1mbehr5Q0AQN7/wuBkgV3zXfsf+MOWyzTQXRlaiuA4sKZhNcK3aMspSbsW3ofb+bZRacTEQHfMk=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr28726948itb.77.1546471628031;
 Wed, 02 Jan 2019 15:27:08 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Jan 2019 15:26:56 -0800
Message-ID: <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
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

On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> The lbr stack is architecturally specific, for example, SKX has 32 lbr
> stack entries while HSW has 16 entries, so a HSW guest running on a SKX
> machine may not get accurate perf results. Currently, we forbid the
> guest lbr enabling when the guest and host see different lbr stack
> entries.

How do you handle live migration?
