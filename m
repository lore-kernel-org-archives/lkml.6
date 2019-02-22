Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ACB2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9D2dbHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfBVWaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:30:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45863 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:30:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so3188928ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKEC0VmQVrMMJ0qABlO9Kgrw18h1KKy3ZeGZvTHtCno=;
        b=U9D2dbHIxMvWrfXkUuk0J+bspwRNyEsnaCLCc0xbrKl4FKsJeKt7isLsuXd56vP7dF
         OmYFPMsXAKpTZTqGrog21UXrtAsA9a1Tl5Z9bAlyrHKHeXwFt7Gz+gOx23SSBuQ1xiNb
         iEyBuYSXQ+9sMw/ULEoY1jSnqKWHE72dEn4H9l12tOOB06Z5w79nhOUrlJXci0YbuYBO
         nhBjqkkh8H5qUpvAXWtnV4u0s9bAr0i1k/ARBUwZtzViGmetVqB32DrSruff5Kv3HSaA
         9rLPO6OkEwaqkZQHQbx95OgdmGmd/ioJ8uiqNrW1cWiq01dDzCiTEj5uPE8SAzzX6tXR
         a6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKEC0VmQVrMMJ0qABlO9Kgrw18h1KKy3ZeGZvTHtCno=;
        b=IMGceGnqYMHN9FCf622GLegSfCDVP1EiQ4Z/U60bjfoOj1o2+eYT79Ya50b6Dj2ohM
         X0ty+gsgypCF4ll7F0ocIaFD0Xg8IA7eV30+F2CzJ2kDn4E6oL3QCdhqrr+QvvDgZGba
         yfJOLQDNQRD6R3jaMozxqyt8Qgkv/eu02JQQO40CXQyY3UW9E61CDwHOcDvIGgmYXOKB
         sFGjlCZHMsqqBzjtUXfJGq26UoU7q0Jtge4h5+WafNRa4NhjjqT+9WpeThZ+N2nUtn51
         VPn4FCahGEie8SAJRnOZl3FkzWark9HSex5Mc5cYQltMjzdqNYOJqKSPRHtnl6cxLJIf
         YD6w==
X-Gm-Message-State: AHQUAuaJjsRMQ0JwT91I9cIJhzwms6WE3C/PkaAx77CALwPVV2fvVZkf
        HEeHj2w0xVXum6zSa1Voo0LOgMvbDnL7DpVS6X+wyT8x
X-Google-Smtp-Source: AHgI3IaWIWX8CDJ5LLw0ZYPNKqoCGw8ncf8m7yyySh2v8yKvhQTcQb4U6EuK5n/ZGakz3bTTgkiFRfMB1hexnYTegI4=
X-Received: by 2002:a9d:74c1:: with SMTP id a1mr4389070otl.107.1550874605421;
 Fri, 22 Feb 2019 14:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20190222201641.yryc5pg6i4jkdj7d@shell.armlinux.org.uk>
 <20190222211833.17439-1-TheSven73@gmail.com> <20190222213611.ogahe24h4t37ndhy@shell.armlinux.org.uk>
In-Reply-To: <20190222213611.ogahe24h4t37ndhy@shell.armlinux.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 22 Feb 2019 17:29:54 -0500
Message-ID: <CAGngYiWeKkfdKT_s3op-PRbNgTZbiiva9RO0zJejFmQkoAdo7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider calculation
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 4:36 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> There's actually two threads of conversation going, and I recently had
> a reply from the maintainer of hdmi-codec suggesting a way forward - so
> I've coded that up as the three RFC patches you should have just
> received.

Thank you, that's awesome !

> It probably would be better to try and find some generic way to deal
> with this.
>
> After all, the I2S source probably knows which ratios it supports.
> Given that many sinks support a limited set of values as well, if
> ASoC core knew the supported set at each end of an I2S DAI format
> link, it could probably select a working bclk ratio automatically.

Agree, possibly the same way the ASoC core auto-matches both sides when they
are connected with a dai_link? Pardon my ignorance.

Of course the auto-matching should only happen when both sides provide a
bclk ratio range - to avoid having to retro-fit every single dai.
