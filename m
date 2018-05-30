Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeE3Oyx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:54:53 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46230 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeE3Oyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:54:49 -0400
X-Google-Smtp-Source: ADUXVKJcKY/i1JJlmwMbpLJjIDQO9q6bCYTHQ/3hfiJ9S2hBRDMcNXPPPGOPXaVbg42hE9jIX6nwZwuk5aRx1Zx+5YI=
MIME-Version: 1.0
In-Reply-To: <20180530103720.GH6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org> <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com> <20180530103720.GH6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 07:54:47 -0700
X-Google-Sender-Auth: xO2qLhhKYI8xzZQHnEMUorhh1Zk
Message-ID: <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
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

On Wed, May 30, 2018 at 3:37 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 29, 2018 at 10:23:20PM -0700, Doug Anderson wrote:
>
>> > +                       qcom,drms-mode-max-microamps = <10000 1000000>;
>
>> Things look pretty good to me now.  I'm still hesitant about the whole
>> need to list the modes twice (once using the unordered
>> "regulator-allowed-modes" and once to match up against the ordered
>> "qcom,drms-mode-max-microamps").  I'm also still of the opinion that
>> the whole "drms-mode-max-microamps" ought to be a standard property
>> (not a qcom specific one) and handled in the regulator core.
>
> I'm confused as to why we are specifying the maximum current the device
> can deliver in a given mode in the DT - surely that's a fixed property
> of the hardware?

Said another way: you're saying that you'd expect the "max-microamps"
table to have one fewer element than the listed modes?  So in the
above example you'd have:

drms-modes: LPM, HPM
max-microamps: 10000

...or in a more complicated case, you could have:

drms-modes: RET, LPM, AUTO, HPM
max-microamps: 1, 100, 10000


Did I understand you correctly?

I'm personally OK with that color for the shed.  I kinda like the
symmetry of having the same number of elements in both lists (and
being able to print an error message if someone ends up asking for too
much current), but it's not a big deal for me either way.

-Doug
