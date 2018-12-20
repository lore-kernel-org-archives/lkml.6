Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF59C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816AB21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWWWS1kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbeLTVk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:40:59 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41251 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLTVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:40:58 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so1062168ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d6P7aA91tixssuD9xVfj5hZC6jY9NBX2k5QOAD8NJc=;
        b=NWWWS1kUgZiWj0PUfpnkGddVPWmLySaQpD2pWe0xmeUk3z35dC9LY25AOl8MaYK8Sx
         J0+1mOVJ6tbAAYR/rd8xCyH22F56UEQa0xQDN4qIl2RV3LeFfsy3IgnebHf81PL7+Vvo
         J9jqzcybcF1iF5Xm+ecBygu6AJQAlMhHQLFbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d6P7aA91tixssuD9xVfj5hZC6jY9NBX2k5QOAD8NJc=;
        b=OX7skMZYzcnkpZWr5H7O5mXygjBzYdO1ItJXcPf5carExqRgpzlz9V0sCGB4vGytEI
         f6Ta4K1R2PCKRxs4EQxg9yHKHCIMsJ+bpcfFHYNCfWv+pXxQUNV/2w4XXLy7NmroaVgB
         MIIUIIGj25BJgd8Z5tdWSEXM6giI/jvGWZDd2cWGgd7k92F5D8fbJn45zXum5iEzkpt2
         +fz+EI05/9SV7gAb6N6ZiKUXZdhY+Yj3/8UwdeoTvsmo8lrKvKsZ7n6YUahyyUqR7U16
         7BZiIhxtbhz3MWEuWh7Q2QLB4tpoaENZgCaubws7BsJ0o4bOr+71IOXITMcf1tntIne5
         9j1g==
X-Gm-Message-State: AJcUukfHX600e9VRNpyV2xJP+e3droFd2L4tR9wjQ3THaxfI5kXw3Mmy
        MUwZg1oT/1Yve7chcnwKjp3De/H0Pzs=
X-Google-Smtp-Source: ALg8bN541iCWWPEgZWL13c4qJN6SdsT7HBfTmUcAE1srTF14TsLPgiTWEixOFhyM/2y03WKZaXHhGw==
X-Received: by 2002:ab0:60da:: with SMTP id g26mr415583uam.104.1545342056408;
        Thu, 20 Dec 2018 13:40:56 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id l22sm11877474vsa.25.2018.12.20.13.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:40:55 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id g68so2012134vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:40:55 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr13132009vsj.144.1545342055072;
 Thu, 20 Dec 2018 13:40:55 -0800 (PST)
MIME-Version: 1.0
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org> <20181130154145.GK18262@codeaurora.org>
In-Reply-To: <20181130154145.GK18262@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Dec 2018 13:40:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XWftL_aFb7rNPMW1AE+1y+Zh3W+qqtfSKHRPN+Qe_w2A@mail.gmail.com>
Message-ID: <CAD=FV=XWftL_aFb7rNPMW1AE+1y+Zh3W+qqtfSKHRPN+Qe_w2A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 30, 2018 at 7:41 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Oct 30 2018 at 11:23 -0600, Raju P.L.S.S.S.N wrote:
> >Add device bindings for cpuidle states for cpu devices.
> >
> >Cc: <devicetree@vger.kernel.org>
> >Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> >---
> >Changes in v2
> > - Address comments from Doug
> >---
> >---
> > arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 62 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >index 0c9a2aa..3a8381e 100644
> >--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >@@ -96,6 +96,7 @@
> >                       reg = <0x0 0x0>;
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >+                      cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> I think it might be better to use
> <&C0_CPU_PD>, <&C0_CPU_RPD>, <&CLUSTER_PD>

I disagree.  All existing examples in both bindings and other device
trees use the syntax that Raju uses.  It doesn't matter
functionality-wise, but I'd much rather match everyone else.  We
should land what Raju has posted and if someone feels super strongly
that the examples in the bindings are wrong then they should attempt
to convince Rob Herring to Ack a change to the examples in the
bindings.  Doesn't seem like a good use of time to me, though.

-Doug
