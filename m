Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA16C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1752177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547132188;
	bh=x8ixPfnY9CDOrkbEci5+EHGsD+DlIszXx6qiBK0WCas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pJ+2RAs9aIG+7DtLvFJ4b5zQpSy9J4WvzVnkBCSYrmH+O9+1D/ziHUEoC8OXx1VsN
	 uUjTbUpEM8QZFPaw77fS+dNd++PuV7T9oJg/Gi2Gh9kGOy7Kc9fN9CC5uQgjB0Vizm
	 AUnqZlOgvGmnTHKnsGqnkaf4phsO+d9Aj5UCgxeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAJO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfAJO40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:56:26 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7FB2177B;
        Thu, 10 Jan 2019 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547132186;
        bh=x8ixPfnY9CDOrkbEci5+EHGsD+DlIszXx6qiBK0WCas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ardrtDcjpxMjuYpH7vTcRF2GUKRsR5fiZXk/OGM01AEDAI+Ilov9oKjI6CvDTzbP3
         nUQkplrJBEABVHoHQ47TbZemyFKdM5F4H3HNzuE3gLc23L+vIZp3NmtrjVdc78sBGr
         TivNJr9UycMHYqErIl6/eIWdSKSdfah99ucVZI/s=
Received: by mail-qt1-f169.google.com with SMTP id k12so13146273qtf.7;
        Thu, 10 Jan 2019 06:56:25 -0800 (PST)
X-Gm-Message-State: AJcUukcuY7VoSIgfTEblM7+GMYw4KBWC9VIFSSO5hLlCPfGOjSC1eBnq
        B0XZ12/jisBiJOawwcSoAF1Z3e2+HTMgUGwWBg==
X-Google-Smtp-Source: ALg8bN4qsrI4IbXruHDYjephGcIiMg+ENVkpyht7YxiZ6hS41dl1OEanw90G6BMC+LHAhVThVZnDg5NLyamV9c4ILyE=
X-Received: by 2002:a37:b646:: with SMTP id g67mr9533110qkf.326.1547132185057;
 Thu, 10 Jan 2019 06:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20181228044819.5697-1-sibis@codeaurora.org> <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com> <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder> <20190104001158.GA200069@google.com>
 <20190105015430.GA67838@google.com> <CAL_JsqLbMNB6EzYCzmq5PBc9EvVmYifsoJBwymV621h385Hv0w@mail.gmail.com>
 <20190109215532.GA178267@google.com>
In-Reply-To: <20190109215532.GA178267@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Jan 2019 08:56:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKF5i8HNT-ez+Q=Dv9OA-Lf1VaqpZbL2ouo0Bm+v5FxJg@mail.gmail.com>
Message-ID: <CAL_JsqKF5i8HNT-ez+Q=Dv9OA-Lf1VaqpZbL2ouo0Bm+v5FxJg@mail.gmail.com>
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

On Wed, Jan 9, 2019 at 3:55 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, Jan 08, 2019 at 09:22:30AM -0600, Rob Herring wrote:
> > On Fri, Jan 4, 2019 at 7:54 PM Brian Norris <briannorris@chromium.org> wrote:
> > > To add to my thoughts, since I think maybe Sibi was a little unclear of
> > > my thoughts:
> > >
> > > One of my primary concerns with the existing approach is that it's
> > > basically a complete free-for-all. We should have some minimal standards
> > > (enforced in code) such that our DTB can never point us at something
> > > like /lib/firmware/<other-vendor>/foo.bin (or /lib/firmware/modem.mdt;
> > > or lots of other bad examples). This could probably be done simply by
> > > always prefixing 'qcom/' (I don't remember -- does request_firmware()
> > > follow '..'? e.g., 'firmware-name = "../bar/foo.bin"'.)
> >
> > We can write a schema to enforce some of this:
> >
> > firmware-name:
> >   pattern: "^\w.*"
>
> Are DT schemas ready to use/enforce? Or would this currently just be a
> suggestion? I'm out of the loop. But I guess that would be interesting.

Yes, please! Initial support is in 5.0-rc.

I'm not requiring new bindings to be written as schemas just yet
though. We need to ring out any issues with early adopters.

Rob
