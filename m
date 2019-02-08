Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D825C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20621908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3PbxSIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBHWFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52442 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:22 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so7270216itc.2;
        Fri, 08 Feb 2019 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMrgUPlPHD04UbzHPVNuFWqzUrtFAIYpkr+vApyx7u4=;
        b=n3PbxSIqDgr1mgy2PETPvv/ibiHDBnbBf44nm1U6ZfndCeSi4dPt8q2UPxC3mp9XyB
         cQQGJ7Wr+toACHqikkTirSm39fHeyLyxT3B6+xSr0NhUkihMUiOPAreS2lsWt3c8emcf
         k61jR8d2FOOwGqrXQ8NRgs5vGtgf/V0j2utexdRpQzEMSmDDAUxbw9rlrkbSZtS1hUIx
         p/9BeoW+VrucE/eIBM1wfFW3gp9brpXGRwiIw5N8Dp8e+emLvD0Nvh0IRQ1zdVObeNPC
         dJ0KOCEslh0iWuhFYPxeUJlq9j72x50AsFPxyY9vW8gDPzYtBtIIPjprW4555jmke/IJ
         bPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMrgUPlPHD04UbzHPVNuFWqzUrtFAIYpkr+vApyx7u4=;
        b=I8kNXSWuFIAdWPpIMxdEEPRpITOyWJULjZdwAGQ89nLCQiVBou1LZ5xXQXAiYbLtd+
         Ho9xy8+chJEQ0HwtVFugN48MrRth3tXTeHRsaFKt0FWxLsevDtiaUrQY17NPI/KpnoEU
         2v3zZjv1tdeI8rpgjJFUerqH1TTcWoiyTpryq3naevTfIvObuWC/um60VzP7BfUKSCjw
         LgdHkEtJyV9a0VPpW6PaV+X2FPbLG9Sfy18H5S3VtSbwQRCWVChDzYYKzaOCvDpDbcBg
         tU3KBE6R5Z5Abiws6f45izWJxMf2xhfsyHdOsNDduUhJo0xIiP2J5eJhiUwOLeNuZ4O9
         h63A==
X-Gm-Message-State: AHQUAubUoGfCWsZ7b3W5AfsrCd2yLH+1uMWKVVX1J5/sHiuCGUNzTZlL
        EhIL8q7XiQvRdedI1Y2S1LHVTYc9XKjcI3x2NSo=
X-Google-Smtp-Source: AHgI3IaiIuZp711McjHyud/Ae5yuItdjbf2Rdv4b5KUv0OmnhTjhhXNMXKfxzfvyJaGAzhG3tobsQxs9TBTWpBKXIAs=
X-Received: by 2002:a24:5989:: with SMTP id p131mr458406itb.6.1549663521157;
 Fri, 08 Feb 2019 14:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org> <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org> <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com> <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com> <20190208163601-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190208163601-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 8 Feb 2019 14:05:09 -0800
Message-ID: <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
> > >> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> > >> However I am still thinking about a workload which I can use to test its
> > >> effectiveness.
> > > You might want to look at doing something like min(MAX_ORDER - 1,
> > > HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
> > > THP which is the most likely to be used page size with the guest.
> > Sure, thanks for the suggestion.
>
> Given current hinting in balloon is MAX_ORDER I'd say
> share code. If you feel a need to adjust down the road,
> adjust both of them with actual testing showing gains.

Actually I'm left kind of wondering why we are even going through
virtio-balloon for this? It seems like this would make much more sense
as core functionality of KVM itself for the specific architectures
rather than some side thing. In addition this could end up being
redundant when you start getting into either the s390 or PowerPC
architectures as they already have means of providing unused page
hints.

I have a set of patches I proposed that add similar functionality via
a KVM hypercall for x86 instead of doing it as a part of a Virtio
device[1].  I'm suspecting the overhead of doing things this way is
much less then having to make multiple madvise system calls from QEMU
back into the kernel.

One other concern that has been pointed out with my patchset that
would likely need to be addressed here as well is what do we do about
other hypervisors that decide to implement page hinting. We probably
should look at making this KVM/QEMU specific code run through the
paravirtual infrastructure instead of trying into the x86 arch code
directly.

[1] https://lkml.org/lkml/2019/2/4/903
