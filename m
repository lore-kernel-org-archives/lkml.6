Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2089732-1519370806-2-16244738864683776721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519370806; b=C8uvUHRnEy3QQXU3Jggv2iozx6hyx+UBo/fD9aETdUopPqr
    +Jhu4JRHF0PCsUGx8oQ36arf/u8EzjoUkB2Uk3cYD+6jNjzApv9pSRgt9at/sjrF
    LZO0haxNwJbgj/dQQOJNCKJMiM1gqbPhVkzFOUa2ZCLYadHvvt2d2ZvGjnwrhp0+
    jNhtTewvkkX83j5FF0fpxmGmNd1pXd22oIaaTNDnpSBlJGD9rg1nlWTjUVqJhLxA
    u3eTNAtN18tPcAvlG5xvDH+rtj3WJtKkOSSniO6TjO8wFrMm0UeUfEDQAUhU+dQt
    7kxgppKaEX9gcBGH0ihgMh3XpECO0LJ8voASWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519370806; bh=w2Yk2kgeaKKqgoLKIj5Y9cy9l2
    k8TyrVyCWlYn44fco=; b=p669q+Zc+mVl7Pah9nIu+i94Y2/ihjD8uBb+zwNtAp
    51tHMc+ULDhuKSuKOOeVCHl0yy8IBl0q+0UmIqWJnrTEuJRWGhUy8j8K4TiS/zzL
    mx3p+dIo4f0BKFFPfDwOa3kjTkP1b3jQwepRwBy9E6TnZ+rbDQp2/ZqV2s3kdLHf
    kFK/zfXAuZER7fg5UsWAExLxB+/G/Nfr1Ep87vVENBY1PqDSK/NoTs0WnsEaO+Gr
    JiT2y89j5Qm2vx1zH4hrJYpvHdglNDxmjL2IWFcnkwvfZcZwZcCDl+OenlKD0aYK
    J1Di5Ckx65zyLsTzoHftQptUsBsGshTqOW8JtSbJ5+Dg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QNBk0/yV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FLJ1+ksb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QNBk0/yV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FLJ1+ksb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBWH0a (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:26:30 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37492 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeBWH03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:26:29 -0500
X-Google-Smtp-Source: AH8x224H9JKO8iK9BFMLzuIevh5M3Jf/pIXiu/rXDdgpA3PobBkrvDBuAkTuYcSNVxDLqy1vZwXBoA==
Date: Fri, 23 Feb 2018 08:26:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/pti: KVM: fixes and optimizations for IBRS
Message-ID: <20180223072624.iy2n6wxo5g54s2x4@gmail.com>
References: <20180222154318.20361-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222154318.20361-1-pbonzini@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Paolo Bonzini <pbonzini@redhat.com> wrote:

> Two tiny patches for the IBRS code.  They should go in
> through the x86/pti tree and should apply to both 4.9 and 4.14 trees.
> 
> Thanks,
> 
> Paolo
> 
> v1->v2: remove patch 2, the same bug has already been fixed
> 
> Paolo Bonzini (3):
>   KVM: x86: use native MSR ops for SPEC_CTRL
>   KVM: VMX: mark RDMSR path as unlikely
> 
>  arch/x86/kvm/svm.c |  9 +++++----
>  arch/x86/kvm/vmx.c |  9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)

Applied to tip:x86/pti, with minor tweaks to the titles/changelogs.

If all goes fine in testing I will send all pending tip:x86/pti changes to Linus 
later today, so the KVM development tree should be able to pull in these changes 
via upstream pretty soon.

Thanks,

	Ingo
