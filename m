Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B388720878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B388720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLFREJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:04:09 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:39946 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:04:09 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990824AbeLFRC2KGuYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Thu, 6 Dec 2018 18:02:28 +0100
Date:   Thu, 6 Dec 2018 17:02:28 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joseph Myers <joseph@codesourcery.com>
cc:     Paul Burton <paul.burton@mips.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
In-Reply-To: <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk>
Message-ID: <alpine.LFD.2.21.1812061659210.4294@eddie.linux-mips.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop> <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
 <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Joseph Myers wrote:

> >  I believe this file is used by the glibc build process to retrieve 
> > syscall numbers for glibc's own use as well for <sys/syscall.h>.  Has the 
> > change been verified not to break this process?
> > 
> >  Cc-ing <libc-alpha@sourceware.org> for information and possible further 
> > input.
> 
> I'm not sure what "this file" is.  The glibc build uses the installed 
> <asm/unistd.h> (the results of #including it, not any other kind of 
> processing the file).

 So how are `SYS_<name>' macros generated that land in <bits/syscall.h>?

  Maciej
