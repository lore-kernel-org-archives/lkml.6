Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDQNJa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeDQNJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:09:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80CA2183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx4/3kTwvTqgQ7d5VptHdwUW4+wK55gbHggNooUm/dBRc+bRRgixWPAzxNcO/F1OZkbiuPVao+m1IcpFXSe+AhnQ=
MIME-Version: 1.0
In-Reply-To: <20180416225259.6571-1-eric@anholt.net>
References: <CAL_JsqKJD86tV0jno_cZR=nLoOThT5rjRu3BPpzAwpcHgxSArQ@mail.gmail.com>
 <20180416225259.6571-1-eric@anholt.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 17 Apr 2018 08:09:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxG1b2NO6CJTge=7PuYJgLfD9uzit_GiXbH8B79v+aZQ@mail.gmail.com>
Message-ID: <CAL_JsqJxG1b2NO6CJTge=7PuYJgLfD9uzit_GiXbH8B79v+aZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/vc4: Remove the need for the GPU-subsystem DT node.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 5:52 PM, Eric Anholt <eric@anholt.net> wrote:
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.
>
> v2: Simplify the DT walking code.
> v3: Always put the node.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/brcm,bcm-vc4.txt         |  7 -----
>  drivers/gpu/drm/vc4/vc4_drv.c                 | 28 +++++++++++++------
>  drivers/gpu/drm/vc4/vc4_hvs.c                 |  1 +
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |  1 +
>  4 files changed, 22 insertions(+), 15 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
