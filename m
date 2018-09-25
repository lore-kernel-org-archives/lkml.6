Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DC62083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuOmBHib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DC62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeIZCWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:22:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeIZCWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:22:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so14744617wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LiZhOqz7StL5Ja1ofBA4O+CSFGJDKQQ5BcXyQrpm6lg=;
        b=XuOmBHibBTCoPO3JBlnCGuET8ceYE2Qe8kriKUPWGsQx2CD8IKGFdu128pzlltfSVy
         3qDVrNXjDIqEA7NKHTVJzsyVOM1gsjTRuQ2CPe+NhMvYD32KJyL6tSQhCzcG78as97JQ
         J82sxYDF29ugqSuFFNraczy7sNPAVQtQbD4faNsontp/Q/CymfALM1MgvFIQtsOxUjBs
         dkFqoaDMimV/oMnM9ckUdqKr3KktSONM/gF7+mJqeT1Wi6s8ClX0lUgn7/5B/wOoT21I
         jJBqUVrE72C4Wpvf6ERL/ofupV1RKUp5qAjjtJzdlp2NPAPCUhcTQHr4dhwk2Yodd6iR
         1NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LiZhOqz7StL5Ja1ofBA4O+CSFGJDKQQ5BcXyQrpm6lg=;
        b=F+fjvybGJZB/ljdUJ988auOHcTVdm0a9P+CPr2f30jtr5uAOxk1ft+GsFGqdWq/FrA
         rPJATkrY5O2CQngoTHCSRMZ1Iuy5NjXddFlYb3b47S2BBY0EAVvhdQrmZ1OxoiE7oMk7
         keoByvgkDxwHQWPmz/x6yTp7X9bVQMD8x3ERONDWmCiBnnQMNntz/dGiPkhtW+NKMoDE
         JWCdP00tWU66nC0MUFZycl4lRj9bnzvcLoqZx/hoWK8bl6NHp6rJps0uNP8LRAnOHLNj
         hGXlDJkdvIFpEJJcFuQYw7VK8rc/oD+Z4w2FcaKOH8sy1L2RgqloZG4FzM2GKU8Pm5Kc
         HFJw==
X-Gm-Message-State: ABuFfojJiJPm4cVCZG5gQqKw4GbmPsWeqVCDsIDDVR4eM3iazV3iDuYB
        G6X42N8zsByxlI+Ioo+cl68=
X-Google-Smtp-Source: ACcGV63Ctn6BGoaJ78s+rSLB/mCL+yQuT0HJqqcLO0HybgvTAGLpRnvcqlFtKuxuh3fBt8cZ6AIjeQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16-v6mr2142887wmc.36.1537906376290;
        Tue, 25 Sep 2018 13:12:56 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id x16-v6sm1982387wro.84.2018.09.25.13.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:12:55 -0700 (PDT)
Message-ID: <a75bc7c92bd9806a56ec2736218dec15b5cf7eba.camel@gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Sep 2018 23:12:53 +0300
In-Reply-To: <20180925195757.glglc6q3ghn3dhs5@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
         <20180920170306.9157-2-yasha.che3@gmail.com>
         <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
         <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
         <20180925195757.glglc6q3ghn3dhs5@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 19:57 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Tue, Sep 25, 2018 at 10:30:52PM +0300, Yasha Cherikovsky wrote:
> > On Tue, 2018-09-25 at 17:45 +0000, Paul Burton wrote:
> > > How about we:
> > > 
> > >   - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and
> > > select
> > >     it for all existing pre-r6 targets (probably from CONFIG_CPU_*).
> > > 
> > >   - Change CONFIG_GENERIC_CSUM to default y if
> > >     !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.
> > > 
> > > That would avoid the double-negative ("if we don't not support this")
> > > that the #ifndef's currently represent. It would also mean any future
> > > architecture/ISA targets beyond MIPSr6 automatically avoid the
> > > instructions.
> > 
> > Thanks for your feedback, I'll start preparing v2.
> > 
> > Looking in arch/mips/Kconfig, some CPU options start
> > with CPU_SUPPORTS_ and some with CPU_HAS_.
> > Which perfix should we use here?
> 
> That's a good question :)
> 
> To be honest I don't think either of them is perfect, since what we're
> really describing is what's supported by the ISA that the kernel build
> is targeting - and in theory the CPU we actually run on could support
> extra things.
> 
> But considering it I think CPU_HAS_ is probably the best choice for
> this, since it's already used similarly to indicate support for pref &
> sync instructions.
> 
> Thanks,
>     Paul

OK, Thanks.


