Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE52C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D621566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxB/DLJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6D621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeHBVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:39:40 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32877 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeHBVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:39:39 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so2470138qkv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G83UnPwS0uwoW6hkqFcpEX0Bbi94KcNlzEZNAwe3odw=;
        b=pxB/DLJFAbJbImaXghQBbR3jlYC+AG1dq6Q1fiy24GATaFSOKYdoiM22kAGjSj5Eam
         uMSXIGwMcwkMFRItSRtC9o8wqvNTKg09tvUIx4+vfTD6ICc0aX0MXQKhwDEKBrs/vrhE
         VNYyKo+Q9UUnO1AlFLYl5jsUr4sLGDSEp1GlPjZT42//3nM260eRkCYnjoc0W+iM9ilo
         kwU90+72S6M1KGJR2eQiAtR/US/AxViSifubRC10KKP8kyZjItc35eCCi6Pw/kTBO+Gp
         r0L6WV7owNpkGWJuVQ5HYNFT4sGBu4/4cHFTlOs7Vk7DP/AHwm9Dxb7DlhVVS3c0pfmP
         eEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G83UnPwS0uwoW6hkqFcpEX0Bbi94KcNlzEZNAwe3odw=;
        b=LYH1RqHCNXaHy2nmqhkKJztTwedhTs3Js14rvw8iXDr/2hl+Usq9uJF8xlYgSjU/Ia
         nnyMoETo4/fVhKUuqnjbUOlwpXhn0iPXpoPDmupVk1/WuX0eaIoO1eN9rfiqzvL4Bo5R
         rRzWhahhqaVhwN0bkznHjn7S5djnGepoGjcSVG4hQ8bSehhEd3b/b7V9eoj9+BVBTceF
         7t73bQwcqUHcd1DBUNl9meP78yTpg4AT+cfONKe1o0giop1Owt7fkg/9taLB4OUIEx6a
         Zr6X2PtfSYIhS1fgnN6Zvzyr191lJCOF0ettk9f98O2YMj3h8NmfthjN5yALG7ExUSjc
         N0yg==
X-Gm-Message-State: AOUpUlGM/AF3nDT0Ql3xRgg2Yn5flf1H+1ine5Mmdn33x3KxC68PrroY
        YcsumDN2sH48c4X08eczcqdMGivcOzOUmVQmE+zcMweM
X-Google-Smtp-Source: AAOMgpcH9iKvIoeny9R5echfHiea0MZwmNTTKt3k5FNx7MpHaiG9ULbHkBVrhaFPAvqhtyEwziN22S7yWLezhXJ4io0=
X-Received: by 2002:a37:c595:: with SMTP id k21-v6mr857394qkl.330.1533239223813;
 Thu, 02 Aug 2018 12:47:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 12:46:43 -0700 (PDT)
In-Reply-To: <20180802193909.GA11443@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Aug 2018 21:46:43 +0200
Message-ID: <CANiq72=PRY+hD0Z_taj-UokuYVL_ab8rnAMz514Jjc_RyzntOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/5] Add pardata bus + tinydrm driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Thu, Aug 2, 2018 at 9:39 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> This is an RFC - to get some responses on the overall design.
> The code builds but has not yet been tested on any HW.
> Before investing more time into this I would like some feedback
> if this is the right way forward or a different design should
> be pursued.
>
> The problem to solve is that I have a propriatary ARM based board
> with a display that is connected using a parallel bus.
> The display is capable of showing graphics
> so it is more advanced than what is found in auxdisplay/

Just a quick note: the original intention of auxdisplay/ was not only
text displays (actually, the first drivers there --cfag12864b/ks0108--
were graphic displays). They have a very low resolution (e.g. 128x64
for cfag12864b), though.

Cheers,
Miguel

> I know there are others using a display connected
> usign a parallel data bus, so this is not a unique problem
> for my board alone. But I do not expect many users as
> any modern design likely uses SPI or similar.
>
> The old (proprietary) approach was to implement a char driver
> and then let some 3rd party lib use the char driver to write to the
> display.
> The goal is to move to a more modern world where I expect
> to have a simple Qt based program running that can
> be used for a few simple things.
> (I do not expect any high performance and do not need it).
>
> Implementation:
>
> A pardata bus is implemented.
> It uses a platform_driver to hook into the DT.
> When probed the pardatabus driver creates pardata devices
> for all child nodes in the tree.
>
> Within tinydrm the pardata support is used to implement
> a driver for the display I have (Winstar wg160160).
> A library module is used to implement the more basic
> things allowing us to have a more simple driver,
> and thus making it simpler to add new drivers.
>
> The implmentation uses array support in gpiolib
> to try to have some performance on screen updates.
>
>
> TODO:
> - Test on HW
> - Add locking so there can be more than one user on the bus
> - Improve pardata.rst documentation
> - Add support for a sparkfun parallel data display
>   (To verify that the library is generic)
> - I may add a class if I see the need
> - Likewise I may add sysfs attributes if there is a need for it
>
> Any comments appreciated!
>
>         Sam
>
>
> Sam Ravnborg (5):
>       dt-bindings: add parallel data bus (pardata)
>       pardata: new bus for parallel data access
>       tinydrm: add support for parallel data displays
>       dt-bindings: add winstar,wg160160 display bindings
>       tinydrm: add winstar wg160160 driver
>
>
>  .../bindings/display/winstar,wg160160.txt          |  53 +++
>  .../bindings/pardata/parallel-data-bus.txt         |  60 +++
>  Documentation/driver-api/index.rst                 |   1 +
>  Documentation/driver-api/pardata.rst               |  60 +++
>  MAINTAINERS                                        |  14 +
>  drivers/Kconfig                                    |   2 +
>  drivers/Makefile                                   |   1 +
>  drivers/gpu/drm/tinydrm/Kconfig                    |  13 +
>  drivers/gpu/drm/tinydrm/Makefile                   |   2 +
>  drivers/gpu/drm/tinydrm/pardata-dbi.c              | 417 +++++++++++++++++++++
>  drivers/gpu/drm/tinydrm/wg160160.c                 | 298 +++++++++++++++
>  drivers/pardata/Kconfig                            |  17 +
>  drivers/pardata/Makefile                           |   5 +
>  drivers/pardata/pardata.c                          | 282 ++++++++++++++
>  include/drm/tinydrm/pardata-dbi.h                  | 257 +++++++++++++
>  include/linux/pardata.h                            | 138 +++++++
>  16 files changed, 1620 insertions(+)
