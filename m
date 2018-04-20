Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754603AbeDTKTl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:19:41 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:46215 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeDTKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:19:37 -0400
X-Google-Smtp-Source: AIpwx48lv3hQNSsURpRZ4XuDPI5itWPq9gAWry9IQkkZIAiSsjj0K4cJBBgkoT4nrB7lKyxv5klcGHpt04GvUWZdce0=
MIME-Version: 1.0
In-Reply-To: <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-4-sebastian.reichel@collabora.co.uk> <a078d8c3-9e65-cc7b-737a-cbd5cf141f95@ti.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 20 Apr 2018 11:19:35 +0100
Message-ID: <CAPj87rPeBim9NyBmMuDKKEwx2apLhdnZyEB9_sfbVQpUHA95+Q@mail.gmail.com>
Subject: Re: [PATCHv3 3/8] drm/omap: add support for manually updated displays
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 20 April 2018 at 08:09, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> It's actually not quite clear to me how manual update displays work with
> DRM...
>
> As far as I see, we have essentially two cases: 1) single buffering,
> where the userspace must set an area in the fb dirty, which then
> triggers the update, 2) multi buffering, which doesn't need fb dirty,
> but just a page flip which triggers the update.
>
> In the 2) case (which I think is the optimal case which all the modern
> apps should use), there's no need for delayed work or any work, and the
> code flow should be very similar to the auto-update model.

Correct. There's been talk (and I think patches?) of adding a
per-plane dirty property, so userspace can as an optimisation inform
the kernel of the area changed between frames. But short of that, a
pageflip needs to trigger a full-plane update, with no dirtyfb
required.

Cheers,
Daniel
