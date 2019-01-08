Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FBCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BFE214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546960967;
	bh=BPLoq9CG3SiZUIItzRSmkQ4qczXdwu0JtbCwRHQmqg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AwhEBqQC3iGZ7FAh1+eLQdFtRRHPjxUktXqrvlmlMN08tNxcCi/0/rJsWZYsJvve5
	 kMQocM25/lSS2F0+2kbW0AnlWOq0BqV1uI252q9NnX3N2Yf2QzfuoTMmu6pBuk9NLR
	 FE61q6FozdtL77182SOldqBM7t53iiyPo/UUhU3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfAHPWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfAHPWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:22:46 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A78921019;
        Tue,  8 Jan 2019 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546960964;
        bh=BPLoq9CG3SiZUIItzRSmkQ4qczXdwu0JtbCwRHQmqg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IkMucHmhSEWt1UylLN9xka/YqinDR5rGhlScgF71R+0pf1nzKehsrpvcVSWQhNCC7
         w7CZlHdY/TbgAkQm+FOhdsPiWHZrBaj0cC/pJVOn4NTCvCs0WCIGaQ13RutyhWNseq
         Q0kMbgWrWd3NkLsCgiRjs+b9JdeoYouSic+EFrF0=
Received: by mail-qt1-f173.google.com with SMTP id u47so4726583qtj.6;
        Tue, 08 Jan 2019 07:22:44 -0800 (PST)
X-Gm-Message-State: AJcUukcBxz0Ttgi2eLb/doKf2shWZAbyZUkOYYQfukaPWLt5fsqjWsbk
        36akBsyKqID/xENCU4HEl5Agzo7eworr16V4rA==
X-Google-Smtp-Source: ALg8bN6nxOq6uurvxXNjXTai2sxMC3P1W1/2Q1BP3kP9SD7XB3II2zPi5IhQLXlumizLHfcTZa3beoHCLxY3gkP6mR0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr2087003qts.144.1546960963401;
 Tue, 08 Jan 2019 07:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20181228044819.5697-1-sibis@codeaurora.org> <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com> <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder> <20190104001158.GA200069@google.com> <20190105015430.GA67838@google.com>
In-Reply-To: <20190105015430.GA67838@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Jan 2019 09:22:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbMNB6EzYCzmq5PBc9EvVmYifsoJBwymV621h385Hv0w@mail.gmail.com>
Message-ID: <CAL_JsqLbMNB6EzYCzmq5PBc9EvVmYifsoJBwymV621h385Hv0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
To:     Brian Norris <briannorris@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 7:54 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi again,
>
> On Thu, Jan 03, 2019 at 04:11:58PM -0800, Brian Norris wrote:
> > On Thu, Jan 03, 2019 at 04:01:45PM -0800, Bjorn Andersson wrote:
> > > I share your concern about this, but I came to suggest this as the
> > > driver cares about platforms but the firmware is (often?)
> > > device/product-specific.
> > >
> > > E.g. we will serve the MTP and Pixel 3 with the qcom,sdm845-adsp-pas
> > > compatible, but they are unlikely to run the same adsp firmware. This
> > > allows the individual dtb to specify which firmware the driver should
> > > use.
> >
> > I understand this, but that still doesn't mean we should be suggesting
> > each DTB to clutter the top-level firmware search path, especially since
> > lazy people will probably just use "modem.mdt" and similar. That means
> > you no longer can ship the same rootfs that supports both QCOM and
> > <other> modems, if <other> modem also uses the same lazy format.
> >
> > It seems like a much better practice to at least enforce a particular
> > prefix to things. e.g., the driver could assume:
> >
> >   qcom/sdm845-adsp-pas/ (or if you must, just qcom/)
> >
> > and your DTB only gets to add .../<your-string-here> to that path.
> >
> > In case it isn't clear: I think it's also severely misguided that the
> > existing driver gets away with lines like
> >
> >       request_firmware(&fw, "modem.mdt", ...);
> >
> > today ;)
>
> To add to my thoughts, since I think maybe Sibi was a little unclear of
> my thoughts:
>
> One of my primary concerns with the existing approach is that it's
> basically a complete free-for-all. We should have some minimal standards
> (enforced in code) such that our DTB can never point us at something
> like /lib/firmware/<other-vendor>/foo.bin (or /lib/firmware/modem.mdt;
> or lots of other bad examples). This could probably be done simply by
> always prefixing 'qcom/' (I don't remember -- does request_firmware()
> follow '..'? e.g., 'firmware-name = "../bar/foo.bin"'.)

We can write a schema to enforce some of this:

firmware-name:
  pattern: "^\w.*"

And you can have a device specific schema to enforce a subdir and/or
filename(s).

I tend to think we should not put part of the path in drivers. No real
good reason other than we already allow that for other users of
'firmware-name'.

> As a bonus: it would be very nice if we can provide a little more
> structure by default, and avoid arbitrary hierarchy in the DTS. That's
> where I brought up ath10k's "variant" as an example; if we can use
> 'compatible' to capture most of this particular Hexagon core's
> properties, then we only leave a single level of variability to the DTS.

Some bindings use compatible to determine/construct the firmware name.
If you want to restrict things, then that's probably how you should do
it IMO.

Rob
