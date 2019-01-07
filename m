Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50022C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E72F206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMHNJWRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfAGSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:48:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33128 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfAGSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:48:50 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so7989406itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBT2xWlBaFx8A82c9pWy3q2KxvGV9+zYcbjmIJA1qtA=;
        b=SMHNJWRyC+rkLo298K1dABmNmqHxeXEqyCnhndLOBEKJ+qbOgIPNea3ZnlYQGg1ecq
         w2DzP8V8y/F47K1w+eOnojnp5ogJte7SRG5xK7LvlZK1oTrKrCzXBdK9gTu4MKd6omm5
         UskMbmvVeQ70dRpZDA+f4+vAhu7l25WxJexySGUEK0cjUd6Cd7XwbDVIg+MYH0/1BgvI
         KY+RELYG9BLYCt/GyGPTDNOBlu/HJEwmBDMuRCXb+Y4OFtnmBtGFkDUMxFzt38ckM2dL
         uZUc4ZZ0ovpKyE7JOKvE6fb/RKehAAv6CHnYZ8wMvTimPAp1JfUPtksH3rt+poTs8O32
         anBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBT2xWlBaFx8A82c9pWy3q2KxvGV9+zYcbjmIJA1qtA=;
        b=jB6RBDwbVwsh5SjF/GQusmRljiBxSQO+FppjoPoM46hrQlRSMcV9SpTSc7YWZl5mt8
         jmDmZSFRD2SyAK8k7S/OhzAs9vgyMgrj93e53sKjFLHq0o0t1HpMyJ4v8B7V/et/YWIR
         1bVdymgk29f8ceVawnrpVXC2pQrbzM3fUaWzR+RGJaFianFzPIPt1VF7oqKc3xedLIoe
         kaTMWNkz6M/f6p3J74GSeWXOOSadmSqt9b5NNeTWiDyMAISEFVi/hgPzvz7btAw/7+CZ
         vhekJ0m3JhtObnBoZLRvgLtqsEyju+TGLWGZdsPfvgOgQK+LG1sgqKq467b6ggvP196l
         sb9w==
X-Gm-Message-State: AJcUukeXcGyTuYY2wPv9GCSTPh6QQ972vwloA/dlqOzNcr2XbptjSv/S
        I+231v3A86MNcUYpMLqOcrujOPMn7TcMdpg7HIASZiWC5s88Rw==
X-Google-Smtp-Source: ALg8bN5VSTavqZQUk2m2ZQWmi3h59i7s5+s819H7QiEfK1AaRV/93X3O7lCqJehvBLQuN1QUgzTFe40w4B629cB5PuI=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr7801886itb.77.1546886929271;
 Mon, 07 Jan 2019 10:48:49 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
 <5C3318A1.9090009@intel.com> <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com>
 <20190107182012.GL6118@tassilo.jf.intel.com>
In-Reply-To: <20190107182012.GL6118@tassilo.jf.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Jan 2019 10:48:38 -0800
Message-ID: <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
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

On Mon, Jan 7, 2019 at 10:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > The issue is compatibility. Prior to your change, reading this MSR
> > from a VM would raise #GP. After your change, it won't. That means
> > that if you have a VM migrating between hosts with kernel versions
> > before and after this change, the results will be inconsistent. In the
>
> No it will not be. All Linux kernel uses of this MSR are guarded
> by a CPUID check.

Linux usage is irrelevant to the architected behavior of the virtual
CPU. According to volume 4 of the SDM, this MSR is only supported when
CPUID.01H:ECX.PDCM [bit 15] is set. Therefore, kvm should raise #GP
whenever a guest tries to read this MSR and the guest's
CPUID.01H:ECX.PDCM [bit 15] is clear.
