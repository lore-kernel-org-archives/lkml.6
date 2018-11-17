Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3335C20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="DZqhi2jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3335C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeKRGBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:01:53 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43643 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:01:52 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so9425409uaa.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTrnDUNKyHpyhiGL04RKJoPYdkUOWMG77u97HirAZPs=;
        b=DZqhi2jpx5GTAcx/nq/ntY+vk8TTxLrLV47/3Ztisc9mpglq/1WtsbmdKPECvepeRR
         cUYdL2iPB01mvKzfleZwVv8mLfSwe6CP2dsq4VNZXXYRYpEZapHpKUmjh4xg7bozvSUp
         1dDobxD1d/f9Prmk4yEXJTgvZ2fvcOz8Qfs2dJpNqkNzvaU+WYTUjtaPQSCn4vK9UsfT
         k1Lgx4OE5rkAFXXgBQUPZjXn3jTLYeYIDBD4MBN6nzb0EvP5XtrM9oKxi4dOcyN0RsAp
         pKyaDw3EDc4PerIcgW3Y9KHAB11iHkKvAIbkenu7R6LwWSfOGAab0jVV186vMpp8Ool+
         qgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTrnDUNKyHpyhiGL04RKJoPYdkUOWMG77u97HirAZPs=;
        b=nNtGgLtReov2wBdw/WKy6c+YVbe6JRKSWLKBi1kL12bqkemMv2g0NOPxSygMsqJAJ+
         D4/Bia8JK4Yt7Y5Lrcz/uP030L5shNw1IQWqd0Gakm3/8hENyJPBtCiTmWd38131VXXt
         C1otQnmtx0pjicddznD9+9IM8OvevNcI3/wWukdNTlOsizSGgwqjQZtlfPEvCODntV/D
         671AqXLwN5LIEDr8yTo/D7EMqyngQvPOTRUE7S7/0CBpzV3/z0JpZXs5uglcCJeodSQM
         Dl/CRNqm0+z1nhaZh12j+fnoX670sIsfxChd2Vka9EYeUbh5w0RXVLj9vjanitlftrYd
         C9Jw==
X-Gm-Message-State: AGRZ1gJKz+j6pasIhKTimOcye6jkQ1tj4vrV2XW445sQ2aQMh4/vrrDI
        YyBSXtN910xRzPDSPeBRky26Lj1ZrWznulgOxY5SVw==
X-Google-Smtp-Source: AJdET5ffJgsOufbPxPMzYSh/eu65cdJHz895yQ0X/AFop5Ey+4QWma89CrmjEJ+8hUjJLwvWZLatQXLgaFP3MzuV994=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr6884326uae.75.1542483849905;
 Sat, 17 Nov 2018 11:44:09 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
 <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com>
 <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com> <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com>
 <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com> <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com>
 <87efbmqore.fsf@vitty.brq.redhat.com> <CANBxJ=FDOpySC7w1fVbWCOy+ASO=A7WcsFiDJEcGtzWbYM6NqQ@mail.gmail.com>
 <8736s1qh3d.fsf@vitty.brq.redhat.com>
In-Reply-To: <8736s1qh3d.fsf@vitty.brq.redhat.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Sat, 17 Nov 2018 21:43:43 +0200
Message-ID: <CANBxJ=FX01h6OZt=zApu6tz_enJxg_kXN+yb8_z52TzucU7H7Q@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 3:37 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ahmed Soliman <ahmedsoliman@mena.vt.edu> writes:
>
> > Hello once again,
> >
> > I noticed that there is still more problems with kvmself test (at
> > least on my machine)
> >
> > Any test that would successfully reach the guest's code immediately
> > VMexit by a shutdown.
> >
> > $ ./vmx_tsc_adjust_test
> > ==== Test Assertion Failure ====
> >  x86_64/vmx_tsc_adjust_test.c:156: run->exit_reason == KVM_EXIT_IO
> >  pid=8499 tid=8499 - Success
> >     1  0x00005604f07bd36c: ?? ??:0
> >     2  0x00007f5c0dc53ae6: ?? ??:0
> >     3  0x00005604f07bd4b9: ?? ??:0
> >  Got exit_reason other than KVM_EXIT_IO: 8 (SHUTDOWN)
> >
>
> Hm, this is weird. Do other KVM users, e.g. qemu work on this host? Are
> you sure this happens on the first VCPU_RUN invocation?

Yes and I have just tested:
   qemu-system-x86_64 -enable-kvm -cpu host,+vmx -m 2G

And Linux as well as android for x86 booted up. Also I kinda have my
kvm tests that works
but they are not built on top of kvm selftest api.

> Could you try doing
>
> trace-cmd record -e kvm  ./x86_64/vmx_tsc_adjust_test && trace-cmd report
>
> to see if there's anything suspicious?

Yes, there is a triple fault induced shutdown probably during EPT handling:

 vmx_tsc_adjust_-17638 [001] 15628.729863: kvm_update_master_clock:
masterclock 0 hostclock tsc offsetmatched 0
vmx_tsc_adjust_-17638 [001] 15628.730820: kvm_write_tsc_offset: vcpu=5
prev=0 next=18446733817569215369
vmx_tsc_adjust_-17638 [001] 15628.730822: kvm_track_tsc:
vcpu_id 5 masterclock 0 offsetmatched 0 nr_online 1 hostclock tsc
vmx_tsc_adjust_-17638 [001] 15628.730911: kvm_fpu:              load
vmx_tsc_adjust_-17638 [001] 15628.730913: kvm_update_master_clock:
masterclock 1 hostclock tsc offsetmatched 1
vmx_tsc_adjust_-17638 [001] 15628.730954: kvm_entry:            vcpu 5
vmx_tsc_adjust_-17638 [001] 15628.730974: kvm_exit:             reason
EPT_VIOLATION rip 0x56545f0b8760 info 83 0
vmx_tsc_adjust_-17638 [001] 15628.730976: kvm_page_fault:
address 180560 error_code 83
vmx_tsc_adjust_-17638 [001] 15628.730989: kvm_entry:            vcpu 5
vmx_tsc_adjust_-17638 [001] 15628.730992: kvm_exit:             reason
TRIPLE_FAULT rip 0x56545f0b8760 info 0 0
vmx_tsc_adjust_-17638 [001] 15628.730993: kvm_fpu:              unload
vmx_tsc_adjust_-17638 [001] 15628.730996: kvm_userspace_exit:   reason
KVM_EXIT_SHUTDOWN (8)
vmx_tsc_adjust_-17638 [002] 15628.739237: kvm_hv_stimer_cleanup:
vcpu_id 5 timer 0
vmx_tsc_adjust_-17638 [002] 15628.739244: kvm_hv_stimer_cleanup:
vcpu_id 5 timer 1
vmx_tsc_adjust_-17638 [002] 15628.739244: kvm_hv_stimer_cleanup:
vcpu_id 5 timer 2
vmx_tsc_adjust_-17638 [002] 15628.739245: kvm_hv_stimer_cleanup:
vcpu_id 5 timer 3

I will try to dive into them after my midterms are over(ends tomorrow)
but I would need to verify that someone else can
reproduce this, I tried bisecting but it seams that this bug was there
from kvmselftests commit one
(rebuilt kernel, kvm and the kvm selftests each time).

Thanks,
