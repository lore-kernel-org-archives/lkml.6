Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F278C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF33206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GAe4gJab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF33206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeHPKvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:51:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23070 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeHPKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:51:17 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7G7sK6E010195;
        Thu, 16 Aug 2018 16:54:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7G7sK6E010195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534406061;
        bh=KdSh7dkBsHX8v+jiaN8Kd+SJzJk6pqr34nouKwYYfuA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GAe4gJabtf3yCGKSDIMOTqEJvuQOvGSLEDKd5mtd0kgSMs67bohCmLAhKxOwjfwvW
         vLrUWHX75Mgcqdctw4NSuf46QBmRvYS3JqZmnoX93H6rxE7KLkGcJ2R75gECBO5kzu
         zRH3XdbMAPI7/te8SnNiIWIdvoNQq6e0ucCxu28/1cR0M4XbvZXF79He0/Z5S8hqBy
         VHcg+4lFjGlk+mkKSk2NAU7mpzIaO7yIbCaYHX/TVg6uPT7Kedd5fCnjnr+SiNsD3o
         uJlU+AWjN1x4ShFH5QBzHGEst/2ITKZfUxBFUA2nFvt1XG3g8YPwlgbuSUAc0ZRUUV
         6mA9XQXE/bXNQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id g18-v6so3122822uam.6;
        Thu, 16 Aug 2018 00:54:21 -0700 (PDT)
X-Gm-Message-State: AOUpUlGMTKiVpD/U06WIYuRaVb1ZDMaagvagc9IkhzKJw+ujdzA0ICxD
        Bft0ULzIhAgt+C3PgY1mcRX/B4t5ACwBxCPF1S4=
X-Google-Smtp-Source: AA+uWPxQC1DelDmNKt5kiyXpxajSUvM/YFcftbD1PWtb9vIn+3Z0Y/kBGNvcfgrcmL3u1A8m2r4kiNGpHrDJytdJMX4=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr4033170ual.141.1534406059859;
 Thu, 16 Aug 2018 00:54:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 00:53:39
 -0700 (PDT)
In-Reply-To: <CA+55aFxRPLjo_XnWDw5sYLnSjNhf8iPHGXomQitnGJjyuViXCQ@mail.gmail.com>
References: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
 <CA+55aFxRPLjo_XnWDw5sYLnSjNhf8iPHGXomQitnGJjyuViXCQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 16:53:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWKrg=U+a1NJW-2SEp2LtG9wwDHQbPdYk=nDHCVSMeEA@mail.gmail.com>
Message-ID: <CAK7LNASWKrg=U+a1NJW-2SEp2LtG9wwDHQbPdYk=nDHCVSMeEA@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] Kconfig updates for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,



2018-08-16 6:10 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Aug 15, 2018 at 10:58 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Masahiro Yamada (15):
>>       kconfig: make syncconfig update .config regardless of sym_change_count
>
> This one is annoying me.
>
> I don't care if it updates .config. But it does so *noisily*, so now
> my build scripts en dup having extra noise coming out from them in the
> form of another
>
>   scripts/kconfig/conf  --syncconfig Kconfig
>   #
>   # configuration written to .config
>   #
>
> which is just distracting me and doesn't seem to add any value at all.
>
> Ok, so it happens because I for legacy reasons have a "made dep" that
> isn't useful any more (but my fingers have that as the "let's do a
> kernel build" now macro), but it does seem to be entirely pointless.
> Why make that big noise about something that doesn't even *do*
> anything?
>
>                   Linus


I see.

I wrote this patch:
https://patchwork.kernel.org/patch/10567117/


I will apply it to my tree with some other fixes
and send another pull request in this MW.


-- 
Best Regards
Masahiro Yamada
