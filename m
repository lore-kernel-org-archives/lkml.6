Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89376C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3UORW7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeLEWrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:47:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38772 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeLEWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:47:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so19047676oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viG5/RsatE8x2Ykr5a1oyvGlkJmJiXjlidnEcsvF+xQ=;
        b=T3UORW7a2L5UbikH+Nc3DT27olWAu79hQEvAmafrTDSlwIbVmu4WuCbQFmGTUyaCr9
         FCWtAi53X6mduntYQSTNQI4+7JwvM3tz0+fquwXzrkP4NAIey5eEBD24u9MWK+jbHdv+
         B1MDq3l/MdPTizE5Z9DBjRgzB6V9XhFjyxY1op6ADodQB7pMrwfPn/xh1nAVlrSXdYgt
         yqdihygvHBPCNVWtbjW32Z9GSr2oX8DVzUHg115qEerPrzOBfLlgubUCqtYrpiWRoG1F
         tOGsI/QtkR2PZatqVwZRgpN4ViN9kNz09ErwvijvpIZybM4h1/e21djqVmWqIcXdkmqF
         Sg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viG5/RsatE8x2Ykr5a1oyvGlkJmJiXjlidnEcsvF+xQ=;
        b=VcGGjDW131hGWOOrzGjG9WW/Y9ISMHNhyIY7ZHsG+vY9jHh3wxBVS6cTTUw3usPWUA
         2Q4sA6+M27e45o3JY3lzH0ZhnXrmsDx6W8LZxZ7QuwOPWr8Hb1bVps7A4EN3GjydDmjt
         z7FNZ7KwBAwCZKoMB+aHF2KOD2+anXyBwJUtLLCZXLStNQY34MSMy3MxNppTG0exDbla
         F7GjJ9QyhaXTmUgmQ8BDIJUGdKP5FvJCEV10P88Er93T1XyyS4YWZZAj4I706Z2c+Rt1
         hg47iRHKSQb0FmBwMCOSlNb5RyHAR9mDiVkGg0liqb7/yvhrXpGLANVCLqVV7xa8IKfp
         q5Lw==
X-Gm-Message-State: AA+aEWbf/BSC6Ofd+IToES9LIBNZgSPzD8NhaUYwegcOPTTpGnEHYlLH
        vXwNUyMTO1xvnrTTKp0hQAlF45lrK4CIYkQpygC5/A==
X-Google-Smtp-Source: AFSGD/X86nT6PUdj7lo49FYLgnyiwwtkaaaL7ZQtCY4Jmp2xttwWkhWHloXVKhIZ/nMuW3410GDFfT+q1P3BLgvXlXs=
X-Received: by 2002:aca:3a55:: with SMTP id h82mr16908999oia.86.1544050034655;
 Wed, 05 Dec 2018 14:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20181205191956.31480-1-ehabkost@redhat.com> <20181205220206.GA16013@char.us.oracle.com>
In-Reply-To: <20181205220206.GA16013@char.us.oracle.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 5 Dec 2018 14:47:03 -0800
Message-ID: <CALMp9eQFqs7w81gWYc=z_YXaBGO-4Nr3_M=rd3eev4KP-U-nGA@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: Report STIBP on GET_SUPPORTED_CPUID
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:02 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Dec 05, 2018 at 05:19:56PM -0200, Eduardo Habkost wrote:
> > Months ago, we have added code to allow direct access to MSR_IA32_SPEC_CTRL
> > to the guest, which makes STIBP available to guests.  This was implemented
> > by commits d28b387fb74d ("KVM/VMX: Allow direct access to
> > MSR_IA32_SPEC_CTRL") and b2ac58f90540 ("KVM/SVM: Allow direct access to
> > MSR_IA32_SPEC_CTRL").
> >
> > However, we never updated GET_SUPPORTED_CPUID to let userspace know that
> > STIBP can be enabled in CPUID.  Fix that by updating
>
> Ooops!
> > kvm_cpuid_8000_0008_ebx_x86_features and kvm_cpuid_7_0_edx_x86_features.
>
> Shouldn't there also be a patch in QEMU to use it? (aka, +stibp).

I don't see how that's relevant here. GET_SUPPORTED_CPUID should
report all of the supported CPUID features regardless of what
particular consumers choose to do with them.
