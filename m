Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CC02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owD0Qw15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKCDl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:41:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45220 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCDl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:41:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id d135so4517501qkc.12;
        Fri, 02 Nov 2018 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AX1C4OASJqS6Hb/1RNJUhZkqcV4fEgeURxuzgTLXfmg=;
        b=owD0Qw15puvZ2+udElelfqVPfuz9I+ht8Tqis3EsbDRoDfmETd+O3kHNHt8CZNaqyp
         8+rFtOFIwjcYAaY5Tb4U/3lkSB98Ne0fTGQvdLqm9Bfu+Bgnxc51cQsJJJbUvdSyjlkn
         5/pqnyiNBYHXOXfsmb0EJQspvlnhHNOTJF0QoKPdb809RJ7K+BL6Dgco8KBF6T5v2eO6
         Rv/4jgIqPiv7Nj2oZV6zB2aAImtGyN1/GWM2zu+5oG/5l7LOQU7dd0dUTLT5IvnheYPf
         j/bNhuWFoadD2U016k1qLCUKeAwXVEblXgn5LZqTffdVKhaSGk+VmOkHC2zsIYBjElpn
         +jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AX1C4OASJqS6Hb/1RNJUhZkqcV4fEgeURxuzgTLXfmg=;
        b=ckvzpqnKezzb90D6OeQSX+kxAJ8fZdbiI+KaVoSoFi6CTrJakXnJ8+t2KbevkgijeS
         NNo2eSO9ZIVFLh/23NkcWvZJA3FSniAo339VlSZtRNu38+TLru6KZHtMz1mV4hu9ORIA
         vcI4kiqQVDzdTvvLhwu5WBRM/alpc9alx4+4H2R7mEvfIwnzuagUwfonyVl+LE1y7uCn
         o0sjHZoVR0Oii1GN7sHcZYlky6xGmKVN5VXdIlbLFeyhOFefNVzBZjibOdgp8ZH3zZRa
         Vafo5KOEJXy005YIAhvW9XTH0JpIJHTVEvK0CmaH6ap54Q1HP6faJ+MhYjymnOS9+lfh
         xYhg==
X-Gm-Message-State: AGRZ1gI0R7Y7EPvlwOl5LrRa6XwNtfCIpGUra/gNNAaHQnhf6udZrLTz
        kgavilbBnP48WGjb665T8MpUP3skZhEqOq1Yo64=
X-Google-Smtp-Source: AJdET5eEOrja3/eIjMu81G9xCPsFjmqaWjwUceFh0oXXkZ38aqepTG9A4tFAEbc4nJ8D5l1KyXcqv8ZtAZcLD/w1UoA=
X-Received: by 2002:a0c:b60a:: with SMTP id f10-v6mr12366743qve.7.1541183629275;
 Fri, 02 Nov 2018 11:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
 <20181102041120.7603-4-ayman.bagabas@gmail.com> <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
 <s5hlg6bfi26.wl-tiwai@suse.de>
In-Reply-To: <s5hlg6bfi26.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:33:38 +0200
Message-ID: <CAHp75VfkyqWRrUND=U9Mb+2-HqpEZhpbUYKs5iTSn0mWK+W_sA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>, kailang@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:30 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 02 Nov 2018 19:12:44 +0100,
> Andy Shevchenko wrote:
> >
> > > +       if (action == HDA_FIXUP_ACT_PROBE) {
> > > +               if (!huawei_wmi_micmute_led_set_func)
> > > +                       huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
> > > +               if (!huawei_wmi_micmute_led_set_func) {
> > > +                       codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
> > > +                       return;
> > > +               }
> > > +               removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
> > > +                       || (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
> > > +
> > > +       }
> > > +
> > > +       if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
> > > +               symbol_put(huawei_wmi_micmute_led_set);
> > > +               huawei_wmi_micmute_led_set_func = NULL;
> > > +       }
> > > +}
> >
> > Takashi, is it a way how the rest sound drivers are written? B/c this
> > symbol_request(s) look to me a bit ugly.
>
> It's a workaround for not having a hard dependency.  The HD-audio
> codec driver is generic, and we don't want to load the multiple WMI
> drivers always for using a Realtek codec.
>
> Ugly, yes, but simple enough.

Okay, thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
