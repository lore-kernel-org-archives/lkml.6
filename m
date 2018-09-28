Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AEE20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBK+Tdlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AEE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeI1WYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbeI1WYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:24:50 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EF52082C;
        Fri, 28 Sep 2018 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538150425;
        bh=d7tNY+6Q4CDhrWs9VOoIAeiecMr2W0kQFLJE+uhPmlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KBK+TdlkNHVe62FQfoZXQsN2FMzoCAb65iazJDrMTT11nlYle2qx6aqzxN2zlKEvS
         MH/bMQ/iqWBZv6sBjGI5UNAbUpj0AGlX26s8lJRBrL6wX/KF6EPHIwAtwl1o1QG7Hk
         iz2KxSE0Je1WynRCEMp9N26Gw6ZWkzeOo49v/aiY=
Received: by mail-qt1-f177.google.com with SMTP id h22-v6so7114612qtr.13;
        Fri, 28 Sep 2018 09:00:25 -0700 (PDT)
X-Gm-Message-State: ABuFfogKDQ02yaP8Yeoe97xgrsOJBRyGIPcx12HKVTbZa3dDVCfZAXr0
        KUIkERHaP1FWnE1QbYRdDpJkIkGG77f89Q+B6Q==
X-Google-Smtp-Source: ACcGV63iDdEJDKo3MJbJr4Ugctovb2ZVyC/uBfYCdey09vaZIiNeXUfO5Tw8k43KyvNeyr8TehDcYu/krnma7IrD6yA=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr13089664qte.164.1538150424717;
 Fri, 28 Sep 2018 09:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
 <20180926223944.GA30051@bogus> <20180928054646.GK8485@dell>
In-Reply-To: <20180928054646.GK8485@dell>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 11:00:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLD=qzXiAptsR4X16_tYwSocFhrLJ=yh6caw1ke8YdESQ@mail.gmail.com>
Message-ID: <CAL_JsqLD=qzXiAptsR4X16_tYwSocFhrLJ=yh6caw1ke8YdESQ@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 12:46 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 26 Sep 2018, Rob Herring wrote:
>
> > On Mon, Sep 17, 2018 at 04:33:22PM +0100, Charles Keepax wrote:
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/arizona.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied.
>
> Probably won't do any harm in this instance, but it's usually better
> for MFD binding changes to go through the MFD tree to avoid
> merge-conflicts.

It had been sitting there for a while, so I picked it up. Plus if we
have conflicts within a binding (other than tree wide clean ups I do),
that's not a good sign that the binding is changing.

Rob
