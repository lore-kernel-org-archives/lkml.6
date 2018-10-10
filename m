Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C377BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5CA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5CA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ise.pw.edu.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJJXzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:55:04 -0400
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:42433 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:55:04 -0400
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 19:55:02 EDT
Received: from [172.19.1.1] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id BEAE668B013
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 18:13:03 +0200 (CEST)
Reply-To: wzab@ise.pw.edu.pl
To:     LKML <linux-kernel@vger.kernel.org>
From:   wzab <wzab@ise.pw.edu.pl>
Subject: Bug introduced in the of_get_named_gpiod_flags function.
Openpgp: preference=signencrypt
Autocrypt: addr=wzab@ise.pw.edu.pl; prefer-encrypt=mutual; keydata=
 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
Message-ID: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
Date:   Wed, 10 Oct 2018 18:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The function of_get_named_gpiod_flags in older versions of the kernel 
(up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
contained an important workaround:

/* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
   *flags = 0; Unfortunately, newer kernels do not contain it. Therefore if the
"xlat" function in the gpiochip driver does not set flags, (like e.g.
the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
the random, unitialized value from the stack in of_find_gpio 
( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.

I have also reported the problem in the Xilinx forum: https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695

With best regards,
Wojciech Zabolotny



