Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C5C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BF02086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BF02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933837AbeFQTrz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:47:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbeFQTrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:47:53 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fec3ppwTGr6r; Sun, 17 Jun 2018 21:47:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D37D61EC0136;
        Sun, 17 Jun 2018 21:47:51 +0200 (CEST)
Date:   Sun, 17 Jun 2018 21:47:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
Message-ID: <20180617194747.GA21160@zn.tnic>
References: <20180507213755.GA32406@avx2>
 <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1529244178.4674.1.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 04:02:58PM +0200, Mike Galbraith wrote:
> (/me does that.. all better)
> 
> From 6ac281ee69f4cb5b581d5f49662fb56b6326155a Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 17 Jun 2018 13:57:42 +0200
> Subject: [PATCH] x86/crypto: Add a missing RET
> 
> crypto_aegis128_aesni_enc_tail() needs to return too.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

[ Mike: took care of the other tail calls. ]
Signed-off-by: Mike Galbraith <efault@gmx.de>

> ---
>  arch/x86/crypto/aegis128-aesni-asm.S  |    1 +
>  arch/x86/crypto/aegis128l-aesni-asm.S |    1 +
>  arch/x86/crypto/aegis256-aesni-asm.S  |    1 +
>  arch/x86/crypto/morus1280-avx2-asm.S  |    1 +
>  arch/x86/crypto/morus1280-sse2-asm.S  |    1 +
>  arch/x86/crypto/morus640-sse2-asm.S   |    1 +
>  6 files changed, 6 insertions(+)

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
