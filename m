Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D34E21939
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D34E21939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeGCHxX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:53:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37893 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeGCHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:53:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id c5-v6so783732qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y5xkVeJY5is/FvaiyzAZe+HNnmvk3LAoYIqKEhGNYVY=;
        b=Fkt3QYIc49HkC2+I4zOZWaekuMGK3/xLRoqCKxvzz1d6AbWVfV1kk4c/mq8efObNKd
         OYrRlRwJbVE5e4CX646VrrVI3P9Xamhr7hRW1g90Z2wPhKZbMr7WgLOZv7DuVl9/h1yl
         NgE3rLPKunYhJuZD6qfgM9VpwLchpC+ZYKmEgvbKC3aKS9gNrWrD1uHOD7tycd9pcFeE
         eUbyqC2sqhggyiWfKT3ecvqmIpwcxDs7A3Ogfwd0i3bN+ZF7KVuLD8LsVNfj8un53zEX
         nh1YBLJMRMlylythJoO5cDz7NMDjU3PwrWI6in7CXUsvadfo6qnB5YefBpRYqShWRwPf
         6hrw==
X-Gm-Message-State: APt69E3CE0Obp+BewBqgZIxGwdXIJckNUoXqzrO1h1T7VpZJhROOvvUx
        9romwfI0iBmBX/dI9NRt0R/sdMPQg2PxcxdfdQ9Vcw==
X-Google-Smtp-Source: AAOMgpcbyf8SOnerx8zWnpVjuq7pPF5YL/XMUd4r+Vvf4TQ+MmuGiIRYZjlOYqs1q9sDZg/hi3HZ9aJj0a/fr55oQds=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr23260650qta.178.1530604400447;
 Tue, 03 Jul 2018 00:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:53:19 -0700 (PDT)
In-Reply-To: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Jul 2018 09:53:19 +0200
Message-ID: <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to
 MT_CLS_WIN_8 quirks
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> The firmware found in the touch screen of the Surface Pro 3 is slightly
> buggy and occasionally doesn't send lift off reports for contacts; add
> MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
> reports.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 45968f7970f87775fa..a793076139d7d0db9b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -242,11 +242,12 @@ static struct mt_class mt_classes[] = {
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
>                         MT_QUIRK_IGNORE_DUPLICATES |
>                         MT_QUIRK_HOVERING |
>                         MT_QUIRK_CONTACT_CNT_ACCURATE |
>                         MT_QUIRK_STICKY_FINGERS |
> -                       MT_QUIRK_WIN8_PTP_BUTTONS },
> +                       MT_QUIRK_WIN8_PTP_BUTTONS |
> +                       MT_QUIRK_NOT_SEEN_MEANS_UP },

NACK on this.
If the Surface has a buggy firmware, we should handle it as a special
case, not as a common failure.
Also, I am not sure this quirk is compatible with Win 8 specification.
Last, we now have a timeout for unreleased touches, so I really don't
think you need that in recent kernels.

Cheers,
Benjamin

>         { .name = MT_CLS_EXPORT_ALL_INPUTS,
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
>                         MT_QUIRK_CONTACT_CNT_ACCURATE,
>                 .export_all_inputs = true },
>         { .name = MT_CLS_WIN_8_DUAL,
> --
> 2.18.0
>
