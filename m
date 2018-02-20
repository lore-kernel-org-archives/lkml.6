Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBTTJ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeBTTJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:09:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C32217A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELvA1sig9XDQd3UzQ1ihu87ZL+s0uHGXVyAsYtNwt+ZS3/yZ7per2DGn4/Po6cMnpbklt6H3iybrgCo/7C29428=
MIME-Version: 1.0
In-Reply-To: <20180219110618.7hgsf3g6womvecay@earth.universe>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
 <20180208183035.8461-5-sebastian.reichel@collabora.co.uk> <20180218232424.47ejrqdze7nm7g5d@rob-hp-laptop>
 <20180219110618.7hgsf3g6womvecay@earth.universe>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Feb 2018 13:09:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyj3GrmyxYtQU=nT6iLyWoiRvo0opjdi7Nx8j3TH-KPA@mail.gmail.com>
Message-ID: <CAL_JsqLyj3GrmyxYtQU=nT6iLyWoiRvo0opjdi7Nx8j3TH-KPA@mail.gmail.com>
Subject: Re: [PATCHv2 4/8] dt-bindings: panel: common: document orientation property
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 5:06 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi,
>
> On Sun, Feb 18, 2018 at 05:24:24PM -0600, Rob Herring wrote:
>> On Thu, Feb 08, 2018 at 07:30:31PM +0100, Sebastian Reichel wrote:
>> > Introduce new "orientation" property for describing in which
>> > orientation a panel has been mounted to the device. This can
>> > be used by the operating system to automatically rotate the
>> > display correctly.
>> >
>> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> > ---
>> >  .../devicetree/bindings/display/panel/panel-common.txt     | 12 ++++++++++++
>> >  include/dt-bindings/display/common.h                       | 14 ++++++++++++++
>> >  2 files changed, 26 insertions(+)
>> >  create mode 100644 include/dt-bindings/display/common.h
>> >
>> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
>> > index 557fa765adcb..c646b8908458 100644
>> > --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
>> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
>> > @@ -18,6 +18,18 @@ Descriptive Properties
>> >    physical area where images are displayed. These properties are expressed in
>> >    millimeters and rounded to the closest unit.
>> >
>> > +- orientation: The orientation property specifies the panel orientation
>> > +  in relation to the device's casing. The following values are possible:
>> > +
>> > +   * 0 = The top side of the panel matches the top side of the device's
>> > +         casing.
>> > +   * 1 = The top side of the panel matches the bottom side of the device's
>> > +         casing. In other words the panel is mounted upside-down.
>> > +   * 2 = The left side of the panel matches the top side of the device's
>> > +         casing.
>> > +   * 3 = The right side of the panel matches the top side of the device's
>> > +         casing.
>>
>> The rotation property in panel.txt already handles this, right?
>
> Yes, looks like it can be used. I guess panel.txt and
> panel-common.txt should be merged, though?

Yes, please. Actually, I'd like to merge simple-panel.txt too because
that is really kernel driver, not a type of panel. But there's a lot
of references to it to fix.

Rob
