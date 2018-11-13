Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF2EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426E52245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmAyiLFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426E52245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeKMO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:56:24 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38193 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:56:24 -0500
Received: by mail-ed1-f52.google.com with SMTP id a2-v6so9270656edi.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 21:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVM/9virbVCyR5wbbOyWiUv7JjM1xwTKyje30UIq6JY=;
        b=FmAyiLFm4GUs/ilgRLg1kPRTPiyjHkCjzjy2/ABgAZr/2mhEL8PPB7ZAYh/197oBW4
         VdI5DqsyMsSNIhB0x7eDqORpnxqw8Xby/tbDPjuOq8aJbELRZHnklH/uT8ulJ/rp8lqo
         z43m0Jsbdwl1a/oxUAHm3ySJjTpugzlwF98mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVM/9virbVCyR5wbbOyWiUv7JjM1xwTKyje30UIq6JY=;
        b=jcC7dvJ5MQA867R5g2XDvUfKSJNDW7LaZE0ZcQwB4BsDxGzQ2Dv25aUPuHWDRIV7aW
         9hskVueGCbsKZSmiaXyfx0bt9FLqo8SKamdnOa1mbFgKXLOmTo0RybaAd3/f4Pras6/a
         Lg7iYm+Oix5TkSRA/D1xz2gP+j1aIUmR4g+xxVSyt9rc4PFR+TCBkN6OtShRUGxGYuty
         advNYsjRgBBt2UZYf4LobsYxkjmBW98tnG4aySsPmjeRkHTPwMZ1nzqRicqlU6cAXfhg
         o3T0Fk+SJR4bA5PDJga0ZAkNq4zX7Wh+CNny2fuVh0F/VCceAFPTZwzdPl+pWDsn8hDm
         uIJw==
X-Gm-Message-State: AGRZ1gK//NdW6e5icDZJyRVjpvCGubWMXAVCGuEzaKPx1mE1jRVydmob
        4F7hiBS3dtzNwrwD4pgEOEJVlXz8K3ODl8RYf2sNUA==
X-Google-Smtp-Source: AJdET5e/ASFpbPN/X9MaWifJDvWRNF0AcHbxTAqAbQuHEvXBevDNF8UzQ1UjowB5Ku8YTyB4Ml8D7Sz5GqabRKFbvFk=
X-Received: by 2002:a50:ac19:: with SMTP id v25mr10010461edc.218.1542085202801;
 Mon, 12 Nov 2018 21:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20181108070449.23572-1-shawn.guo@linaro.org> <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com> <20181113034200.GD20049@tiger>
In-Reply-To: <20181113034200.GD20049@tiger>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Tue, 13 Nov 2018 12:59:38 +0800
Message-ID: <CAAQ0ZWS-j06YM+Vs64RC_e1M9s_5bZfCWyL95SSaKVENJv7BNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
To:     Rob Herring <robh@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sriharsha,

On Tue, Nov 13, 2018 at 11:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
<snip>
> > > +- qcom,init-seq:
> > > +    Value type: <u32 array>
> > > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > > +                program 'value' into phy register at 'offset' with 'delay'
> > > +           in us afterwards.
> >
> > If we wanted this type of thing in DT, we'd have a generic binding (or
> > forth).
>
> Right now, this is a qualcomm usb phy specific bindings - first used in
> qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
> a so good hardware description, I'm a little hesitated to make it
> generic for other platforms to use in general.  What about we put off it
> a little bit until we see more platforms need the same thing?

Are those register write sequences really required here?  At least,
from the test I do, it still works with this property dropped.

Shawn
