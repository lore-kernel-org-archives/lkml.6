Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E8C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC121780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9MXNxbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BC121780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbeKOTRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:17:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35913 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKOTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:17:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so13616414lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POGt2rZPvMhma1DdsQZfBblsntQ1BYmgeqCG+77Xk7k=;
        b=V9MXNxbuF1NfoKQgQX389j/ioxFJLHSbBfn57M49oSe4sHnT+pukGXR6+MbsGditPR
         8FKLUazzkWlFCNnGWvsq/8USyow7OcnxVhKF9Spgt9Y25XE3C0nj8k0xiOG7XI8kZ1ko
         mkMyvuo4GJV0CzW3F13o2pmxZBqK8M+dQ++VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POGt2rZPvMhma1DdsQZfBblsntQ1BYmgeqCG+77Xk7k=;
        b=ArrhPwnUmIeAABD3I0VBgpYrilV72OMRrHOwfk8p/nb32PE6gyHGlJPAMerzuMoPRO
         N3Rw+fuRLsGBeTjkmHHzl4NEIvE2vlgzVvuvLkl9MvGiq3C88zvvsUl/G5ctvQ9utJKN
         tRFBwY2sqIGwjPtwNJgPuHClKgAitK8ebHtKvCV5iB9HfDfK+jRoir7a6k16onmTxw9X
         hpGPVwCAqNML0ZqN258dX1/yykRpN4gQWQGOyJAd5QBVuorf0fhn5mt0ZS/grMl4t+Fa
         V9Zba6VBmXAntUbV0TsXaCZRu7acJCRsyw+mstKpdzm+KmiAG/70zCB03h5ZG0jtgKya
         oeKg==
X-Gm-Message-State: AGRZ1gLFSfWO8mGZqUZRAjDdgVfZ8nvyF70J+fF5OEcjF9THcGOmWLCb
        cPI1E77qzXsa9cQblLub1gJEBSVm626XmTR3OY8xYA==
X-Google-Smtp-Source: AJdET5covG+mSrGKArq6iR0qvMrGj93nGdumMy1DkEz7et0W8vii6vGx81R2hBN1LtjQ0kicT6JcUvCZ4Qs6NvwlImw=
X-Received: by 2002:a19:5154:: with SMTP id f81mr3111209lfb.96.1542273053954;
 Thu, 15 Nov 2018 01:10:53 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <CACRpkdYJNWC3RZXjCu+3EfRbPy6OyLLw-FivpFoe1p3ckHTCmg@mail.gmail.com>
 <90914660-6add-a4d9-0dfe-7b82a7664bd8@gmail.com>
In-Reply-To: <90914660-6add-a4d9-0dfe-7b82a7664bd8@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:10:42 +0100
Message-ID: <CACRpkdZdoQbFtL-UwsZZPPGtt5NK5XUHsBBm51ZwcU0nF-W5pQ@mail.gmail.com>
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 8:55 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

> LED core has had a protection
> against name clash since the commit:
>
> commit a96aa64cb5723d941de879a9cd1fea025d6acb1b
> Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Date:   Mon Mar 30 10:45:59 2015 -0700
>
>     leds/led-class: Handle LEDs with the same name

Oh neat!

I guess the sysfs clashes I have seen can have been other
stuff then, but it was a while back, I don't think it was so far
back as this patch.

Yours,
Linus Walleij
