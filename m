Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9852086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWvMyl/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfAQXhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:37:10 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40578 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfAQXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:37:09 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so7354807vsf.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFeFu2qE3aYM2lO7d/vkjBubl4icwadKMFhui6XZFFI=;
        b=oWvMyl/6tKGfHnlReRmdH8zQg7f1X2w1cgm1msbR2MvSOUfa8b5efxpnQR+vd0kMjj
         vLWRtQXHfL/m6u/4wX7UhXvYQ/PjQm40jP6tlZ3ZoGMQ69AeBD/2jz6VrifjNcUy1pwW
         P1crWy+XIB6Y6W217vElfSHKUbYxfm6F9WOdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFeFu2qE3aYM2lO7d/vkjBubl4icwadKMFhui6XZFFI=;
        b=rpbfCZ6O7rnhQgcMlokmikA+Yb2T3Y80KmuaFxVxg+DKl6p7HfQQfVwMznpJcAwhr/
         RfETAqZ0f3n9zFw/WtZ0BdD3wZkewEYsk5Lu5s3ln+Lg5opUHHEyx8wDJtgLIj4HjSXw
         xdyR5r2DK1RMTvnqZkyhdnRwjn/bI3YMwTiZl7L0LIwWt2N6Y+UZJ6VnXgToi/TaThSv
         IZZwyRx32mXjPMOkJpMEw3F3zMfONxn82aeXWknQkvWUJ+EEbioe7MDAcVavrXbdBSDS
         gKRpSdPZI51Lw3sdDkgR3WhC4owUDNoQawcMndPj9wxs0vKBLD7hvgYYpv5r0diqxrca
         QgpQ==
X-Gm-Message-State: AJcUukekyXdkLLMe1trDaOx8COok7BXbQBCnxn/gnPLi+JWh6MzcLzmY
        Bs8wG98HNIFNeyBIeAxHdQN2HtFpSbc=
X-Google-Smtp-Source: ALg8bN48qIHXNLJmfAz2Es0IBI5BR5epU9ymUBhBdgMxuHtwQ/pAcYAsASwl0MBX2dHYL1X6aNFIHw==
X-Received: by 2002:a67:dc92:: with SMTP id g18mr6730673vsk.76.1547768228679;
        Thu, 17 Jan 2019 15:37:08 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id j95sm5380763uad.6.2019.01.17.15.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:37:07 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id n13so7376657vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:37:06 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr6817525vsj.144.1547768226489;
 Thu, 17 Jan 2019 15:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-7-ilina@codeaurora.org>
 <CAD=FV=V_+wbOhiVNHYAiZ0zD8tC6vCbZpWAZOhOESSnH12Dqig@mail.gmail.com> <20190107185218.GI14960@codeaurora.org>
In-Reply-To: <20190107185218.GI14960@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 15:36:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+yeN7hYnMN8-4B5GBH7d1eXun2zxJ7GhCGJOUPvkFLg@mail.gmail.com>
Message-ID: <CAD=FV=V+yeN7hYnMN8-4B5GBH7d1eXun2zxJ7GhCGJOUPvkFLg@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: msm: add PDC device bindings for sdm845
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raju P L S S S N <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 7, 2019 at 10:52 AM Lina Iyer <ilina@codeaurora.org> wrote:
> >> +                       compatible = "qcom,sdm845-pdc";
> >> +                       reg = <0xb220000 0x30000>;
> >
> >nit: apparently common practice for Quaclomm dts is to pad the address
> >in the "reg" field to all 8 digits.  So the above should be:
> >
> >reg = <0x0b220000 0x30000>;
> >
> >NOTE: it's important to _not_ pad the unit address in the node name
> >(so you got that right).  Only update the "reg".  For context:
> >
> Ok.
>
> Will take care of these in the next spin.

This will now need to be adjusted to:

reg = <0 0x0b220000 0 0x30000>;

This fixes things up to deal with the patch ("arm64: dts: qcom:
sdm845: Increase address and size cells for soc"), AKA:
- https://patchwork.kernel.org/patch/10767511/
- https://lkml.kernel.org/r/20190117042940.25487-2-bjorn.andersson@linaro.org

Thanks!

-Doug
