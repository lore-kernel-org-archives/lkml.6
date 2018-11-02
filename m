Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6893C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863EE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ1+NNGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863EE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeKCDVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:21:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38176 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:21:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id d19so4477859qkg.5;
        Fri, 02 Nov 2018 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aN6lo/c7TCNe0k5DslBBpsb4MzDVFqbUwUm/PJJ1s1k=;
        b=UQ1+NNGv9nh/myj6JciiNKhsUiJDms8XntsI+lSQkOTYo+VJcuxeODpTxjk490e9sg
         Kpj368FkXCeasjGR03pWiEIXdPvIID6mYwrVrF7kts5VcyuoqFdnEqw0rd6UaaoWW8gl
         8ToiqYn/BFEuXgRuFCYC1m2PHi1z9W7v0g4y+lG9nfedNMgAmpkJdfY8WFHEbb7Gs3j7
         lM3DdTtLoN/baC8X7oBUTMOTxbO/xzoX4aOdWsvGx20ro/456M5WnkIA36pi5C3LdkzP
         OdDYhLdpW+F42xLGvrqYoy5D1HBBpaPj2WX/YNXC1d4GbGKAEBtBj4PROGkWYgd+qvx1
         7w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aN6lo/c7TCNe0k5DslBBpsb4MzDVFqbUwUm/PJJ1s1k=;
        b=oswBOSeu+bbFKcpEG7SlPNp1MBNrQaYO0qZ8pTed5/EbzGSqmyPYAvOe4Ibm3J9sTs
         uaMT3THEGF+j3ucq7GwQZxKlwvR7LkqKiMkiIbO2E/4y7HneQsA9Hn02romI3mtHd7KB
         ILr61jmdOt0BmC5EFhHAL8FsEmtZRXYr3TG3Hf+rvYCZN3L7u4VwwcQOxCz7UorA60Yp
         sINXKwuaxucfG/1oE9BqIJR2wwqgJwhmWX5HtP7n/5q7EOa+/Lf0/S0RwSALVEXWlQaV
         9V69zbxQmVL0eb8qubYV5E/CwPB9SBziCPBfM4wrv/qd8K3qDyzLoZrkpYb/XMun3aqi
         VCVQ==
X-Gm-Message-State: AGRZ1gLDsgoHTEfF2TZBwdJQUV6qusVXOEDpKG55XLeOuivV79f8z4Ps
        +aqzUw/LtBAq61qywVywKspJwY7qHUWKz++UhVE=
X-Google-Smtp-Source: AJdET5c+r63nQ9ucLzT+DihUUEyGjDf7ptM437ieEGvFDjn9+xXjV3CBDAwAUKGioq2GKh9Ye5JEdDJAFPovYT3vS+0=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11188703qkf.33.1541182375995;
 Fri, 02 Nov 2018 11:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com> <20181102041120.7603-4-ayman.bagabas@gmail.com>
In-Reply-To: <20181102041120.7603-4-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:12:44 +0200
Message-ID: <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kailang@realtek.com,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:12 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> Some of Huawei laptops come with a LED in the mic mute key. This patch
> enables and disable this LED accordingly.

> --- a/drivers/platform/x86/huawei_wmi.c
> +++ b/drivers/platform/x86/huawei_wmi.c
> @@ -26,6 +26,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/acpi.h>
>  #include <linux/wmi.h>
> +#include <linux/huawei_wmi.h>

Keep it in order and put under
include/linux/platform_data/x86/
folder.

> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __HUAWEI_WMI_H__
> +#define __HUAWEI_WMI_H__
> +
> +int huawei_wmi_micmute_led_set(bool on);
> +
> +#endif

This has to cover !HUAWEI_LAPTOP case.

> +/* Helper functions for Huawei WMI Mic Mute LED;
> + * to be included from codec driver
> + */

Comment style.

> +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)

See above

> +static int (*huawei_wmi_micmute_led_set_func)(bool);

Why is that?

> +       if (action == HDA_FIXUP_ACT_PROBE) {
> +               if (!huawei_wmi_micmute_led_set_func)
> +                       huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
> +               if (!huawei_wmi_micmute_led_set_func) {
> +                       codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
> +                       return;
> +               }
> +               removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
> +                       || (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
> +
> +       }
> +
> +       if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
> +               symbol_put(huawei_wmi_micmute_led_set);
> +               huawei_wmi_micmute_led_set_func = NULL;
> +       }
> +}

Takashi, is it a way how the rest sound drivers are written? B/c this
symbol_request(s) look to me a bit ugly.

> +/* for alc_fixup_huawei_micmute_led */
> +#include "huawei_wmi_helper.c"

Ditto.

Include *.c?! Huh?

-- 
With Best Regards,
Andy Shevchenko
