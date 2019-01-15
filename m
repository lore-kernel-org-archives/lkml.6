Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE95C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1069920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAOI6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:58:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42067 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfAOI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:58:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so2105036qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOsdLjtqZA7KDnwPHYqaXG+fgQYsg/I5XovzL9Yj2u0=;
        b=CLN0VFZduuD9e0OfDWluHAGGlxNuvzfw7JrJezjSSO+ZfyHNo9/IhnmPAxbS60alZh
         SdiAbW9QuXfZopISlcK+QHTthoVtDrl/q9rzNABMmhkGc2R2DZO6+YcSdRCXBGt69iUK
         nDcF6yCdeYyUjn14ovq2uCRU8iMIhf2TPtz8f/hni4vGDMYn/pxlIKI9UyQVLgF3D80n
         HfpVTnxhhzyo8yDQc9S0kMOJj0huNK2fBXhOA54GXPN6gDh7gdwJZpo5O7v6n7fma4iA
         vKqb3neqzMJuakzhrjzr2hiq26rfbe8/pFNUsVBMoX9TCeOSNCBZi2hwUz5xg18a6KO2
         WUpQ==
X-Gm-Message-State: AJcUukcJqrlXCIXeYLKwdDIvAnJ7fja2ym4nDcbaudhhY/AaJ3vsXX3u
        GEO9MReRIEmsxI92OOnpxunxTYK5k59xVDQN34ULSOKE
X-Google-Smtp-Source: ALg8bN7+x+xqwKf8uqwmuwG6VKA09EFK4RapXaOTRKv3/HaaUTGljVT1Gn5LTMELk3V/W3oBLyK3/jFjbaiesetLPco=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr2118069qti.184.1547542686505;
 Tue, 15 Jan 2019 00:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20190111205430.15371-1-kim@kimphillips.com> <20190112014004.GA122403@dtor-ws>
 <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com> <20190114184012.GC117329@dtor-ws>
In-Reply-To: <20190114184012.GC117329@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 15 Jan 2019 09:57:54 +0100
Message-ID: <CAO-hwJKCeV5ZEw7aX58=mnfhWex5QtEVYbRdDX7OosfS5+suUw@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to forcepad
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kim Phillips <kim@kimphillips.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 7:40 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Jan 12, 2019 at 04:04:36PM -0600, Kim Phillips wrote:
> > On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
> > > Hi Kim,
> >
> > Hi Dmitry,
> >
> > > On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
> > >> This patch is the result of seeing this message:
> > >>
> > >> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> > >>
> > >> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
> > >> smbus_pnp_ids, the touchpad continues to work, and the above message
> > >> goes away, but we now get:
> > >>
> > >> psmouse serio1: synaptics: Trying to set up SMBus access
> > >> psmouse serio1: synaptics: SMbus companion is not ready yet
> > >>
> > >> With this patch applied, i.e., the PNP IDs are added to the forcepad
> > >> array, the touchpad continues to work and all of the above messages
> > >> disappear.
> > >
> > > Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
> > > physical button underneath it)? As far as I know there were only couple
> > > of HP laptops with forcepads and when switching to RMI mode forcepads
> > > need F21 handler that we do not currently have in the kernel.
> >
> > I see, no, I'm not sure, but assuming you're right, the IDs
> > should be added to the smbus array instead, after fixing
> > the SMbus "companion not ready" problem?  Pointers for that and
> > the below interrupts when touchpad idle after resume, welcome.
> >
> > Also, the link to get the RMI4 spec in
> > Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> > is broken.  Any pointers for that also appreciated.
>
> OK, sorting it all out some more:
>
> - because we do not have support for F21 necessary for forcepads adding
>   APIC ID to forcepad list actuallty disables SMbus companion mode, that
>   is why you no longer see "companion not ready" messages vs. setting
>   psmouse.synaptics_intertouch=1 module parameter.

Yep

>
> - this does not really matter as your touchpad ends up being driven by
>   i2c-hid and hid-multitouch drivers, and that is how we wait it to
>   work, as we do not want to deviate from behavior on Windows since OEM
>   tested it (the device and firmware) in tha configuration.

Yep too. The I2C-hid touchpads from Synaptics do not have the SMBus
wired at all, so we can't enable SMBus for them. Also, the fact that
the device gets loaded over i2c-hid means that we can't know that it
is the case from the psmouse/synaptics point of view.

>
> - we need to figure out issue with interrupts on resume, maybe Benjamin
>   have seen it?

First time I see it.

I just tried on a XPS 9360 and kernel v4.18 (fedora) and nothing was a problem.
I then tried on a XPS 9575 with v4.19, and here, the wacom I2C node is
also keeping firing the interrupts, but not the touchpad. However,
here, the interrupts are not stopping when I touch the touchscreen or
if I approach a pen.

Kim, rmmod-ing i2c-hid and modprobing back it with the parameter
debug=1 doesn't show any events processed when the interrupts are
firing. Do you see the same?

Cheers,
Benjamin
