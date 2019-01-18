Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A708EC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA3320883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NR5e6G4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfARSMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:12:23 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40866 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfARSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:12:21 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so4972788uao.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89c/n37chfiSqD3X93XSufTc38bZOgBp/fU//w3E178=;
        b=NR5e6G4WsqdTpet8zS+RlrAE9nnVNR69D9kOXurkskijAhW+8LYNkX7WVRRwqf/t0Y
         Zl5cjPei+O7fyMbgVKnogi8vyhcCUvvnUC5/+v1wsg+7GMYJ7NVtHhkgCVslabHzSk51
         oIqBabeU1MBgT0loX8VSpiot8D6qvCTGeeABI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89c/n37chfiSqD3X93XSufTc38bZOgBp/fU//w3E178=;
        b=ndIU7EhWj0B5jvUMld7oKSiA1x3j9qm8wOPZLnXBMsKxXE1rGC7iOHHAQwNAMp/2TK
         WflkRDicY1GEn6zKVa1aat2ei/EmCeNoq3v6MW0AriphgKWJqOyvXogti5deoJltbEHv
         +KtvE5sLF5ifIFNB/mslxiqIJE2xEiEVXW850+8p4tdJjd0wFZfetSbWoJl+8VGQnjOP
         8ZUzxZuV8n2O2jRGPI0I1kiagUmhFbYnpkwpL9El4nYlR62qGDZaWs/59gcsOZPfQ++o
         WLkXcYleEO8QMzT330XDktw4hjCShqxLHQaBjYpwN55dCz4FjHEs29gwBzVbV0o/Augz
         axLA==
X-Gm-Message-State: AJcUukePxh/rfYyyYFo0zKvXR3QCwPyT76zbD2oad5O5IJnrJv7oAIhV
        dJ7xiRlmwpQjSmeIlAMFd6QdgFY29FQ=
X-Google-Smtp-Source: ALg8bN7QMA8tbYjWkIno8b2XoOP9CtTm+V7X/syu8ZvYqzzX6sbsNzXw0cHrQzQGSiFZIV8dKH2lXg==
X-Received: by 2002:ab0:16c8:: with SMTP id g8mr8099550uaf.60.1547835140586;
        Fri, 18 Jan 2019 10:12:20 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q193sm6712105vsd.0.2019.01.18.10.12.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:12:19 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id e16so4960752uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:12:19 -0800 (PST)
X-Received: by 2002:ab0:60a3:: with SMTP id f3mr8082621uam.9.1547835138557;
 Fri, 18 Jan 2019 10:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-2-ilina@codeaurora.org>
In-Reply-To: <20181219221105.3004-2-ilina@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jan 2019 10:12:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xfasgsh0C7h+pZPAh2RxaJDibaAf4WGRTipYUjnZw8vg@mail.gmail.com>
Message-ID: <CAD=FV=Xfasgsh0C7h+pZPAh2RxaJDibaAf4WGRTipYUjnZw8vg@mail.gmail.com>
Subject: Re: [PATCH 1/7] gpio: Add support for hierarchical IRQ domains
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raju P L S S S N <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 19, 2018 at 2:12 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Hierarchical IRQ domains can be used to stack different IRQ controllers
> on top of each other. One specific use-case where this can be useful is
> if a power management controller has top-level controls for wakeup
> interrupts. In such cases, the power management controller can be a
> parent to other interrupt controllers and program additional registers
> when an IRQ has its wake capability enabled or disabled.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Drive-by-nit: If you are re-posting someone else's patch you need to
add your Signed-off-by.

-Doug
