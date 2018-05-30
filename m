Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeE3QYp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:24:45 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41476 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeE3QYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:24:40 -0400
X-Google-Smtp-Source: ADUXVKIyQEJ5xGk59XL3t5NX83Qyn49icNZOMSdIPvNVUHOfnFg66RtZ2Q2OXR/MFfdUwX3IwCD6PCkDxXdE/yVRyWc=
MIME-Version: 1.0
In-Reply-To: <20180530162007.GU6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org> <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk> <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk> <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
 <20180530162007.GU6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 09:24:37 -0700
X-Google-Sender-Auth: nzEuSv6KZUfyLukH5OiGCVnT4NI
Message-ID: <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
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

On Wed, May 30, 2018 at 9:20 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 09:12:25AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 8:50 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, I'm saying that I don't know why that property exists at all.  This
>> > sounds like it's intended to be the amount of current the regulator can
>> > deliver in each mode which is normally a design property of the silicon.
>
>> Ah, got it.  So the whole point here is to be able to implement either
>> the function "set_load" or the function "get_optimum_mode".  We need
>> some sort of table to convert from current to mode.  That's what this
>> table does.
>
> We do need that table, my expectation would be that this table would be
> in the driver as it's not something I'd expect to vary between different
> systems but rather be a property of the silicon design.  No sense in
> every single board having to copy it in.

Ah, got it!  I'd be OK with it being hardcoded in the driver.

At one point I think David was making the argument that some boards
have different noise needs for the rails and thus you might want to
change modes at different currents.  I don't know if this is realistic
but I believe it was part of his original argument for why this needed
to be specified.  If we can hardcode this in the driver I'm fine with
it...  That would actually solve many of my objections too...


-Doug
