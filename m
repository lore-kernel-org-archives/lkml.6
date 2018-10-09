Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3121479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AEYCLdC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB3121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJIWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:31 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17677 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:31 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w99Ev6fn018300;
        Tue, 9 Oct 2018 23:57:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w99Ev6fn018300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097027;
        bh=m7/WFdqs5WYwax/1GpneHIuc93kBzLolfPzM9PGK2gA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AEYCLdC9hdcKdLi64BeaS/7k1s5vk5VHe0TxPeFmadGbABVnK9kxT1EOZyMkXRPLC
         PCWyAF0CwsudkNpDrs8ZARyUHxU9Lk2Xds6+0r5+4SJv4Y/HRqrMXmaaBl8PR+/Frq
         ZR0cGRu9c1RXeSO+I2iVYg62MtJJVwCh7fYz2mbC3GVIHbz48TGqxhQruNT9ptfPU7
         ezRNr7sNUs8HdmJ8jTZkk5GeRFkBSyXsvt/53m0+8UpCjpJsuXxFcsR+8BcLbvJ7T8
         K13eDqyafTsozMpZxoxcIrP8e1Bgyfe1hq4nfpwsJJQq7ee/o9V3rfWSaA1RTqcaFG
         JIB9bQJI3CvcQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id c10so1801309vsk.2;
        Tue, 09 Oct 2018 07:57:06 -0700 (PDT)
X-Gm-Message-State: ABuFfogdgvDjyZyO1JDhWP7jHBv3KGgDgTSLLL2xbjUyLYBEaaC1Oyr/
        dKVJtxBsM+dvNxrBQQQ6xVwlGwi9ask/V/VTyy8=
X-Google-Smtp-Source: ACcGV63B5JIrQwfafi6jcXM67mrzbnkTKSDZ10G2f7IxsemipdUMwc5fkYRPesCDVjGysh4AbKv/yv8TqXMF5KsB/+E=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr8832644vsb.155.1539097025506;
 Tue, 09 Oct 2018 07:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Oct 2018 23:56:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0oiqBDT73O_O+S4vxU1LRO9UZLh5aJ+Wk+KwXNRojyw@mail.gmail.com>
Message-ID: <CAK7LNAS0oiqBDT73O_O+S4vxU1LRO9UZLh5aJ+Wk+KwXNRojyw@mail.gmail.com>
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, David Howells <dhowells@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Some samples require headers installation, so commit 3fca1700c4c3
> ("kbuild: make samples really depend on headers_install") added
> such dependency in the top Makefile.  However, UML fails to build
> with CONFIG_SAMPLES=y because UML does not support headers_install.
>
> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
> Reported-by: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

I did not get any more comment.
I applied to linux-kbuild/fixes.



>
>  samples/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index bd133ef..ad1ec701 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -1,5 +1,6 @@
>  menuconfig SAMPLES
>         bool "Sample kernel code"
> +       depends on !UML
>         help
>           You can build and test sample kernel code here.
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
