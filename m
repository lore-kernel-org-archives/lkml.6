Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D01ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FD20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3AXs4jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693FD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeGTEbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:31:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36981 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeGTEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:31:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so18921687oib.4;
        Thu, 19 Jul 2018 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ulc5nI5SdQwAV7BaCcUKXThA96wYrHpBEjuECQz1uiA=;
        b=r3AXs4jtRtRS/dIPvqI39OifuqTrsHpS10dEqz2z3xp5jt3pOBoHiuK0dbeyxX7Dq3
         OBxiKGfio0BOqn682GnMuikwJACucMUXvlchlxjljkWwYU4NzsDoNvYLxbjKqDo65Hn+
         fZTT7JXKsg0BQY23kbz1xF2gj4btMTWwGf5QyMxlSMS26CtP0g7cerNTpn64kMs6Lk0B
         tO1H1+baR4GaN/fW/LvcmsSJmTu7vmLlzVjBfQ/J5Nyo8ecEb6Udeyrf2OenTIbT92wP
         BC+OOkrLXUXOy+f7ybaatjTNxooMC8rY1Sy0VQPhPc1oI9FqPMhtWasYREGXBmgusHtF
         6fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ulc5nI5SdQwAV7BaCcUKXThA96wYrHpBEjuECQz1uiA=;
        b=ZvqXsnhTgPYZqLGEi5dTWtIIYkXaec0B8Mt7Qgg+wkxDrTNLQqwX5X7A5k6Tnhy6is
         uw2qViuiYVd8F1w0U3Y2+QiUL9m7ztoy9712Z0dVmcrEA2enbP4AC4RoEWjnGpUBf1Vr
         pg2uWMPk7pH0WNQmSC9gctqDmmm+Is/GDcWjSnDftlMEeM+jJ9ac7VpZ72Ah6FT+/ipk
         8QXiOBgA3rD10iIvW/lEWc9ckL4FCFv9p3LBuh/mefT9+scqaAekmx5YenGo/8OGt636
         D8U32iUnCW6CWvR8u003XJoTjlz1uC7hpCEBdlpBGP0wiHAiENmP4xzp5uOT3j5YkfOF
         nRww==
X-Gm-Message-State: AOUpUlHZKWh/3A7cHLRpOfsF0ZScJlWdjGN9EzdRMAxn9RVmAjd5pQoH
        9Kjvf7toKKbyCJfoPZi6dsPLAPXi0tcus3Ui9pM=
X-Google-Smtp-Source: AAOMgpfXX3psIHeM0xNbnylhRi6SzKTOMnfpXDsp/Kbz+PZQdv6TiftAqlX1tWJK/mZPFdcFWJt2W12SoWCyQbBLSmI=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr381282oie.233.1532058335566;
 Thu, 19 Jul 2018 20:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com> <CALzav=fUmJZSvDgTvsB-7nyv1KiAMHgVcq-N+k0WCn3OsrVpNw@mail.gmail.com>
In-Reply-To: <CALzav=fUmJZSvDgTvsB-7nyv1KiAMHgVcq-N+k0WCn3OsrVpNw@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 11:45:40 +0800
Message-ID: <CANRm+Cx8qy7Ttf42zNuEPDGBc-6J1jMpe8di7UGUL2E6bxmMDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
To:     David Matlack <dmatlack@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 07:05, David Matlack <dmatlack@google.com> wrote:
>
> On Mon, Jul 2, 2018 at 11:23 PM Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Implement paravirtual apic hooks to enable PV IPIs.
>
> Very cool. Thanks for working on this!

Thanks David!

>
> >
> > apic->send_IPI_mask
> > apic->send_IPI_mask_allbutself
> > apic->send_IPI_allbutself
> > apic->send_IPI_all
> >
> > The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud
> > environment currently,
>
> From the Cloud perspective, 128 vCPUs is already obsolete. GCE's
> n1-utlramem-160 VMs have 160 vCPUs where the maximum APIC ID is 231.
> I'd definitely prefer an approach that scales to higher APIC IDs, like
> Paolo's offset idea.

Ok, I will try the offset method in next version.

>
> To Radim's point of real world performance testing, do you know what
> is the primary source of multi-target IPIs? If it's TLB shootdowns we
> might get a bigger bang for our buck with a PV TLB Shootdown.

The "Function Call interrupts", there is a lot of callers for
smp_call_function_many() except TLB Shootdowns in linux kernel which
try to run a function on a set of other CPUs. TLB Shootdown still can
get benefit from PV IPIs even if PV TLB Shootdown is enabled since
IPIs should be sent to the vCPUs which are active and will incur
vmexits. PV IPIs will benefit both vCPUs overcommit and
non-overcommit(which PV TLB Shootdown can't help) scenarios. Btw,
hyperv also implements PV IPIs even if PV TLB Shootdown is present.
https://lkml.org/lkml/2018/7/3/537

Regards,
Wanpeng Li
