Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27632C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868C82086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elka.pw.edu.pl header.i=@elka.pw.edu.pl header.b="JBfdMULg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868C82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elka.pw.edu.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJKAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:10:08 -0400
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:45540 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJKAKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:10:08 -0400
X-Greylist: delayed 1014 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 20:10:05 EDT
Received: from [172.19.1.1] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id 129B268B01B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 18:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elka.pw.edu.pl;
        s=2007; t=1539189016;
        bh=z9Ug1FLp2u+K4LCQns5BuNiP4/dgnrZjipeVg422b1Y=;
        h=From:Subject:To:Reply-To:Date:From;
        b=JBfdMULg6e/LPrmP3nNaDQc1s4SN+WVVaHgZ+zu6TChLR0kyqs09k0sg+HB6OKcXM
         lQ50eZjWpy+Lx4mJFKFQcxqtYDTg/f/zZ/m+f0b9jn0n7wCqB0qe6uGhcoX3oIeVLi
         nt+4v+aLgoh5lSOBjtbqprWUloyHLM4GGPnUiAGs=
From:   =?UTF-8?Q?Wojciech_Zabo=c5=82otny?= <w.zabolotny@elka.pw.edu.pl>
Subject: Bug introduced in the of_get_named_gpiod_flags function.
To:     LKML <linux-kernel@vger.kernel.org>
Reply-To: w.zabolotny@elka.pw.edu.pl
Openpgp: preference=signencrypt
Autocrypt: addr=w.zabolotny@elka.pw.edu.pl; prefer-encrypt=mutual; keydata=
 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
 8YwTF5OPSA6HBHbZijiA7KH+Q2qQ+1f8Dg==
Message-ID: <8ce1cc97-3d79-9d52-f5dd-1bac1736a91f@elka.pw.edu.pl>
Date:   Wed, 10 Oct 2018 18:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The function of_get_named_gpiod_flags in older versions of the kernel (up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
contained an important workaround:

/* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
 *flags = 0;

Unfortunately, newer kernels do not contain it. Therefore if the
"xlat" function in the gpiochip driver does not set flags, (like e.g.
the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
the random, unitialized value from the stack in of_find_gpio ( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.
I suppose, that either the workaround should be restored, ot the of_flags variable in of_find_gpio should be initialized.

I have also reported the problem in the Xilinx forum: https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695

With best regards,
Wojciech Zabolotny



