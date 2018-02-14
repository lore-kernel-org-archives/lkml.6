Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966943AbeBNJcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:32:15 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36225 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966664AbeBNJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:32:12 -0500
X-Google-Smtp-Source: AH8x2254E1+K1MqQastyy72uckdH9j71n8jmOHE+9ThqHh88QuIaVQaZvttfHh8HzOiahQAqcUzrF8YpIBIDUQXG0Rw=
MIME-Version: 1.0
In-Reply-To: <2fe86be6-a3e2-9bd6-1d72-63cf0fe3a731@redhat.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-2-git-send-email-geert+renesas@glider.be> <2fe86be6-a3e2-9bd6-1d72-63cf0fe3a731@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 10:32:11 +0100
X-Google-Sender-Auth: k7RMsGWKoCIs9DlWCkNmVk3n0eM
Message-ID: <CAMuHMdXm97QFTC8VYDoByHsXaG5BQqFdhwqMTuGVRKDe-oh8EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio: platform: Fix reset module leak in error path
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
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

Hi Eric,

On Wed, Feb 14, 2018 at 9:36 AM, Auger Eric <eric.auger@redhat.com> wrote:
> If I am not wrong we also leak the reset_module if
> vfio_platform_get_reset() fails to find the reset function (of_reset ==
> NULL), in which case we should do the module_put() in
> vfio_platform_get_reset().

Correct. Will look into fixing it...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
