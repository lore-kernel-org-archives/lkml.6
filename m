Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ACB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEiA/aO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfAPHv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:51:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54655 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfAPHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:51:28 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so1660303ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XT7jZZ1KVvwJQprqHTVEfavipuUF6Dnl96nB3egJmI=;
        b=MEiA/aO55PvUS/MupCPg9KzGZlspdTMND+8hFUqzgDay9Zp9ugeEaNMXSp8+GBur7S
         4uoN62fj6evhLktpHApTtX9P9ygy3bSSyrYRWTHMuR1cqZ1tvIRZUi5TwlTcFRDWpuhJ
         agsE83413pOZthNSJuTPGi7ujklEkUo/uQpFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XT7jZZ1KVvwJQprqHTVEfavipuUF6Dnl96nB3egJmI=;
        b=U97eEoHU2eC+RdRta16+b1L/OJtr9hgre2aHwNyFF5xlLbDFVtev9If3XHOPGd8G1P
         aNWSEZxo1oud23OGfKSHPUaIeVjlGzX2XkxFj+yTQpAyyPmegSdL+iJxV4kCv6JdeqEv
         7G/JbTg5G4/PId2g7jihSRFseGUHR89Oi+K/HZg/9FFL5+sdLwz/8r3WAu0CxmmRNoFZ
         IEgcYGej2ou9avf0hYQArlVDj/ckhp48xdxcD2rLyTlO1E8ghA1IcpbfBOwc6oAUnwcj
         PscBFqqYZzLhdjCXtwVCvx7PzI18rlhdrhuKbs2XD7MteletYBTGA1Cxn8us8wEXcDFT
         Ix5A==
X-Gm-Message-State: AJcUuke4ZfrXmtL87LIoIwplWh/9rsRbXInZB7JbI31M/RjgxT1SPqCY
        RCqm8nb48y1tj0z/JQTPLYTANrx44/TB+9NiSK7GaQ==
X-Google-Smtp-Source: ALg8bN44DvQCdxWT4wJ5kHWaz4SBhYyIyXo9PX2yiG3/ACbRNwwKp8CKMRcrrmcFKDEtNM9Nx05xSHXq4DEzTdr9ET0=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr4988806itk.71.1547625087024;
 Tue, 15 Jan 2019 23:51:27 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com> <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 16 Jan 2019 08:51:16 +0100
Message-ID: <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To:     Yueyi Li <liyueyi@live.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 04:37, Yueyi Li <liyueyi@live.com> wrote:
>
> OK, thanks. But seems this mail be ignored, do i need re-sent the patch?
>
> On 2018/12/26 21:49, Ard Biesheuvel wrote:
> > On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
> >> Hi Ard,
> >>
> >>
> >> On 2018/12/24 17:45, Ard Biesheuvel wrote:
> >>> Does the following change fix your issue as well?
> >>>
> >>> index 9b432d9fcada..9dcf0ff75a11 100644
> >>> --- a/arch/arm64/mm/init.c
> >>> +++ b/arch/arm64/mm/init.c
> >>> @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
> >>>                    * memory spans, randomize the linear region as well.
> >>>                    */
> >>>                   if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> >>> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> >>> +                       range /= ARM64_MEMSTART_ALIGN;
> >>>                           memstart_addr -= ARM64_MEMSTART_ALIGN *
> >>>                                            ((range * memstart_offset_seed) >> 16);
> >>>                   }
> >> Yes, it can fix this also. I just think modify the first *range*
> >> calculation would be easier to grasp, what do you think?
> >>
> > I don't think there is a difference, to be honest, but I will leave it
> > up to the maintainers to decide which approach they prefer.
>

No it has been merged already. It is in v5.0-rc2 I think.
