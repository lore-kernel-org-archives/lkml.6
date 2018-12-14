Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441DC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5479D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeLNAws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:52:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17982 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbeLNAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:52:47 -0500
X-UUID: a68450dd5630445e8730c001cbd621ca-20181214
X-UUID: a68450dd5630445e8730c001cbd621ca-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1323402994; Fri, 14 Dec 2018 08:52:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 08:52:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 08:52:35 +0800
Message-ID: <1544748756.29110.2.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 14 Dec 2018 08:52:36 +0800
In-Reply-To: <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
         <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
         <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 70A9EDF891D9D6D7AAFE0303FF6817EEDD6BB97A58C57E96600C0DDB7294ED932000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 19:15 +0100, Ard Biesheuvel wrote:
> On Thu, 13 Dec 2018 at 19:12, Will Deacon <will.deacon@arm.com> wrote:
> >
> > [+Ard because I'll basically go with his preference on this one]
> >
> > On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> > > When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> > > perform linear virtual address to physical address translation.
> > > Sometimes we're debugging with only few information such as a kernel log
> > > and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> > >
> > > Tested by:
> > > echo c > /proc/sysrq-trigger
> > > [   11.996161] SMP: stopping secondary CPUs
> > > [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> > > [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> > >
> > > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > > Tested-by: Miles Chen <miles.chen@mediatek.com>
> 
> Fine with me, but I would like to see an ack from Miles Chen :-)

Can I ack my own patch?

Acked-by:Miles Chen <miles.chen@mediatek.com>
> 
> > > ---
> > >  arch/arm64/kernel/setup.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index f4fc1e0544b7..4b0e1231625c 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
> > >       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
> > >               pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
> > >                        offset, KIMAGE_VADDR);
> > > +             pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
> > >       } else {
> > >               pr_emerg("Kernel Offset: disabled\n");
> > >       }
> > > --
> > > 2.18.0
> > >


