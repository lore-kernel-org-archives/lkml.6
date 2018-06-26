Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D3D25AB5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIFeTv5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D3D25AB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFZPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbeFZPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:50:04 -0400
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0E726D1B;
        Tue, 26 Jun 2018 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530028204;
        bh=8FCMRcUBW5KGuRr+Y2KMmjgoE9Xbx2NMESHodUwOVsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bIFeTv5yB/Rg/ADqUy0ylVpULT12A5oKy52FM7i+nwCcHW2IZYcMQk3UhDOrvdzY3
         ch8tFZHqbjuBR5/ytnz3YFtaWpA/zwODeUDRljWFGv04ZWZhank+GdogDk3ZQ1r1lF
         48jePR8sNfEADkGXhfN9skKSyIoqeT3ucA0b2FKQ=
Received: by mail-io0-f174.google.com with SMTP id l19-v6so16421752ioj.5;
        Tue, 26 Jun 2018 08:50:03 -0700 (PDT)
X-Gm-Message-State: APt69E3Fb3a0FSUyz1b3EIN1OGwq7fV5VtXR91fyTEWtB2diKkQAlvYC
        ntvwNTsFFXPhg05ALa1mxWE4SPO4+NUjRO1cDQ==
X-Google-Smtp-Source: AAOMgpfSbyRQZJp112V3tUaIRLoaqfj6XE4Xk2EaLaIVQnoE9ST/1B/5emIHYSvQ+E0/isHnqpEFHSXmoDnXxMjy+ys=
X-Received: by 2002:a6b:c696:: with SMTP id w144-v6mr1715070iof.79.1530028203297;
 Tue, 26 Jun 2018 08:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180621015237.100100-1-mka@chromium.org> <20180621015237.100100-10-mka@chromium.org>
 <20180625153341.GB23270@rob-hp-laptop> <20180625185037.GE129942@google.com> <20180625200304.GF129942@google.com>
In-Reply-To: <20180625200304.GF129942@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Jun 2018 09:49:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkYn66nrjphfLQzsO-eG1KZWdHxZbW5NEgkX4EhLbwAQ@mail.gmail.com>
Message-ID: <CAL_JsqLkYn66nrjphfLQzsO-eG1KZWdHxZbW5NEgkX4EhLbwAQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers property
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Mon, Jun 25, 2018 at 11:50:37AM -0700, Matthias Kaehlcke wrote:
> > Hi Rob,
> >
> > On Mon, Jun 25, 2018 at 09:33:41AM -0600, Rob Herring wrote:
> > > On Wed, Jun 20, 2018 at 06:52:34PM -0700, Matthias Kaehlcke wrote:
> > > > The optional opp-throttlers property is used to configure the throttlers
> > > > (see drivers/misc/throttler/*) that use a given OPP to throttle the
> > > > corresponding device(s).
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > > Changes in v4:
> > > > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > > >
> > > > Changes in v3:
> > > > - none
> > > >
> > > > Changes in v2:
> > > > - patch added to series
> > > > ---
> > > >  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > > index c396c4c0af92..747e79740c75 100644
> > > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > > @@ -170,6 +170,9 @@ Optional properties:
> > > >    functioning of the current device at the current OPP (where this property is
> > > >    present).
> > > >
> > > > +- opp-throttlers: Array with phandles of throttlers that use this OPP to
> > > > +  throttle the corresponding device(s).
> > > > +
> > >
> > > I think it would be better to make this a boolean for each OPP entry and
> > > then add "operating-points-v2" property to the EC node to point to the
> > > OPP table.
> >
> > Thanks for your suggestion. "operating-points-v2" would have to be an
> > array of phandles, a single thottler can have multiple throttling
> > devices.

I don't see any issue with allowing that.

> > > Unless there is some need for a different throttler for each OPP entry?
> >
> > Having the option to use different OPPs per throttler would be my
> > preference. E.g. there could be configurations where one throttler
> > only interacts with certain throttling devices and another one
> > with others.

Your terminology is confusing. By "throttling device", you mean an OPP
table (or OPP entry) which is not a device. OPPs are just a table of
state information.

> > I see another option to achieve this, if you don't like the reference
> > to the throttlers in the OPPs. The throttler could have a list of OPPs
> > (as phandles, not frequencies as in v1). The main inconvenient I see
> > here is that the used OPPs would need a label, which they usually
> > don't have. Maybe this is no soooo bad, since the label could be added
> > at device level, only on devices that use a throttler, so it wouldn't
> > clutter the platform .dts files.
> >
> > This could be a single array with all OPPs from different devices,
> > or multiple arrays, one for each throttling device:
> >
> > throttler-opps-0 = <&cpu0_opp_03 &cpu0_opp_05>;
> > throttler-opps-1 = <&gpu_opp_02 &gpu_opp_04>;
> >
> > My preference would be multiple arrays, because it's easier to read.
>
> I take the preference back. The OPPs for each device (group) can be
> clustered within the single array and if needed clarifying comments
> can be added:
>
> throttler-opps = <&cpu0_opp_03 &cpu0_opp_05  /* CPU0 */
>                   &gpu_opp_02 &gpu_opp_04>;  /* GPU */
>
> This is simpler algorithmically and there is no need for an additional
> property indicating the number of OPP groups or probing.

I'm still trying to understand why you would have say throttler-A
wanting to set cpu freq to X and throttler-B wanting to set cpu freq
to Y. There's both the question of why/when would you have 2 or more
throttlers (in DT) and how would you resolve multiple requests.

The whole design of a throttler directly dealing with OPPs especially
for non-cpu devices seems like it is missing some level of
abstraction. What if you want to throttle by some means other than
frequency such as idling cores? I guess abstraction would make it hard
to make things optimal for every platform when in the end you just
want to set specific frequencies on a number of devices. It seems like
a similar situation as early big.LITTLE designs vs. EAS.

Rob
