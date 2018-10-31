Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E500ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3B92054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/nECttj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeKAAg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbeKAAg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:36:58 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B307E2054F;
        Wed, 31 Oct 2018 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541000306;
        bh=SrHiqprI2Igm7mZX0Lj3vPpqA6DpW9/dFrupZWZ5joY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/nECttjGJVXPeoQDl2D3ydV/pQY3WuzUX4odigd44F3QCHQ1TuffgBCdm84kl53D
         GetHQqcEIIclpwrwqdkDMlM6vCLNk/2vrbzku8Nag/8DvxU/ORbQxAeoBhxF6u0pC6
         4NnAVKTpFjplAha5vmmWntuP3n9PjeAXxV3kUTBo=
Received: by mail-qk1-f172.google.com with SMTP id o125so6938046qkf.3;
        Wed, 31 Oct 2018 08:38:26 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJzhECBuAwYBiF6z1lej5CHYnEG7ZftHine5f8YcQi57yt3litD
        3RgJhdNM1rWxz5c9wpSr5jh26ISPmUSG9cz5VQ==
X-Google-Smtp-Source: AJdET5dpkLPA/853rQ+bTlNW1Qq7Llf6js2SQlVWqMJjuATT/WnZMYpf83CMTA/1m3YfXlZN0t/zpJlBsx90Ay0pjD0=
X-Received: by 2002:ac8:173d:: with SMTP id w58mr3096992qtj.76.1541000305921;
 Wed, 31 Oct 2018 08:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
 <20180926223944.GA30051@bogus> <20180928054646.GK8485@dell>
 <CAL_JsqLD=qzXiAptsR4X16_tYwSocFhrLJ=yh6caw1ke8YdESQ@mail.gmail.com> <20181009065522.GD32033@dell>
In-Reply-To: <20181009065522.GD32033@dell>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Oct 2018 10:38:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCCMg1GeCU0_2-EvGS2FaRq4j1tFqEMswv5QBZ_jr9ZQ@mail.gmail.com>
Message-ID: <CAL_JsqLCCMg1GeCU0_2-EvGS2FaRq4j1tFqEMswv5QBZ_jr9ZQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: arizona: Correct link for sound binding document
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:55 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 28 Sep 2018, Rob Herring wrote:
>
> > On Fri, Sep 28, 2018 at 12:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 26 Sep 2018, Rob Herring wrote:
> > >
> > > > On Mon, Sep 17, 2018 at 04:33:22PM +0100, Charles Keepax wrote:
> > > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mfd/arizona.txt | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Applied.
> > >
> > > Probably won't do any harm in this instance, but it's usually better
> > > for MFD binding changes to go through the MFD tree to avoid
> > > merge-conflicts.
> >
> > It had been sitting there for a while, so I picked it up. Plus if we
>
> A little over a week is not 'a while'. :)

You're right. Probably should have waited 2 weeks. Developers
shouldn't have to wait longer than that for a response (according to
the chief penguin).

> > have conflicts within a binding (other than tree wide clean ups I do),
> > that's not a good sign that the binding is changing.
>
> Not sure I understand this.

If there are multiple sets of changes to a single binding within 1
release cycle (more than 1 really IMO), then that is a problem in and
of itself. We may want drivers enhanced feature by feature, but I
don't want bindings to. Bindings shouldn't be evolving. Maybe
sometimes different people add different things, but then they need to
work out the dependencies and conflicts, not you or me.

Rob
