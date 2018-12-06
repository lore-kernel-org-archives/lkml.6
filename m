Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94826C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C6120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C6120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeLFMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:15:44 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:40850 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbeLFMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:15:44 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990828AbeLFMPludY8u (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Thu, 6 Dec 2018 13:15:41 +0100
Date:   Thu, 6 Dec 2018 12:15:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     Firoz Khan <firoz.khan@linaro.org>,
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
In-Reply-To: <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Paul Burton wrote:

> > Could you review this patch series. I would appreciate if you can
> > perform the boot test on the actual platform.
> 
> This is looking pretty good to me, so I look forward to v4 with Arnd's
> comments addressed.
> 
> I've verified that the sys call tables are identical for both
> 32r2el_defconfig & 64r6el_defconfig before & after this series, and that
> both still boot fine.

 I believe this file is used by the glibc build process to retrieve 
syscall numbers for glibc's own use as well for <sys/syscall.h>.  Has the 
change been verified not to break this process?

 Cc-ing <libc-alpha@sourceware.org> for information and possible further 
input.

  Maciej
