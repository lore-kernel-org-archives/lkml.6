Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B0E2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Te3N14h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGINyR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:54:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37008 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbeGINyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:54:14 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so17123481ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gu6VzRNgiB8gboDBEcXx6PYJWjfzIJJmIKCn8ugKlWM=;
        b=Te3N14h6ClnJ9aw6fyCYkEwY/uLkXYl7NbbQ+CeEqwgirhmDfdg2AogGjEv0ic/5YC
         HtjP0hh4DxDAmOVA7uVDLvLyS/4HRsuJ59aGZGd5moFNUhniMO2+vkrDLIqF/uR82Xgx
         0Y3fsr+NPg7UNnpJvCmkRNUXF94zuygdYlgAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gu6VzRNgiB8gboDBEcXx6PYJWjfzIJJmIKCn8ugKlWM=;
        b=gyY9RCT90aojKtucLGjj6UtIJu0Gnb1eFGQpgh2ce67YzSzPSyod8Us9B4Lq0M1cMq
         b8PzF9EnPv2C/3QJgpgofuoiZ2BW4+4SMT6Fh63XdcfEEDA2amruwMp8XaNy/uAyW6E5
         pV4VEFwGQEpinZAncMYToqYry4SuT92gQcad6/2AHTndep76nfRvoOsp+6gjfhXL40ZC
         VLaGxI3A7W4V/xqD1pxr8VWqAJ3I8mLAnrDHfHORQCbsesvH2oVwWM13UqAWNKAWNxRa
         qDRGzK8veu0K1Y5TwXu5pVYwJZjhuwwmhdSwtqsV0zd2udgp43FQrvEs45M6NxbRpL3k
         pHdQ==
X-Gm-Message-State: AOUpUlGwYFccxFRyBeo2TUZqYDqcWTAOo2hhhhS6MmRfpPnb+k6IZCun
        rfiFqQwsOMadDZth2It/wwj6C4wRR/Y9YyGgSLP0IQ==
X-Google-Smtp-Source: AAOMgpe5BUnLIl9/siRpm4Q9a0ici7bJYinBfB1nC+zi6bGlDo1yMn8ZschtfJT/nynq0c8raCvIRSDlq5wv2pVxRRg=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr16651423iof.304.1531144453621;
 Mon, 09 Jul 2018 06:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
 <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com> <153055420964.143105.3738779882090053054@swboyd.mtv.corp.google.com>
In-Reply-To: <153055420964.143105.3738779882090053054@swboyd.mtv.corp.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:54:01 +0200
Message-ID: <CACRpkdbNSNzT8tiYDXk1dc447xGqf1bV+O93hgEQdT+GcQtddA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:56 PM Stephen Boyd <swboyd@chromium.org> wrote:

> I could do with some more clarity from Linus in the "Drivers needing
> both pin control and GPIOs" section of
> Documentation/driver-api/pinctl.rst but I read that section as stating
> that the GPIO driver needs to mux the pin as a GPIO by requesting the
> pinctrl backend to do so, unless the hardware overrides the muxed
> function selection when the GPIO is used, without involving pinctrl
> software.

Yeah that text is especially terse :/

What it says (or what I meant to say) is that there is a choice
between letting the pin control and GPIO functionality on the
same pin be handled orthogonally or implementing these
gpio_*() callbacks into the pin control backend, but in either case
the two APIs must be used in sequence:
pin control setting comes first, second the GPIO subsystem can
request the GPIO line.

I'll see if I can clarify.

Yours,
Linus Walleij
