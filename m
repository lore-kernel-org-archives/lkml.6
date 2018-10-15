Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A2C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA2020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOp9QJ61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA2020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:53:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeJOUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:53:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so9665334pff.2;
        Mon, 15 Oct 2018 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMOQF8H8m8yaVhwd1TW7856+OBXlY9AQ0KamvEV9FMc=;
        b=oOp9QJ61XuCguPf+BfVtwqyU6CC08WIAC8kztQipEad40yipvl9vUkA7mTgAGaQZRc
         h5d13ulONAxH8PLYgboFmEgKUVRrEGY3QhYl0wqaNtwPuvt2O986EQ18wx0a/vJsT/Ic
         0doUhRZnleoLJ2UCtYnn3h3Ehnv0NpvF46rC222nidmKtook/Mqws4ALl6LYB77S507h
         WPFYAEZJo73ZZVyTNMOXc0MNqh/nq/rnom5t5DU1TxCZaeNytBB7J9HFW7nCOi+K5f0h
         6ApWO7MV4xtVWrBNYAtaAS1f3nIknJ0nJBeTJn6K9hOBcn4ruTKGfKT3shbp12baOuJE
         cSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMOQF8H8m8yaVhwd1TW7856+OBXlY9AQ0KamvEV9FMc=;
        b=QE1textOIorp5MOkK+NjwylTHuyaVscsOLfiyvcBJjFKVDSYLJoMHCpF7yeDRP6XGx
         G8Ve+t/xjhs4y5+2IxdjjMiaFV332bRl4P9YNw7rLWygldgw0DKo5E3aD6N9rDgVkXmL
         JaMMyUDMjo2GZypUgCwsSoX6ZXyKb73nQ4h7Qg+hfssP8ULB7tzsFqis2VS9G1oGEKIg
         MF8wvXbUBIfrVX/un+pGS5qGGvyXJU5qAoEAFfz6Ilm/AVzjTtK8uuDE5jvLI24DAPWs
         1Qckx516YClceOJ5weVbpE83B6LNT8lewxlgVRGWUsBMD+3xXaqZC6tcmWqI1r8RRGQc
         pXCw==
X-Gm-Message-State: ABuFfoge3xxcIF1Xmqjwy77cAtHoATyouNSIVP/1pllOzjs9rMrhd8rR
        mMeezCoxklK7jXH6ES8j/f0rppnv6E9V6WAmOhc=
X-Google-Smtp-Source: ACcGV60PkEUUAi1iLjZc+TPVceYFRxSMd7kyYfXGea9aYUXwa5W2Kp2zgX0cF1EZBXoTOt9no6flqjXWzl7ZdDmNaJM=
X-Received: by 2002:a63:6bc2:: with SMTP id g185-v6mr16348478pgc.25.1539608924476;
 Mon, 15 Oct 2018 06:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-8-Tianyu.Lan@microsoft.com> <bdb05a65-f849-7346-61b7-99c444050254@redhat.com>
In-Reply-To: <bdb05a65-f849-7346-61b7-99c444050254@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 15 Oct 2018 21:08:32 +0800
Message-ID: <CAOLK0pzrzydk9rk-Jijh=rA0oLkSafEqmumY2NSxe44J2=zv2A@mail.gmail.com>
Subject: Re: [PATCH V4 7/15] KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        devel@linuxdriverproject.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo:
              Thanks for your review.

On Mon, Oct 15, 2018 at 6:04 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/10/2018 16:53, lantianyu1986@gmail.com wrote:
> > +     bool flush = false;
> >       int i;
> >
> >       spin_lock(&kvm->mmu_lock);
> > @@ -5654,18 +5655,27 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> >               slots = __kvm_memslots(kvm, i);
> >               kvm_for_each_memslot(memslot, slots) {
> >                       gfn_t start, end;
> > +                     bool flush_tlb = true;
> >
> >                       start = max(gfn_start, memslot->base_gfn);
> >                       end = min(gfn_end, memslot->base_gfn + memslot->npages);
> >                       if (start >= end)
> >                               continue;
> >
> > -                     slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
> > -                                             PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
> > -                                             start, end - 1, true);
> > +                     if (kvm_available_flush_tlb_with_range())
> > +                             flush_tlb = false;
>
> This should be moved outside the for, because it's invariant.
>
> > +                     flush = slot_handle_level_range(kvm, memslot,
> > +                                     kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
> > +                                     PT_MAX_HUGEPAGE_LEVEL, start,
> > +                                     end - 1, flush_tlb);
>
> ... and this should be "flush |= ".
> >               }
> >       }
> >
> > +     if (flush && kvm_available_flush_tlb_with_range())
> > +             kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
> > +                             gfn_end - gfn_start + 1);
> > +
>
> ... and this can be just if (flush), because if flush_tlb is true then
> slot_handle_level_range always returns false.

OK. Will update.

-- 
Best regards
Tianyu Lan
