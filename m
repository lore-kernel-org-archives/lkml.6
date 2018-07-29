Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C07C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1833A20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1eerSKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1833A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbeG2WaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:30:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36301 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbeG2WaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:30:24 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so14180716itp.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlyYTrkP/BRDYsZ/o/gq1Wg6bOQawmu75gHjBnUiPWA=;
        b=a1eerSKdmVGJlcJWjmmN5yQXAk7lx40oqLQs9dhZsD7DmingL6OnmKE/jr4i97FCPu
         NmigyHok/JmP7x3xgYQ2ivttTSDAqqrjng3qHp/62wu+D0onRyojETb3ysGDFYy5/WgH
         FU2Gu0YAiJ8PHljQH5y9B4ZCiHeEEmAnyyu5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlyYTrkP/BRDYsZ/o/gq1Wg6bOQawmu75gHjBnUiPWA=;
        b=d9g6Jly9/2AF2uDPiltqXMT/lThmdZyyhjwFBH8kxE7u5C0hTj3tn9UbIF6fpLojV1
         1zk1YpAN3qorODHez1jp5cyFpRhFYXcqoyNkIRgLIMWnYko4/adToT/zNJF77HFS20Ne
         8xREi9TM437auDNg1N94sHFeGuP7GWdz+8gGd2ppdMBXAwtUPvkX72slqAs6Jikd+j7b
         qc30+nmHXN9XPJfMTOMfIaEV/N43GKQZdIqnjywBTzyVpkES0bFzfXqwnyxmJgd2keN0
         w5jzPGBF2VDykt+tfd+ht0UWgMGWcmIqN4Zbw2ftNbeYwcbWKnQ+oXJncYXfTzGo8kMC
         vE6g==
X-Gm-Message-State: AOUpUlE4rywwFwe9Nzsggnfg0SukBDdzUjz5UXZGrsqpFnUS5xD37Pxa
        /knVOch687m6KiF4KmIMcOjwOZQ2758WyToh0xTGAg==
X-Google-Smtp-Source: AAOMgpfAFvMA8rwAO2LUf3Tcyrk/AgHHW+16qkNP46+pB/Qk28De9lbQ/n0YtuPcyoyqPoLjwZxVERikwD8Hx0GaJGs=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12560844iti.135.1532897916426;
 Sun, 29 Jul 2018 13:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <1532114623-81911-1-git-send-email-aditya@kobol.io>
In-Reply-To: <1532114623-81911-1-git-send-email-aditya@kobol.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:58:16 +0200
Message-ID: <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
To:     aditya@kobol.io,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Richard Genoud <richard.genoud@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        gauthier@kobol.io, alban.browaeys@gmail.com,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoping for some review from Gergory, Ralph or Richard who all seem
to use this driver!

Yours,
Linus Walleij

On Fri, Jul 20, 2018 at 9:24 PM Aditya Prayoga <aditya@kobol.io> wrote:
>
> Hi everyone,
>
> Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
> The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
> mvebu does not allow more than one PWM on the same bank.
>
> Aditya
>
> ---
>
> Aditya Prayoga (2):
>   gpio: mvebu: Add support for multiple PWM lines per GPIO chip
>   gpio: mvebu: Allow to use non-default PWM counter
>
>  drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>
