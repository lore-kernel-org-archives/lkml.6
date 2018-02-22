Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBVWyZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:54:25 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36765 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBVWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:54:24 -0500
X-Google-Smtp-Source: AH8x225mgFBAO5SOeosEXgRWrP5+BALESYh5E7AhmAgbHS9zm5bslQp7aRujt3YNGzgj/usgMG347EBSveRoTqwDlck=
MIME-Version: 1.0
In-Reply-To: <878tbkaitz.fsf@anholt.net>
References: <20180222162420.2825703-1-arnd@arndb.de> <878tbkaitz.fsf@anholt.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 23:54:23 +0100
X-Google-Sender-Auth: PuKxXby3PYfgeUMzVc2oFnSYtm8
Message-ID: <CAK8P3a3jsAE_jEWf_amtton5rLTN-H3QmyZnSsMeY4ym_d-KYA@mail.gmail.com>
Subject: Re: [PATCH] drm/p[111: add CONFIG_OF dependency
To: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Boyd <sboyd@codeaurora.org>, Tom Cooksey <tom.cooksey@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 9:08 PM, Eric Anholt <eric@anholt.net> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> We cannot select a symbol without meeting its other dependencies:
>>
>> warning: (DRM_PL111) selects DRM_DUMB_VGA_DAC which has unmet direct dependencies (HAS_IOMEM && DRM && DRM_BRIDGE && OF)
>> drivers/gpu/drm/bridge/dumb-vga-dac.c: In function 'dumb_vga_probe':
>> drivers/gpu/drm/bridge/dumb-vga-dac.c:207:13: error: 'struct drm_bridge' has no member named 'of_node'
>>   vga->bridge.of_node = pdev->dev.of_node;
>>              ^
>>
>> Here it seems reasonable to depend on CONFIG_OF, as all platforms
>> using this driver already require that anyway.
>
> Looks like we'll be going with
>
> https://patchwork.freedesktop.org/patch/205580/

Ok, even better!

      Arnd
