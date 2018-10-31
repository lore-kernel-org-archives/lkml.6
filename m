Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14438C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E5E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dftXHN1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E5E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJaWbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:31:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38520 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJaWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:31:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so1480980ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfEwcORosAFYSmxOS6t9aUm+hODmnwIsUYU0N6JrLTg=;
        b=dftXHN1XAqszeBsuSMDyT3gOssc1+scPNCBD+7OI6ZwGfIR4VRcMz6V85k6TL5SKLU
         mD/TBimbHhYPhrQdomVgVDQ6iCvmTojDgJA2qRofLMl5AAtnynqsgpNUKq285Rj7dpCK
         qWDJxx/oo1th0z7Z4Nu6m6YsK6U0imO3kaQj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfEwcORosAFYSmxOS6t9aUm+hODmnwIsUYU0N6JrLTg=;
        b=fzo38pQKj75VN7AZM5H9RTyQQEl3GhnLYMIpkxHfvH0OxlwCSl0l+evD4hARSd/Ood
         3OCu5hnRfcER7phRU/NpaXSuEFEPBfp/wrEc1FwS/b4rg7y4cChDHHncthsbgLu9CllY
         QZTLlst+5q7QjmmFKIzQvWobZ+8O3/DdwuzNjbsC1t+UlB4SE733YJRin7OwDG+K5Rq5
         xv6GMswR3gpX8aU9lXGpEpv+UXwqUX5Kos1P3FgWHdfiQRluRnpgogNaZvaQBEj2BLrB
         vKL+F5bTs/8eUPzJEoCLkHYs8yeJsT2tmfeDIDRURKSx3YHNqI4H/XQJQ7ZAiwPvJgqd
         xAsw==
X-Gm-Message-State: AGRZ1gJdT0FhdyDOf9vKrgtl4eqY5xWpcFsIUS1AvXPC0Wmi+gBQvqWb
        zZNaCXvj0RhWW5N7DBrgfO5Zvy+PvBazAjMC81Lzo9FfYnJjEQ==
X-Google-Smtp-Source: AJdET5eh7q0e4SVx0T83UKcpbnVOkpEYDZKi5LLkcdWw18iAaOgEBnNfGhuLe5Wa/dsQkwkhTUTEm9bv6bPqZfivuGc=
X-Received: by 2002:a2e:710c:: with SMTP id m12-v6mr2064326ljc.66.1540992816825;
 Wed, 31 Oct 2018 06:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox> <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
 <20181025210456.GA14792@flashbox>
In-Reply-To: <20181025210456.GA14792@flashbox>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 14:33:24 +0100
Message-ID: <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:04 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> In my opinion, there are enough of these warnings to warrant changing
> the type of param globally (arm64 allyesconfig):

Yeah as it is from the compiler, sure we need to get rid of it.

> Linus, did you have any other objections to this patch given my
> reasoning in these past couple of emails or would you like me to try
> adding explicit casts to all of these call sites?

I would favor the model to:

1. Replace all occurences of enum pin_config_param with unsigned
   int.

2. Replace the whole definition of enum pin_config_param with
   #define PIN_CONFIG_BIAS_BUS_HOLD 0
   #define PIN_CONFIG_BIAS_DISABLE 1
   etc etc.

I think it is not a good idea to try to do both at the same time.

A slightly lesser evil variant is to add a few PIN_CONFIG_CUSTOM_1
PIN_CONFIG_CUSTOM_2 etc at the end of the enum and just
#define MY_CONFIG PIN_CONFIG_CUSTOM_1
in all drivers that use these.

Yours,
Linus Walleij
