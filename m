Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeE3Qci (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:32:38 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34631 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeE3Qcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:32:36 -0400
X-Google-Smtp-Source: ADUXVKLM8K5a/ECO+hE8+BvRFofYEJqI84zg+bnDBx6+ebUlFpue2bIZ/Q4YtffD9A4pGQa94zzMbe5vPbc1RaNX2bc=
MIME-Version: 1.0
In-Reply-To: <20180530161311.GT6920@sirena.org.uk>
References: <20180523155617.GN4828@sirena.org.uk> <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk> <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk> <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk> <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk> <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 09:31:55 -0700
X-Google-Sender-Auth: oNmEtbONGEItK7lhKj692v4ZNEs
Message-ID: <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: Mark Brown <broonie@kernel.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 30, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 09:09:02AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 9:07 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > It needs something to tell it what the new voltage to set is.
>
>> The regulator driver has its own cache of what voltage was most
>> recently requested by Linux.  It can use that, can't it?
>
> If we're just going to use the most recently set voltage then hopefully
> the hardware already knew that, and it might not be the lowest available
> voltage if the last consumer to get turned off was holding the voltage
> higher.

To circle back to the original point: the problem is that (IMHO) the
hardware is doing the wrong thing by still counting Linux's vote for a
voltage even though Linux also voted that the regulator should be
disabled.  So basically we're working around the hardware by
pretending to vote for a dummy lower voltage whenever Linux wants the
regulator disabled.  From Linux's point of view everything works as
normal--we just tell the hardware a falsehood so it doesn't count our
vote for a voltage while the regulator is disabled.

-Doug
