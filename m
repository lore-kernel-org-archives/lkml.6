Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeE3Oq5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:46:57 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44394 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbeE3Oqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:46:52 -0400
X-Google-Smtp-Source: ADUXVKIexr7RCeT+ZC8n2Jw7t2mo4EfbyG9vhDPK2VmvUldllhLaijrRUwmuSdEfOzzA+GwesTPl69044U8zSfx8dn4=
MIME-Version: 1.0
In-Reply-To: <20180530093701.GD6920@sirena.org.uk>
References: <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org> <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk> <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk> <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk> <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 07:46:50 -0700
X-Google-Sender-Auth: yThp_NbASaZBg1eIVACCFMGN8jk
Message-ID: <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
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

On Wed, May 30, 2018 at 2:37 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 29, 2018 at 10:30:33PM -0700, Doug Anderson wrote:
>> On Wed, May 23, 2018 at 8:56 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Yes, that's definitely not what's expected but it's unfortunately what
>> > the firmware chose to implement so we may well be stuck with it
>> > unfortunately.
>
>> We're not really stuck with it if we do what I was suggesting.  I was
>> suggesting that every time we disable the regulator in Linux we have
>> Linux vote for the lowest voltage it's comfortable with.  Linux keeps
>> track of the true voltage that the driver wants and will always change
>> its vote back to that before enabling.  Thus (assuming Linux is OK
>> with 1.2 V - 1.4 V for a rail):
>
> That's pretty much what it should do anyway with normally designed
> hardware.

I guess the question is: do we insist that the driver include this
workaround, or are we OK with letting the hardware behave as the
hardware does?

-Doug
