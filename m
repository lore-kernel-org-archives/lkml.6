Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeAaQxC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:53:02 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35316 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeAaQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:53:01 -0500
X-Google-Smtp-Source: AH8x22639tL9UuKdOwwiLz1nuY/EhUHoY7voi2fphj7R+zEfkDXUVkxfBIKFGz3hnZO0oA3/GLc0yCBhm3TZbfKL3l0=
MIME-Version: 1.0
In-Reply-To: <CAOw6vbKsG=B7vV5_NcwgeAc-=guRN1Xh-dCxKytkDeOjayatLw@mail.gmail.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
 <20180130202913.28724-34-thierry.escande@collabora.com> <1517403243.14302.1.camel@pengutronix.de>
 <CAOw6vbKsG=B7vV5_NcwgeAc-=guRN1Xh-dCxKytkDeOjayatLw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jan 2018 08:52:59 -0800
X-Google-Sender-Auth: o5ocRZlgLtz0ByLp4uYQFsxc3LQ
Message-ID: <CAD=FV=UB+ovYFSi2aB_qe3igX3K7BxMWaEEoNPx1UMdscKwQtQ@mail.gmail.com>
Subject: Re: [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
To: Sean Paul <seanpaul@chromium.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
        Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Yakir Yang <ykk@rock-chips.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Jan 31, 2018 at 7:16 AM, Sean Paul <seanpaul@chromium.org> wrote:
> On Wed, Jan 31, 2018 at 7:54 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> Am Dienstag, den 30.01.2018, 21:29 +0100 schrieb Thierry Escande:
>>> From: Sean Paul <seanpaul@chromium.org>
>>>
>>> Change the mode for Sharp lq123p1jx31 panel to something more
>>> rockchip-friendly such that we can use the fixed PLLs to
>>> generate the pixel clock
>>
>> This should really switch to a display timing instead of exposing a
>> single mode. The display timing has min, typical, max tuples for all
>> the timings values, which would allow the attached driver to vary the
>> timings inside the allowed bounds if it makes sense.
>>
>> Trying to hit a specific pixel clock to free up a PLL is exactly one of
>> the use cases envisioned for the display timings stuff.
>>
>
> Agreed, I think we had this discussion the first time around. We
> should drop this patch.
>
> Thanks for catching this!

Are you sure we should drop this?  In order for things to work
properly (not generate noise on the digitizer or other EMI), this
needs to run at a very specific pixel clock with very specific
blanking times.  I know that earlier we had slightly different
blanking times and Samsung came back and said that there was noise on
the digitizer.  I could be wrong, but I don't think there's any way
currently to be able to specify exactly what timings should be used on
a particular board.

Don't get be wrong--I think a patch such as this one that claims a
single board's timings as the "right" ones for a generic panel is a
bit of a hack.  ...but at the same time there are no other users of
this panel (that I know of) in mainline and the timings presented here
are certainly sane timings for this panel.

In any case, previous discussion at: https://patchwork.kernel.org/patch/9614603/


...oh, and looking at the previous discussion reminds me that the
timings presented in this here patch are actually not the right ones
(they have the right PLL, but the wrong blankings to avoid the noise
issues).  See <//chromium-review.googlesource.com/381015>



-Doug
