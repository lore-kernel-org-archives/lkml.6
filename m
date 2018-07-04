Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87894208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87894208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeGDRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:35:38 -0400
Received: from foss.arm.com ([217.140.101.70]:41228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753103AbeGDRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D3180D;
        Wed,  4 Jul 2018 10:35:36 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF7D03F5A0;
        Wed,  4 Jul 2018 10:35:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E1A951AE180C; Wed,  4 Jul 2018 18:36:15 +0100 (BST)
Date:   Wed, 4 Jul 2018 18:36:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
Message-ID: <20180704173615.GC9668@arm.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 04:34:30PM -0700, Laura Abbott wrote:
> 
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I was previously focused on x86 only but since powerpc gave a patch,
> I figured I would do arm64 since the changes were also fairly simple.
> ---
>  arch/arm64/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)

If you drop the trailing semicolon, then:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
> index b82c85e5d972..2c429dfd3f45 100644
> --- a/arch/arm64/kernel/vdso/note.S
> +++ b/arch/arm64/kernel/vdso/note.S
> @@ -22,7 +22,10 @@
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> +#include <linux/build-salt.h>
>  
>  ELFNOTE_START(Linux, 0, "a")
>  	.long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;
> -- 
> 2.17.1
> 
