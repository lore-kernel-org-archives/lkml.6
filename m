Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D908121473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="C0VKNSzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D908121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeHQLRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:17:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:41926 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeHQLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:17:55 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7H8F7GJ008407
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 17:15:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7H8F7GJ008407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534493708;
        bh=aaOf1Qn1Ur85xeijtULGDzZzMLuKA+HC5qhcoRyye/A=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=C0VKNSzDeA0/JwqsJvo8p/KCh4+rjNyOFxh5tNK4Pii5aiVALaRVweQIFOJ2QDkWU
         FwFuI6iFGOmZUAH80ZIXNcXNRUGgsChJ/ug8k7QQ+lM/O4oZxfndMGHRrbaR2ukIkh
         t/Zy5rIte+2oXnL21FcHsmJoSDlaNiaPKz/lDPonJiyws+fYlUr+pQwZG+VtSFuNg5
         3hA5dQKcsJ2sNNrlPZNWRcl/EOv33jnkGH/+vA/g6kZgQ5E9NkRATeHf6/z4jotOOi
         yP9bsx9l4iuZEbz91Yr6Yo3LK5Di0v4hLJUjIqjB1YPrppHt1cYkXwvm+4NQ5OrKs2
         VkcQTyLBHJy7Q==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id k25-v6so5231716uao.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:15:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlFxZ+vyWVu0/44StFmEztqU6C3JgqZk/p/5GMAnLeb6XHjdtedr
        TAUk7w7la69Lu/jnW8mnWGpYr/itbO2fBTf6lQk=
X-Google-Smtp-Source: AA+uWPze5GeFIXjO/vNNEIdm2QpfRDX8ebcubByQVq10T2qZhZfoOUhwkRvd9Mmvu2zdNbmJQLzZsIGShxFIV+tCLsE=
X-Received: by 2002:ab0:30ce:: with SMTP id c14-v6mr22274637uam.58.1534493707419;
 Fri, 17 Aug 2018 01:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 01:14:26
 -0700 (PDT)
In-Reply-To: <20180817074747eucas1p1a70969aac4238b0c8db0d8e59f4af078~LnGev9y9l2871228712eucas1p1X@eucas1p1.samsung.com>
References: <CGME20180816161825eucas1p11be9cea5d622b905154590bae90a47a4@eucas1p1.samsung.com>
 <20180816161817.12267-1-andrzej.p@samsung.com> <CAEYzJUHghs+2p4n1TesL3=VkCJcvs1TevjeFhqiQHdX+cqfqiQ@mail.gmail.com>
 <20180817074747eucas1p1a70969aac4238b0c8db0d8e59f4af078~LnGev9y9l2871228712eucas1p1X@eucas1p1.samsung.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 Aug 2018 17:14:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUsZB--DWMB4hpw74OnTiz+d2jrdp+CA9L=AOdkbEmhg@mail.gmail.com>
Message-ID: <CAK7LNASUsZB--DWMB4hpw74OnTiz+d2jrdp+CA9L=AOdkbEmhg@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: create deterministic initramfs directory listings"
To:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc:     =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, forney@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 16:47 GMT+09:00 Andrzej Pietrasiewicz <andrzej.p@samsung.com>:
> Hi Bj=C3=B8rn,
>
> W dniu 17.08.2018 o 01:34, Bj=C3=B8rn Forsman pisze:
>> On Thu, 16 Aug 2018 at 18:18, Andrzej Pietrasiewicz
>> <andrzej.p@samsung.com> wrote:
>>>
>>> This reverts commit 9e6e0d5f2a2713402cf9dce69b9f9b516e4185d2.
>>>
>>> The reverted commit introduces broken builds. Even though the cpio arch=
ive
>>> does contain all the specified files, it seems that the kernel, while
>>> populating rootfs, scans the cpio buffer linearly and fails to create
>>> files whose parent directories are nonexistent at the moment of this fa=
iled
>>> creation. As a result, such files are not accessible when kernel boots =
into
>>> initramfs.
>>>
>
> <snip>
>
>>
>> I'm unable to reproduce it. On my system the listing is sorted so that
>> it works (parent directories appear before files). I tried to run with
>> LANG=3DC and it also sorts correctly. What is your LANG=3D? I think we
>> better add a LANG=3DC somewhere in the kernel build system, because I
>> think you have a LANG=3D that makes it sort differently. A quick fix
>> would of course be to insert it right next to sort, but there may be
>> other places that may break due to LANG=3D settings.
>>
>
> Thanks for the tip. My LANG is pl_PL.UTF-8. Indeed, prefixing the "sort"
> invocation in question with LANG=3DC does solve the problem. I don't feel
> competent enough to say whether this is the correct place for the fix,
> or if the fix should be made elsewhere. Another option is that it is the
> "sort" itself that should be fixed (or the locale, or both).
>
> Would you be able (as the author of the patch in question) to check if
> there are other locales which cause the problem?
>
> Thanks,
>
> Andrzej


I cannot add LANG=3DC to the high-level of the build system at least
since it would break the localization.


--=20
Best Regards
Masahiro Yamada
