Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B3223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="zz46TUdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9B3223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbeKPCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:24:15 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:38787 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPCYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:24:15 -0500
Received: by mail-ua1-f45.google.com with SMTP id p9so7202743uaa.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sh6o/Mn25PUR8M9CsY50B2LiJlattBZBHrkwcLg2viA=;
        b=zz46TUdOVA8FahIM4mTvdXqfBKYOdUOHSYM439zauh9ojHENV9Yxo/KjqsHEVDawir
         EcDlr0zg2BKHp6b38//bkoAZRXgigkyp+Zxb37mQ8eSxvL+LFA5f1mfypJ/P1II843+n
         OPNOuy2/kt7ZGCbo62QoewMGL8Ugni5ZpEGsyJ9A0UVAydTfLlYCp/7iaFgYhvjOtsT3
         DDgBfsU5QUhUs4oaj+62zTb+l6t/dIz8ektictWZHFP8jB8YAuUhZosMigc+2sLWE8dj
         oXqAi6BtbQ1oVxwBg7nKAdyamw0Znoh+VQGVz+q6tdb9mfewREziyxvRJrIJeCSYpdq5
         m/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh6o/Mn25PUR8M9CsY50B2LiJlattBZBHrkwcLg2viA=;
        b=K2vA5ymsU3TP5k7sUEEEmyRGTLB0+fjyPlwHMgZGTXYeoC6wJR/jENqRvkKUNt6h/O
         6mgvZxYt1Sg/D8AKzJjOQ8GpaW0IvpphK5YZhua8EzhIVdJ7JsA4oWwti0xgylGsIJJ9
         p8WuKXn/ULHEIQ2i3hA7bfgChPFvwTp61K/YoSgs6AElTPe0HCLbX3vB78lJ5pnj+aON
         NtMtV4Mu4J7xtErkeN0MlOkuEFYPXzymd5TtthKmZXrIN6qqqg/IqJ8nuEyH6rCbIHUT
         ueFAE7fpA3UPIW6VECkE++tta/FohuaZHZdLQHEFaTEAaDAfbD5rd6NRgXRcw3oNYhMu
         OhXQ==
X-Gm-Message-State: AGRZ1gJ8t7h4YmupyUFeZ/CCE7yivtxNB+BRxzYKVW6kavWYmp6GXnOO
        qAl9kG1NV6rV4ipNd+cR84SRIh3c/k21QmeEG+Bm3w==
X-Google-Smtp-Source: AJdET5d9dfMIBGA0CAz1ZmT9kDorwZY9DtKZgNh90OD9HdnmpTX4dLTwCXqNzxPUWt6KnQJruiq9tyXke4h7d+SDVeo=
X-Received: by 2002:ab0:4121:: with SMTP id j30mr3018112uad.65.1542298546292;
 Thu, 15 Nov 2018 08:15:46 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
 <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com>
 <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com> <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com>
 <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com>
In-Reply-To: <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Thu, 15 Nov 2018 18:15:22 +0200
Message-ID: <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Andrew Jones <drjones@redhat.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Thu, Nov 15, 2018 at 4:50 PM Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Nov 15, 2018 at 03:36:44PM +0200, Ahmed Soliman wrote:
> > mmap(NULL, 6291456, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> > -1, 0) = 0x7f46ea2a1000
> > madvise(0x7f46ea2a1000, 6291456, MADV_NOHUGEPAGE) = -1 EINVAL (Invalid argument)
> >
> > For comprehension, this is done on intel core i7-4500U CPU @ 1.80GHz
>
> Argh. I see what it is. Your config doesn't have CONFIG_TRANSPARENT_HUGEPAGE=y,
> so madvise_behavior_valid() returns false, which causes madvise() to
> immediately return EINVAL. We should be more careful in kvm selftests with
> our madvise behavior use.
>
> >
> > As for now I will comment the madvise line and the assert when writing
> > my own kvm self test. I think it wouldn't cause any trouble?, If it is
> > not the case, please let me know.
> >
>
> You may not need madvise() at all for your test, depending on what you're
> doing. So leaving it out may be fine. Reworking kvm selftests to ensure
> only valid madvise behaviors are used (and only when necessary), before
> adding new tests, would be best.

Confirmed it worked after CONFIG_TRANSPARENT_HUGEPAGE=y
I will send a patch soon that should make the self test check if
Transparent huge pages are enabled first before issuing the related
madvise()

Thanks,
-- 
Ahmed,
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
