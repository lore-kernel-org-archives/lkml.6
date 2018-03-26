Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeCZPCT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:02:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51137 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCZPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:02:18 -0400
X-Google-Smtp-Source: AIpwx4+zV9yKXQfLYsExKpBEjxFplMTRg7XaHcQBj5aSX+cORzwBBpGrJw3Kn6ngBHQqK5iF9j7wkQ==
MIME-Version: 1.0
In-Reply-To: <20180326144507.s5vit2cb7rjm6csk@flea>
References: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi> <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
 <20180326144507.s5vit2cb7rjm6csk@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 26 Mar 2018 23:01:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dmypdgrxGd44jR_4djaWR43UjaQcAJgx5g2Y0Yhhnwg@mail.gmail.com>
Message-ID: <CAGb2v66dmypdgrxGd44jR_4djaWR43UjaQcAJgx5g2Y0Yhhnwg@mail.gmail.com>
Subject: Re: [linux-sunxi] Preferring cursor plane over overlay plane
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: =?UTF-8?B?Sm9vbmFzIEt5bG3DpGzDpA==?= <joonas.kylmala@iki.fi>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:45 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Mar 26, 2018 at 10:22:45PM +0800, Chen-Yu Tsai wrote:
>> On Mon, Mar 26, 2018 at 10:14 PM, Joonas Kylmälä <joonas.kylmala@iki.fi> wrote:
>> > Hi DRM subsystem developers,
>> >
>> > I ran into this patch where overlay plane was switched to cursor plane
>> > because there was no proper cursor plane available on the display
>> > hardware: <https://lkml.org/lkml/2018/3/17/120>. Can we discuss whether
>> > to have a policy of using a normal plane for cursor plane in case a
>> > dedicated HW cursor plane is missing?
>> >
>> > Daniel Vetter suggests that it might be fine to use normal plane for
>> > cursor plane because how to use the plane would be only "a hint to
>> > userspace" (see the email linked).
>> >
>> > My motivation for having this discussion is that the newer Allwinner
>> > SoCs don't have dedicated HW cursor plane and the sun4i DRM driver
>> > currently uses the extra planes as overlay planes which makes moving the
>> > cursor on Xfce4 DE a terrible experience. To have better cursor moving
>> > experience one overlay plane would need to be sacrificed.
>>
>> If you look at the development history, we've never supported cursor planes.
>
> X can use an overlay to put the cursor though.
>
>> At the beginning we supported one main plane and one overlay plane. That was
>> it. The Display Engine 1.0 does have support for an extra hardware cursor,
>> but we haven't done the work to support it yet. I don't know about the
>> Display Engine 2.0 though.
>
> An issue with supporting the hardware cursor we have is that as far as
> I understood, the cursor plane in DRM has the assumption that it would
> be an ARGB format. In the first display engine, the format is actually
> an 8-bit palette with 1 bit of alpha iirc.

Looks like it's 32x32 pixels with an 8-bit (max) palette, with full RGBA
for the colors in the palette. I don't see the 1 bit alpha you mentioned.
Looks like this needs some extra work for building the palette and copying
the cursor image.

ChenYu
