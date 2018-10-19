Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E18C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D70F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EjLsBP2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D70F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJSKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:46:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32540 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJSKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:46:26 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9J2g7bL003522;
        Fri, 19 Oct 2018 11:42:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9J2g7bL003522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539916928;
        bh=RZR8C5Ssbmf1f+TZriYgPVcFQt5aZvhOnMDJa7+4MWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EjLsBP2/LUMHbSwRo5UICGDIhlvjjqBctIWOBdB5D8m/idjKdZbaGnRx3zUd+lySY
         sFlVeQf7Av9p+gF9ojY02atH/AAxRd7MYcGEXzaT3UXmBW1oSYd/m+q+cl6Tf0mpfS
         u783Nvn5q+rQFeN4DoYi+dkfsgomAGM7zqtQHhVy9X7tcuDLTt47q+qGq9UBApNwdE
         uQJLiziFfRbLKWnh65nvtcYHSQ1j/DL6NPqj+go++IFk0c5EDXTeyveE7kzkb/GCPJ
         Y+LL2iO/1AFNNfF0GN8A4hm13VhHgcD5j/8TxBXjIl9vRi7KHcz/Prb9VL1cBesSsv
         NBlXJCAhdexBQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id g201so24388092vsd.12;
        Thu, 18 Oct 2018 19:42:08 -0700 (PDT)
X-Gm-Message-State: ABuFfohQeb9wA2M9C3TqweOEcKz6GkRtOlaG+krjuqcyv6zyCDW7SH0R
        /dBaKu4odFabS7Uw97yi7qgQYG/mDYliofLwf14=
X-Google-Smtp-Source: ACcGV63yKR188utpZAXo1BEvvnbQVKAZ+dtS0UA12pW7wmgBQ8Vt1ZCDQNPcZ9872T2sT1+WLkqmbI7PH/2/vbzr4Ks=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr13800721vsb.155.1539916927299;
 Thu, 18 Oct 2018 19:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic> <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic> <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
 <20181018165057.GH20831@zn.tnic>
In-Reply-To: <20181018165057.GH20831@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 11:41:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
Message-ID: <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 1:53 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 19, 2018 at 01:39:21AM +0900, Masahiro Yamada wrote:
> > It is not realistic to enable this warning option by default.
>
> I believe the question is whether to enable that warning by default in
> KBUILD_HOSTCFLAGS. Enabling it by default for the target kernel is of
> course, too noisy. That's why it is hidden behind W=2 there.


Sorry, I misunderstood the question.

The difference about the noisiness between CC and HOSTCC
is just comes from the amount of source code.

Adding -Wshadow to KBUILD_HOSTCFLAGS emits another warning in Kconfig.
Of course, it is easy to fix.
But, I just started to think this option is a kind of harsh...


--
Best Regards
Masahiro Yamada
