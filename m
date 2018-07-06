Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2FEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A24240B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iHpiR4Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A24240B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeGFAow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:44:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27635 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbeGFAou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:44:50 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w660iUW1001320;
        Fri, 6 Jul 2018 09:44:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w660iUW1001320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530837871;
        bh=TzvM9AMM8+7VwTK2hG1fGUN36X/IOSMV8tnbf0keMF4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iHpiR4RnzYMwuwUg5Gq8pofjChb+SHS8yzShhsSrhSvakqbftLD9NUkm9KPqEJ/yV
         NbehayiTqKPKlgkQyBB2zeFycJZDcb8X/mmAMYvm+/fWj3SdpF9YyQvCr1YfTGWE0t
         znUll4JlNclktR0/6T+eS3pPhjzQoaSBR4GHm0OmuQw45QQuX3xL1XhVPNfJHQeR4R
         6ea1optbhD1s3NccfIs3gfsKp22fG7MDgVqJoEnOduzewTPilXbhdSF1pNErfvClWy
         yKHzJ8Fkvk+s4/06S0pjKSUzCux6es2z8WV7zf7zod2c4QCBKlN/UH0i/Sb66jCnnV
         YxfxhQR3C3ueQ==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id l64-v6so5902912vkl.12;
        Thu, 05 Jul 2018 17:44:31 -0700 (PDT)
X-Gm-Message-State: APt69E1EPYQUXB2KJjIdTYdnlQ9AEBXdIwLdXb34TBWlnrsAsXNoM16w
        bNolQ6YWc6TvVZx6YT0JB2D5M1AZCOrY6/7sKQk=
X-Google-Smtp-Source: AAOMgpcTt4FknTuup7cdNVIdqKualiF0ybNngH5vdGFtP8E7OjYhE8D2FP1DzP1fRKlBBxdcM4hdiQxSXfuU0eUvRkk=
X-Received: by 2002:a1f:88:: with SMTP id 130-v6mr4618475vka.154.1530837870104;
 Thu, 05 Jul 2018 17:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 17:43:49 -0700 (PDT)
In-Reply-To: <9a4b8d07-b9cc-4843-a74c-7f40ebc4c9af@infradead.org>
References: <9a4b8d07-b9cc-4843-a74c-7f40ebc4c9af@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 09:43:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqeD8dcjHFHd8rFcyyyihQC4=CRBx0_LH6GCq6HDeW-g@mail.gmail.com>
Message-ID: <CAK7LNATqeD8dcjHFHd8rFcyyyihQC4=CRBx0_LH6GCq6HDeW-g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: update kbuild.txt ARCH alias list
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 4:57 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> In Kbuild documentation, add alias for 64-bit sh ARCH ("sh64")
> to the list of ARCH aliases.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/kbuild/kbuild.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
> +++ linux-next-20180704/Documentation/kbuild/kbuild.txt
> @@ -88,6 +88,7 @@ In most cases the name of the architectu
>  directory name found in the arch/ directory.
>  But some architectures such as x86 and sparc have aliases.
>  x86: i386 for 32 bit, x86_64 for 64 bit
> +sh: sh for 32 bit, sh64 for 64 bit
>  sparc: sparc for 32 bit, sparc64 for 64 bit
>
>  CROSS_COMPILE
>


Looks good.


I will change the subject to

kbuild: update kbuild.txt ARCH alias info for sh


I see another patch "for sparc".

https://patchwork.kernel.org/patch/10510213/


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
