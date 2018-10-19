Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98EBECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C862064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C862064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJSQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:14:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJSQOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:14:19 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J9ggE37UNLuX; Fri, 19 Oct 2018 10:09:01 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D11B1EC09F7;
        Fri, 19 Oct 2018 10:09:01 +0200 (CEST)
Date:   Fri, 19 Oct 2018 10:08:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
Message-ID: <20181019080853.GA28610@zn.tnic>
References: <20181017000809.GA21292@WindFlash>
 <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic>
 <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic>
 <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
 <20181018165057.GH20831@zn.tnic>
 <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:41:31AM +0900, Masahiro Yamada wrote:
> Adding -Wshadow to KBUILD_HOSTCFLAGS emits another warning in Kconfig.
> Of course, it is easy to fix.
> But, I just started to think this option is a kind of harsh...

What is more, if we added -Wshadow to KBUILD_HOSTCFLAGS, then there'll
be a difference in build options between host and target kernel in that
the host kernel build will be stricter wrt shadowing. Thus, it is a
maintainer decision, IMHO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
