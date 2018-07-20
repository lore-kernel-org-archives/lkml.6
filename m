Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63874ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F120647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="znycW6vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142F120647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeGTSQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbeGTSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:16:22 -0400
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com [209.85.214.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B7E2084A;
        Fri, 20 Jul 2018 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532107627;
        bh=Qz+O8RDb7OAsnq4sTUvTjUlyOg0Z3kmUFm0IrwMYhUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=znycW6vUd4CMS4mVwr+RXAx0JvqKzTI/YW5bQvgi488SBN+WgFKjA4eR1qJ2/zX/a
         Il3DqiSe3xIzebJinXqYugFjkN+0l3b52t7zIKowcRoEn+h6vKzRQyfdkY2a4jSXx4
         Qvud71lSoU3FK0OuWU46fUhf5Bv8wWZPfffZJww0=
Received: by mail-it0-f42.google.com with SMTP id v71-v6so15554638itb.3;
        Fri, 20 Jul 2018 10:27:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlH/AP2M4MTPtCj8TVQdueamEtavJUt78hwh1qi3zeloq0xgpiTL
        Cxe1eYkXDugsVHg1gV2beMHIZF1qNagqXW4nZg==
X-Google-Smtp-Source: AAOMgpfV1RLulLXdO+MCSGTIzrMOXA7WnZxriU4F17IVaA2T2Z8EYMHbRm1C+KyhV5TFt5OGTTmEilEO/x8EwvQalFM=
X-Received: by 2002:a24:f83:: with SMTP id 125-v6mr2760585ito.18.1532107626961;
 Fri, 20 Jul 2018 10:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180706233142.166296-1-dianders@chromium.org>
 <20180720141059.GA3064@rob-hp-laptop> <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
In-Reply-To: <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Jul 2018 11:26:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
Message-ID: <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
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

On Fri, Jul 20, 2018 at 9:13 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Rob,
>
> On Fri, Jul 20, 2018 at 7:10 AM, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jul 06, 2018 at 04:31:42PM -0700, Douglas Anderson wrote:
> >> A few patches have landed for the qcom-qmp PHY that affect how you
> >> would write a device tree node.  ...yet the bindings weren't updated.
> >> Let's remedy the situation and make the bindings refelect reality.
> >
> > "dt-bindings: phy: ..." for the subject.
>
> Sorry.  Every subsystem has different conventions for this so I
> usually just do a "git log" on the file and make my best guess.  I'll
> try to remember this for next time though.

NP. I'd like to add this info to MAINTAINERS or maybe a git commit
hook could figure this out automagically.

> In this case, though, it looks like this already landed.  I see this
> patch in Kishon's next branch.
>
>
> >> Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
> >> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >>
> >>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> index 266a1bb8bb6e..0c7629e88bf3 100644
> >> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> >> @@ -12,7 +12,14 @@ Required properties:
> >>              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> >>              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
> >>
> >> - - reg: offset and length of register set for PHY's common serdes block.
> >> + - reg:
> >> +   - For "qcom,sdm845-qmp-usb3-phy":
> >> +     - index 0: address and length of register set for PHY's common serdes
> >> +       block.
> >> +     - named register "dp_com" (using reg-names): address and length of the
> >> +       DP_COM control block.
> >
> > You need to list reg-names and what are the names for the other 2
> > regions?
>
> Here's the code works.  You can tell me how you want this expressed in
> the bindings:
>
> * In all cases the driver maps its main memory range (for the common
> serdes block) without specifying any name.  This is equivalent to
> asking for index 0.
>
> * For "qcom,sdm845-qmp-usb3-phy" the driver requests a second memory
> range by name using the name "dp_com".
>
> ...basically the driver is inconsistent between using names and
> indices and I was trying to document that fact.

That's fine as long as the indices are fixed.

>
> I guess options:
>
> 1. I could reword this so it's clearer (open to suggestions)
>
> 2. I could add something to the bindings saying that the first reg
> name should be "reg-base" or something.  Then the question is whether
> we should go to the code and start enforcing that.  If we do choose to
> enforce it then it's technically breaking compatibility (though I
> doubt there is any real dts in the wild).  If we don't choose to
> enforce it then why did we bother saying what it should be named?

I think you need to state index 1 is dp_com (and only for
"qcom,sdm845-qmp-usb3-phy") and a name for index 0. 'reg-base' doesn't
seem great, but I don't have another suggestion.

For the driver, it's not the driver's job to enforce any of this.

Rob
