Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C37D20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C37D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLKP77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:59:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeLKP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:59:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759BE1596;
        Tue, 11 Dec 2018 07:59:56 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 438C33F575;
        Tue, 11 Dec 2018 07:59:56 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4F95A1AE0CFD; Tue, 11 Dec 2018 16:00:19 +0000 (GMT)
Date:   Tue, 11 Dec 2018 16:00:19 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>, akpm@linux-foundation.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Subject: Re: [PATCH v13 00/25] kasan: add software tag-based mode for arm64
Message-ID: <20181211160018.GA12597@edgewater-inn.cambridge.arm.com>
References: <cover.1544099024.git.andreyknvl@google.com>
 <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
 <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[moving akpm to To:]

On Tue, Dec 11, 2018 at 04:57:27PM +0100, Andrey Konovalov wrote:
> On Tue, Dec 11, 2018 at 4:18 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Dec 06, 2018 at 01:24:18PM +0100, Andrey Konovalov wrote:
> > > This patchset adds a new software tag-based mode to KASAN [1].
> > > (Initially this mode was called KHWASAN, but it got renamed,
> > >  see the naming rationale at the end of this section).
> > >
> > > The plan is to implement HWASan [2] for the kernel with the incentive,
> > > that it's going to have comparable to KASAN performance, but in the same
> > > time consume much less memory, trading that off for somewhat imprecise
> > > bug detection and being supported only for arm64.
> >
> > For the arm64 parts:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > I assume that you plan to replace the current patches in -mm with this
> > series?
> >
> > Cheers,
> >
> > Will
> 
> Hi Will,
> 
> Yes, that was the intention of sending v13. Should have I sent a
> separate patch with v12->v13 fixes instead? I don't know what's the
> usual way to make changes to the patchset once it's in the mm tree.

No, I was just checking that the intention was for akpm to pick this up in
preference to the old stuff! That works for me, and the minor conflict with
arm64 in next was already resolved by Stephen.

Will
