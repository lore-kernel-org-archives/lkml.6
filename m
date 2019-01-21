Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEAC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31522085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ILLKqWAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfAUPgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:36:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33190 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfAUPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:36:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so6430512wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gsIWm4YAdMzHSFkBaQakNMAM/i+/75SJ59wg5CyuTfI=;
        b=ILLKqWASQ9GcKR2KmgabCHMcn46Kt5Fqhi2/syIf+dzthSJObEKL8UGqxkPZNRKvKj
         xJ+vc2PTmx9jVMhHNB/8a9ICOlw4Q2MyNWfzlhvwGjgzyMbXoe6g9A0elSruMdLlQy3f
         IShfp9EepVvSyyqsZgp5Y3t6Gb8zWX5nahtgjwtXRho/ygMcvQ66iPBiwiJ+jm9nVOJn
         FaQGesxObRFiUQ3phpy8r16CXDSrtucmxK3/laDVdj+CzKK8JheB667GFHA7TUudQRSl
         EVYESiK+Jk4954Pum4iM6qAr04VR/9d1PyJ0UFV48nSW4tMaFHxxPQbuZJVZX/+4fAWB
         YcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gsIWm4YAdMzHSFkBaQakNMAM/i+/75SJ59wg5CyuTfI=;
        b=dkYGjU/rMAv/Ko9QWz4CUQzoc8Uwk6eDp0ovzs4o2kOfQPx196czVlJfOL7Gvse/v0
         DjWTRB4aaUc6Og2bSwO/IOKL4sMPNXfAeiAhEt+wzzux9+opUlYTs5RrG88dJWlRndZa
         HF063aOSqyRdw4wY5HNpD6NyZYTExujaPQp57th4/b6LXShx/A9oDVlDGtkmig4BuyQf
         8b9KNpseoUAgRbMAOXlSXiycdWbedoDGcQRBLCRKXrwhphyDRLQ+JY1k40nj6Gu9rUtL
         14VKj/dMoUcZcr/vlOwBfWy439ktyVT1DFLP5QmlnHM2tAkB1ejgVWpYtmQbulqFIOz2
         Ps2w==
X-Gm-Message-State: AJcUukdMQ70tbtIXyjb6wptF/v9XDW95DtReUcxx21PjbPDKOqKOkmWF
        LRDr5+k5DyCuqK3vKPw5OOOrD2I1IHE=
X-Google-Smtp-Source: ALg8bN4287u8JGodm32UPUcS7IXUrJK558ctFhFfap4xkwzei3zdL2VvgHfNTD0/Yf9x8Fs+Q5yHyw==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr26187811wmc.3.1548084970525;
        Mon, 21 Jan 2019 07:36:10 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id e27sm108804445wra.67.2019.01.21.07.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:36:09 -0800 (PST)
Message-ID: <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com>
Subject: Re: [PATCH 0/3] pinctrl: meson: g12a fixes
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Jan 2019 16:36:08 +0100
In-Reply-To: <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com>
         <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 14:53 +0100, Linus Walleij wrote:
> On Thu, Jan 17, 2019 at 11:23 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
> > This patchset fixes the initial pinctrl support added for th g12a SoC
> > family, which is mainly around the register regions claimed by the
> > driver.
> > 
> > Linus, would it possible for you to provide a tag with these changes to
> > Kevin ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-meson-fixes
> 
> > ATM, we can only use the devices for which the pinmux is already set by
> > the bootloader. Enabling the broken pinctrl driver could cause regressions
> > in kernelCI. Having a tag, would allow us to start using pinctrl on this
> > SoC in this cycle, w/o regression. It would be nice :)
> 
> When you say "this cycle" do you mean I should target fixes (v5.0-rcN)
> or next (v5.1) with these patches?

I was referring to the 5.1 release but it is a good question, I did not really
think about 5.0.

Those changes are mainly fixes, so guess it could go in the 5.0 but support
for this SoC is still in its early stages, so either way is fine by me. 

Whatever is simpler for you I guess ;)

> 
> Yours,
> Linus Walleij


