Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD60D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxbWSm59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD60D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJHQ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:28:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42254 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:28:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so7924622pfn.9;
        Mon, 08 Oct 2018 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvRdKkwK+I3lOz3MeYG+1PNEz6XD60qqpE1+d3IPDow=;
        b=mxbWSm59/Pw4GF+7n31cbXZAQrpY558z/dUc8XMeTCHWQsicw5EyIhsuzgiOk+OKHo
         DTsedc9KIeqdw3VpR7hPKyv/lrbgfJZN4HSKUVHAWp6z9MHNc7tD5miIyFrYMODhXm8Z
         McIT/d6u3kCowXAiBsl6lrpunnIyizA9qLmH5WuS8Xoj3WzilVUfgYJH321nAd+K/kvX
         4c9MWHu0AuRlkrHvnKPwAKIEiB+uFKkOBkORpAmc6MMd06Mjso4MqQascPuaCiIBZb1e
         4zfnpH1fSKRvl//hZMkoN429cHKPueqlJl2nN8tS0JldouFX7IcuSozUgEzLHZ521Y/K
         NsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvRdKkwK+I3lOz3MeYG+1PNEz6XD60qqpE1+d3IPDow=;
        b=rk/wO6Ny6t8HoTjNinVfJSo4a+FLoCJ4msaj98rIW7At4J4yY/sSa0Hy5ZDnkqmjPF
         fOHz9VBDzDkkV6HgkXcVo37uIOUfRL6yrzZfNhqpCK/6dw4rrmXfmHOjiSODF30/WxQz
         t5zCnBFNJc2pz2Zj+lLSFJSWrdtDUgQD4frU84Y+8po9wmmSGlO8JekemSXWl3Bg7gYp
         6MF86mQbxB2kJ9u3oowe8w7h/JpOCt4yxxo4R81gkz7niMhF9B31c6Nh2iTKuZyzxYZm
         /LMrjJVdC71Pp9WLCDPcfse37645lPsM66U6ajgaNMS8ZFi59/FzNduUYxUnC7RixY9v
         RSig==
X-Gm-Message-State: ABuFfojWfAb8MbKnY0Gxf/1YibPFAuWIFsdMwzRjssz4DeyiH3BQzGXL
        MVp1H2EWQbUtl/b7fjE5krp1h4mEuc2WAc67Yic=
X-Google-Smtp-Source: ACcGV63Q2pcopijspaeMJXXGZyjbdAbYfpGILNQynfrkKAOLixIRXOyYDcKRGBklEFa0UccPibqc9CbuZWS4eat+PcQ=
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr24143896pfd.106.1538990259093;
 Mon, 08 Oct 2018 02:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
 <20180927034829.2230-3-Tianyu.Lan@microsoft.com> <2ab49b6e-59d1-1b1f-b533-85e5bc49dd85@redhat.com>
In-Reply-To: <2ab49b6e-59d1-1b1f-b533-85e5bc49dd85@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 8 Oct 2018 17:17:28 +0800
Message-ID: <CAOLK0pykDDmXtDwGCMeokoFrYjd+qVrzFSxVi0iiq1=Z+_K9Pg@mail.gmail.com>
Subject: Re: [PATCH V3 2/13] KVM/MMU: Add tlb flush with range helper function
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
        kvm <kvm@vger.kernel.org>, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, Jork.Loeser@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo:
              Thanks for your review. Sorry for later response due to holiday.

On Mon, Oct 1, 2018 at 11:26 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 27/09/2018 05:48, Tianyu Lan wrote:
> > +
> > +     if (range && kvm_x86_ops->tlb_remote_flush_with_range) {
> > +             /*
> > +              * Read tlbs_dirty before flushing tlbs in order
> > +              * to track dirty tlbs during flushing.
> > +              */
> > +             long dirty_count = smp_load_acquire(&kvm->tlbs_dirty);
> > +
> > +             ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
> > +             cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
>
> This is wrong, because it's not the entire TLB that is flushed.  So you
> cannot do the cmpxchg here.

Yes, nice catch. Will update in the next version.


-- 
Best regards
Tianyu Lan
