Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7453246CC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XmH6AMrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7453246CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeGDD4Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:56:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34432 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeGDD4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:56:23 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w643uHAf002264;
        Wed, 4 Jul 2018 12:56:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w643uHAf002264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530676577;
        bh=HHAOy/SMN8/QxWH84Hw8IeVkBIXYb66mTKEKXAGTiJw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XmH6AMrjNP42ayPn9c/Z0GvubDsiIyO3N4qQ9MmGEe7wdqvVEZAMMyQMPonmmcGqJ
         nQxghS/KhVnrBJYG0dyQVROdl5UfSqapePstgUMhsDwE5YcTJoVMIR8wJVyMkJjaEz
         mf66a23/CWcf/GOY2JcBVvLlIMojy8c/gcMm+O+IEeeZJq9z0JuUmaChve1Y+3Syqo
         VZ+O/DjMrdWPy44pvg6EHMIT0Nxo9G0ucjOHIf90wI5PxhAHJKVm61p1Wqn5MH1nQQ
         uGupoTFIkX9vnhvF0lY7EWn59i8NFTOg4pXa/PQeaDLCUsMmMxWS6l+eeBK4gb48MA
         aLFg5KV3yVu+Q==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id t4-v6so2241054vke.9;
        Tue, 03 Jul 2018 20:56:17 -0700 (PDT)
X-Gm-Message-State: APt69E3OccDuAfBBpulf7xdADTZbtFLxcfNQARKNpnDieYfop5iDIqZ7
        mboFyBgGz3o2A6zbF7kvLQWSzDtlGxdf2rX6v5w=
X-Google-Smtp-Source: AAOMgpe+vTe1nSVRRfp9wPfUlEV/dL9mfJ5/4odz7ZeeWdFjFV1xjVSgJfeszv0x8/cgyN7nn/DM0cqH2iarX04Fmzc=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr163481vkj.160.1530676576553;
 Tue, 03 Jul 2018 20:56:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:55:35 -0700 (PDT)
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com> <20180703233430.14416-5-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Jul 2018 12:55:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
Message-ID: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
To:     Laura Abbott <labbott@redhat.com>
Cc:     Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
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
>
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
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;



I think this works, but
I prefer no-semicolon in assembly files.

For coding consistency,
I want ';' as statement delimiter in .c files.
But, only new line after each statement in .S files.

For example, in arch/x86/xen/xen-head.S
I see no semicolon after ELFNOTE().

I found this:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473k/dom1359731141352.html
It says ';' starts a comment line
although it is not the case of GAS.


Same for 3/4.



-- 
Best Regards
Masahiro Yamada
