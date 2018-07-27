Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B210C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0392D208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYLdFjfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0392D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeG0Slj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:41:39 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40439 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeG0Sli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:41:38 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so10347298oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CM/tjtfsBOnRjg4dlus9Z+nkNaqYi4+ENA1XZ2Q+fYQ=;
        b=JYLdFjfoHJGrLpHu7VHqcO/6dyGn0cdPkxCkguGchAIh176mbTxQ145+Y2X6QKEBqV
         +1v68KtYK1utBcO2vDQGX+PpwbfADN3lCiXNq+zlq4rtYpSYuk3GfrOGG0vOYSuLGYT+
         fdFUz2qDZ5CWSB45wq9hmdsnR7G1GwahvDDZWOxjFO/6wurqamUU9mVrPTAvDkDNsW1u
         M5Fh0aXnPLInZ5BfE+Qzmq+0UtTnx8ykd02XPVNR+Af7iK9Cbz8Wqkd4TZBc3S97t7QP
         2ovEx58RYRFgJ75LA/EXzeGG/pw62VzcBYx8nfhJkoGyFDSMuCb0LPOliR/V5HVl6NX0
         vSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CM/tjtfsBOnRjg4dlus9Z+nkNaqYi4+ENA1XZ2Q+fYQ=;
        b=YvbnJzixSCwr9Plj8DJYOmLDiPUr3XiROXLVXn7paEuFrNfzHqTO3nFOL7hzD7Vpxl
         B37CeBYU3hScaCXhu9GTEp3UIhCbcul0FP+2fBSPLgteakNajMCjbyX0yZkYhCpo59z4
         omOutQywzGrmkfWP29cmwzmxU19pqRPFs64JTh0PIJbZIUKviCz7vhNqOBF0+GulPqMM
         LEMXSXMRAgaLyR4uIk2BTE098uHT3m36njEb6rBjveTe4IKRzrsAVp7AdqWYRoRMW2n3
         6HbRwh3DljcYABv/qJnEd8Eem13Fzatds6tvnUG997cq6klGpPx8xA2KEb2gwOXasdDC
         bnjQ==
X-Gm-Message-State: AOUpUlEUBHRLquEDstEdysE+SqpyhpQKFnjqzhYHO5+SJJQeoDwxqPsA
        FqxnkKmAF3Oz5YHqCxOock3tZ+hKwBA2L6xazBmg0w==
X-Google-Smtp-Source: AAOMgpf/sVAewxrTfz5RVPIEoE66LVSd+MzvYm0Yf8KUS8G5f0f1g/HYku7oN0K+cMPo7LGNoR/ZXLbKqICjB3WTyoE=
X-Received: by 2002:aca:e8c9:: with SMTP id f192-v6mr7532998oih.87.1532711927794;
 Fri, 27 Jul 2018 10:18:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 10:18:47
 -0700 (PDT)
In-Reply-To: <20170320081628.18952-2-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-2-khuey@kylehuey.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 10:18:47 -0700
Message-ID: <CALMp9eR-g7-vv8vcTZbf0jeoH=5wNfnwjOT-gW-4gPFDsrLBJg@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] x86/msr: Rename MISC_FEATURE_ENABLES to MISC_FEATURES_ENABLES
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2017 at 1:16 AM, Kyle Huey <me@kylehuey.com> wrote:
> This matches the only public Intel documentation of this MSR, in the
> "Virtualization Technology FlexMigration Application Note"
> (preserved at https://bugzilla.kernel.org/attachment.cgi?id=243991)
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>

The old spelling matched volume 4 of the SDM, Table 2-43. "Selected
MSRs Supported by Intel Xeon Phi Processors with
DisplayFamily_DisplayModel Signatures 06_57H and 06_85H."
