Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeDPOXJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeDPOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:23:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2112183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx48WpwMgPxXmNqaLD3U3LKyB1hTIdTsc/APjunlo1SsA2Td4xdnI8I0nSZnCDjzHHgJeyDXXLabVE7wm4hpnagI=
MIME-Version: 1.0
In-Reply-To: <3bf87960-06f8-3224-10d9-4ad76ff446a4@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se> <20180409105918.20792-3-peda@axentia.se>
 <20180413174648.zxljbw634o2r4zty@rob-hp-laptop> <3bf87960-06f8-3224-10d9-4ad76ff446a4@axentia.se>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Apr 2018 09:22:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvPFp-5Km78Vbt=R-rA8F1pm5H4BzvKh9z2JOYrpVDRA@mail.gmail.com>
Message-ID: <CAL_JsqKvPFp-5Km78Vbt=R-rA8F1pm5H4BzvKh9z2JOYrpVDRA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display: atmel: add optional output-mode property
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 8:54 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-04-13 19:46, Rob Herring wrote:
>> On Mon, Apr 09, 2018 at 12:59:15PM +0200, Peter Rosin wrote:
>>> Useful for beating cases where an output mode selection heuristic
>>> fails.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>> index 82f2acb3d374..dc478455b883 100644
>>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>> @@ -10,6 +10,10 @@ Required properties:
>>>   - #address-cells: should be set to 1.
>>>   - #size-cells: should be set to 0.
>>>
>>> +Optional properties:
>>> + - output-mode: override any output mode selection hueristic and force a
>>> +   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
>>> +
>>
>> This needs to be generic, not just added to some random display
>> controller binding.
>>
>> It also belongs in the port or endpoint node as is done for camera
>> interfaces.
>
> Hmm, should I extend media/video-interfaces.txt with more bus types (or since
> I'm targeting parallel interfaces, perhaps the new bus types should be
> autodetected from other props?) or should a write a new binding similar to
> it?

Ultimately, I'd like it documented in one place. It can stay in
media/video-interfaces.txt for now, but we should probably move it or
portions of it out of media/. I don't have a good suggestion other
than up a level where people will find it easily.

> One question regarding bus-width, should it include hsync/vsync/de/clk?
> If yes, how to distinguish rgb565 with all those four from rgb666 with
> only de/clk (some panels do not need hsync/vsync)? 20 lines in both
> cases...

I'd say no, it is just the data lines.

> Or are rgb444/rgb565/rgb666/rgb888 already supported by the media video
> interface binding? That's not at all obvious to me.

Not sure, I'd guess not.

Rob
