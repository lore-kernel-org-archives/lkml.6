Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF13C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AA221872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ndmp2tEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGRLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:11:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46546 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfBGRLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:11:53 -0500
Received: from zn.tnic (p200300EC2BD188009C13CA0C499330CD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:9c13:ca0c:4993:30cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40F211EC014B;
        Thu,  7 Feb 2019 18:11:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549559511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mL5kM6FX0Yu4eQL6KITcrIhTQkDtu4RtCtOc3AFp+QA=;
        b=Ndmp2tEutm2w5xZqV89qzmP4fXadljzSJaIyMDvxgAlFT2x2WMhL9p15sYyJCulV4jh5z9
        xCWP5GI7mJ4Un931VsLWZUNoyQwsnDWpueE/A1zvxzJ1NNs3+OURSWKy3wchGbC9OvNCFA
        SkqZQQPFw8Fe6fjldzWodGzjiZAzXNk=
Date:   Thu, 7 Feb 2019 18:11:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/27] x86: Use symbol name in jump table for PIE
 support
Message-ID: <20190207171145.GH2414@zn.tnic>
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-3-thgarnie@chromium.org>
 <20190207121729.GE2414@zn.tnic>
 <CAJcbSZFe+Cn9+gEa4iv56sZE+WXXiHjeR8Mcte9s_HYr8QBrsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJcbSZFe+Cn9+gEa4iv56sZE+WXXiHjeR8Mcte9s_HYr8QBrsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:04:45AM -0800, Thomas Garnier wrote:
> I assume that's an optimisation done by gcc later.

So why is that change even needed? Where does it break?

> The P modifier in the documentation does state that it is used to
> generate PIC code.

The documentation says:

"If used for a function, print the PLT suffix and generate PIC code. For
example, emit foo@PLT instead of ’foo’ for the function foo()."

when you use %P for a function. Which is not how it is used here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
