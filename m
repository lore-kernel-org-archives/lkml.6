Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCMS4jI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C1F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGJsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:48:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45015 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeLGJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:48:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so2969781lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owIMGX0zemiqfnl4vXIAcdx2Vr7Uc7+3UuYHHK/Nyxg=;
        b=dCMS4jI+Y3Bst45CoAgAvpWA8BB4fyAbzFwoTc40H1nPD/1UXtXLDFCL0Ds+ro16do
         ejQTltkBHjx1BsTnJpNMVdNmASWVElFa7CVlF1KQjWu+aowrNHM+tpHM9dcXMirw5flH
         NEJZ2V7lWuWrbedVz+bE4RzgubffZM0bIgjnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owIMGX0zemiqfnl4vXIAcdx2Vr7Uc7+3UuYHHK/Nyxg=;
        b=knqRBbpm/iJipMwF3YbSrtu7GjBPTrWy0yTKotpjjYUO8YMUk7WyLf8NYgYNZDfwD4
         4BNKpgfGAkDf49qKexl9/imSilELcduRjEVoVtKcECMIEwzqmzzbiq1cpLEMCYUbVY+I
         rUX4iIXze6Z7tyMWA4oT7VG53fcWtLHwi1BQAZGBMI+dagA++8BopRyXqozfpCKPaaEO
         HHn4aFd4M5sXdkm3TIDDzVF+fGW8iahj9/PijCZpPVYDD6rqujCRzChHuXzmk9BTyX6v
         oLqvjGbAz+KX7GOjugvcVENwMcxEP/25S2rVWjR+P+6hhZ9Ten56L1stfcSayMPIlrU/
         WO0w==
X-Gm-Message-State: AA+aEWb8m+mxHLln8ot+DXyVHfnqMxmR6Yzd52xV+Fmnk0zG3G6nY4YI
        z59zCElJYYMMYkqVgb7D1D0bw1V9K4QJCtPyIC4BRw==
X-Google-Smtp-Source: AFSGD/VijDAlpfR46oznn0VKGkuORUBAhviF4yCihbF8dcOrwpDLW00Y3r2VzwXC09WompECICdaNUxAn84X4tdRI0A=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr932812ljk.4.1544176101184;
 Fri, 07 Dec 2018 01:48:21 -0800 (PST)
MIME-Version: 1.0
References: <1543338018-708-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543338018-708-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:48:09 +0100
Message-ID: <CACRpkdaM1j7tXm+rekxWUOuzshfYxHf66mYQYtJLuHq=kpJ6Vw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
 up the stack
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 6:06 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> for the dev_err() messages). The probe function should return an error
> if one of the banks failed to initialize properly indicated by
> not returning non-0.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")

Patch applied with Sean's ACK.

Yours,
Linus Walleij
