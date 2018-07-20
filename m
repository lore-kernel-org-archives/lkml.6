Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB5E20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzClNLo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB5E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeGTEfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:35:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42135 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeGTEfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:35:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so18911074oib.9;
        Thu, 19 Jul 2018 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/gKdgI/c9YH0m40UfMcjMjMmlUpCU1lBJT57UOSQx0=;
        b=jzClNLo1yJTzUCL/d67zVmaJQMztrrMeucYE5vkYPcPvtVdj7tp6OxJSpvEEEgr1oq
         2CpBXWkw4gttnByFPFSRZ86r+lJp5f5eoyM7Kq/ysneFe0Yfyxcb0EFBaYWiLKLnytYG
         XuEXNTPYeFaD0EDUYG6l9lMmIrrDtu2QFBdvyrcSQBBPFyYyxJxQuFPd24NzuWKkL59c
         nuAUaiQ0Csi0G3HL/gLPXhrg0bZQJvHfvbqAbo8LvpIw9jKxynE2UjUNjjaJl10QUTib
         kDH6tpam3DNxw7AqCfwDCZMYGalXE156eB/eSDKIpamA6DnL0LTtf24SZWzuIj0QmilS
         sQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/gKdgI/c9YH0m40UfMcjMjMmlUpCU1lBJT57UOSQx0=;
        b=VxsXcfIHODIf0KCMpFdLOcsnQ8xi77ZKgrXEcWTh0flhTHEEEQv/inBHo98j23CtHc
         8qLT7iDzVtTE+OQEW7IZL9CaXGM8jWIP5w/K4N48to+Az/T0ziT8HdDRRTteu+0zWVHg
         tUVp/xqzCwS1jX78hOCA4WBYrQXdSFjLaHXE7r9wbOBBNB3+Z/xjvSgEsVogHmYfNH1M
         dRIt6nLbfmmTWifCT1k0CgY772hTI3SmGUFvsl0DiXBtkCaJEKeTgEAJcIIiikTxj+N9
         HqdEz78eSqG/leBGuh0GxlUCbW82jQlMaDR6R/ASlLHZmhVgCPn4Or1735ZGv7RTA5gY
         MCAw==
X-Gm-Message-State: AOUpUlHN96vyidoNc9WTNHg2v3ZNyBoSvnS9XNxJrDxIz7aa90DSSIIr
        mCTlGUgdvjLZKYurDjmrijHUsYTNBp4MKDMy69c=
X-Google-Smtp-Source: AAOMgpdnUI4qvBmxkHVcEMTw+3JVQJQVsSzt17rRtOfeBiWxIZmykIzCoKGH2dapBQhiSuzDySb839z435qr+/wTRTY=
X-Received: by 2002:aca:cc46:: with SMTP id c67-v6mr411728oig.197.1532058572024;
 Thu, 19 Jul 2018 20:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-5-git-send-email-wanpengli@tencent.com> <a4f281c2-f189-ae23-bf86-2ea009b38357@redhat.com>
In-Reply-To: <a4f281c2-f189-ae23-bf86-2ea009b38357@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 11:49:36 +0800
Message-ID: <CANRm+Cw8wwSY0qDyT3p_etgNud9b1Jz0tPaJgvq4GT3s=eM91Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] KVM: X86: Implement PV IPIs send hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 00:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/07/2018 08:21, Wanpeng Li wrote:
> > +
> > +     rcu_read_lock();
> > +     map = rcu_dereference(kvm->arch.apic_map);
> > +
> > +     for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> > +             vcpu = map->phys_map[i]->vcpu;
> > +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > +                     return 1;
> > +     }
> > +
> > +     for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> > +             vcpu = map->phys_map[i + BITS_PER_LONG]->vcpu;
> > +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > +                     return 1;
> > +     }
> > +
>
> This should be the guest's BITS_PER_LONG, not the host's (i.e. you need
> to pass op_64_bit from kvm_emulate_hypercall).

Will do in next version.

Regards,
Wanpeng Li
