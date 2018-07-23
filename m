Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DECB20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCd5d5dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DECB20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbeGWHWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:22:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42021 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeGWHWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:22:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so31235774oib.9;
        Sun, 22 Jul 2018 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FP6V1Gj4Zn4hDVESE3XmkAUY7Ym9mMOGijI3YtaZ3A=;
        b=vCd5d5dLotM37/bAC/cx+0GgeW5LLWZlI03Apj2rw8JY5jaBZFEh11miSVt2l+iYpd
         Ws6kw3jNjcQ9HJlxTyQVMjpsZ75WRLV6GP40ohnEwSS9uq1GzuTRtdpezxqkeir0vjP5
         19PGEhIFC+EmtGScXlcTRfkyjSiNl100WgrDk/oYefqXSo6NorLIzBiZbqOMcR5WrcB6
         DyXaHkPvSSVO6Xdqnuh4enaUsH6l+uqVzIbZloEVTGu1sqEHpAV872uPJnm2rScCAHpP
         6h0j10rOl/LdCFQ+jS1hGIhJWrbd9jbWPvn6XIBOE/+n2ZC/b6I//WkkgfUkjLQhPaFn
         ovnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FP6V1Gj4Zn4hDVESE3XmkAUY7Ym9mMOGijI3YtaZ3A=;
        b=GB7w44m+1SZVqHVG0QGhl6l8rGmN1oPi1oq0rg6pQJ9Cq7kUqZUt0v6wNXHmcKMABY
         GcsxHQ4CAdGuZcwLANLsY81T4JFpSQ+QrpoiiaSDZuUH8slGXnXmXlaA+RmAzTkXcee+
         qDseI2GXYdXHhtlwMFQkxVqBsJ0kQTFYRdOPohMoVQMkZPKSHW+aBnC0PG0CAENJqUmU
         w+qM3KZuMFDSlrTu3xavdvNL1Rjt+h5sX4FkxhszGyFMvAft9QerWQ+pgdLLxzudEl+w
         Du7ouygdEEHw2yl8mV/zn7F4fjM5Lsl5cvsMGuSyrdCsM8KyO/A8lmJM2iR0xEP5A++X
         jk1A==
X-Gm-Message-State: AOUpUlFl3GALRLNCphSeM63uOsYB77h0pKhs3InV60L3554IbyVeI1pK
        MnBcLwb3yNw2we3B6hVa4akMfyZWqgTW0U6K3AE=
X-Google-Smtp-Source: AAOMgpfRM0Tr6HvAXDqiR/GVJLvWc9aMbcgF3AC5eyiVrtbK8AUNYSH401J2+LLRO/40NT/zU0WCqUU9lzR+6Lnjaxw=
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr7747002oif.119.1532326948482;
 Sun, 22 Jul 2018 23:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <1532104133-15777-1-git-send-email-wanpengli@tencent.com>
 <ea83d8dd-2c9b-c3fb-c88b-f48ad1d06240@redhat.com> <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
 <CANRm+Cwt=eUcfu7oZr8U5JT9rKS9wMFoHe+hwfzF88xqrFKD0g@mail.gmail.com> <54c97f32-4b56-bfdd-c1a6-614988806ece@redhat.com>
In-Reply-To: <54c97f32-4b56-bfdd-c1a6-614988806ece@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 14:22:20 +0800
Message-ID: <CANRm+CzSpa_yXYMxorf3kbY8_Xv47gCT4cP8vZFq07gKf2D7LQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: X86: Implement PV IPIs send hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 at 14:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/07/2018 08:10, Wanpeng Li wrote:
> >>> On 20/07/2018 18:28, Wanpeng Li wrote:
> >>>> +a0: ipi_bitmap low 64 bits
> >>>> +a1: ipi_bitmap high 64 bits
> >>>> +a2: the lowest APIC ID in bitmap
> >>>> +a3: APIC ICR
> >>>> +
> >>>> +The hypercall lets a guest send multicast IPIs at most can handle
> >>>> +128 vCPUs per hypercall on 64-bit machines and 64 vCPUs per hypercall
> >>>> +on 32-bit machines.
> >>>> +
> >>>> +Returns 0 if successfully delivery the IPIs and 1 if discarded.
> >>> This description does not mention what happens in 32-bit mode.
> > Sorry, I think I mentioned "64 vCPUs per hypercall on 32-bit machines" above.
>
> Yes, but the description of a0 and a1 is not accurate.  Something like
>
> a0: lower part of the bitmap of destination APIC IDs
> a1: higher part of the bitmap of destination APIC IDs
> ....
>
> The hypercall lets a guest send multicast IPIs, with at most 128
> 128 destinations per hypercall in 64-bit mode and 64 vCPUs per
> hypercall in 32-bit mode.  The destinations are represented by a bitmap
> contained in the first two arguments (a0 and a1).  Bit 0 of a0
> corresponds to the APIC ID in the third argument (a2), bit 1 corresponds
> to the APIC ID a2+1, and so on.

Thanks to the great description, I will fold this to the next version.

Regards,
Wanpeng Li
