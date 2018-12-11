Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE882C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EC92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiJjfZVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EC92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLKIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:45:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40731 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLKIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:45:31 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so2459030ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 00:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWBTgUBk2X9dWCGwyVWMhC6XsKOx13IfEp9WSgotmTk=;
        b=GiJjfZVQc4ZiByjyT6x9upCBwEjlCJkjjNPPGijHJBSObUBz/iofrZxB64eZnBwETE
         gzSB9a5PXCWne9q+pe8boJbHwtgbrzKolrIhjO8e8ZeATjYTGOUD9xiAQVE7hznDWrRU
         KUTbVNtv71sHvQmndD9MFTDtjLqtzKPHuVpbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWBTgUBk2X9dWCGwyVWMhC6XsKOx13IfEp9WSgotmTk=;
        b=JASraVrOMRE9bcmzucKhHv4meDVtt8BNODdCnF21W3uHknOHXWXd6iHdUCOXtvPdoN
         v9dw/mrjC7KdbM+yl7VGRuxfdkpGPhQGOpjDFubOnyd0X2CK9BsBZf5UkMI51wfVJyNH
         nvrPwXEkNA4EsxoSBTOdp7YEK3uVOpyIlkAClpIdt812A4ra9D4xk1DrOpinMku87saf
         kM46ZsjDtpC2mqe87dxr4eoRZuF0TqXYZTCwYX9nDWl+jxXh/Qp+tIQ5XorXf95Q86Lj
         kbUrRjNVKutr0k84p+GPZpFYrVQ14HNcBipUZCWICIuen4xxqG5QEpWxMYc4YJwtrnF3
         GvYQ==
X-Gm-Message-State: AA+aEWY7gFnxzlRGXUT1iuE43frOA6vvPno8aHEd/iFZoxh5S2pSGCB3
        h00a4V/jnlGCXfB0rUMcSBOQhc4H/WrPEHVju/5iPQ==
X-Google-Smtp-Source: AFSGD/Xcmjqh22QusgRcVQ57PLm6fMtI2qmXINEDqclyUt+vMie65oE6lwWWxSH7xs05bHve659n5NPoWcwZe8sJlYY=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1346065iti.166.1544517930531;
 Tue, 11 Dec 2018 00:45:30 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
In-Reply-To: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 11 Dec 2018 14:15:19 +0530
Message-ID: <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 11 Dec 2018 at 01:21, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Dec 06, 2018 at 10:48:24AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
> > index 26143e3..0364eec 100644
> > --- a/arch/mips/include/uapi/asm/sgidefs.h
> > +++ b/arch/mips/include/uapi/asm/sgidefs.h
> > @@ -40,6 +40,6 @@
> >   */
> >  #define _MIPS_SIM_ABI32              1
> >  #define _MIPS_SIM_NABI32     2
> > -#define _MIPS_SIM_ABI64              3
> > +#define _MIPS_SIM_ABIN64     3
>
> Whilst I agree with changing our own definitions & filenames to use n64,
> this macro actually reflects naming used by the toolchain. ie:
>
>     $ mips-linux-gcc -mips64 -mabi=64 -dM -E - </dev/null | grep ABI64
>     #define _ABI64 3
>     #define _MIPS_SIM _ABI64
>
> Our macro here is used to compare against _MIPS_SIM provided by the
> toolchain, so for consistency I think we should keep the same name for
> the macro that the toolchain uses.

Will this below change will help?

 #define _MIPS_SIM_ABI32              1
 #define _MIPS_SIM_NABI32            2
 #define _MIPS_SIM_ABI64              3
+#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64

Thanks
Firoz

>
> And I realise that undoing that but keeping n64 in our own filenames &
> macros is another type of inconsistency, but something imperfect is
> unavoidable at this point given that the engineers way back when decided
> to use "ABI64" for n64.
>
> Thanks,
>     Paul
