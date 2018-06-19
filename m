Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AD220652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="m9+CR/ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AD220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966552AbeFSN5V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:57:21 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36340 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966465AbeFSN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:57:16 -0400
Received: by mail-ua0-f195.google.com with SMTP id c23-v6so13092877uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Ap7JQsAzcPu16fRCPFa7MEZ4aT0Ss+7rmepAOwI/Pg=;
        b=m9+CR/apiPevKoJm84h7D8TrKSjT6uc4gHEN5wUiUhndpx4YphroWuY6qlDE467d6u
         nPlKGq9nIlll99V9Ku57HZwIVzbzxuQqIsDyNt6hglBR4kf7D91V0QgyZaAt7m80w3al
         Jx814CQDYsnA5a8KcRD5LdeaqVGqKE1O+XLCSZ5l/QohK4eNp5aZVkH/7WuXonBdaoVH
         oWBV0d90XNAhUsA0PthzjQAo88qUvC2a/Ocl+Mu5JGpVeU/PEMK6DAJ0c2PHhCGSqZFB
         hiubzjHhiTmQ5f0e1IVq9ZEtVnr/clLhGi6jPQxiea6OlHIpM8hAX0iVIt4tszGmHf6y
         kCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Ap7JQsAzcPu16fRCPFa7MEZ4aT0Ss+7rmepAOwI/Pg=;
        b=Fb47VscWFaRlkJYdNKyEid+gJzbMj07QtY5PdtQ5HKPW2q5/5h/i2zq2grCclkhHYc
         zQpUmbnINXRTakBUclF/ZYPWk+y/hlLc90ft/4enBXNqrgZYFQwCkpehkpMWH0phDaG4
         Z2Jx+VY7pwEEs/BBV5TjUPaUErE1DgbtdUPH9TM6xCuurjyURDGiMjyYjMFzSvn32imN
         dSWhbY0eMJp3BQQikqEfh+vc19aSLHoQw8HD6ZoFEqdLa7RCwja8jYolPs/lt3IyIjmO
         sZHMVkGDZPSz+PNgRthDK/YP9pO24fLgnMNeh9FesHmKodo+LvKWCIFl6PoGopfjH0fb
         Bueg==
X-Gm-Message-State: APt69E2xmPiRIj6WSgaOQM+mmwwC/VlN+wGTddk6Vz0MtxA9iCObScQq
        PxqrMTxxVAgo3xqld/VCytOGpTzafj16T36kKgk9OA==
X-Google-Smtp-Source: ADUXVKIlDTBKWsKZo0F1qPQTDpMsX5yBtHfZHsJE9FTG5qMwGUC2V68fVFRVkMdayeh1Si6/r4KuC1R6rX2auLb6XKg=
X-Received: by 2002:ab0:5a2f:: with SMTP id l44-v6mr10328296uad.188.1529416635445;
 Tue, 19 Jun 2018 06:57:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c4:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 06:57:15 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com> <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 19 Jun 2018 16:57:15 +0300
Message-ID: <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Simon Horman <horms@verge.net.au>,
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

On Tue, Jun 19, 2018 at 3:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Gilad,
>
> On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wr=
ote:
>> The patch set enables the use of CryptoCell found in some Renesas R-Car
>> Salvator-X boards and fixes some driver issues uncovered that prevented
>> to work properly.
>
> With DEBUG enabled on R-Car H3, I see lots of
>
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0)
>     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8)
>
> during boot. Is that expected?

Yes. The condition itself it is reporting is not necessarily bad. It
means that driver
did not act on certain HW notification during interrupts and that's
OK, we don't act on all of them
depending on configuration - e.g. if you have CONFIG_FIPS enabled and
an active TEE module or not.

I can rate_limit the message if it bothers you but other than that it
is a harmless debug print.

Thanks,
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
