Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D157206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062632;
	bh=cmJ9BUids2jbhalCPElosVSXRss/tV5qmDolb/NM9Jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vk0OTqTJ1dDfUhvGJjFmgLA+u4HOrsP9g5qVFCd0O4eCJreHA1yeZc+Q1Im/rKuNI
	 9/fBg5dFFV1+XYWLsqSrzw6K/bAK0thnrljDZnNUG7049ly5mi3fLp6qnQkkQ9q1aF
	 5XONIFBWqjFYF+26kU7i0PjznIcCEkmc1QvMQp88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfAIThL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAIThL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:37:11 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E6721783;
        Wed,  9 Jan 2019 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062630;
        bh=cmJ9BUids2jbhalCPElosVSXRss/tV5qmDolb/NM9Jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lg0kJ2B3X69vbsrbRJGyrMy+8WfDGUXkdpYXmRC6UukGUTF1PEwHwt1rKuTqYA2Nx
         fbVNUWNb1Us/psycyGhpy26TRUpJ9jyouBj1Su6D5YxcSk7PvAgCWnMsezfLLWE/Gi
         CVfQ4ISDyrewyil37qnBJTQBeU9ulClj8ZBPAdUs=
Received: by mail-qt1-f182.google.com with SMTP id n32so9616414qte.11;
        Wed, 09 Jan 2019 11:37:10 -0800 (PST)
X-Gm-Message-State: AJcUukdW52JHl6Y4+3XJmy+dulWAItl9By9/U3kML1jm0Fi/4CekTZSZ
        KFWwXkqXsIuzdO5UurAscOtkzjhPogVgxXGaCg==
X-Google-Smtp-Source: ALg8bN4thLmeMbCbntEvgjQS3UEkzUwlFHtblRn17ZRSXZRRIQLteGYjPdXq3n/boxqnPd/bm3Fuj5rwfJcYf5in0Cs=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr6743674qtd.257.1547062629272;
 Wed, 09 Jan 2019 11:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-5-ilina@codeaurora.org>
 <20181229000714.GA3654@bogus> <20190107185113.GH14960@codeaurora.org>
 <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com> <20190109173111.GB22547@codeaurora.org>
In-Reply-To: <20190109173111.GB22547@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Jan 2019 13:36:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com>
Message-ID: <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com>
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

On Wed, Jan 9, 2019 at 11:31 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Jan 08 2019 at 07:49 -0700, Rob Herring wrote:
> >On Mon, Jan 7, 2019 at 12:51 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Fri, Dec 28 2018 at 17:07 -0700, Rob Herring wrote:
> >> >On Wed, Dec 19, 2018 at 03:11:02PM -0700, Lina Iyer wrote:
> >> >> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> >> >> routed to the PDC as interrupts that can be used to wake the system up
> >> >> from deep low power modes and suspend.
> >> >>
> >> >> Cc: devicetree@vger.kernel.org
> >> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> >> ---
> >> >>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
> >> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> >> index 665aadb5ea28..a522ca46667d 100644
> >> >> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> >> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> >> @@ -29,6 +29,11 @@ SDM845 platform.
> >> >>      Definition: must be 2. Specifying the pin number and flags, as defined
> >> >>                  in <dt-bindings/interrupt-controller/irq.h>
> >> >>
> >> >> +- wakeup-parent:
> >> >> +    Usage: optional
> >> >> +    Value type: <phandle>
> >> >> +    Definition: A phandle to the wakeup interrupt controller for the SoC.
> >> >
> >> >Is this really necessary? Is there more than one possible wakeup-parent
> >> >node?
> >> >
> >> No.  There is only one but depending on the architecture, the wakeup
> >> interrupt controller could be different device like PDC on SDM845 or MPM
> >> on SDM820.
> >>
> >> What do you have in mind? Let me know if you have a better idea than
> >> referencing in DT.
> >
> >If there's only one possibility for a given platform, then you can
> >just use of_find_compatible_node(). I don't think it matters that
> >different platforms have a different device here. It's not going to be
> >a large table and you may need to know the differences if there's not
> >an abstracted interface to it (seems there is in your case).
> The GPIO irqchip would be in hierarchy with the wakeup-parent
> irqchip and no device specific functions would be called directly.
> We could achieve this with compatible strings to the irqchip.
>
> >Alternatively, if the PDC/MPM code knows what interrupt controller it
> >is associated with, then it could setup that relationship and the
> >interrupt controller code could retrieve that. Maybe the stacked
> >domain support doesn't work in that direction (I haven't looked at the
> >irq code much since that was added).
> >
> The PDC/MPM do not know about the association.

Neither does the main interrupt controller. The association is part of
SoC integration. You can describe that association in either direction
and that is sufficient from a DT standpoint. You've probably picked
putting this in the GIC(?) based on what works more easily with the
Linux irqdomain code.

> >However, my main concern is documenting something genericish in a
> >device specific binding. It looks like Tegra is trying to add the same
> >thing, so this needs to be documented in a common place. One question
> >is whether wakeup is the only use or if this should be more generally
> >a secondary interrupt parent?
> >
> Yes, wakeup is the only use of this interrupt parent.

Maybe for you, but I was wondering about this more generally. Should
we encode what the function (e.g. wakeup) is in the property name or
have something like aux-interrupt-controller? Maybe some platforms
have some need for a secondary interrupt-controller which is not
wakeup. Routing interrupts to other cores perhaps?

> It is powered by
> an always-on rail and therefore can detect some interrupts that are
> routed to it even when the GIC is powered off. Though Tegra's
> implementation of the irqchip is a bit different from QCOM, the idea is
> generally the same. It would be helpful, if we could make this a
> generic enough binding.
>
> -- Lina
>
