Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6AECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813F206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C813F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeGUF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 01:59:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeGUF7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 01:59:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1385720;
        Sat, 21 Jul 2018 05:07:55 +0000 (UTC)
Date:   Sat, 21 Jul 2018 07:07:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     lkp@intel.com, kbuild-all@01.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.4 STABLE BACKPORT] x86: paravirt: make native_save_fl extern
 inline
Message-ID: <20180721050752.GC27598@kroah.com>
References: <20180720223642.126080-1-ndesaulniers@google.com>
 <201807210738.RRpvc56w%fengguang.wu@intel.com>
 <CAKwvOdnrwW-CaVKR-iJTDfwVGRj4xE=5MaUMyvjqsEw-7yPiZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnrwW-CaVKR-iJTDfwVGRj4xE=5MaUMyvjqsEw-7yPiZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 05:06:07PM -0700, Nick Desaulniers wrote:
> On Fri, Jul 20, 2018 at 5:04 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Nick,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on tip/x86/core]
> > [cannot apply to v4.18-rc5 next-20180720]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/x86-paravirt-make-native_save_fl-extern-inline/20180721-073112
> > config: i386-tinyconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/x86/kernel/irqflags.S: Assembler messages:
> > >> arch/x86/kernel/irqflags.S:22: Error: bad register name `%_ASM_ARG1'
> >
> > vim +22 arch/x86/kernel/irqflags.S
> >
> >     16
> >     17  /*
> >     18   * void native_restore_fl(unsigned long flags)
> >     19   * %eax/%rdi: flags
> >     20   */
> >     21  ENTRY(native_restore_fl)
> >   > 22          push %_ASM_ARG1
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> oops, probably should not have cc'ed vger.kernel.org for a patch meant
> for stable.

stable@vger.kernel.org is the right address, you did it correct.  I
think 0-day just got a bit trigger-happy on this one for some reason,
don't worry about it.

thanks,

greg k-h
