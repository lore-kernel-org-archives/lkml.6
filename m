Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7F520850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIv0nKRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfAHDmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:42:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40165 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:42:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so1177958plq.7;
        Mon, 07 Jan 2019 19:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKJodC/fqmxyY09UdTJHPL4jkV8xwQpAkt2atTNVY2Q=;
        b=UIv0nKRp12x3kUmuPMkZwsIDZIcHhfsy7c1BgSo9daR+bVW1l3JfmWC48csOLvmzM4
         g2SsVPCmAwQnswmX3oM6NGZvR9OE4O2JglU1X4FZ8A+/H3uF+v54n1OMGCXg8qkJPHhL
         T7s61fhv6y/a8maTd/U85+KRWE3b/TZxwz3ct0xopNtAfT3oD6UCE+wvglfYRKOsjG9q
         uT2HWeX5Zkc2YElARz3yS3oIBT7gxSfk6vEzyvVaif+yvs+FB+gn4uRxCFYBwD2+m9VS
         feHAkvGuye3BxqQl2XS8rhb2GRy/hWxrdB8WNMjxQzGaT8hxHT0oprpblNkMCBlc0wlq
         VF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKJodC/fqmxyY09UdTJHPL4jkV8xwQpAkt2atTNVY2Q=;
        b=EdJSXE8X3fpnBPV16DwWwIvlPsOtxWKWnxuSAptwm/0Q/Vt9lzomN72xDSmyijh1WP
         b4hC0IP/Kqw6QNU1U35saeOSTJ9M0uf05o//bs+b3/K2z49eocmwSgzQkLQMHButPkEO
         T0whE8FHzGC1DqtdKjZGOZDebYCPZybMav88BVUUlzvXJ9btmz1S6HjSB2LTpSG429BD
         KikjEHmq7vq0uSKki106s1DRofVBHOxxw0EAgAJROltltf9r0WQAcpThzozyNhhGZILh
         MkCINlNsPx+N8eXflqxPB+q1WmJuVDawb8/dDuWGVhkXy+NdhGxqpUMnL7JeATkhcjMC
         o75Q==
X-Gm-Message-State: AJcUukf9qOgDCzQckLTuEiJvhTteqLwzJ7gbbM2V7GO0bIxmL086493k
        u0RkVTL/IirOFGDmlcY3p5QlHY8ukNjNScQXK6Y=
X-Google-Smtp-Source: ALg8bN4ngKnkpiDqIKFMSt3Unfc3HkgEdj8Z7LCdN89jRUf+BkM4KYH/NFezHtJ2V+29MSaW+etYIlyex4ESR1jtnTA=
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr150616plo.162.1546918936825;
 Mon, 07 Jan 2019 19:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-12-Tianyu.Lan@microsoft.com> <20190104161235.GB11288@linux.intel.com>
 <CAOLK0pzPe3agXCFrvHt9Qa_kRVfdtYeKorbRL2waOo29f5wcyw@mail.gmail.com> <d434edb8-5f09-7331-c89d-9b78907e896a@redhat.com>
In-Reply-To: <d434edb8-5f09-7331-c89d-9b78907e896a@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 8 Jan 2019 11:42:05 +0800
Message-ID: <CAOLK0pxrdWZ6RAJROw0cyfexjZnKqSsCrm-jUD=wUHWvWV47kQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] KVM/MMU: Flush tlb in the kvm_age_rmapp()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo:
               Thanks for your review.

On Tue, Jan 8, 2019 at 12:31 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/01/19 04:42, Tianyu Lan wrote:
> >> I'm assuming you're
> >> clearing young to avoid the flush in kvm_mmu_notifier_clear_flush_young(),
> >> but keeping that flush is silly since it will never be invoked.  Just
> >> squash this patch with patch 10/11 so that you can remove the unnecessary
> >> flush in kvm_mmu_notifier_clear_flush_young() and preserve young.
> >>
> > The platform may provide tlb flush with address range as granularity. My changes
> > are to use range flush when it's available. kvm_mmu_notifier_clear_flush_young()
> > is common function for all platforms and most platforms still need the
> > flush in the
> > kvm_mmu_notifier_clear_flush_young(). I think it's better to separate
> > flush request and
> > "young" from return value of kvm_age_hva(). New flush parameter I
> > added in the patch 10
> > can be changed to a pointer and kvm_age_hva() can use it to return
> > flush request.
>
> There are two possibilities:
>
> - pass a "bool *flush".  If NULL, kvm_age_hva should not flush.  If not
> NULL, kvm_age_hva should receive a true *flush, and should change it to
> false if kvm_age_hva takes care of the flush
>
> - pass a "bool flush".  In patch 10, change all kvm_age_hva
> implementation to do the flush if they return 1.
>
> I think I prefer the latter, in this case the small code duplication is
> offset by a simpler API.
>

From my understanding, this means to move the flush in the
kvm_mmu_notifier_clear_flush_young()
to kvm_age_hva() and do flush in kvm_age_hva() when young is >0 and "flush"
parameter is true, right?
-- 
Best regards
Tianyu Lan
