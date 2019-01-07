Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E15DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0502085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HA4bDr3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfAGSFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:05:40 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52570 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:05:40 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so2465175itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9g+6HwMP9gvVHgdkijBM5/BFjJjMxfixoLwKD9Du1bM=;
        b=HA4bDr3GnI8phJrHJeuR53fiDT9oCkR0fHg7SxuIC0qbgqbYOfgvedbGx0iMysCuPk
         yIAykapwJWRtU92yEb/w5kf0CzTeh6Qnha5eeZ/9mkEPXJ4KCTW9j6KuZgZWNiEPNh9d
         NWnQB6JlE/ewsR91/tkGpYHVZzmVstjdIYV6GYXoQQ5iuX/KJi4E1PgLsQZ6hhgtEkUY
         9PyEfPsmxVmQBHrtIPtdOo29c48pLDIMFlF3wB92tL5zRXXwtpBtvvDzdsZo9Mvw0d6L
         dNL4ghmF0IqufmyR6rJqD4hG2830oXSwgQTslXXLNJp3xgKSRUslyyTQF7+lMEFrFpmY
         KUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9g+6HwMP9gvVHgdkijBM5/BFjJjMxfixoLwKD9Du1bM=;
        b=J7ucBFRKwhCb2tjug7PbybxgTzpf22/Upk6I+PlLCzG6Pbn6sh0z4Kr2jd3yJyKX/o
         e3PMeO0C7xCqDb9i8rWJ6/LjJ6xDr1eBTa5U9wMhWK8qzvIlnA7PhCrPCBn9d7drmH+n
         LE/LtX9CT25udPB6AaTysv7jkzZIp1fFcbRqFDgB/lFfOJ0H5L1R/uZVHFp+6OAXLLvZ
         xN3GYQD+t9oUjJtFthNeeOJbBJojHCOb3SB88Zmrk4bw3mq+jQOWoQC7bTmLmarzJ82e
         iqPjBDefLV31JxvtAKLDEOL356MXuoTXyaRZtXbhuED8Z/h8uR1xO2LxDIimf9B1+yZ1
         R6JQ==
X-Gm-Message-State: AJcUukeJs89Licm32pcVBm335RXSFZFPUTM6Ah8p4jUNf1LDUCZv/j+A
        h5uMsCpt+DqmyH5nEWsMznGOzWHOnMbGpRxIQEuBBg==
X-Google-Smtp-Source: ALg8bN4aXOtQ24WBdEsXy6tZcWzzmtktfswcolTPkdBtZ2m9JINb1Lpd9+xHpHSCWwRUJE/KYIzpetd9KSR3BIaZSkw=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr7697660itb.77.1546884338477;
 Mon, 07 Jan 2019 10:05:38 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
 <5C3318A1.9090009@intel.com>
In-Reply-To: <5C3318A1.9090009@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Jan 2019 10:05:27 -0800
Message-ID: <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com>
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

On Mon, Jan 7, 2019 at 1:09 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 01/03/2019 11:25 PM, Jim Mattson wrote:
> > On Wed, Jan 2, 2019 at 11:55 PM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> >> Right, thanks. Probably better to change it to below:
> >>
> >> msr_info->data = 0;
> >> data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
> >> if (vcpu->kvm->arch.lbr_in_guest)
> >>       msr_info->data |= (data & X86_PERF_CAP_MASK_LBR_FMT);
> >>
> > This still breaks backwards compatibility. Returning 0 and raising #GP
> > are not the same.
>
> I'm not sure about raising GP# in this case.
>
> This PERF_CAP msr contains more things than the lbr format.
> For example, a guest with lbr=false option could read it to get PEBS_FMT,
> which is PERF_CAP[11:8]. We should offer those bits in this case.
>
> When lbr=false, the lbr feature is not usable by the guest,
> so I think whatever value (0 or other value) of the LBR_FMT bits that
> we give to the guest might not be important.

The issue is compatibility. Prior to your change, reading this MSR
from a VM would raise #GP. After your change, it won't. That means
that if you have a VM migrating between hosts with kernel versions
before and after this change, the results will be inconsistent. In the
forward migration path, RDMSR will first raise #GP, and later will
return 0. In the backward migration path, RDMSR will first return 0,
and later it will raise #GP.

To avoid these inconsistencies, the new MSR behavior should be
explicitly enabled by an opt-in ioctl from userspace (not necessarily
the same ioctl that enables LBR).
