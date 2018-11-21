Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45172145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VkRSWUTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45172145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKUQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:48:26 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34184 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:48:26 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAL6F17r013486;
        Wed, 21 Nov 2018 15:15:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAL6F17r013486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542780902;
        bh=zB9Y5yyvxPcBgFCnd1m/5LsDMilPNg9+nFlfgxS2Oyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkRSWUTO1LcQjQU3glnBQMDCDtiNIGOhFvOgpgC4CUkQLE8hDYmjfcXten5fi8TvY
         d/aqZ86JT5F9BFVKlVpECzhAHtjAdnjRgRn9eqTTf/m/BvCP9N2O2PXqyHzdiwq0Sn
         n+80BKF4G94FTKLtIGaj/t0nsFUN07mp2BBB3RYnwL8ecbE13iNXngoTB8hQInqEzk
         fQIkQu+W0B6cZ8oPUQw0n6gchqu/E9WfISGT4CWo7lecK5D4v9GHge65jBTkv2XXTt
         o0APTMbe30T0+9ToAZvJ2X5i6McrIZ+RQYzAQkWpC6+TJFEdUiqwBOWmGftUvHbcKu
         0qIYN9NRumlxw==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u19so1538052uae.4;
        Tue, 20 Nov 2018 22:15:01 -0800 (PST)
X-Gm-Message-State: AA+aEWaKuzmUBZTFkqCs4NqdkqgVBrDIk/uhx3CJaBVUSR0q6Wp4k3qr
        Eje52z/k7qfUYisH3nr65kI8tt6ebjvMvQHwLeE=
X-Google-Smtp-Source: AFSGD/UNXD31pXr62mBt74CcXL6CkOfiDVKpTMpzjfOVBVTFoK5s+BZGWLBDt7NdSz0tlPC6EmZfc6ls/fizPdzYb30=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr2144141uaj.42.1542780900768;
 Tue, 20 Nov 2018 22:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20181115005602.30746-1-paul.walmsley@sifive.com> <20181115005602.30746-2-paul.walmsley@sifive.com>
In-Reply-To: <20181115005602.30746-2-paul.walmsley@sifive.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 15:14:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQL78X2aLsAM9YQb3oCZOb+kQkB2NkoX8r=rBsH7e7mQ@mail.gmail.com>
Message-ID: <CAK7LNATQL78X2aLsAM9YQb3oCZOb+kQkB2NkoX8r=rBsH7e7mQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] modpost: drop unused command line switches
To:     paul.walmsley@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 9:56 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Drop modpost command line switches that are no longer used by
> makefile.modpost, upon request from Sam Ravnborg <sam@ravnborg.org>,
> who wrote:
>
>     modpost is not supposed to be used outside the kernel build. [...]
>     I checked if there were any options supported by modpost that
>     was not configurable in makefile.modpost.
>     And I could see that the -M and -K options in getopt() was leftovers.
>     The code that used these option was was dropped in:
>     commit a8773769d1a1 ("Kbuild: clear marker out of modpost")
>
>     Could you add a patch that delete these on top of what you already have.
>
> https://lore.kernel.org/lkml/20181020140835.GA3351@ravnborg.org/
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---

Applied to linux-kbuild.
Thanks!



>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..85bd93c63180 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2416,7 +2416,7 @@ int main(int argc, char **argv)
>         struct ext_sym_list *extsym_iter;
>         struct ext_sym_list *extsym_start = NULL;
>
> -       while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
> +       while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
>                 switch (opt) {
>                 case 'i':
>                         kernel_read = optarg;
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
