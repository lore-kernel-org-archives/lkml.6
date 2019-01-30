Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F6B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ7yC4v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfA3Jm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:42:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46570 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfA3Jmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:42:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so20072132ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uXH7VsDEKtDfaQSwQFqJfQjwYByBc2MQq7YYc9T1U4o=;
        b=QQ7yC4v9AOI7fJpfODuYgWt1SCjHqwMEwYfNBzwJvHcPUq35YtJNHNpnOkdC6cVcyw
         0HY1obIO40Z6DUgTm8romApS5uJ+5mwn3FKXIldy2LKrWdod/YBi3qtvMhYo+EQGd/MD
         Xmgiazpf5QNLg/T2bQba4WJadQxkT9z/1dmI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uXH7VsDEKtDfaQSwQFqJfQjwYByBc2MQq7YYc9T1U4o=;
        b=EUWiU8/9f1IB0cA5oUPVg8lnmxDkueEYAiVOZZ8tv0h3sxC2G1LB0byWTxnTPPksZj
         C/MV7bTvE0I0oGgCq7p5gUcqfIUDqEXq/NMC47ZamNRDXxgFdk4fV4VNv0Ilb+yHEuuN
         RTcHNUPyjIHDxwdJiiCAVEYz52VOUW079Y0u6rytl6qETbbPYzYAnA4bnptCuDK04cT/
         9alhZzlTCMshr2RptLMMf0xr0In3Kqq8VLFVuGxpQ7mNTveTb0F7Xs4k9R/fTEySWAxc
         Z/DlffVmOxWhX74NKb+BEqypa7+17Mj+37j7lqW8eR54MuCIzV++fLpjR2Pj3cpFrdtV
         sjsQ==
X-Gm-Message-State: AJcUukdnbns9aFfZ9utXByOkiOPhnZr3FaRE3/2GYCGV/8Hq8Cv2gM2Z
        ZVjGOnJttjAu0vTdst2ru+fndmlulT10BVSSKKWVOg==
X-Google-Smtp-Source: ALg8bN6zenLEcdrK8rpdSET/uVMsnd4BLio0HNZ6sttfGhRWKFjucJTaN27glLvogVcD/b5SXro4tPS9XCubxbKZH1I=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr24900862ljc.97.1548841373129;
 Wed, 30 Jan 2019 01:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-3-brgl@bgdev.pl>
 <CAMRc=Md4iTPi_i3EO5QT2SW1S2__8mMe22+9tcO7VUE2_hPNiw@mail.gmail.com>
In-Reply-To: <CAMRc=Md4iTPi_i3EO5QT2SW1S2__8mMe22+9tcO7VUE2_hPNiw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:42:41 +0100
Message-ID: <CACRpkdYswaxCOqS9vgtKrLH-Bnxu3p1=KG=S71FGmLr8qu+ciQ@mail.gmail.com>
Subject: Re: [PATCH] gpio fixup domain
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 2:39 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> wt., 29 sty 2019 o 14:35 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
>
> Please ignore this one, it got lost on the way. It was just experimentati=
on.

Pretty interesting experiment anyways! Now both GPIO maintainers
know the intricacies of the hierarchical irq domains, which is a win
in itself when we try to come up with some generic handling here.

Yours,
Linus Walleij
