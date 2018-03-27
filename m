Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeC0Isb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:48:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55569 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeC0IsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:48:24 -0400
X-Google-Smtp-Source: AG47ELvylVuTcsk1t9A8Gta7HKrruKp9LbIBoTfPKT9jjxZqOHQG2Ikzcfs8UYVgOhj8EQNzu7PIZg==
MIME-Version: 1.0
In-Reply-To: <1522140259.1110.43.camel@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com> <20180323095529.5nptn5achjt3esog@flea>
 <1522137643.1110.4.camel@bootlin.com> <20180327081731.he3lhnvqffuimsi5@flea> <1522140259.1110.43.camel@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 27 Mar 2018 16:48:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v67bykhv6oTO0dQTyUOcB0CZZUPHg06F8K0oN5C_PH3E7A@mail.gmail.com>
Message-ID: <CAGb2v67bykhv6oTO0dQTyUOcB0CZZUPHg06F8K0oN5C_PH3E7A@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 4:44 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Hi,
>
> On Tue, 2018-03-27 at 10:17 +0200, Maxime Ripard wrote:
>> On Tue, Mar 27, 2018 at 10:00:43AM +0200, Paul Kocialkowski wrote:
>> > Hi,
>> >
>> > On Fri, 2018-03-23 at 10:55 +0100, Maxime Ripard wrote:
>> > > On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
>> > > > The YUV channel was only disabled in
>> > > > sun4i_backend_update_layer_formats,
>> > > > which is not called when the frontend is selected.
>> > > >
>> > > > Thus, creating a layer with a YUV format handled by the backend
>> > > > and
>> > > > then
>> > > > switching to a format that requires the frontend would keep the
>> > > > YUV
>> > > > channel enabled for the layer.
>> > > >
>> > > > This explicitly disables the YUV channel for the layer when
>> > > > using
>> > > > the
>> > > > frontend as well. It also sets the relevant interlace bit, which
>> > > > was
>> > > > missing in the frontend path as well.
>> > >
>> > > This should be part of a separate patch. Usually, if you write "it
>> > > also does..." at the end of your commit log, it's a pretty good
>> > > indication that it should be another patch :)
>> >
>> > I must say, I figured that this part was missing in the frontend
>> > path by
>> > chance and couldn't really test the feature, so I'm also tempted to
>> > drop
>> > it altogether. What do you think?
>>
>> If you haven't been able to test it, then yeah, don't submit it.
>
> Alright, noted.
>
>> > Also, is interlacing actually used on any of the video outputs we
>> > support? Perhaps RGB?
>>
>> Composite would be a better guess :)
>
> Oh and I was wondering what CVBS was about. Now I know!
> It seems that we don't support it for now apparently, anyway.

You could also try adding interlaced modes to HDMI.

ChenYu
