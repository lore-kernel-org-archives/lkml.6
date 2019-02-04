Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3322082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfBDNov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:44:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfBDNov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:44:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCDAA78;
        Mon,  4 Feb 2019 05:44:51 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBF03F557;
        Mon,  4 Feb 2019 05:44:49 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:44:45 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/arm: Don't expect a return value of
 ptdump_debugfs_register
Message-ID: <20190204134445.GA22170@fuggles.cambridge.arm.com>
References: <20190201192001.6495-1-natechancellor@gmail.com>
 <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:18:22PM +0100, Ard Biesheuvel wrote:
> On Fri, 1 Feb 2019 at 20:21, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > As of commit e2a2e56e4082 ("arm64: dump: no need to check return value
> > of debugfs_create functions") in the arm64 for-next/core branch,
> > ptdump_debugfs_register does not have a return value, which causes a
> > build error here:
> >
> > drivers/firmware/efi/arm-runtime.c:51:9: error: returning 'void' from a
> > function with incompatible result type 'int'
> >         return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> >
> > The arm version is still awaiting acceptance [1] but in anticipation
> > of that patch being merged, restructure this function to call
> > ptdump_debugfs_register without expecting a return value.
> >
> > [1]: https://lore.kernel.org/lkml/20190122144114.9816-3-gregkh@linuxfoundation.org/
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> 
> Catalin, Will,
> 
> Could you please apply this directly?

Sure, we'll pick it up.

Will
