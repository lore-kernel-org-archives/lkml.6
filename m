Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C13208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWmQwwVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfACPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:34:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39497 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbfACPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:34:56 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so27256114iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzcrO/DDIabG61fKvh3m/tBm+wvoA5YtgUbBVcpXEbQ=;
        b=RWmQwwVtIponRV1jmDO5ilD3V8yH+FO7Ud4zkAKjiW2v3WnC5OYkSVz4hW38UbNk01
         UPJ1nlYFTxc1V4LCEy7rL/JNdQcTNpOV998m4Ct3B/LQqECUfTzdLoPd/MDm6LiRb9OH
         5EVKJpovvgxBwiXqeA8uTjHLKQFDFVkT0uqM+urny4clmWGf5NgREz7xNyOqWYZS1niR
         sOL18UeltCqrHHpNjH2aPLAU0ldLGhdizKQi60aH3tPIvqGgXO7VfK/EdU/ThWzR5BYN
         +98RqrmBiLdh0iLOs4Y4/7NdLU0KfeEuv9MkuIUdXD99IOKcloDcC96x+dPnv3Toewng
         C70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzcrO/DDIabG61fKvh3m/tBm+wvoA5YtgUbBVcpXEbQ=;
        b=heU8F8dbwJ5kC/OKeZN5pbwFSQesvga5Qc8U1tCRuI1U/8PGELNQfftnuydtsKXLnL
         Yv2Nb0xYyPmneydTndL2PCdAkYijF1zmBr3VD4ypOUd4mATkggDaCZcLDy9gnJvQH2jh
         ZfZ1uJErjmu76YKr+YvAFMF31rW0kL6A77NTOnAYvaO2wW4XxfR5X0OC221omQ1W+8nQ
         sbRttyAsL2a60T9Wgr8wKXehxDCYmxgCTFSqrvzDOsJT7yqR7CBLMONtnhtHGBD3cUE1
         tnguAIc56pWto1+PZtfQyJB3yg6t8Vys8gNEMHRq6RUjhhLYfYWT8MEtFu61/arVVldX
         tDew==
X-Gm-Message-State: AJcUukevrQiLxwPu3zNnaBlLrg9ahpIaaadiVz8C/pRrMNJiObPWLKpv
        mcEPt0Qa5TNnQynEUarVBRR9S86thjEXVcDoBV47UA==
X-Google-Smtp-Source: ALg8bN60kACinhCtNuJ2AqklHh6+gZhYiwxOFxMFSURhcticxssMVq96kSpdrLBPW0sw0QsRDzCVM7wic+CkaQajyk0=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr34641809iod.40.1546529695287;
 Thu, 03 Jan 2019 07:34:55 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
 <5C2DB81F.3000906@intel.com>
In-Reply-To: <5C2DB81F.3000906@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Jan 2019 07:34:44 -0800
Message-ID: <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
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

On Wed, Jan 2, 2019 at 11:16 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 01/03/2019 07:26 AM, Jim Mattson wrote:
> > On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
> >> The lbr stack is architecturally specific, for example, SKX has 32 lbr
> >> stack entries while HSW has 16 entries, so a HSW guest running on a SKX
> >> machine may not get accurate perf results. Currently, we forbid the
> >> guest lbr enabling when the guest and host see different lbr stack
> >> entries.
> > How do you handle live migration?
>
> This feature is gated by the QEMU "lbr=true" option.
> So if the lbr fails to work on the destination machine,
> the destination side QEMU wouldn't be able to boot,
> and migration will not happen.

Yes, but then what happens?

Fast forward to, say, 2021. You're decommissioning all Broadwell
servers in your data center. You have to migrate the running VMs off
of those Broadwell systems onto newer hardware. But, with the current
implementation, the migration cannot happen. So, what do you do? I
suppose you just never enable the feature in the first place. Right?
