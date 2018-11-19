Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A49C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42062086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fwRx1jqu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bb44EIhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42062086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeKSRd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:33:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKSRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:33:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3846F60386; Mon, 19 Nov 2018 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542611473;
        bh=5niH4Ff9WlxydQFvyUv4a7G2G3T9YOh9n9FsKqFxlm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fwRx1jquG8iUK1YgCayA4tkYyUYPTRcjevaeKihSPzTni/y/wjiwi9MljISdOgNi0
         1mXseXT4wxm5g2yk0zYINvli2EFutd1HSEiyIkVfp13i7OPnAgyJNPWLElubL7d4/Z
         WBhjK5UyarUM1Q46j5eRHKZ11ip7DZks7iaBuzVc=
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 647A360AD8;
        Mon, 19 Nov 2018 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542611472;
        bh=5niH4Ff9WlxydQFvyUv4a7G2G3T9YOh9n9FsKqFxlm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bb44EIhSnJQDsWTO5u3fwBgCoxEZ0EyGuKoVQeL0JrnofLwWU0cYUUyeHcCDwtzJ6
         TeLdL5RMw4sUnxecpas8ERWcxclZsr5O8TYVHuHqGlcX6q0LmZ2cLrixCbjde3cygW
         Xxtjqv3s4qzH+LC9uXDqheb+bBkveNM3GaZ0jZPg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 647A360AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f175.google.com with SMTP id d135so47007451qkc.12;
        Sun, 18 Nov 2018 23:11:12 -0800 (PST)
X-Gm-Message-State: AGRZ1gJdUQL1GSfcu0+nZKqzdRM6LeZ0eH8Q9m3ET3EIxREtdE6ng0/6
        nOFMbB5P3cQZYmzwYMlRYYOX0bysCCnjGHM+OdE=
X-Google-Smtp-Source: AJdET5fQWXryssOArRbHloPb7ncFXu5U4f9ohsXOXMsFl+mmCmlEPjyEFW89kwEAXjYWlw4+402TZiuletvcIJT9nBM=
X-Received: by 2002:aed:3746:: with SMTP id i64mr19530704qtb.307.1542611471602;
 Sun, 18 Nov 2018 23:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20181108070449.23572-1-shawn.guo@linaro.org> <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com> <20181113034200.GD20049@tiger>
 <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com> <20181119065503.GB10788@dragon>
In-Reply-To: <20181119065503.GB10788@dragon>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 19 Nov 2018 12:40:59 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGmsLT8UOk+-4zOKkYxJbkhqy=oDw2ZqrXLDCGbF8uTHA@mail.gmail.com>
Message-ID: <CAFp+6iGmsLT8UOk+-4zOKkYxJbkhqy=oDw2ZqrXLDCGbF8uTHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
To:     shawn.guo@linaro.org
Cc:     Rob Herring <robh@kernel.org>, kishon <kishon@ti.com>,
        sallenki@codeaurora.org, anur@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>, vkoul@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:29 PM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Sat, Nov 17, 2018 at 09:13:38AM -0600, Rob Herring wrote:
> <snip>
> > > > > +- qcom,init-seq:
> > > > > +    Value type: <u32 array>
> > > > > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > > > > +                program 'value' into phy register at 'offset' with 'delay'
> > > > > +           in us afterwards.
> > > >
> > > > If we wanted this type of thing in DT, we'd have a generic binding (or
> > > > forth).
> > >
> > > Right now, this is a qualcomm usb phy specific bindings - first used in
> > > qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
> > > a so good hardware description, I'm a little hesitated to make it
> > > generic for other platforms to use in general.  What about we put off it
> > > a little bit until we see more platforms need the same thing?
> >
> > I'm not saying I want it generic. Quite the opposite. I don't think we
> > should have it either generically or vendor specific. The main thing I
> > have a problem with is the timing information because then we're more
> > that just data. Without that we're talking about a bunch of properties
> > for register fields or just raw register values in DT. That becomes
> > more of a judgement call. There's not too much value in making a
> > driver translate a bunch of properties just to stuff them into
> > registers on init. But then just allowing any raw register value to be
> > in DT could be easily abused.
>
> Rob,
>
> I agree with your comments.  Honestly, I'm not comfortable with this
> 'qcom,init-seq' thing in the first impression.  The similar existence in
> mainline qcom,usb-hs-phy.txt makes me think it might be acceptable with
> the timing data added.  Okay, I know your position on this now.
>
> @Sriharsha,
>
> Seeing that 'qcom,init-seq' is being configured with the exactly same
> values for both HS phys in SoC level dts file (qcs404.dtsi), I think
> such settings can be moved into driver code as SoC specific data.
> Unless you have a different view on this, I will do it with v4.

phy-qcom-qmp and phy-qcom-qusb2 have been maintaining such SoC specific
init sequences in the drivers if you would like to have pointers from them.

Thanks
Vivek

>
> Shawn



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
