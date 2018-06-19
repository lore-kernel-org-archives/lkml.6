Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F77C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967306AbeFSVpI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:45:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964888AbeFSVpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:45:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F296AE22;
        Tue, 19 Jun 2018 21:45:04 +0000 (UTC)
Date:   Tue, 19 Jun 2018 23:44:59 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, felix@feldspaten.org
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
Message-ID: <20180619214459.GI31750@zn.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
 <20180619094658.GB31750@zn.tnic>
 <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
 <20180619194350.GG31750@zn.tnic>
 <15f10b01-e32f-5fc1-a2e6-3c6ab1461b30@amd.com>
 <20180619213255.GH31750@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619213255.GH31750@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:32:56PM +0200, Borislav Petkov wrote:
> config CRYPTO_DEV_SP_PSP
>         bool "Platform Security Processor (PSP) device"
>         default y
>         depends on CRYPTO_DEV_CCP_DD && X86_64
> 
> so CRYPTO_DEV_SP_PSP already depends on CRYPTO_DEV_CCP_DD!
> 
> So why should KVM_AMD_SEV depend on CRYPTO_DEV_CCP_DD too?!? Do you
> catch my drift?

And then in addition to that, KVM_AMD_SEV needs to "synchronize"
selection states so that KVM_AMD *and* CRYPTO_DEV_SP_PSP both have the
same setting - either =m or =y - so that the build works.

I can't think of a proper way to fix that right now, though, need to
sleep on it.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
