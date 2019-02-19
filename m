Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E274C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0618D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfBSBkj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:40:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:43100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732665AbfBSBki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:40:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 17:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; 
   d="scan'208";a="134531155"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.88])
  by FMSMGA003.fm.intel.com with SMTP; 18 Feb 2019 17:40:35 -0800
Received: by ubuntu (sSMTP sendmail emulation); Tue, 19 Feb 2019 09:40:33 +0800
Message-ID: <1550540432.2534.1.camel@intel.com>
Subject: Re: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT
 symbol
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Date:   Tue, 19 Feb 2019 09:40:32 +0800
In-Reply-To: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
References: <20190213174005.28785-1-hch@lst.de>
         <20190213174005.28785-6-hch@lst.de>
         <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 16:55 +0900, Masahiro Yamada wrote:
> +CC: Ley Foon Tan <lftan@altera.com>
> +CC: nios2-dev@lists.rocketboards.org
> 
> 
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> 
> > 
> > diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> > index 715e6c09b4a5..3b50689007f5 100644
> > --- a/arch/nios2/Kconfig
> > +++ b/arch/nios2/Kconfig
> > @@ -20,6 +20,7 @@ config NIOS2
> >         select OF_EARLY_FLATTREE
> >         select SOC_BUS
> >         select SPARSE_IRQ
> > +       select TRACE_IRQFLAGS_SUPPORT
> 
> This is a behavior change of nios2.
> 
> TRACE_IRQFLAGS_SUPPORT was previously 'n',
> and this commit is changing it to 'y'.
> 
> 
> 
> 
> Strangely, nios2 defines TRACE_IRQFLAGS_SUPPORT twice
> with different default values.
> 
> In Kconfig, the first one becomes effective.
> 
> In this case, 'def_bool n' in arch/nios2/Kconfig is used.
> 'def_bool y' in arch/nios2/Kconfig.debug is dead code.
> 
> 
> I think this select should be dropped
> to keep the current behavior,
> but I hope the NIOS2 maintainer will give us
> some comments just in case.
> 
Yes, please drop this patch to keep original behavior.
Thanks.

Regards
Ley Foon
> 
> 
> 
> > 
> >         select USB_ARCH_HAS_HCD if USB_SUPPORT
> >         select CPU_NO_EFFICIENT_FFS
> >         select ARCH_DISCARD_MEMBLOCK
> > @@ -39,9 +40,6 @@ config NO_IOPORT_MAP
> >  config FPU
> >         def_bool n
> > 
> > -config TRACE_IRQFLAGS_SUPPORT
> > -       def_bool n
> > -
> >  menu "Kernel features"
> > 
> >  source "kernel/Kconfig.hz"
> > diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> > index f1da8a7b17ff..a8bc06e96ef5 100644
> > --- a/arch/nios2/Kconfig.debug
> > +++ b/arch/nios2/Kconfig.debug
> > @@ -1,8 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > 
> > -config TRACE_IRQFLAGS_SUPPORT
> > -       def_bool y
> > -
> >  config EARLY_PRINTK
> >         bool "Activate early kernel debugging"
> >         default y
> --
> Best Regards
> Masahiro Yamada
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
