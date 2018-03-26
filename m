Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCZO2Z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:28:25 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:46208 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeCZO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:28:23 -0400
X-Google-Smtp-Source: AG47ELvYE5GzeN/XyiEZBYixOBsZ/yrxK0GG/2DfewtDZP4bj6Kwo5Oane7t9ajKNk2khNKpmUJOrQ==
MIME-Version: 1.0
In-Reply-To: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi>
References: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 26 Mar 2018 22:22:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
Message-ID: <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Preferring cursor plane over overlay plane
To: =?UTF-8?B?Sm9vbmFzIEt5bG3DpGzDpA==?= <joonas.kylmala@iki.fi>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:14 PM, Joonas Kylmälä <joonas.kylmala@iki.fi> wrote:
> Hi DRM subsystem developers,
>
> I ran into this patch where overlay plane was switched to cursor plane
> because there was no proper cursor plane available on the display
> hardware: <https://lkml.org/lkml/2018/3/17/120>. Can we discuss whether
> to have a policy of using a normal plane for cursor plane in case a
> dedicated HW cursor plane is missing?
>
> Daniel Vetter suggests that it might be fine to use normal plane for
> cursor plane because how to use the plane would be only "a hint to
> userspace" (see the email linked).
>
> My motivation for having this discussion is that the newer Allwinner
> SoCs don't have dedicated HW cursor plane and the sun4i DRM driver
> currently uses the extra planes as overlay planes which makes moving the
> cursor on Xfce4 DE a terrible experience. To have better cursor moving
> experience one overlay plane would need to be sacrificed.

If you look at the development history, we've never supported cursor planes.
At the beginning we supported one main plane and one overlay plane. That was
it. The Display Engine 1.0 does have support for an extra hardware cursor,
but we haven't done the work to support it yet. I don't know about the
Display Engine 2.0 though.

ChenYu

> Also, I probably missed some recipients for this email so please forward
> it to the recipients you think might be interested about this.
>
> Best regards,
> Joonas
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
