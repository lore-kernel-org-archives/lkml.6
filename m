Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB14BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC12070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxZvZiiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfAHRTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:19:44 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35425 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:19:44 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so7061776itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zpa2fL7q2YZTofq9H0F49nWh5nPFN0Bl9DMZ4qDyzi8=;
        b=cxZvZiiqvt5CbEYPCEFQ65p+1B3pprinpPzF0PdVI+SQwvkKXidk3R9GBFec3EBXOG
         looVJcRTokGt2rmKessd1x48pAZfXc/oyqe0rLNguuE7UP8KZXQdfnq2Ec3oYN/z8aoZ
         za/k9/GmJj5ve/Ca6wG7oAW46b3EGCsY+o4X0/xHZXGG8wpKi4VYlXA7DYe9NDqfcF8X
         ZJaA4iOUCV31JBOy8EKyyGv961qKGEdQMaox0OCetrMH8J4HISGFmGOXYJsRCpXGtTmW
         Ewj3Jd5FvO9/f/guObVTOHdvysCFzrMb44Rr3vSfE4NIB5NYOCNjNQE0UXrjjo4ldzQM
         0waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zpa2fL7q2YZTofq9H0F49nWh5nPFN0Bl9DMZ4qDyzi8=;
        b=r5CtftsBpDk7JSOavc2aFd+AbwrRgczt8S1gj8WCsuD9KeKHxec86qVHP/3Skqu0Ye
         4brY3OfZceiR3qbOlTurFZH02prV03WkcPJ0JIkFxZEGryINGcg23PPS6JBnRXiJlm5c
         3KWPSII7RfWSIKdmDtPHm12l/Ip7IM545hWrN7vJlmzeBawzbQCC0U2g1AlixWuC6AXK
         V6IUDXL0GCmVcxPxi4HbBioaCq2vUSPBRzKw9DBPtOju31zFNtGZBxQLz71l4pyuKfxr
         X3TnYa8qduvbzfooxXFiq5TDVpIODIn8c7g5F5OHLMFhE9XKunVimdiEHsBMvjziuMYA
         15dg==
X-Gm-Message-State: AJcUukfV5UOEG/AaAQJC/Kolhy9y+/smL7g7LEDpzsRiOg6e/1WoPT5h
        plLaVqHgzSR6qn9eK4RgoWLic7NB8fTNbHM49a9lCw==
X-Google-Smtp-Source: ALg8bN6Ou/5/xF0tY5jUcJTvLf6IctdCv0epIHr4OrR571e81CpaZEmznhbtmqhgePpt4eVAybK2QqxTe3LusJPZvgs=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr1803645itb.77.1546967982815;
 Tue, 08 Jan 2019 09:19:42 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
 <5C3318A1.9090009@intel.com> <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com>
 <20190107182012.GL6118@tassilo.jf.intel.com> <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
 <5C34570D.6010208@intel.com>
In-Reply-To: <5C34570D.6010208@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 8 Jan 2019 09:19:31 -0800
Message-ID: <CALMp9eQad9UkPMd+VUyCMqi07BoiOU3F5Ws_Re7o_vkd_Z-Dkg@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Mon, Jan 7, 2019 at 11:48 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 01/08/2019 02:48 AM, Jim Mattson wrote:
> > On Mon, Jan 7, 2019 at 10:20 AM Andi Kleen <ak@linux.intel.com> wrote:
> >>> The issue is compatibility. Prior to your change, reading this MSR
> >>> from a VM would raise #GP. After your change, it won't. That means
> >>> that if you have a VM migrating between hosts with kernel versions
> >>> before and after this change, the results will be inconsistent. In the
> >> No it will not be. All Linux kernel uses of this MSR are guarded
> >> by a CPUID check.
> > Linux usage is irrelevant to the architected behavior of the virtual
> > CPU. According to volume 4 of the SDM, this MSR is only supported when
> > CPUID.01H:ECX.PDCM [bit 15] is set. Therefore, kvm should raise #GP
> > whenever a guest tries to read this MSR and the guest's
> > CPUID.01H:ECX.PDCM [bit 15] is clear.
> >
>
> Probably one more check would be better:
>
> if (!boot_cpu_has(X86_FEATURE_PDCM) ||
>      !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
>      return 1;

Thanks for that change!

> (host isn't expected to read this MSR when PDCM is not supported
> by the guest, so don't have "!msr_info->host_initiate" added to above)

In keeping with commit 44883f01fe6ae ("KVM: x86: ensure all MSRs can
always be KVM_GET/SET_MSR'd"), I think the host_initiated check should
be added.
