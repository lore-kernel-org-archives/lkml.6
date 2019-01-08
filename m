Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD9E206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546958971;
	bh=m8BIIjBVyt7wySueQRm61YIDr1y9Mta75gwDvJq68u4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cyd2oK1QHPQdrU32pIwpqeZ33MSzy8WKw12+kuutaQzkjCu/mMNhAAgqZMk3O/Qai
	 7dlbEeLCSlKZ/mrlZ+ZN4/o4uDgj/KRKKxVr2tU4pm98SAJ78/atYKXR+I+4mTlhgZ
	 o0c4YVchuE8A3HjPSb69Sd8jHtAwoLODsFaJ74NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfAHOta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfAHOt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:49:29 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9E32173C;
        Tue,  8 Jan 2019 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546958968;
        bh=m8BIIjBVyt7wySueQRm61YIDr1y9Mta75gwDvJq68u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T++pmsMNn1K9IlgrMRUQfiO58HU9MwzCstwZglej0Td7neyDmEa+HTyhlgZ60TM5R
         NDnxwM8W91rDff9FOEb+IDDEDPEPeIrCFvaJ4skwM8wYGlNqCV7qVSRXn/iWYL/ZBg
         qKQ4rp7G6T7VGmBloSpSyYnW31X2/z6ZzlsZVPbQ=
Received: by mail-qt1-f173.google.com with SMTP id u47so4592585qtj.6;
        Tue, 08 Jan 2019 06:49:28 -0800 (PST)
X-Gm-Message-State: AJcUukfzL0BrP5hDOZD7AANPk186fjHPKIKT9p3Hx5yp47cIpZQyOO2a
        d6zuYe6jDG5MlH87mEsjcj/N+eUsJBUySVea9g==
X-Google-Smtp-Source: ALg8bN43A52J0g4nlfN1OIbt/EnmfDmGxiiE2U1raAdhBj56wsfCQjLt2bt9TGdIXQIol7KKJqyzFcJK5jY/F9XdBos=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr1953881qts.144.1546958967363;
 Tue, 08 Jan 2019 06:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-5-ilina@codeaurora.org>
 <20181229000714.GA3654@bogus> <20190107185113.GH14960@codeaurora.org>
In-Reply-To: <20190107185113.GH14960@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Jan 2019 08:49:16 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com>
Message-ID: <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 12:51 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Fri, Dec 28 2018 at 17:07 -0700, Rob Herring wrote:
> >On Wed, Dec 19, 2018 at 03:11:02PM -0700, Lina Iyer wrote:
> >> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> >> routed to the PDC as interrupts that can be used to wake the system up
> >> from deep low power modes and suspend.
> >>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> index 665aadb5ea28..a522ca46667d 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> @@ -29,6 +29,11 @@ SDM845 platform.
> >>      Definition: must be 2. Specifying the pin number and flags, as defined
> >>                  in <dt-bindings/interrupt-controller/irq.h>
> >>
> >> +- wakeup-parent:
> >> +    Usage: optional
> >> +    Value type: <phandle>
> >> +    Definition: A phandle to the wakeup interrupt controller for the SoC.
> >
> >Is this really necessary? Is there more than one possible wakeup-parent
> >node?
> >
> No.  There is only one but depending on the architecture, the wakeup
> interrupt controller could be different device like PDC on SDM845 or MPM
> on SDM820.
>
> What do you have in mind? Let me know if you have a better idea than
> referencing in DT.

If there's only one possibility for a given platform, then you can
just use of_find_compatible_node(). I don't think it matters that
different platforms have a different device here. It's not going to be
a large table and you may need to know the differences if there's not
an abstracted interface to it (seems there is in your case).
Alternatively, if the PDC/MPM code knows what interrupt controller it
is associated with, then it could setup that relationship and the
interrupt controller code could retrieve that. Maybe the stacked
domain support doesn't work in that direction (I haven't looked at the
irq code much since that was added).

However, my main concern is documenting something genericish in a
device specific binding. It looks like Tegra is trying to add the same
thing, so this needs to be documented in a common place. One question
is whether wakeup is the only use or if this should be more generally
a secondary interrupt parent?

Rob
