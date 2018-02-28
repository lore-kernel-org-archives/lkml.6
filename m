Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934874AbeB1VRm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:17:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44249 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932974AbeB1VRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:17:41 -0500
X-Google-Smtp-Source: AH8x2276gNAbjWj+M6ODVWaio3U8w6yHEKx11w17b1VNFHxyZKNZqgwegTHBXbm5kJzkAxsDuzs8AMoFQ115ka9vYqM=
MIME-Version: 1.0
In-Reply-To: <20180227183908.GF5448@atomide.com>
References: <1519747558-17257-1-git-send-email-tharvey@gateworks.com> <20180227183908.GF5448@atomide.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Feb 2018 13:17:39 -0800
Message-ID: <CAJ+vNU2d-KKMHvb2bJt-b_9h7c2YM1NJS4PYYi7Y=YzT-VQJNg@mail.gmail.com>
Subject: Re: [PATCH] regmap: irq: fix ack-invert
To: Tony Lindgren <tony@atomide.com>, Guo Zeng <Guo.Zeng@csr.com>,
        Barry Song <Baohua.Song@csr.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 10:39 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tim Harvey <tharvey@gateworks.com> [180227 16:07]:
>> When acking irqs we need to take into account the ack-invert case. Without
>> this chips that require 0's to ACK interrupts will never clear the interrupt.
>>
>> I am working on an mfd driver that will use ack-invert and discovered
>> this issue. The only user of ack_invert currently appears to be the
>> motorola-cpcap driver. I'm not clear why that driver doesn't appear affected
>> so I'm cc'ing those involved with that driver for review and testing.
>
> I gave this a quick try and it fails with cpcap. So yeah, you're right,
> it seems we still have the cpcap config wrong.
>

Tony,

So you would agree with my findings/patch right? I certainly don't
want to break regmap-irq in general :)

Adding Guo Zeng and Barry Song to the thread as they were the authors
of the ack_invert feature (a650fdd9427f1f5236f83d2d8137bea9b452fa53)
and I'm not clear what happened to the chip they were needing it for.

> Things do work with the following patch and your patch for cpcap. So
> they should both be applied together as a single patch.
>
> Care to fold in the following change and then repost your patch?
>
> Otherwise we might end up breaking things easily for booting or
> bisect or stable. Or else the patch below needs to be applied first
> to avoid breaking things.
>

So cpcap needs to write 1's to clear irq's not 0's right?

Yes, I can certainly roll in the fix for cpcap if everyone agrees
that's the right move.

I'll wait for some feedback from Mark Brown as well.

Regards,

Tim
