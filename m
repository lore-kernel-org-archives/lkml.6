Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57DC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6CE20866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="QXqoNm7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6CE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeIJAKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:10:51 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46211 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeIJAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:10:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131-v6so7102084ywc.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KzWLIShI1wQK0hY9NzQtIf37kvhJiOXlzz0oUr5GF+4=;
        b=QXqoNm7+mETEAcXRveALZbfbjBuuNhmU3jo/RZtMpd7FJe8yhymRfl2uEOHL5qSEJF
         YzJnRoYRuQ+7l1p2u5T4DPpmNXZ5tK/VlVwVjWXYDvFdzBsuCwc/jRHT8+dxbybfNjaX
         J6UNmtqLMUYHYiDLlYlJ0JTrGjZffFhMyN7azpP6h3ERukEClMb/0/6U05iM0YRm2mG1
         KCEhGVh346E5X42oUFigsEQk4cRjNsR9ONYxtINq5FB5vQHacQ6lxgZN7rj13mnE5d0+
         wH7Q0s6aDO7OGPQhlbipU0z2ROR1/PxLbmHCegp5szs2uoA1HrIPZcuV4gZpfPwKvOgy
         rqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KzWLIShI1wQK0hY9NzQtIf37kvhJiOXlzz0oUr5GF+4=;
        b=YCZ708RV7/snuUbaHwEPRZRlBG/+W1mZYEUmSvEXFlRenLBbFdkK/4SL3EO73m9M7g
         ttWQ+gwNA+baA8pDe9pEOJ71hxYigZwgb8E0treCHmt4++NcIwzOX5rVh9nDHkLzM0N3
         DhkCyHg2vzeWdspNq8CHj2aD+x33ItiL2ryDGg7IPe+si/XaRyglw1neF727YLHSgNsq
         YeJSNn+VzpVHOJg0yxu9iQgEbmVwuGS5Mdot2+Jj0AMyGgZXXZiYOSdnZpDdPK0PUuDM
         Wazo7qaT+mHbN3CVyasLAiMdQcsMof1m9XJostk4JdOmF8RcXOMJ3A6tVhQWl+QBCczb
         o/uA==
X-Gm-Message-State: APzg51DU2AHomDCtMMqDDonIfhPU3ASr4EsrRtqXXuaZKs99qveqQNFA
        CUv7hPFNVSpmU4qP5EjQcLypwov1I4g5euClqxqAbw==
X-Google-Smtp-Source: ANB0Vdb8IzWRDiiL5loRvrOquwoUt8Axmvoi1JkiVTj0U3wynXcoNa4YXTpTFofzgyptgYRGz7EbHBdWh3wxy/3aYu8=
X-Received: by 2002:a81:346:: with SMTP id 67-v6mr8742562ywd.23.1536520810141;
 Sun, 09 Sep 2018 12:20:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:e106:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 12:20:09 -0700 (PDT)
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com> <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Sun, 9 Sep 2018 12:20:09 -0700
Message-ID: <CAAtXAHfwpKagBUQSFLJ1bBsxvbvyg=+nCuQv11eD+nhuxD=1_A@mail.gmail.com>
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Olof Johansson <olof@lixom.net>
Cc:     Jolly Shah <jolly.shah@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt@codeblueprint.co.uk, Sudeep Holla <sudeep.holla@arm.com>,
        hkallweit1@gmail.com, Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, rajanv@xilinx.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Sat, Sep 8, 2018 at 6:18 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>> From: Rajan Vaja <rajanv@xilinx.com>
>>
>> Add ZynqMP firmware IOCTL API to control and configure
>> devices like PLLs, SD, Gem, etc.
>>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>
> This patch worries me somewhat. It's a transparent pass-through ioctl
> driver. Is there a spec available for what the implemented IOCTLs are?
>
> Should some of them be proper drivers instead of an opaque
> pass-through like this? Could some of them have stability impact on
> the platform such that there are security concerns and the list of
> arguments should somehow be sanitized?

I tend to agree with this, good catch.

> What's the intended usecase anyway? Just a debug tool during
> development, or something that you expect heavy use of by some
> userspace middleware?

I suspect it is another attempt to make userspace clocks/plls work? Scary.

Cheers,
Moritz
