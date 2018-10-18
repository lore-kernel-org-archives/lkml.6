Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48FECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68121473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt/MNWrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE68121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJRIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:39:22 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42577 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:39:22 -0400
Received: by mail-ot1-f42.google.com with SMTP id c23so26321998otl.9;
        Wed, 17 Oct 2018 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pVNULNmaIPdhGLb418dkGShvlwgSldpOtquYxd0t40=;
        b=Qt/MNWrVz5d0Aqz6od4IrPOGnkRf73kWFZOp1iJfLwXNZEIxN6fhf4L8Yxg7JkA0Eb
         M90NxKGKFARvEY3tCpaPndOotEACYYuo/csdm7lo0riXxgkRlTmXeoRENaL4AH4kJZO8
         TVoqOwvhOojUTyj77F/tR+1e+Ooy5kcRcaYmRsr11vptnlGlLzklf42oBbP5ThbqdUpt
         Sl9CGuldtbNur50keOp8iq0V/tEplma32MyUwabZdEJE3cfoqQDuNzkqMrupMcbM6fXR
         XODw7yAekX2iGJEOtZK5Y7wbGTuZyJoPmPMVMaWRQuG2IRv0WzGE7piuz4sH5xZKW0Rr
         0TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pVNULNmaIPdhGLb418dkGShvlwgSldpOtquYxd0t40=;
        b=Qs5CdSTVDZMpvurGnbFf/m0U18nUSVmB6tPuRZpglFdAgHH4j9UcLsdvKW5VKVkIJC
         8dsfoCntI8XIEtiaFrUeXMYOGfkIU/Kp0s5OTsvaLeSy4r8DMMS8wgIaY6iWFZO/SBWL
         haSHOqEA7js9akNn7IQuXEqVyFm9I+icgK3m8/VGhY8uhFTmidl7HNxoSK+T86jcAVuW
         oreYaGr/TPPjSoYielRaDMsmiZA5MSdXRB3fmiV0864whMy34JaaN2GrYardXCsexQqp
         5zKRDTKyKjmu7hmXq0x0OwPdzX6KV977VWJtesSkTTzsJn2gFiSsVtlYs5sLeZKsbhNP
         3rnA==
X-Gm-Message-State: ABuFfojkFUDMSO+M1Oz+0JcTP+Ksr8EWIThYOSgNF6D+mDtcxlukk19O
        WRULjjhBhXsp/yrBtJLrmlMK0cPab00RCr24/tI=
X-Google-Smtp-Source: ACcGV62rTCgdxdA89cB7x3D9uIvuzd4XOHeX2VBMsTGEeVZg0eiMYep7MKd6EcJpuDg/zRr6vg8dcDP/8VpE6MvedVQ=
X-Received: by 2002:a9d:948:: with SMTP id 66mr18529453otp.178.1539823264828;
 Wed, 17 Oct 2018 17:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com> <20181017083126.GB22535@zn.tnic>
In-Reply-To: <20181017083126.GB22535@zn.tnic>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 17 Oct 2018 21:40:53 -0300
Message-ID: <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Boris,


> Next question: why not -Wshadow simply?

Good question. I can change it to -Wshadow and fix stuff for v2.

>
> Also, -Wshadow for the target compiler is an extra warning (W=2). Why is
> it enabled by default here?

The idea was to put it as default and fix all the shadowing warnings.
What do you think?  I am open to suggestions.

Thank you,
Leonardo Bras


> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
