Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9760C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72121208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl5xkc88";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="itGRs11F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72121208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeGJXfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:35:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGJXfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:35:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so16290759wrv.10;
        Tue, 10 Jul 2018 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MVNFJlGhsROJmiWx5pxXnmd1iUxMcua6aZ6nFGJFSmw=;
        b=Xl5xkc88mivneFgf/TWu/xVZKnVpvvzYhDlavo8EAOm9ZAxHtjWXcCdxsw+/kFVYoZ
         a2QoEPxPsMhlQoi6kxfcTn5mLKN4iNDXuDqgpfP6FGQyW7xD8ySCOgRZCsBrBvk/P7dm
         DOHr6o22x89nGejgMfqXrujgu6zvhhbiItJgrv+Vhd3wvoG9LTDI83zO9dmqTu1wV3Js
         IJybZSsXKsanjRSSo5WFoCYZDMJ0TEbd8cQZgFje2R5ZmnlMBF9b9nKNuaObH8gWVxw9
         izg0Mf4b8Z81+Q19eWvkGhUimkAE085GQQn2+eznKRMMK0Ce1mtxteh8icbAxCZsO3r7
         jSOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MVNFJlGhsROJmiWx5pxXnmd1iUxMcua6aZ6nFGJFSmw=;
        b=itGRs11FVkzpbN0qfccYNn5n7epTEF/M0kCX3z8DXP/c7szVOgFLRFppTWv1D8Hdto
         GbLBVyKfkSyzVzRtF4p15aviZN+aMY+YRuDCeu6Kmt4CQpS50fUG2E2GfWgGxRvSfrbK
         2Dgv/4rSLbXjxGgZrV7J1KRtoy8IgjzoMAYsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MVNFJlGhsROJmiWx5pxXnmd1iUxMcua6aZ6nFGJFSmw=;
        b=TeGNhJWvgQd/J3Z2pbpxeMeUDmGIaz+hJw2oaQt6e5T7KU7VdCLNvQPHsSVV2nOTW2
         7uJtOZ2p4XL/ZLtLXhGmfywugky59qfP4dvSd/2MhmicSr8diBP7G7GDiU4qzK8QW98/
         OIhaKUHFmeG6ujhU3nYHwTADXJRIyVEBbX+/tbFifX/nlX7TApk4Xwz4QMfjI0eJ/8C2
         vAUSBdOh+B3Q9lhIRoMV1qyKmEA8cu3KIRXhhPDIbdeZ2+uhNp+yZBlyWY3o1YBKSBrq
         RV/AGwZDbUtpUGOXBgdjEEH2g14nQV9zePCkEzc4xAbHe2kygLCcfhZgrTsY+g3veVR6
         Kf2g==
X-Gm-Message-State: APt69E1vljFyeQ1PUygjOvM6nFXlAN9Vvo9gvrBGxUj10zRT0sbttCNm
        2su73zdNFhWAJS240i7r3v80t1Qu9RGhp1k94Ew=
X-Google-Smtp-Source: AAOMgpetaNFMbprzNHkdANhC9qM8nXpYbOMJkkShI9nOKcp/oPZ65LVSG+FKwqqUHzl159LUlhhI6uzBi3WxK6zRts0=
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr20590793wro.214.1531265653154;
 Tue, 10 Jul 2018 16:34:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ec16:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 16:34:12
 -0700 (PDT)
In-Reply-To: <20180706162154.196345-3-dianders@chromium.org>
References: <20180706162154.196345-1-dianders@chromium.org> <20180706162154.196345-3-dianders@chromium.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 10 Jul 2018 16:34:12 -0700
X-Google-Sender-Auth: Jjemzv5EmqjqcpH-iK2iKAZmY1M
Message-ID: <CANcMJZDYpvwKaNPf_jAvTbLifv2JRcDqo5+JCOkdB7j2A_1gLQ@mail.gmail.com>
Subject: Re: [RFT PATCH 2/4] usb: dwc2: Turn on uframe_sched on "his" platforms
To:     Douglas Anderson <dianders@chromium.org>
Cc:     hminas@synopsys.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 9:21 AM, Douglas Anderson <dianders@chromium.org> wrote:
> There's no reason to have the uframe scheduler off on dwc2.  Running
> with uframe_sched = False is equivalent to saying "I don't want to run
> the correct code, I want to run the old and incorrect code".
>
> The uframe scheduler has been off on HiSilicon since commit
> 37dd9d65cc41 ("usb: dwc2: add support of hi6220").  Since then there
> have been many many improvements, notably the commit 9f9f09b048f5
> ("usb: dwc2: host: Totally redo the microframe scheduler")
>
> Presumably if everyone is good w/ the uframe_sched turned back on we
> can kill all the old and crufty non-uframe sched code.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Not sure exactly how to exercise this, but in my initial testing with
usb on HiKey, this seems to work ok.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
