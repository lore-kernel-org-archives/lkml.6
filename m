Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50677ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBF821473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LDbqF+hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBF821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJRLX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:23:29 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60373 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeJRLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:23:28 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9I3OEI8024814;
        Thu, 18 Oct 2018 12:24:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9I3OEI8024814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539833055;
        bh=0HoAy8lyK1GTxpmQU9CCIt4f1xXNJYMkHsEXOrpiE54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LDbqF+hcEzMGYJw1ThfDYoDOKQvQyix5u+wWQ9HCKKMAbIeAnr4bp075X1Dbi1Hzy
         OtdNFYKraExEUM1TMHzqLhr1u/ELI2ZueBEDmDGGQRg2fPvEPgGOFXRhH57lT+5g1W
         f7sPOwTGZ5C0nQqdLKSamjmBjeF4BQkACW3/FlfFc0t37qQSXC0MB3Fb1aGy+kb0Ht
         In+2nn96qrt9rWGtH2I09zV0mhZ81Hf/GlsLe9hv0QYY56sY06oQw76bOb3ys64LwK
         Kmog58tiD8L9V4IKm7RO1m/w9smfn90w0gbcJlxNUDTM8yD7GE7W6sufq/c/z7uN0R
         amoYdC79BEUkg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id r83so22181394vsc.4;
        Wed, 17 Oct 2018 20:24:14 -0700 (PDT)
X-Gm-Message-State: ABuFfohjqyETGmFNQDlrR2QkWow4vikWy6ikpdsDX9L3YM4Q/ElUB1uF
        wlptVRsRuBURuEihqSGIfMIPyJD0asUNOYGx+2I=
X-Google-Smtp-Source: ACcGV60H3wutY3x24BAS5j6BQ/d6boZ+rODt+4LIJa0iEa4BD16jZcTXiBMXuXd/8tLbg5BqUAs9YHTAow5XU6mMbuA=
X-Received: by 2002:a67:3793:: with SMTP id j19mr11436330vsi.215.1539833053544;
 Wed, 17 Oct 2018 20:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181017180657.9410-1-natechancellor@gmail.com>
In-Reply-To: <20181017180657.9410-1-natechancellor@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Oct 2018 12:23:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjwZr2NPNE9aGnzQv-uUWjf1=A+kX3pjALqYfsWORv5g@mail.gmail.com>
Message-ID: <CAK7LNARjwZr2NPNE9aGnzQv-uUWjf1=A+kX3pjALqYfsWORv5g@mail.gmail.com>
Subject: Re: [PATCH] isdn: hfc_{pci,sx}: Avoid empty body if statements and
 use proper register accessors
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     isdn@linux-pingi.de, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Oct 18, 2018 at 3:09 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/isdn/hisax/hfc_pci.c:131:34: error: if statement has empty body
> [-Werror,-Wempty-body]
>         if (Read_hfc(cs, HFCPCI_INT_S1));
>                                         ^
> drivers/isdn/hisax/hfc_pci.c:131:34: note: put the semicolon on a
> separate line to silence this warning
>
> Use the format found in drivers/isdn/hardware/mISDN/hfcpci.c of casting
> the return of Read_hfc to void, instead of using an empty if statement.
>
> While we're at it, Masahiro Yamada pointed out that {Read,Write}_hfc
> should be using a standard access method in hfc_pci.h. Use the one found
> in drivers/isdn/hardware/mISDN/hfc_pci.h.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/66
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/isdn/hisax/hfc_pci.c | 6 +++---
>  drivers/isdn/hisax/hfc_pci.h | 4 ++--
>  drivers/isdn/hisax/hfc_sx.c  | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
> index 8e5b03161b2f..a63b9155b697 100644
> --- a/drivers/isdn/hisax/hfc_pci.c
> +++ b/drivers/isdn/hisax/hfc_pci.c
> @@ -128,7 +128,7 @@ reset_hfcpci(struct IsdnCardState *cs)
>         Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
>
>         /* Clear already pending ints */
> -       if (Read_hfc(cs, HFCPCI_INT_S1));
> +       (void) Read_hfc(cs, HFCPCI_INT_S1);



Why is this '(void)' necessary?

I see no warning without it.



-- 
Best Regards
Masahiro Yamada
