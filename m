Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3165517-1518753752-2-11497936283242156316
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
    t=1518753752; b=DIup/QrhOr+SLftUpA7eOBpOEMEW1ZgEOF0CDXyQQHic54B
    xGRVqQaxBQ78QTHdRhIWzYF3/JInpQqYO1Pa080XXd3N4Nlma+dbI9MpYkD9q4hs
    nkFRHcDRN9aNTD5hnISjOTww28SsxeGPFoX0luEXnfUEIei66PGnUbimJrkcH30+
    u2DRpeMRzDqKhU0JzKIRV+qssjOBq+QHki8Fw6bA9YUkpeDDpNlSlJjUgAK461qq
    etgCQZNw0M0aEGe7pZfagDla+zGUCV5l0mR1ysroVheA4J1VkHqgV81k8rY/Plvz
    mx0jd9FtqmCUn8UVBNOZV67rCOynRv3WonxR9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518753752; bh=gi1WKP2bmjplqt2NIWAEJ1esA8ZOcPCNFuUOxc
    IxeM0=; b=uMLmAcKssxLlPohagEeemP7C6fmRds+0/OZ1BwbYHp+w93B60f1DbZ
    a+5ocyiH84w3uk32HsfdOem98Euwd1nWUka2EYvFH16GbiPCtVo7b8enrpumDFCH
    14pBR23+6qKt92LnBangkWc2yOvefGm/uzuxnSYF25qJnt9OLG/jMPBRHfi0X7MT
    7ul5v3ru0rOSaHIUbsmRvFE6cQHrNEuqlMuskTjyKkJz9TwL3P2pd6fU1MAYoZt0
    uAVDsPEnWZtj3RY3L9OjCEygnLyTOjERBKzFVTTZGrS7ikVJgdzz8NNjfScdvn5K
    zYfEmi3XgRPT1PwmaUAP0jerAECgLz9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=cDImy0N5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n6lateZI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=cDImy0N5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n6lateZI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeBPECT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 23:02:19 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35301 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeBPECS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 23:02:18 -0500
X-Google-Smtp-Source: AH8x224zjlLBqK2DYkf0o2WBnZZ8rdm8ErdfVn9P123DpRPgDLO/95MAI+a09pos/3Mg1Y0/puL06yKETNShTXRxpLU=
MIME-Version: 1.0
In-Reply-To: <1517938181-15317-9-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk> <1517938181-15317-9-git-send-email-dwmw@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Feb 2018 20:02:15 -0800
Message-ID: <CALMp9eQMtV+f2+uYzeq2SCmvCVBAZ9G9pxJWV-BbAsSLbqR5zg@mail.gmail.com>
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

> @@ -8828,6 +8890,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>
>         vmx_arm_hv_timer(vcpu);
>
> +       /*
> +        * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> +        * it's non-zero. Since vmentry is serialising on affected CPUs, there
> +        * is no need to worry about the conditional branch over the wrmsr
> +        * being speculatively taken.
> +        */
> +       if (vmx->spec_ctrl)
> +               wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
> +

Shouldn't this be wrmsrl_safe? Userspace can make an ioctl to set
vmx->spec_ctrl to non-zero even if the MSR is not supported on the
host.
