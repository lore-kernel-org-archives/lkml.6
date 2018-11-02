Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0FC20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTN6obCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0FC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeKCIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:30:20 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39286 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeKCIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:30:19 -0400
Received: by mail-vk1-f193.google.com with SMTP id o10-v6so788622vki.6;
        Fri, 02 Nov 2018 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfT34+9lft1knftLPFl6Z3SSVqD5RjGTMgBn2JHyRrA=;
        b=CTN6obCHzSGdeDVtjzF6g3pbZuqv3ubPXPydGQci8m8Fl1m/J+CI5ESmLLjTrfFaVE
         KrkpejJu5biwloO0aACHMpAErqfmZy8WV1lEDLY+0cFD+b9OWvl5zWQEsJICQMhejgwY
         fvEo7KRAeWA/akiw3aFDT9ls4/p8yP9mXyAuKQF40YEEW7XoLEAgYGvk11BJtu9abZbw
         RfpmP30AjPnW9G3nljOHSe/HJwc5kR8pzUgsgNXeH6RyH+fNvdX/5+a47TN7lUJLZ1gT
         lymdHQ9hz5CFxHIocWRmBepUXh3yL/8rmAxBVzKvukw0LRglZ0Ri44UkGiVpOsGpd4Kj
         WeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfT34+9lft1knftLPFl6Z3SSVqD5RjGTMgBn2JHyRrA=;
        b=aGlhkfWZILffqggbgLJG45Urzn2YOPK4ttc1jBPn6/TuCMXz06VqTBrkjSHATCgNb0
         pxwLeYmS+PMbXRV0blLSX14yYbpCw00DchPlfPC58vwEkbFg31E8k6gKpvI86no4NNR+
         8NQ4Zo+G52naXnT+p8OetovSlXe7AEztYNRAEHSbtLF82f8HJ4uVNIg9CnFKemHSGn0+
         jl5UlS0XNfXb4+HvtVHz7Ymn7FeWppw0y4l73FDzxR0xspiTSD/pv7RX5OXrkoPN/luj
         50MGD8BDuUxtXhjW/CjMp/4bwdUB7s9/jCKG03YFDqZojc1LD3iwS0qauFDuqb7rXaL8
         kmMw==
X-Gm-Message-State: AGRZ1gJmYarJ/1sfhSd6vqGQDzlpJajmx8/mq6QqU4y3YhYboanA8qk5
        AqF2HiPUuKUA8HCynke6nA==
X-Google-Smtp-Source: AJdET5eutOiY0zSs7iPpUynirYG1o4Zf0OIwbxazvPWV7LaLcv8eae5ihJYxtJ2RtYLR2kc53zw5UQ==
X-Received: by 2002:a1f:9352:: with SMTP id v79mr5856368vkd.73.1541200869694;
        Fri, 02 Nov 2018 16:21:09 -0700 (PDT)
Received: from 960.ws ([2601:902:c200:6512:a7fd:514d:7aab:c075])
        by smtp.gmail.com with ESMTPSA id t84-v6sm1505149vkt.35.2018.11.02.16.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 16:21:08 -0700 (PDT)
Message-ID: <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kailang@realtek.com,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Date:   Fri, 02 Nov 2018 19:21:07 -0400
In-Reply-To: <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
         <20181102041120.7603-4-ayman.bagabas@gmail.com>
         <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 20:12 +0200, Andy Shevchenko wrote:
> On Fri, Nov 2, 2018 at 6:12 AM Ayman Bagabas <ayman.bagabas@gmail.com
> > wrote:
> > 
> > Some of Huawei laptops come with a LED in the mic mute key. This
> > patch
> > enables and disable this LED accordingly.
> > --- a/drivers/platform/x86/huawei_wmi.c
> > +++ b/drivers/platform/x86/huawei_wmi.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/input/sparse-keymap.h>
> >  #include <linux/acpi.h>
> >  #include <linux/wmi.h>
> > +#include <linux/huawei_wmi.h>
> 
> Keep it in order and put under
> include/linux/platform_data/x86/
> folder.
> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __HUAWEI_WMI_H__
> > +#define __HUAWEI_WMI_H__
> > +
> > +int huawei_wmi_micmute_led_set(bool on);
> > +
> > +#endif
> 
> This has to cover !HUAWEI_LAPTOP case.
> 
> > +/* Helper functions for Huawei WMI Mic Mute LED;
> > + * to be included from codec driver
> > + */
> 
> Comment style.

/* Helper functions for Huawei WMI micmute led;
 * to be included from codec driver
 */

> 
> > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> 
> See above
> 
> > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> 
> Why is that?

This is used with symbol_request and then in the update function to
locate the function from the wmi device. But I guess you are right, we
could use the function defined in the header file directly.

> 
> > +       if (action == HDA_FIXUP_ACT_PROBE) {
> > +               if (!huawei_wmi_micmute_led_set_func)
> > +                       huawei_wmi_micmute_led_set_func =
> > symbol_request(huawei_wmi_micmute_led_set);
> > +               if (!huawei_wmi_micmute_led_set_func) {
> > +                       codec_warn(codec, "Failed to find
> > huawei_wmi symbol huawei_wmi_micmute_led_set\n");
> > +                       return;
> > +               }
> > +               removefunc =
> > (huawei_wmi_micmute_led_set_func(false) < 0)
> > +                       || (snd_hda_gen_add_micmute_led(codec,
> > update_huawei_wmi_micmute_led) < 0);
> > +
> > +       }
> > +
> > +       if (huawei_wmi_micmute_led_set_func && (action ==
> > HDA_FIXUP_ACT_FREE || removefunc)) {
> > +               symbol_put(huawei_wmi_micmute_led_set);
> > +               huawei_wmi_micmute_led_set_func = NULL;
> > +       }
> > +}
> 
> Takashi, is it a way how the rest sound drivers are written? B/c this
> symbol_request(s) look to me a bit ugly.
> 
> > +/* for alc_fixup_huawei_micmute_led */
> > +#include "huawei_wmi_helper.c"
> 
> Ditto.
> 
> Include *.c?! Huh?

Is that the wrong way? Should I define the functions directly into
patch_realtek.c?

> 

