Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A78ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B5F208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+MZW6Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeGMSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:12:48 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43791 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGMSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:12:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so63703252oib.10;
        Fri, 13 Jul 2018 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h+kJR83Vf4rbVPEwKW47vCA96RGiN9A7JY+vxyRF5IU=;
        b=D+MZW6HzTKGhV7V1vx0j9j/XOEQtMqq3tdG5CRoGeGw90IylXaNl49XsbOVX40Lo20
         sp8t6/JEzRtVSaR2fSbTtWV49v7lCGo75vSQ7+8PDcn0BmhDg6o0G2R5RECUGHzxlJrB
         zBMHX7ehICRdHCB2qWzMdrFlFzeDj2nvboCnHjuPGb8eGSsi06SBD8XOthPmZA2vwghf
         WcnBV50tp+AoQpvY/LsLBCACqAVpf/cKAVwLdjWWV6zq546PkxHAfoGDe5km38zGYBuy
         0Tgi6QCfNy+L7UgC4qP990slEza3I2UW22/AaMndFh4quTcia++CMvcNuFidyVFBr4l5
         9LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h+kJR83Vf4rbVPEwKW47vCA96RGiN9A7JY+vxyRF5IU=;
        b=AAqe+I9oNBFtiCdnps3Q+ervgOnSMXwm2sESJL4kcy3iSDCzlfqBZOZeZoPRkRfP3B
         H9RpwihPafunDfAyVaBErmBCTDCUdTAc/Yc/krI3mlwnC1LBOacskCjdV80ngZya28bb
         UUkx/D81eLhsrfTgkzJQD0MtDs3WOqJ1VFeL1nD1hVUgmer5BadVGEDarSHKJ47f3bfh
         A3AxyQhA5eua5coJOxSYstmzdrW/oxbAbPEqU9Cal1fSZInFGNicbljHSML5aQ4+zqEP
         FYFVkCPr5mCAk63uAAucsvXoHzZstgZqKWDOdycLv/rNpg9pcAJavENam2WPIm9xzBNP
         Qqug==
X-Gm-Message-State: AOUpUlFPO8xpkFN7EFsBaOWV0RKL0WsiJ2URy2ZnNCtTZakEMSjEElN3
        pZlPAROlIEM6kHG7sJ/BCySDR6OatEjz/IKr42A=
X-Google-Smtp-Source: AAOMgpdnSTQPTRe3HkXF+TPbmL+a1rbe2q0mDAi8o3p2gOSZb56byaLhnwPet5t1LNWtf7yZFUlUpbbXiRMEmpRdcLA=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr8183222oia.198.1531504628119;
 Fri, 13 Jul 2018 10:57:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:57:07
 -0700 (PDT)
In-Reply-To: <CACRpkdaKQ_Lg=t3DLsvXQNLwi=BYugqNGyssEM9Hn2Ss5r-kQw@mail.gmail.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdaKQ_Lg=t3DLsvXQNLwi=BYugqNGyssEM9Hn2Ss5r-kQw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 14:57:07 -0300
Message-ID: <CAOMZO5COXS8udCzC3VEhcxt5P9v__hE6LR1ie4xcJKXKwLUmog@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 4:11 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 10, 2018 at 9:53 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
>> GPIO registers could lose context on some i.MX SoCs,
>> like on i.MX7D, when enter LPSR mode, the whole SoC
>> will be powered off except LPSR domain, GPIO banks
>> will lose context in this case, need to restore
>> the context after resume from LPSR mode.
>>
>> This patch adds GPIO save/restore for those necessary
>> registers, and put the save/restore operations in noirq
>> suspend/resume phase, since GPIO is fundamental module
>> which could be used by other peripherals' resume phase.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Hoping for some review on this before applying...
> Fabio? Bartosz?

Now I could find the patch on my Gmail Inbox :-)

It looks good to me:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
