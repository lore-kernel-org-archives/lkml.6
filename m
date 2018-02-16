Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3165517-1518754599-2-520078809897413979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518754598; b=QUnWtpG7aJoutBYVntAfdu8Vg7HAxr/kdFg48WIVGAhYvsl
    /C80rctVLjj922zwvY2SJXFbzZqdmRQ0KgRnr4cdKP3BU5wcyiYYPt3NUQkOAM/6
    I/HDz0LOxF2A80x5J8cQqfURWqd6jp07ASj5KiNPkKGeow1it91dpSsW2uA8UcCz
    ny3Zn6Oon84zykrrJXaOocxgjU6N1DWFmGi2WqTqsvGjRiQ3aCqJ1CYtJlRonhWi
    AOXwp9FnE/ebewaBl7KNdQzrTKQUqibHeWwJeuWvU4hagRVO095i8yQgyaxPcIDJ
    N7moqQCFJPHWbg03EA0dPmMduCfaj1QJPXY1Y1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518754598; bh=UTf9sqCRjwDWrmy57HkSjri2CJDSW6zAGOtT1n
    K1FPM=; b=XYpvYxbgTck1ojR/m91cli+/9Dgf0mzj1zMp0emBHZscLeAiLLaT2p
    AyUek/JqF2sipSRW48FPiCB6X2H42xmDUiEHzXODBiIxl59/Aoa2fkDl4pYFeJ6b
    +qkp6i+0Dpaa/AN38LuUnL5LTzBGwfbx0d3sOXKPo2x1LWFOLMAwerml2hCUgYTt
    nCHySS7oRIO7kBPzF3tsMh9/MuXlYMxVkL/J0jP6okGm7kbLeTIzU9vUQspNvj53
    CSMU0VAY/3BOgDL4pV2qoDoNjRDxd/1LbpD8irSqHr/I/lcNLWwxm4/LYTkkir4I
    viemmwSVwWQgdq3lRIr+gcBhq1kB1XOQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=V8UVAax2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FMDQqWE/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=V8UVAax2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FMDQqWE/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeBPEQf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 23:16:35 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:40955 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeBPEQe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 23:16:34 -0500
X-Google-Smtp-Source: AH8x227OQ4+j6/3r/gUzuwfg0HaQotysUH7HunAqJGEnfJVi+92jTHkquzk9KmtOcg4za04Sv1IEOjhYWjVFzCvh1a8=
MIME-Version: 1.0
In-Reply-To: <1517938181-15317-9-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk> <1517938181-15317-9-git-send-email-dwmw@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Feb 2018 20:16:32 -0800
Message-ID: <CALMp9eSBqM7YoyFb+darU=1r33vR_P+Yoo7HqX=_M-wyu0zM8g@mail.gmail.com>
Subject: Re: [PATCH 8/9] KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 9:29 AM, David Woodhouse <dwmw@amazon.co.uk> wrote:

> @@ -8946,6 +9017,27 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  #endif
>               );
>
> +       /*
> +        * We do not use IBRS in the kernel. If this vCPU has used the
> +        * SPEC_CTRL MSR it may have left it on; save the value and
> +        * turn it off. This is much more efficient than blindly adding
> +        * it to the atomic save/restore list. Especially as the former
> +        * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
> +        *
> +        * For non-nested case:
> +        * If the L01 MSR bitmap does not intercept the MSR, then we need to
> +        * save it.
> +        *
> +        * For nested case:
> +        * If the L02 MSR bitmap does not intercept the MSR, then we need to
> +        * save it.
> +        */
> +       if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
> +               rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
> +
> +       if (vmx->spec_ctrl)
> +               wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +

Again, we haven't verified host support for this MSR. Perhaps this
should be something like:

if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)
    && !rdmsrl_safe(MSR_IA32_SPEC_CTRL, &vmx->spec_ctrl) && vmx->spec_ctrl)
        wrmsrl(MSR_IA32_SPEC_CTRL, 0);
