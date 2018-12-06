Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5C72151B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUZ16VKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5C72151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeLFI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:58:18 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:32964 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:58:17 -0500
Received: by mail-vk1-f194.google.com with SMTP id d201so5348965vka.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miOE57QVLhagd+yNlO8ZHRuDQ1XzmREhrzlQtdOl9h8=;
        b=UUZ16VKkA6Rl7M76jB1OJk8TVkdekPxg8HAsi+4kPrKZ8r4YzA+aWVMpmmChVbtWR3
         iQK3qEo9A70aRnph+CuhRBWjfLxPJVNlgrWBeQ0pPRbu3XJubLPbSw6OF5LXzh8MI6hV
         qGNjyMdCZfGar1ME4B5x2u2eezsBcS7qJee9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miOE57QVLhagd+yNlO8ZHRuDQ1XzmREhrzlQtdOl9h8=;
        b=bFTx3POMgX3Jnew86sG2Et7AIKg2wepwR+pPPLLsjDY6CRi88PWvN2reVk9fJ7mi5Z
         OTsvDxG6XG5VMTa7LvVjf18INkelQfEyE1hUIASKlp2rkwpkfq5d+gD9LRGrXUdZaB46
         6YsZzI57Q7ine1EERGcmA14oOc22BSkhE6XnYvWOUyr8tbfdUxmBNvZyp2hqZ0/fWkrJ
         FsnHtWG2eI8HIYSnGq4JV2wPUWo2/IRRfRir90sWFrup88NGiBhArXMZq3aJZ2+wlszW
         UymGiy/wl9D3Nv7nd2JLlYNxFGhOyn2Qoo2KEvsnTHtG7g5dk/OhatiBXgI8a2bFdis/
         g0YQ==
X-Gm-Message-State: AA+aEWYPwZRVFfEQolOrlI2y4Vx4k7x5y8HAURGIh433VgzVaGOWERko
        oQRj7kq4bmUaVARy0v9a7QS8jxqA4VYD4GJUNHwqfg==
X-Google-Smtp-Source: AFSGD/X9LhP3xQqBeoVcmjacfw72dbz0QERifMryfeUQWgSSVyfhD/NWBCnSpWRK1JT4X1qSET2lsYApV9I5N6FloMw=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr12026333vka.4.1544086696333;
 Thu, 06 Dec 2018 00:58:16 -0800 (PST)
MIME-Version: 1.0
References: <58a96c0933bf4c812fa2dd382e6cb377@natalenko.name>
 <CD517154-3155-4D89-AAA5-11DA0DE7B9EF@canonical.com> <CAPDyKFpHzERzE4T-AExwHAbhzrbxuSLy5cg0et24wzfbOZNw3Q@mail.gmail.com>
In-Reply-To: <CAPDyKFpHzERzE4T-AExwHAbhzrbxuSLy5cg0et24wzfbOZNw3Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Dec 2018 09:57:40 +0100
Message-ID: <CAPDyKFpoNY_zvX6dahdFEutYryxPSWAV0H_9tWsVkvgUbsvvzA@mail.gmail.com>
Subject: Re: [PATCH 0/5 v7] Keep rtsx_usb suspended when there's no card
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 at 13:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 23 Nov 2018 at 07:06, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Ulf,
> >
> > > On Nov 8, 2018, at 8:17 PM, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> > >
> > >> This is based on Ulf's work [1] [2].
> > >> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> > >> platforms and ~1.5W on AMD platforms.
> > >> [1] https://patchwork.kernel.org/patch/10440583/
> > >> [2] https://patchwork.kernel.org/patch/10445725/
> > >
> > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> >
> > Do you think this series is ready to be merged to v4.20?
>
> I have had a brief look at the latest version a while ago, looked
> good. However, allow a few more days before I can give it my final
> blessing.
>
> BTW. We need to figure out what path to route the changes through. I
> can pick it via my mmc tree, unless someone object to that.

Okay, so I have picked up the patches and applied them to my next
branch to my mmc tree. While doing that, I have also added Oleksandr's
tested-by tag for all patches, including the four mmc patches. I also
added your tested-by tags to the the four mmc patches.

Finally I made little cosmetic change to last patch in this series,
which was dropping the surrounding #ifdef CONFIG_PM while do the
assignment of .driver.pm to &rtsx_usb_ms_pm_ops, as that isn't needed.

If anybody have any objections, please tell me.

Kind regards
Uffe
