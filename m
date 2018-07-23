Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A269ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2A20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU18h/xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGXAhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbeGXAhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:37:24 -0400
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com [209.85.220.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0B620875;
        Mon, 23 Jul 2018 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532388829;
        bh=aWQhunCdGpIC+MedilzP1YrA4wc0f7h4HzFPaul6kWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nU18h/xpgsa8mQS3mmsa3xibZCZ8Jncz5VOnXxZxmnuPO/8f2edn0/vkNpMw0K9z6
         C1EL/Mm5wjgcf5WL/kqLLcNXEmt6xYFBFhFN+gEdgrnCxMK2/7rX+quWgs46KnlYW0
         oWG3dOM+90LFTa4XZ5FoN1Vo9kl+CkHD30x17xh8=
Received: by mail-qk0-f178.google.com with SMTP id t79-v6so1559348qke.4;
        Mon, 23 Jul 2018 16:33:49 -0700 (PDT)
X-Gm-Message-State: AOUpUlFv4vrL2HORA2bXQPtCsn7wSj2GTTH5+DdWB89duDV9WOP2BLaz
        S7dCbyGLZHaQNlUrtTXWoHLtea096UVnZA2jaQ==
X-Google-Smtp-Source: AAOMgpce27MI9NmlcbAnv88kx+Bsz3qGRQo4sTMsO+lTIXFKn9qFTIgKLvtsgfI9uu8L6ge+OLhf6PqrkKrU16oCmEU=
X-Received: by 2002:a37:a0c8:: with SMTP id j191-v6mr9074066qke.375.1532388828627;
 Mon, 23 Jul 2018 16:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180706233142.166296-1-dianders@chromium.org>
 <20180720141059.GA3064@rob-hp-laptop> <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
 <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
 <CAD=FV=XBCeKUrfMCppfhetWNWLJWzsbiBkQnTugoXDff-0SD5w@mail.gmail.com>
 <CAL_Jsq+X=RZK-GU+9LqK-0O1A=cYeudhHvvnrXm6xv=j1Ck4_w@mail.gmail.com> <CAD=FV=UDq8oq+nKsa2mZWvAUueUFxEUSYz2JoZ=E7e131SOR=g@mail.gmail.com>
In-Reply-To: <CAD=FV=UDq8oq+nKsa2mZWvAUueUFxEUSYz2JoZ=E7e131SOR=g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jul 2018 17:33:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com>
Message-ID: <CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:37 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 23, 2018 at 7:04 AM, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jul 20, 2018 at 11:54 AM Doug Anderson <dianders@chromium.org> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Jul 20, 2018 at 10:26 AM, Rob Herring <robh@kernel.org> wrote:
> >> > On Fri, Jul 20, 2018 at 9:13 AM Doug Anderson <dianders@chromium.org> wrote:
> >> >>
> >> >> Rob,
> >> >>
> >> >> On Fri, Jul 20, 2018 at 7:10 AM, Rob Herring <robh@kernel.org> wrote:
> >> >> > On Fri, Jul 06, 2018 at 04:31:42PM -0700, Douglas Anderson wrote:
> >> >> >> A few patches have landed for the qcom-qmp PHY that affect how you
> >> >> >> would write a device tree node.  ...yet the bindings weren't updated.
> >> >> >> Let's remedy the situation and make the bindings refelect reality.
> >> >> >
> >> >> > "dt-bindings: phy: ..." for the subject.
> >> >>
> >> >> Sorry.  Every subsystem has different conventions for this so I
> >> >> usually just do a "git log" on the file and make my best guess.  I'll
> >> >> try to remember this for next time though.
> >> >
> >> > NP. I'd like to add this info to MAINTAINERS or maybe a git commit
> >> > hook could figure this out automagically.
> >> >
> >> >> In this case, though, it looks like this already landed.  I see this
> >> >> patch in Kishon's next branch.
> >> >>
> >> >>
> >> >> >> Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
> >> >> >> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
> >> >> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> >> >> ---
> >> >> >>
> >> >> >>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
> >> >> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >> >> >>
> >> >> >> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> >> >> index 266a1bb8bb6e..0c7629e88bf3 100644
> >> >> >> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> >> >> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> >> >> @@ -12,7 +12,14 @@ Required properties:
> >> >> >>              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> >> >> >>              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
> >> >> >>
> >> >> >> - - reg: offset and length of register set for PHY's common serdes block.
> >> >> >> + - reg:
> >> >> >> +   - For "qcom,sdm845-qmp-usb3-phy":
> >> >> >> +     - index 0: address and length of register set for PHY's common serdes
> >> >> >> +       block.
> >> >> >> +     - named register "dp_com" (using reg-names): address and length of the
> >> >> >> +       DP_COM control block.
> >> >> >
> >> >> > You need to list reg-names and what are the names for the other 2
> >> >> > regions?
> >> >>
> >> >> Here's the code works.  You can tell me how you want this expressed in
> >> >> the bindings:
> >> >>
> >> >> * In all cases the driver maps its main memory range (for the common
> >> >> serdes block) without specifying any name.  This is equivalent to
> >> >> asking for index 0.
> >> >>
> >> >> * For "qcom,sdm845-qmp-usb3-phy" the driver requests a second memory
> >> >> range by name using the name "dp_com".
> >> >>
> >> >> ...basically the driver is inconsistent between using names and
> >> >> indices and I was trying to document that fact.
> >> >
> >> > That's fine as long as the indices are fixed.
> >> >
> >> >>
> >> >> I guess options:
> >> >>
> >> >> 1. I could reword this so it's clearer (open to suggestions)
> >> >>
> >> >> 2. I could add something to the bindings saying that the first reg
> >> >> name should be "reg-base" or something.  Then the question is whether
> >> >> we should go to the code and start enforcing that.  If we do choose to
> >> >> enforce it then it's technically breaking compatibility (though I
> >> >> doubt there is any real dts in the wild).  If we don't choose to
> >> >> enforce it then why did we bother saying what it should be named?
> >> >
> >> > I think you need to state index 1 is dp_com (and only for
> >> > "qcom,sdm845-qmp-usb3-phy") and a name for index 0. 'reg-base' doesn't
> >> > seem great, but I don't have another suggestion.
> >>
> >> ...but why do we bother giving "dp_com" a name if we're saying it has
> >> to be index 1?  It feels like the author of the driver was trying to
> >> transition from specifying to specifying registers by index to
> >> specifying them by name, but left the first register specified by
> >> index for compatibility (or code simplicity?).  It seems like the
> >> whole point of referring to things by name is to _not_ force the index
> >> number.
> >
> > No. Specifying the order and indexes is how bindings are done.
> > "-names" is extra information, not a license to change the rules.
>
> OK.
>
> Just for context: I'm not trying to be argumentative or anything--I
> just seem to be lacking a fundamental understanding of why reg-names
> exists and when it should be used.  I'm trying to ask questions so I
> can have a better intuition here and submit better patches / do better
> reviews.  I'm sorry if I'm coming off as a jerk.  :(  I'm not trying
> to be.
>
> Do you happen to know if there's anything written up that explains all
> the conventions around reg-names and I can just read that?

Probably not. We should add it to the DT spec I guess.

> For context, it seems to me that clocks and registers have different
> conventions, but I certainly could be wrong.  From what I've seen
> clocks are often specified in bindings by name and referred to in code
> by name.  Conversely reg-names seems to be highly discouraged and
> people are told to just refer to them by index.  The difference
> between the two always seemed strange to me, though I always assumed
> it was because it was more common to just have one or two register
> ranges but a whole chunk of clocks (and more get added over time as
> the driver matures).

That probably is because the clock binding has had clock-names from
the start (it may have been the first one). That was probably partly
due to the clock API also was mainly by name already if we want to
admit Linux influence on bindings. IIRC, reg-names came along for the
OMAP folks and was related to the hwmods stuff. Part of it was also
people wanting platform_get_resource_by_name to work when converting
to DT. If you haven't figured it out, I'm still not really a fan. It
is definitely more useful for some bindings than others.

There's a few cases where I think *-names is useful. The first is what
I mentioned where you could have holes in the list. The 2nd is things
like the standardized "wakeup" name for wakeup interrupts.

I really don't like seeing things like reset-names with a single entry
like "rst".

> >> I'm imagining a future compatible string that adds yet another address
> >> range.  Presumably we'd refer to this by name too.  In that case both
> >> of these would be fine:
> >>
> >> reg = <0xa x>, <0xb x>, <0xc x>;
> >> reg-names = "reg-base", "dp_com", "new_range"
> >>
> >> reg = <0xa x>, <0xc x>, <0xb x>;
> >> reg-names = "reg-base", "new_range", "dp_com"
> >
> > But why. There is absolutely no need to support both of these.
>
> I guess I'm trying to understand the motivation for reg-names.  If you
> say that something must be index 1 and also have reg-name of "dp_com"
> then the reg-name isn't buying us anything and maybe the more proper
> fix is to change the driver to work by index and drop the whole name
> thing here?  Should I do that?

That would be fine by me.

> > What you could need to support is this:
> >
> > reg-names = "reg-base", "new_range";
> >
> > The order is still fixed, but we have optional entries in the middle.
> > And that is the case when using -names is helpful. Otherwise, "-names"
> > is just unnecessary bloat to DT.
>
> From what you're saying the _only_ reason you'd ever want to use
> reg-names is if there is an optional register range.  Is that right?

IMO, yes. But I'm not going to tell people to remove them unless there
is only a single entry.

> I think for me intuitively I expect that drivers will change and
> expand over time and I'd expect more / different (and maybe optional)
> ranges to be added.  In general I feel like named registers scales
> better with less complexity.

They should only really change for new h/w and that should imply a new
compatible which can also define what is at each index.

> >> > For the driver, it's not the driver's job to enforce any of this.
> >>
> >> Sure, but anything that the driver doesn't enforce people will get
> >> wrong.  In other words if we say that the name of the first register
> >> ought to be "reg-base" but don't enforce it then someone will later
> >> come in and say it's stupid that one of the names uses a dash and the
> >> other an underscore.  They'll change "reg-base" and it will work.
> >> Someone else will decide that "reg-base" is a dumb name and will
> >> change it to "serdes".  It will still work.  Now we have a bindings
> >> that claims "reg-base" and lots of different device trees in practice.
> >
> > You are arguing against making the binding stricter and then worrying
> > about the driver getting things wrong. Stricter bindings leave less to
> > interpretation by the driver and less chance to get things wrong.
> > Unless "anything goes" and then the binding can never be "wrong".
>
> I guess I'm saying that my intuition says that over-specifying things
> seems bad to me.  The driver will either ask for a register by name or
> by index and not both.  In my mind either is a fine way to do it so as
> long as the driver and the binding is consistent then we have a
> functioning system.  Specifying that people have to do get both the
> index and name right basically gives people twice as many places to do
> things wrong.

Validation should solve that problem mostly. The only thing we can't
validate is if the names are the right order, but the addresses are
not.

> > Again, it is not the kernel's job to validate bindings even though we
> > have little else right now. That will change soon hopefully.
> >
> >> If the whole "keep things compatible" is important then what matters
> >> more is what's happening in practice, not what's should happen in
> >> theory.
> >>
> >> IMO if the driver isn't enforcing that the first field be called
> >> "reg-base" then it shouldn't be in the bindings doc.
> >>
> >>
> >> BTW: I use the name "reg-base" in my example because that's what the
> >> register was named in downstream device trees that I found.  Even if
> >> the name isn't terribly appealing, if it's not terribly objectionable
> >> I'd rather pick something that's closer to what people used in
> >> practice.
> >
> > I don't really care. People just make shit up anyway.
> >
> >>
> >> ---
> >>
> >> How about this?
> >
> > No.
> >
> >>
> >> - reg:
> >>   - For "qcom,sdm845-qmp-usb3-phy" (names mapped by reg-names):
> >>     - "reg-base": address and length of register set for PHY's common serdes
> >>       block.  MUST BE THE FIRST RANGE LISTED IN THE LIST (AKA index 0).  Note
> >>       that the name of "reg-base" is suggested but not enforced.
> >>     - "dp-com": address and length of the DP_COM control block.
> >>   - For all others (only one range--don't use reg-names)
> >>     - offset and length of register set for PHY's common serdes block.
>
> OK, I guess I will try again then and you can tell me when I get it
> right (unless you tell me I should just change the driver to not use
> named registers at all).  How about:
>
> - reg:
>   - For "qcom,sdm845-qmp-usb3-phy":
>     - index 0: address and length of register set for PHY's common serdes
>                block.
>     - index 1: address and length of the DP_COM control block.

Instead of repeating index 0 below, just say "for
'qcom,sdm845-qmp-usb3-phy' only" here.

>   - For all others:
>     - index 0: address and length of register set for PHY's common serdes
>                block.
> - reg-names:
>   - For "qcom,sdm845-qmp-usb3-phy":
>     - Should be: "reg-base", "dp_com"
>   - For all others:
>     - The reg-names property shouldn't be defined.
>
>
> -Doug
