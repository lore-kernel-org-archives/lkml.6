Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D6CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A54A2538F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrfZe9SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A54A2538F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754661AbeGBMIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:08:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43275 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbeGBMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:08:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so1710730oib.10;
        Mon, 02 Jul 2018 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7GGwVQu73IvJg3JvDEzagTHBWvRnCgzrqAshi/n6wg=;
        b=JrfZe9SSnF+RA5V+/w5M34NSUyJqOiokZkDcowNBejwNowFnfksxt1XjFh1rx8f4ee
         RbT4QHL/2d/brjE7I0EtS77nA2kYU7aJeOWuCmIr30n+8oyQCvnIlGAQmeCqzZti/6UV
         zZGvy4KYEqgLI5R2Aftl9X3P/1ObTG2XYIukWQbNow84ukPZlqIgJ3N9RJk+2iaRAYwq
         dbiqpo2PFA8fKxfv5C52xPlfV7mKgigzjxjO/hQu1iaCy2MB3anmPIjNsb0jOg6PZ8B1
         9NCTBTEGvXRPt4KoRPE40UHYnSN20cbEKms/8jPWZz7ylL49UzhWif4MMhc/Pj25G+tM
         4mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7GGwVQu73IvJg3JvDEzagTHBWvRnCgzrqAshi/n6wg=;
        b=kbjARKy3q9kcYc4jTPnFm5bnyrUe4qdHcCYsMwHNOV2sFPCcHkzdxGOa+RYiOUxS0i
         OPhiyevhJHXrHcKjQFMktzNUSumcFxdat8+d7MUwRpPLcY9Q2ASItg17oGBH3E94q8I+
         aCA3gCSvHiHlrvUcngMp29o9fy+SY6uHXSp0mWImdmoxH5/RH4n2WsEOuLWMLDquFq4E
         pl0nP4+L2BkZLb+rYUJYpFS7AghxBR9bo6Lkl20MjAd08ziDR8QLxsQR4xWaxD9dwEgU
         oYUYtKWbNQ1m1jdAZpADn4N3qmGNY9PJYpHl7IhkwdFS6Ls3sgbfiaHbrTImWMnUk/MZ
         i6yg==
X-Gm-Message-State: APt69E0gX/Sjqli7heYsxkFvn6kWTmDs8pz9aDiZcstTHXOjcKW/Oa0Y
        TZ4Gmqtwgz3d0ZoekQNAqJ3LO/lZUh4Sr6zQ7dg=
X-Google-Smtp-Source: AAOMgpctYB0UTo0dSGGJ63mCmlEadOGP7CxZ6BoXiqluQuQWPMkBwM3x6Gz3CO4Csk1yaxlj5XanE1jkusSkhD0ol3E=
X-Received: by 2002:aca:68a2:: with SMTP id o34-v6mr14560863oik.267.1530533330360;
 Mon, 02 Jul 2018 05:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
 <1530526462-920-2-git-send-email-wanpengli@tencent.com> <9e886415-2b68-ac1d-aadb-b44695ab0b21@redhat.com>
In-Reply-To: <9e886415-2b68-ac1d-aadb-b44695ab0b21@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 2 Jul 2018 20:08:40 +0800
Message-ID: <CANRm+Cx1pAg_L7gPvdqoM7Aw7JYFhN7h9z7xXPHKnkq4JXxHdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: X86: Implement PV IPI in linux guest
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 at 19:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/07/2018 12:14, Wanpeng Li wrote:
> > +     unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0, icr = 0;
> > +     int cpu, apic_id, ret = 1;
> > +
> > +     if (cpumask_empty(mask))
> > +             return true;
> > +
> > +     local_irq_save(flags);
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             apic_id = per_cpu(x86_cpu_to_apicid, cpu);
> > +             if (apic_id < BITS_PER_LONG)
> > +                     __set_bit(apic_id, &ipi_bitmap_low);
> > +             else if (apic_id < 2 * BITS_PER_LONG)
> > +                     __set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);
> > +             else
> > +                     goto ipi_mask_done;
> > +     }
>
> CPU masks are themselves bitmaps made of longs, so you should be able to
> avoid the loop here.

As we discuss offline, loop is needed since I need to convert
processor id which is allocated by OS to apic id.

>
> > +static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +     if (!__send_ipi_mask(mask, vector))
> > +             orig_apic.send_IPI_mask(mask, vector);
> > +}
> > +
> > +static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
> > +{
> > +     unsigned int this_cpu = smp_processor_id();
> > +     struct cpumask new_mask;
> > +     const struct cpumask *local_mask;
> > +
> > +     cpumask_copy(&new_mask, mask);
> > +     cpumask_clear_cpu(this_cpu, &new_mask);
> > +     local_mask = &new_mask;
> > +     if (!__send_ipi_mask(local_mask, vector))
> > +             orig_apic.send_IPI_mask_allbutself(mask, vector);
> > +}
>
> Likewise, here it should be possible to check the highest bit in the
> mask before copying it.

__send_ipi_mask() has already handled sparse APIC ID and > 128 APID ID
scenarios.

Regards,
Wanpeng Li
