Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeBZJn1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:43:27 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55075 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeBZJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:43:25 -0500
X-Google-Smtp-Source: AH8x224xik+R2y+TUleN4PvFd5CXmpPx2zMOZHpXrSGunhrDXCXqlGnK+QaNxWzjaQnvblU0Y0UEyw==
MIME-Version: 1.0
In-Reply-To: <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net> <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 26 Feb 2018 17:43:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
Message-ID: <CAGb2v64fxs5Ne5=orQxNcg70Z_N0NJyyC7MPuNH6pxcqrsUq4g@mail.gmail.com>
Subject: Re: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 5:38 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
>> Some NM PLLs doesn't work well when their output clock rate is set below
>> certain rate.
>>
>> Add support for that constrain.
>
> In such a case, you should round the rate to the minimum the clock can
> operate at, and not return an error.

That's true for round_rate. But what's the expected behavior of set_rate?
AFAIK we presume all users call round_rate before set_rate, but that doesn't
seem to be true all the time.

ChenYu
