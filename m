Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D9C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B88214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHMA8OU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B88214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJQIhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:37:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38475 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJQIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:37:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so19680408oif.5;
        Tue, 16 Oct 2018 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj9uAqGJ4tTJnDwumO/ai2exba+qRiidOuUmCPe67C8=;
        b=hHMA8OU6Exxd3GuURYwHgi+7AaPNWTd8PGrzPx9BmKNTxltR6EFRTf8JVKXNXgwAOG
         xzNjsNSU9yiefM5FuWx3G2Ew7zkHAoBt1Dq6Ag6EKhKZBHNK9OBn8s7LHKU3INqNPnqP
         GOnxu51SZM1SNL9wPoIOogv4lZNeaMIaPOun9sOMtMvwHLwfplbldargX1ZON1Yp6XSQ
         t9qvxS2WCFbdt34TRe4z0AXFGZrE71K4e3uXameQNyEPMgeeOSUHj7HHXrt3GcJF5ZFT
         PdpUu0eWZXGA7/+lsef2z8M8eI+GMGNQhji32Xnd4vgyNOLSwhsNs7qe5vscUVnXN1X9
         6KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj9uAqGJ4tTJnDwumO/ai2exba+qRiidOuUmCPe67C8=;
        b=kYtDp39DQFk3aEqTpYejuHMqlAgMqxpIN4H1od3FhNJx9UWRI62oSI+/NLQ/X/QIlD
         Jx578vgcOACVP2Yiju7YnUmOBRve0xBz3ubUeY8wvYYJYOLvDXGuDW5iJJfHdXMX0Zfp
         +XvqzNtDPYYh7vawPSVJUR4CzM17AGjRo31TvTymV++5Ew2Sf27nSZ/ohiIKbzvqi9Jn
         ctdkOMcixqpF40ef6dj11zSsESg1QxJap0+dD0oPeRSwn+h+vU+eSRHX6L7HxCIuOKjw
         FBMHh7E141ltO15WZpl6gRRrsalSYBlQygp1NN40h5jX19UHqp6hqS8LM5vM+0fePeLJ
         dT3g==
X-Gm-Message-State: ABuFfohBfm+LVWUOmSMYqeVTVz5e400GPEsMU+7e78zqzqQGaDJ9duqH
        EHiOkdTy9iO6qvrcNgF9Jf1qeWrfRYXhg1V+DYc=
X-Google-Smtp-Source: ACcGV63eUVtJJKDOjOZfKI1uzzl61WwImkNHTg3zHkJImClc/Erz74lSBBVSQ1fTxHknI2+pJJi/3zAke8LGQ6N/vaA=
X-Received: by 2002:aca:a896:: with SMTP id r144-v6mr12121420oie.317.1539737088210;
 Tue, 16 Oct 2018 17:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181016225522.13077-1-pbonzini@redhat.com>
In-Reply-To: <20181016225522.13077-1-pbonzini@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 17 Oct 2018 08:44:47 +0800
Message-ID: <CANRm+CyonYOzGdXo+D8gr8n04=f=S92QH-HxETKnoGGxhMFREA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: enable nested virtualization by default
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 at 06:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> With live migration support and finally a good solution for CR2/DR6
> exception payloads, nested VMX should finally be ready for having a stable
> userspace ABI.  The results of syzkaller fuzzing are not perfect but not
> horrible either (and might be partially due to running on GCE, so that
> effectively we're testing three-level nesting on a fork of upstream KVM!).
> Enabling it by default seems like a nice way to conclude the 4.20
> pull request. :)
>
> Unfortunately, enabling nested SVM in 2009 was a bit premature.  However,
> until live migration support is in place we can reasonably expect that
> it does not offer much in terms of ABI guarantees.  Therefore we are
> still in time to break things and conform as much as possible to the
> interface used for VMX.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Suggested-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e665aa7167cf..89fc2a744d7f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -107,7 +107,7 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
>   * VMX and be a hypervisor for its own guests. If nested=0, guests may not
>   * use VMX instructions.
>   */
> -static bool __read_mostly nested = 0;
> +static bool __read_mostly nested = 1;

Really cool, a milestone for nested. :)

Regards,
Wanpeng Li
