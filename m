Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCNMSa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:18:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53417 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeCNMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:18:29 -0400
X-Google-Smtp-Source: AG47ELs3DX5DMD3WsS1AWlput/Mv7IidzFZTTpfvEUuSPAUkbpHiXcRe1Q/Jx1u1Kv8g9LiB57BMAFquAMMy5BHzOJ8=
MIME-Version: 1.0
In-Reply-To: <1521018736-20980-3-git-send-email-hl@rock-chips.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com> <1521018736-20980-3-git-send-email-hl@rock-chips.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Mar 2018 12:18:27 +0000
Message-ID: <CACvgo51zSBdBZWgsNAg+e0uRnjuFU8sNOXKks6nUf4GQag+SoA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: Add INNOLUX P097PFG panel bindings
To: Lin Huang <hl@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
> From: huang lin <hl@rock-chips.com>
>
> The Innolux P097PFG panel is 9.7" panel with 1536X2048
> resolution, it reuse P079ZCA panel driver, so improve
> p079ZCA dt-binding to support P097PFG.
>
> Change-Id: I8704914898fe53b734d31fbe646df8aa5fd8b30d
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - None
>
>  .../devicetree/bindings/display/panel/innolux,p079zca.txt     | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
> index d0f5516..8cadd8c 100644
> --- a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
> +++ b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
> @@ -1,13 +1,18 @@
>  Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
> +Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
>
>  Required properties:
> -- compatible: should be "innolux,p079zca"
> +- compatible: should be should be one of the following.
> +    -"innolux,p079zca" for Innolux 7.9" P079ZCA 768*1024 panel
> +    -"innolux,p097pfg" for Innolux 9.7" P097PFG 1536*2048 panel
>  - reg: DSI virtual channel of the peripheral
> -- power-supply: phandle of the regulator that provides the supply voltage
>  - enable-gpios: panel enable gpio
>
>  Optional properties:
>  - backlight: phandle of the backlight device attached to the panel
> +- power-supply: phandle of the regulator that provides the supply voltage
> +- avdd-supply: phandle of the regulator that provides positive voltage
> +- avee-supply: phandle of the regulator that provides negative voltage
>
Guess that answers my required/optional question earlier.
Currently the code assumes that all of these are required. And will
crash badly if any are missing.

-Emil
