Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2864C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882E72086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JudpRY7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882E72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeLMKwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:52:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeLMKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tv9QIBkjsUG6r3Sg/D/Kx5L7YwlU2tYAOckfeYuussw=; b=JudpRY7/TWvLCDg5nsZTbt+Kj
        1SjsQB8uF49SRcr919SwNEiVVdj/hgXsyf0xxbL8irXc/dnpd8wFasJBvXvX/f0s2PFBcxKBV6fNt
        fmPx0DcmJGn/hSKRdziRAVFM8MmrPG8KqV1k2NTEz3ryQ5DYEH4X0vi0oXHf5e80ycQ9W48/3OpPn
        IUo8TUHOOj58iH7MCIkqDO7TCNfDTipvFnx9G1ojWFy1TgTt/R/xFOLlYtzlT28/r5zCahObBmw52
        Rqt/dQxr0dqmNw/hQAwSn56x6OkVTcM7IoJDebJPC/59ZwKUZzzIDfhCUONrcE2D8YDDFfSZYDCvL
        SdbA8HupA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXOap-0004p4-Vs; Thu, 13 Dec 2018 10:51:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55057207261E3; Thu, 13 Dec 2018 11:51:46 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:51:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Richard Biener <rguenther@suse.de>,
        Nadav Amit <namit@vmware.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Message-ID: <20181213105146.GH5289@hirez.programming.kicks-ass.net>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:17:41PM +0900, Masahiro Yamada wrote:
> Revert the following commits:
> 
> - 5bdcd510c2ac9efaf55c4cbd8d46421d8e2320cd
>   ("x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
>   ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - 0474d5d9d2f7f3b11262f7bf87d0e7314ead9200.
>   ("x86/extable: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - 494b5168f2de009eb80f198f668da374295098dd.
>   ("x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops")
> 
> - f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6.
>   ("x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs")
> 
> - 77f48ec28e4ccff94d2e5f4260a83ac27a7f3099.
>   ("x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs")
> 
> - 9e1725b410594911cc5981b6c7b4cea4ec054ca8.
>   ("x86/refcount: Work around GCC inlining bug")
>   (Conflicts: arch/x86/include/asm/refcount.h)
> 
> - c06c4d8090513f2974dfdbed2ac98634357ac475.
>   ("x86/objtool: Use asm macros to work around GCC inlining bugs")
> 
> - 77b0bf55bc675233d22cd5df97605d516d64525e.
>   ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
> 

I don't think we want to blindly revert all that. Some of them actually
made sense and did clean up things irrespective of the asm-inline issue.

In particular I like the jump-label one. The cpufeature one OTOh, yeah,
I'd love to get that reverted.

And as a note; the normal commit quoting style is:

  d5a581d84ae6 ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")
