Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A5C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6278206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VIvyzsiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6278206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeI3JEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:04:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46249 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeI3JEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:04:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8778f682;
        Sun, 30 Sep 2018 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=mphiti1i2w2NgrTtpzTMRK1yooE=; b=VIvyzs
        izujXT1nObdVz//WAUr6bL5mK7RB6+rfGRyRpY1RQR05Ot6pKCnQD2LSw+zLFZgt
        8umcU1Do9h0GGzlu8pdt53u1Per4pEvgWKKHl53EfiEnLtzeuUq2qQ/soawpb+gZ
        SmFh09Ov7rWR3W75GEyqB0ZtRCmUR3qXPhdNBGLndJCFJ6sPUX2Cpg1chO6TrKuR
        /jgdHqwOTJXPybCRNd5h96MyZywI6s3CAt/IaSqzVLgcYRd71gGmPkofenrj+GMo
        oKfYy6cz5iC6MMnukW2dzF9Y1fx9ew5oFK99q5KV+ifVlrlIU1CYUO64EvHMlN63
        VXTCCO+1U7LG54Gg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 372a8dde (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 30 Sep 2018 02:14:33 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id d63-v6so8489100oic.12;
        Sat, 29 Sep 2018 19:33:32 -0700 (PDT)
X-Gm-Message-State: ABuFfoj0UryJabTzb6a5yB/TSKRPCt5g+k25SZcD5FCrnnknf/0FzpdK
        e7HQJ0exnK2CqrgiseOFSilP/NHjSnZddsBPKng=
X-Google-Smtp-Source: ACcGV61NzGi8Z4givOvsJQ4g/sN59huKHtNdQFdMeK9Q0VsAPPI47HjCdNeV0etioEHYvzVIRIG8ZsMtB2bI9vO0Fmg=
X-Received: by 2002:aca:d489:: with SMTP id l131-v6mr2265429oig.15.1538274811561;
 Sat, 29 Sep 2018 19:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu8knzzmK4_KouFQWKzMdHFgEsk-CtBrcuAvk0bYkDFO=w@mail.gmail.com>
 <CAHmME9qtN8kiKnMHTa76r9a_5Ou_s3WhAMT_HnH7-1FeoHUOZg@mail.gmail.com> <CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 30 Sep 2018 04:33:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9rw=khsP=8PzbWUtwjVh55stzgr1qHcQUi8h7-a--Sr7w@mail.gmail.com>
Message-ID: <CAHmME9rw=khsP=8PzbWUtwjVh55stzgr1qHcQUi8h7-a--Sr7w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Sat, Sep 29, 2018 at 8:16 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > You mean to say that since these nobs are def_bool y and are
> > essentially "depends on ARM", then I should just straight up use
> > CONFIG_ARM? I had thought about this, but figured this would make it
> > easier to later make these optional or have other options block them
> > need be, or even if the dependencies and requirements for having them
> > changes (for example, with UML on x86). I think doing it this way
> > gives us some flexibility later on. So if that's a compelling enough
> > reason, I'd like to keep those.
>
> Sure. But probably better to be consistent then, and stop using
> CONFIG_ARM directly in your code.

Ack.

> > The reason it was added was indeed because of:
> > https://lists.01.org/pipermail/kbuild-all/2018-September/053114.html
> > -- exactly what you suspected, ARCH_RPC. Have a better suggestion than
> > !CPU_32v3?
>
> Yes, you could just add
>
> asflags-$(CONFIG_CPU_32v3) += -march=armv4
>
> with a comment stating that we don't actually support ARMv3 but only
> use it as a code generation target for reasons unrelated to the ISA

Alright, I'll do exactly that. Though, if the rationale for this has
to do only with codegen -- with what the C compiler does -- then
shouldn't this be set globally for CONFIG_CPU_32v3? I couldn't find
any macros that test against __LINUX_ARM_ARCH__ being 3 in the
assembly, so this shouldn't be a problem I don't think. Maybe I'll
send a patch.

Jason
