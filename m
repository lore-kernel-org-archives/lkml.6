Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C8C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2000224011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l0fMIra7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2000224011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeGFBGh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:37 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28819 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeGFBGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:35 -0400
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com [209.85.213.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6616MCf007953;
        Fri, 6 Jul 2018 10:06:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6616MCf007953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530839183;
        bh=fuH8I96q4dZgrjr1aCUmwR0DKVhp0IeYUcMl6/xxilA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=l0fMIra77QO7uP/tNNtWI9mSdrL7f1Ucph/T7vvKfnFwqdyCC6g4rtHYc14NjcL2Y
         r4Kp4j9toW099xoHravF9uzwxXSCIAD8hvUk155hL+U1w9JB+Np+p/xx4w/7T1PNVz
         E5aFlruX5liFsh75eHgqeK1+b3gZbRbUdVuuvToycq3hd593ZVcBgEwLS+iOsBgYs7
         DnjenciLeUYNG83E1XZFf0rt1K+ZlczBPCTapJ0XcykydoYNjPZNTM9ROPP5jXrjHs
         5oaMeIloPsQpm4UjuT/PVLWvn90gnXw697xu3fZLGkMGZHqE7Qtvs0ItdYYuGOgeZl
         gdYqHGu+LeWwg==
X-Nifty-SrcIP: [209.85.213.43]
Received: by mail-vk0-f43.google.com with SMTP id o202-v6so5931984vko.2;
        Thu, 05 Jul 2018 18:06:23 -0700 (PDT)
X-Gm-Message-State: APt69E0tL21I4OqVW/kL2Zy87EB48oMvrod0eSs9BY3Gy7kSOwv+N4e1
        dZmnor3erMI8d+62qAmkxz3Ws0LXj61gz2vPI+8=
X-Google-Smtp-Source: AAOMgpckCuPz+O5I92+Ph2xKjvBg/8Ie3wiAHW930qpDGnRKZgrtNU/NBRiMQKOm93bmUfI8wKtOPNYsmmtjAtj8atw=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr4720655vkf.34.1530839182019;
 Thu, 05 Jul 2018 18:06:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 18:05:41 -0700 (PDT)
In-Reply-To: <9a4b8d07-b9cc-4843-a74c-7f40ebc4c9af@infradead.org>
References: <9a4b8d07-b9cc-4843-a74c-7f40ebc4c9af@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 10:05:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASS3k5FDGLdB=ak6-zUHZA1zsF4_v=+NsNyZbf=7Qer=g@mail.gmail.com>
Message-ID: <CAK7LNASS3k5FDGLdB=ak6-zUHZA1zsF4_v=+NsNyZbf=7Qer=g@mail.gmail.com>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Applied to linux-kbuild. Thanks!



-- 
Best Regards
Masahiro Yamada
