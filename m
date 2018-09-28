Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A252073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGFbDKuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A252073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeI2Bsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeI2Bsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:48:37 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3488C206B2;
        Fri, 28 Sep 2018 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538162605;
        bh=YMvozbtkC/oW1nUWRK3qqS7vmZC2HjGwzNVE4ZzZq9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGFbDKuv7E8FLrsH32OAT/BKOREUQuxV0O27XZnFOhvN4AukrHKBYpBJinAaUWde4
         OMD97H7wwhei10gSj57Ja7YnD297ytyxJ3Uz+svd1TK96bsutyfWrfJKEX+CPUiHMy
         s/YkuAP//vsyBGbpzivySZh87YBghMtOkfb5Jacc=
Received: by mail-ot1-f52.google.com with SMTP id b43-v6so2644032otd.12;
        Fri, 28 Sep 2018 12:23:25 -0700 (PDT)
X-Gm-Message-State: ABuFfogd2JOxDAF84nB2yLMCRttkIJHT9xUqpwL3J3jaD4tvIeIObLWV
        Pa+BxDOTQzznKtjaZ+Gw3gCHHEq4GrhL1epB9Tg=
X-Google-Smtp-Source: ACcGV63/z6VVl5Oy6VdcJFYjyjsw5ihwShvE7DPh284iEYu3muFFzFJv1r9vIfd3LSfhKIOAwAHH7Wvlf2JdlKstoAQ=
X-Received: by 2002:a9d:4e10:: with SMTP id p16-v6mr21623otf.131.1538162604517;
 Fri, 28 Sep 2018 12:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
In-Reply-To: <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 28 Sep 2018 14:22:46 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
Message-ID: <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Timur Tabi <timur@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus <linus.walleij@linaro.org>, ricardo.ribalda@gmail.com,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 2:14 PM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> Nack.  Causes a XPU violation to the GPIO config registers.

That doesn't surprise me at all.

I believe that the problem is that gpiochip_line_is_valid() is being
called before gpiochip_irqchip_init_valid_mask() is called, which
means that gpiochip_line_is_valid() always returns true.
