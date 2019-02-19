Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B92F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI9uz13J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBSIPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:15:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46671 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:15:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so9744751pgp.13;
        Tue, 19 Feb 2019 00:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNujeU7qzhkK3JY0Befn7uYd90h7Ocpo7KzFQEHrNVg=;
        b=FI9uz13JXul2nE9DiSF0kL91BihrS3Z2rSAxtd8ZK3/cs/zVOtGQW/Lv8z/2jPK7y3
         MbRvXhnugQzFIxHhWgrivEwEo52t74CuFaSLZufwXbJTjhqRU0uK2mSGaKXetg/EkufL
         mXCBMlzfFAfaLYBRHGlsYgn2Ok5Pt6LHWbzOw1/LwBk4MriwzND7qfK/FhW13h8cTGDJ
         EloATziEHoRbIeU1Gz38aRT6reVNzWvi1sv4iKqvCxV/YEv6F6j1Crv9+LvOzb1ReNsD
         Z4paR5FPsnPjGY9sT4PyFSWRVtjQK2mEVRxC4E1YOFlULyo4UWK+f/5ezMABXNsxPkly
         CxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNujeU7qzhkK3JY0Befn7uYd90h7Ocpo7KzFQEHrNVg=;
        b=obobt3IS/z7ItZH9Pzuotv+1ITkxv1kaMdBSNQCbtdL550qsaDRoOE3V6/wvjTX89Q
         Te88p3bAlqQHE0nuzLyECN+biDTyWXcCfSdIrlyvXuHSosMLcvCtqbYWer/vYec2lCeJ
         ZJPnEbfXo2jHFeSHquAhk7HsjFX9XFVeTQy2AmiFiIBl6h4KDM/PhF/n+wZuM1vunIw1
         58esxfc10wiRKrB6efcPDgwmiFuFs8YMA6qJMTg5VkUdQ9UY0epkMQiSQMxPqJVmNxsf
         kX76S47MNsMwpZH4mh6XFgTDOgydF48iirJWWj6e9E9BQzVm23MFvyiiHmFBNxxzoGga
         U/Zg==
X-Gm-Message-State: AHQUAua6YMW0i9gdjPsgVHoTfxNHQnaGojuO+iJAgN9h+F7CdF21Rsu1
        767UxVklntvn9XW6KUByNm4=
X-Google-Smtp-Source: AHgI3IbCr1IIDViv1S8BxYBn/8A8M5sD6POqB+Rw9rc6mOwUi69JlBtcg7/7WcqwS1bSA92CUu8BDQ==
X-Received: by 2002:a62:445a:: with SMTP id r87mr27943600pfa.13.1550564112520;
        Tue, 19 Feb 2019 00:15:12 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h13sm8543471pfn.114.2019.02.19.00.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 00:15:11 -0800 (PST)
Date:   Tue, 19 Feb 2019 00:15:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Message-ID: <20190219081510.GB65896@dtor-ws>
References: <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
 <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
 <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
 <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
 <CAMty3ZDBu2Y9psNu9nrZ=BNVvhpJ2qYn-Qp7MDqdhK9_SrcpNg@mail.gmail.com>
 <20190218071207.GE242714@dtor-ws>
 <CAMty3ZDbFU-NpWQvkaUWgUiVTabjTZoFWUCUZSPKMA6VuHc+iQ@mail.gmail.com>
 <CAMty3ZBVpNY+JF_vEMs83M29WKQDhzmk7LyL-HHCCA7uD0Y+=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZBVpNY+JF_vEMs83M29WKQDhzmk7LyL-HHCCA7uD0Y+=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:00:19AM +0530, Jagan Teki wrote:
> On Mon, Feb 18, 2019 at 3:03 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Mon, Feb 18, 2019 at 12:42 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Sun, Feb 17, 2019 at 02:45:52PM +0530, Jagan Teki wrote:
> > > > On Sun, Feb 17, 2019 at 1:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > >
> > > > > Hi Dmitry and Rob,
> > > > >
> > > > > On Thu, Feb 14, 2019 at 3:21 AM Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Please CC DT list if you want bindings reviewed.
> > > > > > > > >
> > > > > > > > > Sorry I forgot.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > > > > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > > > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > > > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > > > > > > > to trigger the power.
> > > > > > > > > > > >
> > > > > > > > > > > > So, document the supply property so-that the require boards
> > > > > > > > > > > > that used on GT5663 can enable it via device tree.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > > > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > > > > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > > > > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > > > > > > > >                               (swapping is done after inverting the axis)
> > > > > > > > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > > > > > > > >
> > > > > > > > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > > > > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > > > > > > > of the same kind, but I'll let Ron comment on this.
> > > > > > > > > >
> > > > > > > > > > Yes on lowercase though there are some exceptions.
> > > > > > > > > >
> > > > > > > > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > > > > > > > probably need to keep the voltage, but the binding is incomplete.
> > > > > > > > >
> > > > > > > > > What is incomplete here? can you please elaborate.
> > > > > > > >
> > > > > > > > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
> > > > > > >
> > > > > > > Though it has other supplies, only AVDD28 is connected in the Host
> > > > > > > interface design similar like 9. Reference Schematic on Page, 23 in
> > > > > > > attached manual.
> > > > > >
> > > > > > That is for a particular board design. It still has other supplies.
> > > > > > Just make the binding complete please. You can make them optional. I
> > > > > > don't care if the driver supports controlling all the supplies or not
> > > > > > (though Dmitry might).
> > > > >
> > > > > So, Can I make bulk get and enable in all 4 regulators global to
> > > > > driver or specific to that chip, in either way the regulators which
> > > > > are not used to process via dummy regulators (which we all know).
> > > > >
> > > > > or regulator which are not using are get via devm_regulator_get_optional.
> > > > >
> > > > > Any suggestions?
> > > >
> > > > Just realized to go with bulk calls, please have a look at on v5 [1]
> > >
> > > I do not believe you can use bulk regulator API here as you need to
> > > implement the power up timing scheme mentioned on p. 12 of the spec you
> > > referenced earlier. And, because of that timing diagram, I believe if
> > > you want to control AVDD supply, you also have to control VDDIO supply
> > > as it has to be on only after enabling AVDD.
> >
> > AVDD here is AVDD28 it' is an out name of pin (mentioned in p. 23). So
> > the power scheme goes to enable AVDD28 and then VDDIO does that really
> > mean bulk of two regulators?
> 
> The time between these two regulator operations is nearly 0, as per
> power scheme diagram T1 >= 0us. I think I can use bulk since there is
> no necessity of delay between these two regulator operations.
> 
> What do you think?

Does the bulk enable provide any guarantees as to the order of
operations? If it does not then I think we should ensure that they are
powered up/down in the right order.

Thanks.

-- 
Dmitry
