Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79B9206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2xQN4FpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfBOIEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:04:12 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32866 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfBOIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:04:11 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1F83tTl011351;
        Fri, 15 Feb 2019 17:03:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1F83tTl011351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550217836;
        bh=kHKbz0gOv35Ah/QQhnBmrwbYc/guOMnBm5JbWFvPQrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2xQN4FpOTqwbGcbGEAXjXa1e5FmcwxC1oMXIrbgyonBS8oOg+OxMYYj+BopMRwQT2
         mfw1/xYm6D1zg3Jl1C31m+Ty3OMt76hWZWvEgERXHeIj2NcKWorfDmF3TsCMkG+kmV
         D5lmyddj5bl8AR/fmRgqcJkGu+rHpx8disQoPAG7PIQGDTjlmxhrWBR6qn0Lrj/zSj
         xZFb5vpuG14b/GJNk7w1iGxO3LypxIGQ7iBEYW4S7j6HXSq57Eeha0stlVVn3CI20y
         J3tnZLR9VoaZxOcVYKN52ouG3lFuy0066/ATAokp1APUpVobxNlfeXM8t5yX8v+jL2
         8DfVCzOym/fsw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id r201so5263610vsc.11;
        Fri, 15 Feb 2019 00:03:56 -0800 (PST)
X-Gm-Message-State: AHQUAuZvCKVBHzvYPUVWXQ+XNKD+cTQnGvYQZZr1llwA1nTBv6l8+fNz
        WteTdxmi1YOOMb/n5Z96Wr6or0s7PjK65+UFLC8=
X-Google-Smtp-Source: AHgI3Iahfm5Xcwy0sIHWy0ApJ/yAOiV7JONTiN2xT2/kKwRTRvgfCpC9tfWmVJeNXL9iAgxPRe2CjirFE+7P4rhB788=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr4278793vsd.155.1550217835117;
 Fri, 15 Feb 2019 00:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-10-hch@lst.de>
In-Reply-To: <20190213174005.28785-10-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 17:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQL-7fMadH1R2SrmwJyDBRoCiECJ-WSJrztO2o+wkV06w@mail.gmail.com>
Message-ID: <CAK7LNAQL-7fMadH1R2SrmwJyDBRoCiECJ-WSJrztO2o+wkV06w@mail.gmail.com>
Subject: Re: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>



> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 52b4d48e351a..9de1d983a99a 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -29,9 +29,6 @@ config UNICORE32
>           designs licensed by PKUnity Ltd.
>           Please see web page at <http://www.pkunity.com/>.
>
> -config GENERIC_CSUM
> -       def_bool y
> -
>  config NO_IOPORT_MAP
>         bool
>



You missed to add 'select GENERIC_CSUM' for unicore32.



-- 
Best Regards
Masahiro Yamada
