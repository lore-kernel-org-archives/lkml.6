Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E942C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D8206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvMaEyKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAOADt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:03:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36109 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfAOADs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:03:48 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so2097963itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0W8txPFyvoxj+szZzjhgBl2jXFGFteZf6FMF2NQRuv0=;
        b=uvMaEyKyTtn7FDcLQiwISJO+TLzDSqdqpUs3Yrg0nVDKKgEe44bR/SHa6tp+AQWt4Z
         lNLYrqEh67vntOqCqUEx4hz9jOBvuVftN6dn2WGCzvYYwV7OFT0s7E0jmpQUNWMNNbOb
         h+eV+HgHqBKtFIIBRrruEMLObNxLaQwUT92ag+lvxxeqvWAycfJk6VPXLBt9gs+iM77R
         RDtd+XS6ZXeP+ckKG175Fw+5hmWyiCHPSYi9w7b0q5+L+MP1UtRD66hb30pbeN5t40jv
         rfDRydhWZikyi6ZARyj//waRl9f9pm2bqazsnH9fZVX6wSxHcU//3IUDlckVN6NjURDi
         w96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W8txPFyvoxj+szZzjhgBl2jXFGFteZf6FMF2NQRuv0=;
        b=NtCpT2OIwNXXh9tvgsuLvYxjwed7+ezFXC5O7abs6FwQ+TRyI5usz8sfUWidv5B5/7
         Ttbsa9JBvAke1LhkbMGxBMoGb/M3XvyA0HIuN/fSHohmEUjHMuNfUdPnQz3cCR2PkebZ
         dNoGWDOuHO40v4RhvBEGww55/Rr9T8rzYAwPgT4J3SlP7z7xYNDqzzfmLO+vTVUxyfya
         4+rZ6Dy5IOxX00tj/u//q/EdFkIy2sP5Ffl/J2zXMQxHjM8f5Yf9pffq9FcTeFFMfipb
         dCwy6kBSap+i/OhWaUK9fJtsAcjP2iHEJyQeiPR2SmlJR76+x+Xv8iE2abgE8KOkrWGk
         6CRw==
X-Gm-Message-State: AJcUukcme9hCgede25Oyr+UAsGaTnfZeMLjtNiJvH0mC092iiSmoGsRy
        oCmiLinPw1JOsa3h/dVG3SfRNogzP2GyJ1kN7qGaPw==
X-Google-Smtp-Source: ALg8bN6fDVEpUUqC7w0yTvO56nDaDdnQQzdjdlbKcRP5nGPLZnzvc8gshkCm5NfIHZqaEJ4MLbaVQvExmbUYRM51J7g=
X-Received: by 2002:a02:8a69:: with SMTP id e38mr646703jal.81.1547510627825;
 Mon, 14 Jan 2019 16:03:47 -0800 (PST)
MIME-Version: 1.0
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com> <20190114234728.49239-1-tmroeder@google.com>
In-Reply-To: <20190114234728.49239-1-tmroeder@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 14 Jan 2019 16:03:35 -0800
Message-ID: <CALMp9eSovFPZOmztDtzcf0BnkoV1=4ua1ymOfuEg0K7acug24A@mail.gmail.com>
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
To:     Tom Roeder <tmroeder@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 3:48 PM Tom Roeder <tmroeder@google.com> wrote:
>
> This changes the allocation of cached_vmcs12 to use kzalloc instead of
> kmalloc. This removes the information leak found by Syzkaller (see
> Reported-by) in this case and prevents similar leaks from happening
> based on cached_vmcs12.
>
> The email from Syszkaller led to a discussion about a patch in early
> November on the KVM list (I've made this a reply to that thread), but
> the current upstream kernel still has kmalloc instead of kzalloc for
> cached_vmcs12 and cached_shadow_vmcs12. This RFC proposes changing to
> kzalloc for defense in depth.
>
> Tested: rebuilt but not tested, since this is an RFC
>
> Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
> Signed-off-by: Tom Roeder <tmroeder@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
