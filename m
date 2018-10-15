Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC3C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F348E208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxe9dOMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F348E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJPDdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:33:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeJPDdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:33:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so22312396wrt.1;
        Mon, 15 Oct 2018 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SiZ5Ikkntzdp4vIR1DzobI3d2pxuVNgf/xdKMPBVTtg=;
        b=Vxe9dOMFNYqUgjwNlXzCY6X2A8LExOUzyyPJ0F+sxFaIsH7BLM+0errMW8w3V1FYj7
         bR5XwXXmkk8LQhASBUPoPEDnHvWmcA84xT91s2y4XMlVAR5kBwST27sNCpqb/7ui9FMl
         6PKUFgZzPKwaKZ/mQkrIukp8ScmvP0I57y80yKbcUOFoNfoS+/WCnjv1eieLGeJrIlKI
         +mDYiAcJJM8Qv/eSt8G6ZztnnOg+wxtoOl2PdxgiX4iX7fcBuFe+rXcMshPw4GX/SQqe
         JC1gxyRtNgu730de26W0/AeWSZxysctDq6zHXYn1CXwZUQFMnNVvdqCqlI4JCWGcmzh1
         P+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SiZ5Ikkntzdp4vIR1DzobI3d2pxuVNgf/xdKMPBVTtg=;
        b=Y8/F1buTEa6n2wWvzfFPd3YdyXic/HFp35mM0DYTPckfKbhFcahN2v6odSEqj9AK03
         xQchzUQ8KDRM96HW0JmeIOtL5VE6MBpVlOtkeje13cuSGaEVLfiX3hlNzEBpVgZ+HTL1
         hcc2wO6tZDO7lv3dQEARuSMfABow/RQhiPwDw5e1VCK8k6t+TujfrY9Eg/OAB3iRSdKU
         mdV/sReAMLdXDw+fWlbtc1oCmQnRdyAQ9nU4vq1UzXNJI+8zP5EUfFvnjOyf6/ZAHixw
         FnwjLWNcBbbMA0mMA9b+jZFwD2kLPv/5IEUNVleZ7PmtlwzTaBPy9EPQ4AI0Cwpezwk4
         YAHw==
X-Gm-Message-State: ABuFfohGDwNZYFHK4OhAzrAQV2YEAhub9vNmdb4NcFLUJDgJO4kAgPSx
        89w+rqLqdQw5unwjT8KM32A=
X-Google-Smtp-Source: ACcGV634J1B8M29mKqKa8RAyJgIakNbH7vIHrKXIxIOU1ewzlIkRALGwr3XXA4BCXXYSNfKKzAG1oQ==
X-Received: by 2002:a5d:6309:: with SMTP id i9-v6mr15309828wru.163.1539632813199;
        Mon, 15 Oct 2018 12:46:53 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c13-v6sm8845009wrm.50.2018.10.15.12.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:46:52 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:46:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
Message-ID: <20181015194650.GA11458@flashbox>
References: <20181013010348.6740-1-natechancellor@gmail.com>
 <CAKwvOdk8HGTtQ=qb2THgRb3B6O=iErXFyrbKVoGDkMeFAdD3kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk8HGTtQ=qb2THgRb3B6O=iErXFyrbKVoGDkMeFAdD3kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:40:36PM -0700, Nick Desaulniers wrote:
> On Fri, Oct 12, 2018 at 6:06 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building the kernel with Clang, some disabled warnings appear
> > because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
> > this list so that the build is clean again.
> >
> > -Wpointer-sign was disabled for the whole kernel before the beginning
> > of git history.
> >
> > -Waddress-of-packed-member was disabled for the whole kernel in
> > commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
> > warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
> > Disable the address-of-packed-member compiler warning").
> >
> > -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
> > LLVMLinux: Add Kbuild support for building kernel with Clang") and for
> > x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
> > warnings about GNU extensions").
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/112
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
> > and suggested potentially rewriting the x86 portion of this Makefile to
> > behave like the arm/arm64 one where problematic flags are filtered out.
> > While that comes to fruition, it would be nice for this folder to behave
> > like the rest of the kernel when it comes to this warnings so that the
> > build is cleaner, thus this patch.
> >
> >  drivers/firmware/efi/libstub/Makefile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index c51627660dbb..d9845099635e 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)                := -march=i386
> >  cflags-$(CONFIG_X86_64)                := -mcmodel=small
> >  cflags-$(CONFIG_X86)           += -m$(BITS) -D__KERNEL__ -O2 \
> >                                    -fPIC -fno-strict-aliasing -mno-red-zone \
> > -                                  -mno-mmx -mno-sse -fshort-wchar
> > +                                  -mno-mmx -mno-sse -fshort-wchar \
> > +                                  -Wno-pointer-sign \
> 
> Hi Nathan, thanks for this patch.
> 
> Should this be:
> $(call cc-disable-warning, pointer-sign)
> as well?
> 

According to commit 1d6bf3a9a546 ("kbuild: add -Wno-pointer-sign flag
unconditionally") in -next, all supported compilers recognize the flag
so I don't think it's necessary.

> > +                                  $(call cc-disable-warning, address-of-packed-member) \
> > +                                  $(call cc-disable-warning, gnu)
> >
> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >  # disable the stackleak plugin
> > --
> > 2.19.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Thanks for the review!
Nathan
