Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32320881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="X745B60b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLBUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:03:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41094 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:03:30 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so8695294ioc.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLGcKEygPrM1x+RcE56w2mEPkTzR+dx1vQHaBqZTcys=;
        b=X745B60b5/ktkU903MlWSJt++9v8imDHs5VU79MVQQKX9JdNmhJT+xfZZehBq6J4mN
         ZlGiDcGANChAoyGiZCOePgDlfq6Xu0CSIvwyG4bJAgVRDGkYYjAcNPQFxjbOHm5M4d+e
         V4gnfqgvqSPmk1YecgZkT7t5YThbcO3X2LZ/9HoLKJvwEUpyYbR/AnL7Rbg1mPagOOK9
         OPgaGsVE3hscdLxd2Jse33WccvROvUoNXT2Vkwh6plZrc2Dwgu4Axgq6/u7s55F0p4qA
         5r6vd/e6GB2hpuv107pL6yUBt4JcFSbji2oCB6g3UdmGfq4oA34CH9hxjVERcuQlfcqC
         rppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLGcKEygPrM1x+RcE56w2mEPkTzR+dx1vQHaBqZTcys=;
        b=Z5WQOGgUg8QOdMZ9AJBwKTZGmLCxvTYOIbRK5GQ0ADaMEjZMSeWRtNyDC0eqbcBUrH
         mQ2069cz5H7j1GQClmJJ0kSdMo9Ytdw1pleCsTh2OAZILLiNXqj6B/GziU2aNVwrt4ha
         IBMIqfqNRZIeGTr/odPE9yaIDF2Frj9Lui/cnDtpOk2oO+KKQOK5yjEkMeCoMNYp5eFa
         8lDhDYOwrhbG9RZPYUn+wne0NR1CjjUYWPBlYl0rttFzOlciHSBRwzD3L7IZ9XScejYk
         +TKjMBA/jxRASS2QAjB9hoV59g5o5uUeZPMJHOLhkDz8BUMxJeppL9NWMs55ywdfd/zo
         GudQ==
X-Gm-Message-State: AA+aEWYzMAi5j7COZ2XqEiKLaCjT91waqIiWkpknik/lGYXVC98FviwK
        HP7Qes/1tAJ1W8vbRlZM++uGDoEr8LNGsZ7tiEE11g==
X-Google-Smtp-Source: AFSGD/VkuxR4saps5fhdiGOpgXVJk/OMVaVW1PHmc+8jlLGd+hswx/7ab2kcTFW0dYp8PxoDGYCC1BfdT8bC50MWang=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr12656624iol.155.1543781006394;
 Sun, 02 Dec 2018 12:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20181016145758.12995-1-matthias.bgg@gmail.com> <2529be64-7737-6237-7558-fb15dd22b513@gmail.com>
In-Reply-To: <2529be64-7737-6237-7558-fb15dd22b513@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 2 Dec 2018 12:03:15 -0800
Message-ID: <CAOesGMiE7M_urw2wyeE9gsv6C5xGnFG9uuT+z9rDeoed4mHSUA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mediatek: Update SoC entry
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        ARM-SoC Maintainers <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 11:41 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 16/10/2018 16:57, Matthias Brugger wrote:
> > Add IRC channel and URL of the wiki.
> > Also add soc drivers folder and regex to catch more
> > mediatek components.
> >
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
>
> Any comments on this patch?
> Through which tree should it go?

We can apply it directly, I'll do so on next pass. Patch itself is fine.


-Olof
