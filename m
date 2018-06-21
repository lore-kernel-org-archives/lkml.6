Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF40C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D86208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="02c/yPGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D86208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeFUFBC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:01:02 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40797 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeFUFA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:00:59 -0400
Received: by mail-ua0-f196.google.com with SMTP id l11-v6so1200006uak.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vc9ZGU18FCQ7P8RO3Alkx8eGMKt3EI45j6O8bFaNXOc=;
        b=02c/yPGWKfe4po9AsobLkZqPdUtLhPfGIDPnsdQxxUf6NKpIRNDnHHUH4qslhCVc6g
         EwaX/A3+39I1qwd2TeCRDOWKPe1rvgdKJ2xcPJCQIXx4Im6P3//J2Mvk6H4HKSWU/c5o
         /EG3hz3CZhdY7G9qOG3W+gH09gHyGOKDREb8MhLAdmZ/abgHT58q0w85zXXqWe6Jx5v5
         1lgkpsPGmN6hpDBS+s12M7kHu7bTYltES4u9w3xDK66lUZxiQRrWegDrCGKPavVAxqs/
         sbItf2zFeKFJW7tX1jcbIkI2WDgKNkQUujhFixVt2lHhTf+msVX5nrdQh9wt2BbMpbr9
         VRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vc9ZGU18FCQ7P8RO3Alkx8eGMKt3EI45j6O8bFaNXOc=;
        b=UZSmLYy5tcBpr0g4AbFaGrGFQgI9t8SZOrXB9hYGqLkkC9GqO7ktYWyGAkXb0xeEEz
         rov228yA7IKV0TP12iuyDQc7Z7WFSvNGYD4osLMAfvyVBXiZPZxBanwQZARy8H5mqhhU
         aVBKybcHOcCbsk26vM0zTHFzlYHU0sM84Ze8zbgsflqnbE1QTgugW1RiWA7hOH43vF6K
         U5eU+a0g/Ak3F6gg+wxEP553TF844MWXTXaj53nT9l7jq18nxKN5OQUggXNXkO4gePTK
         syJPMvhLbrcWllVkhqi3OpyD9tFoLHx2Zr1zw7RxWck9YMm+qpXtlKxqzIGY8+g+G19r
         hj4w==
X-Gm-Message-State: APt69E3RTTS5+H70ADeWQsPndSGkJ+2rhdjHt3Q4RVkOUfvqgcoDwAIz
        7o3Kj9iiukfw8iDwZRFtSzEKc5EbMp9OKqeI6UXGUA==
X-Google-Smtp-Source: ADUXVKIk1k/KnvBiwt6B66u2ZlUiQwwBF8lLiEAzMW0qjnL8R/88ujlzyVgj9iVCz4/2FDXMTmN8XFYC1YKL9YwzT8Q=
X-Received: by 2002:ab0:4d44:: with SMTP id k4-v6mr15452469uag.177.1529557258224;
 Wed, 20 Jun 2018 22:00:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c4:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 22:00:57 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <20180620085145.7bxfbu7bi45sftnk@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
 <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com> <20180620085145.7bxfbu7bi45sftnk@verge.net.au>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 21 Jun 2018 08:00:57 +0300
Message-ID: <CAOtvUMfgUFT3+8kwVpACU6tXBX1TrzB-1uiHg7X=KXN-Utv0mg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:51 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jun 19, 2018 at 04:57:15PM +0300, Gilad Ben-Yossef wrote:
>> On Tue, Jun 19, 2018 at 3:58 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > Hi Gilad,
>> >
>> > On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com>=
 wrote:
>> >> The patch set enables the use of CryptoCell found in some Renesas R-C=
ar
>> >> Salvator-X boards and fixes some driver issues uncovered that prevent=
ed
>> >> to work properly.
>> >
>> > With DEBUG enabled on R-Car H3, I see lots of
>> >
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0=
)
>> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8=
)
>> >
>> > during boot. Is that expected?
>>
>> Yes. The condition itself it is reporting is not necessarily bad. It
>> means that driver
>> did not act on certain HW notification during interrupts and that's
>> OK, we don't act on all of them
>> depending on configuration - e.g. if you have CONFIG_FIPS enabled and
>> an active TEE module or not.
>>
>> I can rate_limit the message if it bothers you but other than that it
>> is a harmless debug print.
>
> Rate limiting sounds like an excellent idea to me.

Will do.

Thanks!
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
