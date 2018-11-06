Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB31C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53192086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUShrcVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53192086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbeKGBsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:48:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36904 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbeKGBsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:48:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id p35so3244991qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNnk4vwsDBIehwNzIbuyDGRO7VJ7ihL999Lrg531tkw=;
        b=rUShrcVORcA/rTeufimKWFsm1vJBVLz7ScUwOpf1FIgsAuT1Z498MLqeHLgeIznwRy
         IsMtBW5ML1LL6vF8uKCX9Q8VmVLt0+rDGJH8w1eTO0ldg49Ctq0rjrdby3d3k8DDhT7F
         ABq/yBElF1jEMN9L1kCEyuAcPTHhu9WKAd1ZmGv6DXoZXBplNQS+MJ7H4CPrFkrXCjYI
         dfN8cUH2HwVYnAKKAXdvN60WNsm86lfV+RuC6QgtZQSiUzGdnp/fy3hGR11IKChvHF22
         1cNz7fy4xC0Kx8MjPk8dQMiCHNXIooGigxmt6Bp2RrmpaM27UPB8LiA+4kr539wXoV05
         Dyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNnk4vwsDBIehwNzIbuyDGRO7VJ7ihL999Lrg531tkw=;
        b=MX/151yQ8GaaCOo2OUAq5zStcmBX8U9ubW4h6xXGQpNBqnVPzCjHgnIfUIhD4LtLY6
         ln5cKzmBBFKoo76zck0BdmLYkKjLUhbL1NwChFQW6vBgjqof7TH6Qe+ircSS9qWZJ9VI
         0bhS0PhX5mHYPIwH7wy1j+nSJsRPBBWPt2+u+Vw2Ys/jtxUJSlrfiq/LXizY9TZyctTh
         NPTuogZkQa8J9IDoBaVmMuJWRskfDPFe2FsioJ6WRa/OuZLfh8Or0XUbyh4dLdKKFRb5
         o3Ziu1nNzcKdTB0YRNnIHOxdRInnNnUi67AxxszHULBXzpx0/dblX0dRhd707PFceDn5
         gVvQ==
X-Gm-Message-State: AGRZ1gIfqTdsed1R4h43Jthg4gwFM3y4MxiuN+QNhzPuZ3PJUS73XKLb
        1IQGGXNhNeN9xiC7pnl3RpPjog==
X-Google-Smtp-Source: AJdET5eN0ByA+xjMa1wq92nFD77BiXJAYp/fKX4pdQjb5wpR17a5SAgMiQgBaDTzdjkk+Klaz3tRJw==
X-Received: by 2002:a0c:b3da:: with SMTP id b26mr14516354qvf.138.1541521367849;
        Tue, 06 Nov 2018 08:22:47 -0800 (PST)
Received: from brho.roam.corp.google.com (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id u11sm6530624qtc.61.2018.11.06.08.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:22:47 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:22:43 -0500
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181106112243.6fabdb0f@brho.roam.corp.google.com>
In-Reply-To: <876d5a71-8dda-4728-5329-4e169777ba4a@redhat.com>
References: <20181029210716.212159-1-brho@google.com>
        <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
        <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
        <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
        <20181030154524.181b8236@gnomeregan.cam.corp.google.com>
        <71d52e0f-ec40-d423-4dd4-e3aeb3730166@redhat.com>
        <20181102163254.04be68b5@gnomeregan.cam.corp.google.com>
        <876d5a71-8dda-4728-5329-4e169777ba4a@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 at 11:19 Paolo Bonzini <pbonzini@redhat.com> wrote:
> > void kvm_set_pfn_dirty(kvm_pfn_t pfn)
> > {
> >         if (!kvm_is_reserved_pfn(pfn)) {
> >                 struct page *page = pfn_to_page(pfn);
> > 
> >                 if (!PageReserved(page))
> >                         SetPageDirty(page);
> >         }
> > }
> > 
> > I think we want to SetPageDirty for DAX, so making PageReserved be true
> > for DAX seems like the way to go, or we'll need more KVM-specific
> > changes.  Apologies is this was discussed in the previous thread on this
> > topic and is redundant.  
> 
> Isn't it the opposite?  We want SetPageDirty, so PageReserved must _not_
> be true.

You're right on that, I had it backwards.  The other DAX work is making
it so that DAX pages are not reserved, so the only extra '!' was in my
head.  

Thanks,

Barret

