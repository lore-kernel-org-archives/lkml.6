Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E2ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DB220676
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="08hfiQLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DB220676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeIWTn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:43:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33965 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:43:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10-v6so328095lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C5+9DdUIa1SXcHBQy7B4QK/Om4O6fR+/Z/u1c1nwl/8=;
        b=08hfiQLSGyCSsJJp62uLSBCR6ymKe5ipStBxuZfWZVT/gh8xaVkqX0hQLAZZbpBb8D
         l9j1UcC/yFvvuelFlcrzNfc7TcTDvlmzTfsIXk3cWJIku7y9yNo7WkTC93TtErUcoJH9
         5N5L0y+pi3zKgGQetyxGgr41x+mz65f9EA/0Qbkytw7jLv5cycP54h3ZwcszpIGlaKi6
         UAgeV4WJbO/qjXakJelr5hxW6aauUx/ZuClCW53wkvdF4FtKZ/dK5RtN1EcvnLYvFv9n
         n3h69DikULZ16pOMPEOueaxIKL4eV7ZuLFyWmIXQvwk18bygZBdu0Q+ZbE+FKO5hLK4U
         K62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C5+9DdUIa1SXcHBQy7B4QK/Om4O6fR+/Z/u1c1nwl/8=;
        b=Ls+T9SxCumoB8bK1HINIjFJTDVB9QWdm/V8K40Oo6UyUhFm66vohUrtkVw55feHykN
         qMggeNs5whESJiXK67DtE2OVpAEFbJfrRQaYTwvfjc1tPrbc4pJ1THh+GfVCHw/gVCMk
         B4OrfvTmMOP0DqctZUoSnX4xkN5vdgjaDwgD6zCKXCq6H164RsgjJdjyXcMA82y/sWfR
         QSqpXngUfy6QqencwF21DL+CVo7vd07KFlvucDO1R+FlxMMDK72lFC9CvAZY7N0pypwk
         Ke+EyxUos0ndOp1QvNYhHKcXL2ErltDok3FzojtWIJjZP9D/kH3CdSIcA7+rp8n2i7rP
         EowA==
X-Gm-Message-State: APzg51B2lRI5intZLEtZdfhDZPQuO8hJ+LSYPbr331hf22pVddn/EDZE
        5cs0iiU2YOdA0jySGwproSfdt8RGJfWj3MhSHVr/7Q==
X-Google-Smtp-Source: ANB0VdZU2xTcCtD6WkQrvRyTjwPPFcmSLcWFbnWZUjDVfV2xRMveQPVL74vNZR/j1CvJs90nt3jDcJQIyt/P4RZA5ig=
X-Received: by 2002:a19:1588:: with SMTP id 8-v6mr3739390lfv.36.1537710382039;
 Sun, 23 Sep 2018 06:46:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:eac3:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 06:46:20
 -0700 (PDT)
X-Originating-IP: [85.30.9.151]
In-Reply-To: <20180830180205.18121-1-krzk@kernel.org>
References: <20180830180205.18121-1-krzk@kernel.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 23 Sep 2018 14:46:20 +0100
Message-ID: <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
>
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
>
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.

I have to admit that I don't really like this approach, and I missed
the patch when originally posted (I did notice it in the pull request
it came in with though).

The main concern for me is that with a blanket "everything is always
unstable" we discard the notion that we should strive for bindings to
be stable and backwards compatible.

Questions that come to mind are:

 - When do they stop being unstable?
 - Is there a way to note in the binding itself that it's still
unstable with an anticipation of when it will be settled in?
 - Is there a better way to version the bindings to avoid complete
backwards compatibility?

Pointing out a couple of cases where it has been painful to stay
backwards compatible could also be useful for understanding (even
though you run the risk of each case being explained away with
suggestions of how it can be handled).


-Olof
