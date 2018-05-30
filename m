Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeE3QJJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:09:09 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40971 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeE3QJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:09:04 -0400
X-Google-Smtp-Source: ADUXVKLiewQ3LARsVYwLCOtT3OIEEmWkKnOiOJFY4ubj08tgJegPneRC2rs5yVTe5gxhgpLDL/HMDS6xIJPphsVDlMU=
MIME-Version: 1.0
In-Reply-To: <20180530160744.GS6920@sirena.org.uk>
References: <20180523154057.GL4828@sirena.org.uk> <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk> <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk> <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk> <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk> <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 09:09:02 -0700
X-Google-Sender-Auth: lwX0FUiPiDqL4_EiXCLcVGEsYgY
Message-ID: <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
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

On Wed, May 30, 2018 at 9:07 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 09:06:16AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 8:48 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Without the core doing something the regulator isn't going to get told
>> > that anything updated voltages anyway...
>
>> I was just suggesting that when the core tells the regulator driver to
>> disable itself that the regulator driver tell RPMh to not only disable
>> itself but also (temporarily) vote for a lower voltage.  When the core
>> tells the regulator to re-enable itself then the regulator driver
>> restores the original voltage vote (or applies any vote that might
>> have been attempted while the regulator was disabled).  That wouldn't
>> require any regulator core changes.
>
> It needs something to tell it what the new voltage to set is.

The regulator driver has its own cache of what voltage was most
recently requested by Linux.  It can use that, can't it?

-Doug
