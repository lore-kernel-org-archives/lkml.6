Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A68A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzDFKhlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfAJV2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:28:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37255 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfAJV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:27:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5898626pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:from
         :to:references:subject:cc:user-agent:date;
        bh=5Ca+giYTOowQwvE/IYNggDIbq1m8J3g7CFwxZA8Q0ag=;
        b=CzDFKhlk2/vTBwaFRoaf9vrKU+hbJyXFgKAoBWIZej2feOIXGQ11uVjRJdWMVAQMDz
         kxCu5CkKZjIgZNP5eqwHhvFsMxIOZEABqK5IMfQCt4tIDlaOlg3z9b82JWSSJ3959ZkZ
         iZkIaNwu+FfVTRBct7RB2ub9GwDmap6wwF2nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:from:to:references:subject:cc:user-agent
         :date;
        bh=5Ca+giYTOowQwvE/IYNggDIbq1m8J3g7CFwxZA8Q0ag=;
        b=JSD/gSeu4cYN2j3GYaxQdz+SQdlGqP6J+a8Zbs7x3neJZZzBTM4k7oveFvxXycs+DN
         6Nq1AYeMz6POl8FF6B2BsMKNmPh6i35e3bw1r7Yw4OLTPw8cSHxSVFQGrI7vg9qq9apt
         WcvoajJJ2n8v4gIqNv67F4yXF45PjNql24B7BJM16QDLpfNPHzHk/zHAaQx/UsMEMNhk
         /h/JwF+AU/VycEfuHFO25wHJMYJKf2GLlLY/2ONUu7qRwVCjRZThrSb4aOOXCPtSCH8o
         EE/FIsO9dly6uITaj6ZTvZvPBn1dBDu7Gea7/bi/Nr/KkByBcIaRIzPdRJvPjB6LIxC2
         X2iw==
X-Gm-Message-State: AJcUukfEPqG4XEuFeW3Ud6KzEDJ25sYuqa5+BOqDTii42d64U8m97aPb
        w8IVzvM6mrrW4NrBRA+SaGdb5A==
X-Google-Smtp-Source: ALg8bN72S+kydfm7mb89O2iixkm5DCUaNIdOab/W2XNkH7SgO09QtN3dLSWyYIDWyUWO78i72p+wfw==
X-Received: by 2002:a65:534b:: with SMTP id w11mr798087pgr.125.1547155678286;
        Thu, 10 Jan 2019 13:27:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w136sm111267669pfd.169.2019.01.10.13.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:27:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Message-ID: <154715567680.19284.12367636883540337540@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org> <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com> <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org> <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com> <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org> <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org> <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com> <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
User-Agent: alot/0.8
Date:   Thu, 10 Jan 2019 13:27:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P L S S S N (2019-01-10 08:58:41)
>=20
>=20
> On 1/9/2019 11:16 PM, Stephen Boyd wrote:
> > That could be done by making a PDC clockevent that has some DT binding
> > of a property pointing to an MMIO timer frame and then reimplementing
> > the MMIO timer code in the PDC driver on top of the frame/register
> > region it pulls out of there. Or it could be written in reverse by
> > having the generic MMIO timer driver point to the PDC somehow and
> > implement some platform specific API to pass that information to the
> > real wakeup programming part in PDC.
> >=20
> > I'm leaning toward the first approach where PDC is the clockevent and
> > that uses the MMIO timer on the backend to do what it needs to program a
> > wakeup. That way you can mandate the usage of the physical timer and
> > keep this quirk away from the ARM timer driver. It also makes the idea
> > of a qcom,pdc-timer-mode sort of useless because the PDC will have a
> > property that points to the timer frame and that will mean "use this for
> > broadcast wakeup". I'm not sure how the ARM folks feel about this
> > though. It would probably require some sort of ARM timer API that lets
> > us program the MMIO timer frame from the PDC driver. So exporting
> > arch_timer_reg_write() and making that always inlined to optimize hot
> > paths would be required.
> >=20
>=20
> Regarding the first approach -
> If PDC clk_evt_dev is created and registered to broadcast framework, it=20
> means it will replace MMIO timer event device in broadcast framework (as =

> only one broadcast event timer can exist). So in registration phase, the =

> tick broadcast framework would configure broadcat event handler for=20
> PDC(clk_evt_dev).

Yes all the MMIO timer frames would need to be marked as "disabled" I
suppose, or somehow we would need to tell the MMIO timer driver to not
register the MMIO timer frame from there because it's used by the PDC
now. Maybe that would require changing the MMIO timer's compatible
string to be something different.

>=20
> Even if we have some way of exporting arch_timer_reg_write() to program=20
> the wakeup for MMIO timer, the irq handler for MMIO timer is responsible =

> to invoke event_handler. However, since MMIO timer is replaced by PDC=20
> timer event device, event handler will not be able to inform broadcast=20
> framework. What can be done about this?
>=20

It sounds like you imagine that the MMIO timer frame will still be
active and in use by the ARM architected timer driver? I wasn't thinking
that would be the case. I was thinking that the PDC code would basically
reimplement all of the ARM timer code again by calling some shared timer
code so that we avoid code duplication. Including the irq handler that
would be registered for by the PDC driver and flow from that piece of
code instead of the ARM timer code.

