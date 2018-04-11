Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDKJVv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:21:51 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46383 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeDKJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:21:47 -0400
X-Google-Smtp-Source: AIpwx4/8it0ZLVCf4Lzka8kkVgpS5TQ8TWAOWIM2kGmUagA7jYrGq8fZdWJwewHNO3BOAdRQxfy4bY7gyVY21Lew928=
MIME-Version: 1.0
In-Reply-To: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Apr 2018 11:21:45 +0200
X-Google-Sender-Auth: DihTv8Lp4Ci8WtASiqA3b4tl4aQ
Message-ID: <CAMuHMdUR0rVNWUeWPr6JE3uKXhGspnzLEb-BBgg_5_+WvMD6=g@mail.gmail.com>
Subject: Re: [PATCH] vfio: platform: Fix using devices in PM Domains
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:15 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If a device is part of a PM Domain (e.g. power and/or clock domain), its
> power state is managed using Runtime PM.  Without Runtime PM, the device
> may not be powered up, causing subtle failures, crashes, or system
> lock-ups when the device is accessed by the guest.
>
> Fix this by adding Runtime PM support, powering the device when the VFIO
> device is opened by the guest.
>
> Note that while more fine-grained power management could be implemented
> on the guest side, if exported, this would be inherently unsafe, as
> abusing it may kill the whole system.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Please ignore, this was sent accidentally with another series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
