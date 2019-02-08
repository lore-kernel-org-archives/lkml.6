Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E5BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FCC20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX+xXfjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBHRHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:07:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37903 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfBHRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:07:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id 2so4708379qtb.5;
        Fri, 08 Feb 2019 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVZMGhD31f8oQjIockTx98buATc2BRsKCEaSj1rH2qY=;
        b=RX+xXfjhgJF9tqPFf29kZdl7LipHIj1YYQOfrilDAblvIU3hcIbJPt57GDGn1kmSRL
         Am/rODYiouEPN5dDvnXSobEZ4Jgy1nYAXIOabjCJ29f/l6uDohEBnuH1Ky0elbVkNle+
         ZVsKZmF89rvO2ff+rG9n6NVj2C0wI30Sauzum78Ti77nzy3dFVHAjGhgCr1MBEVk3jCJ
         yRwy/4N+6xX02gscZKhdBf/TP4ne/jRgFLpssHolPWmXjY+jBDvTANDAXNRpmQ6E7qDX
         tbnbnUhaiOKbLK2bf3H0vdk609w/Pg09GlUQykJ32ixUlO/VmPk9VKD78icCHMWtGhQh
         hgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVZMGhD31f8oQjIockTx98buATc2BRsKCEaSj1rH2qY=;
        b=J5jAVuJ+W2gAiVAFj5S6Gq6/G/5uRhw9HRG3atU9CX98WRr4FMToTUXmKqaxMEVoMX
         SafqxM3SyMSFduza6tOKTId2CuPMfkk/jqnrVlIxtNkjEihZvH3aqYaq+1xJYpUyAVZ8
         S0+jcwbE0yKwlQSvVtK9E0ZI2++0Hu27wlHW9gvgED9sVAU7f5/4UuI7QmRefvT+5I9N
         tSmxTx1nVKa5gfAJBTTmdXWn1o2iLZtJ3KER0tRNCbfb+Q/b+mtmFiQXSTpk7Bo5PTq/
         fcg5pTnUHqS8xmHFXa7MZ7R7Vp//8A1boehXx73aowQAzWc+ed1I5mruNOZi4l5FhwIf
         PGIg==
X-Gm-Message-State: AHQUAua+mmvh5k64QuRL7Sz+vLhm3dBDXEpwaLJpaQyL4ZSAidPfeLNU
        6WlameJ6W79905DKOt9TNdffw/Re3291IRDRLFc=
X-Google-Smtp-Source: AHgI3Ib8p/VP4StUx2dG6qeaByCeLKXhK8kzniUhxkOE3SUtOCSurweIOtLJxpQo8AJeSdCwc/7aPHWfFAQqqOa16YI=
X-Received: by 2002:ac8:f0f:: with SMTP id e15mr6544805qtk.373.1549645628969;
 Fri, 08 Feb 2019 09:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20190208012312.105259-1-ncrews@chromium.org> <20190208012312.105259-5-ncrews@chromium.org>
 <4620e71f-9579-0d4e-2cf8-7851e77e81fc@collabora.com> <20190208161605.GD23062@piout.net>
In-Reply-To: <20190208161605.GD23062@piout.net>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 8 Feb 2019 18:06:57 +0100
Message-ID: <CAFqH_50nRvt-gXFFKExFtDtwyTyk_dWVoodsHL_j5OnWum9+YQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] platform/chrome: rtc: Add RTC driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

[snip]

>
> The series should probably go through the chrome tree. The only possible
> conflict would be in drivers/rtc/Makefile and it should be easy enough
> for Linus to solve.
>

Perfect, I will pick also the RTC patch then.

[snip]
