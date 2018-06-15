Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8E110C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F72208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxFtXbNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F72208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936218AbeFOJB2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:01:28 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43719 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936076AbeFOJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:01:27 -0400
Received: by mail-ua0-f194.google.com with SMTP id z16-v6so5943124uaz.10;
        Fri, 15 Jun 2018 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nQvcwLk2f81Lkq78FdUKFKvRGpXFGneTtuK/mr78p5Q=;
        b=XxFtXbNCRtwz7kpBf3+kP8IO5E27kBJZzaPaa33ma3ZnGm1OXOwlEidqZsyZpimVVK
         Uk3KyUYgScNVFh5S8sU0aPq9q1PDFmte/nOybDBBCpSJttTMlWcGINmrSRmjrHjO5KTY
         6bYAC2Sd00ccgH+7IotEdFpBCaFgWmI6fkmPTxSxtSkNjtm9+qMgwk3IgGpMnkmd2KEr
         sFDO6hZJvBGNm8j38jAubWBpWXMBqlRMud+S53YRPZiG0ejGfcnpochZiAAXySOfCBQz
         RfvtcPP1jJ7ms8NE0sp9G+uqyzve23qBcsxs4UtO0Ik22QsdY4ZUxlaNW6Ekv1n79T2r
         tclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nQvcwLk2f81Lkq78FdUKFKvRGpXFGneTtuK/mr78p5Q=;
        b=mNwfCFaPfp0X7uksg0aIkRm2QMin4f0qv77IQ3OnW34hQMCQWa4ZRxIDWycuykq2aI
         +CauyTsM7xz2Wtdr038pXelN4nGaJINNPKMqjVAMVjYq2vjZ472VJWXNxADqqkZxXXp/
         zZHQGxPRWuQUr7C9iE4jJLw1xMxCH0xAZDtptYu789IlPWwpNjrCg2jmCV3DIVgmzL0A
         0Y5RRkHxXs+ZSSedEVljQ3fzhBhe2kVhJsFCa1rwgonB2m2cScmm4guYaYoDv1AiWLS7
         jql1LGV31jpZHuvaucZFnWxuW5UivBWwdQLdtTWziI02BxRQj4KDtrSUa+jiQhA4760U
         ZLbQ==
X-Gm-Message-State: APt69E2bYBuGwDOalrEzDjrtNdxbamLvESgokWuLqO2CK2uDUJM7kLk6
        aGK2cMbI6ySU3rbGxoeXf4GE49StqhOJfy+sHIw=
X-Google-Smtp-Source: ADUXVKLCtEwvRiFETY2jaLB/EgU53howLlOz4sy2vju3K01A72hmIQl2bj3gV165l20BvXjtqBbIS41VEBzl6zfgWmk=
X-Received: by 2002:ab0:6008:: with SMTP id j8-v6mr514606ual.28.1529053286278;
 Fri, 15 Jun 2018 02:01:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 02:01:25
 -0700 (PDT)
In-Reply-To: <CACRpkdbjMLiJtxUpuSuvOBKD-rbybF8baJUBjvP6Hv5baeWY7w@mail.gmail.com>
References: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com> <CACRpkdbjMLiJtxUpuSuvOBKD-rbybF8baJUBjvP6Hv5baeWY7w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jun 2018 12:01:25 +0300
Message-ID: <CAHp75Vf+NijTozdZVXq8TX_SFT0ScCy4VdzM4Y+31V4twgo+0Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: max732x: add error handling for i2c_new_dummy
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 5:27 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jun 12, 2018 at 5:28 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
>
>> When i2c_new_dummy fails, the lack of error-handling code may
>> cause unexpected results.
>>
>> This patch adds error-handling code after calling i2c_new_dummy.
>>
>> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>
> Patch applied for non-critical fixes.

It might potentially be a regression if the driver used to work when
dummy device creation failed.

>
> Yours,
> Linus Walleij



-- 
With Best Regards,
Andy Shevchenko
