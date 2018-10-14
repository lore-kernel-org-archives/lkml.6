Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D4C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC71620659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC71620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeJOEMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:12:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeJOEMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:12:35 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3eSO2nYBWR-m; Sun, 14 Oct 2018 22:30:23 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDC0500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2B831EC0987;
        Sun, 14 Oct 2018 22:30:23 +0200 (CEST)
Date:   Sun, 14 Oct 2018 22:30:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Use assembly instruction mnemonics instead of
 .byte streams in arch_hweight.h
Message-ID: <20181014203022.GF7667@zn.tnic>
References: <20181014202354.21281-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181014202354.21281-1-ubizjak@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:23:54PM +0200, Uros Bizjak wrote:
> Recently the minimum required version of binutils was changed to 2.20,
> which supports popcnt instruction mnemonics. The patch removes
> corresponding #defines that implement popcnt instructions using target-dependant
> .byte streams and uses unified instruction mnemonics instead.
> 
> Tested by building x86_64 and i386 version of the kernel and comparing
> objdump dumps of the pathced and unpatched vmlinux.o. They were the same.
> 
> v2: Update commit message to emphasize removal of #defines.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/include/asm/arch_hweight.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Thanks.

But with one week before the merge window and this being not nearly
urgent, it'll have to wait for after the merge window.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
