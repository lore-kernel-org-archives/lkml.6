Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeCLIQL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:16:11 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:43659 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:16:08 -0400
X-Google-Smtp-Source: AG47ELuFyxAZxzOIjPBfDDW6JMQvgjUKbuU/Uok1xS7Ap+5JRLX/cAWJkBqp53aUPWZwSG6qehIiVg==
MIME-Version: 1.0
In-Reply-To: <1520842245.1513.5.camel@bootlin.com>
References: <20180220044425.169493-20-acourbot@chromium.org>
 <1520440654.1092.15.camel@bootlin.com> <6470b45d-e9dc-0a22-febc-cd18ae1092be@gmail.com>
 <1520842245.1513.5.camel@bootlin.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 12 Mar 2018 17:15:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A9mSP8Ufe-gn2Epa55M_NNOVaBL_cdWjdZ5PycbTvqbA@mail.gmail.com>
Message-ID: <CAAFQd5A9mSP8Ufe-gn2Epa55M_NNOVaBL_cdWjdZ5PycbTvqbA@mail.gmail.com>
Subject: Re: [RFCv4,19/21] media: vim2m: add request support
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc: Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Dmitry,

On Mon, Mar 12, 2018 at 5:10 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Hi,
>
> On Sun, 2018-03-11 at 22:42 +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> On 07.03.2018 19:37, Paul Kocialkowski wrote:
>> > Hi,
>> >
>> > First off, I'd like to take the occasion to say thank-you for your
>> > work.
>> > This is a major piece of plumbing that is required for me to add
>> > support
>> > for the Allwinner CedarX VPU hardware in upstream Linux. Other
>> > drivers,
>> > such as tegra-vde (that was recently merged in staging) are also
>> > badly
>> > in need of this API.
>>
>> Certainly it would be good to have a common UAPI. Yet I haven't got my
>> hands on
>> trying to implement the V4L interface for the tegra-vde driver, but
>> I've taken a
>> look at Cedrus driver and for now I've one question:
>>
>> Would it be possible (or maybe already is) to have a single IOCTL that
>> takes input/output buffers with codec parameters, processes the
>> request(s) and returns to userspace when everything is done? Having 5
>> context switches for a single frame decode (like Cedrus VAAPI driver
>> does) looks like a bit of overhead.
>
> The V4L2 interface exposes ioctls for differents actions and I don't
> think there's a combined ioctl for this. The request API was introduced
> precisely because we need to have consistency between the various ioctls
> needed for each frame. Maybe one single (atomic) ioctl would have worked
> too, but that's apparently not how the V4L2 API was designed.
>
> I don't think there is any particular overhead caused by having n ioctls
> instead of a single one. At least that would be very surprising IMHO.

Well, there is small syscall overhead, which normally shouldn't be
very painful, although with all the speculative execution hardening,
can't be sure of anything anymore. :)

Hans and Alex can correct me if I'm wrong, but I believe there is a
more atomic-like API being planned, which would only need one IOCTL to
do everything. However, that would be a more serious change to the
V4L2 interfaces, so should be decoupled from Request API itself.

Best regards,
Tomasz
