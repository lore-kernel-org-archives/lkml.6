Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD7C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D620989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SskGSv5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeK3KcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:32:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35312 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3KcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:32:06 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so3065075ioc.2;
        Thu, 29 Nov 2018 15:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQ+WFkdZwE9CtNgM9j7g9M5KPCWqo/rsOlSZBVBeyVQ=;
        b=SskGSv5RWeUrL4sHxhqqO32YGFoc6egQqGGrhrlyxf5et3+04XdfpUzzSZPBWnAf58
         9s3kEsz/WgFnfq34jYKPfKmUdoJcFBhlqEvGpoxqEU9TXcnkEeZ6dCaKWkyYqYpetHUt
         u+LfWkTmWb3YWnQoECZ22C/R86Ng/Ks1d4DmTay2VoEInDn1Mftkh2mAezpUfb6X3Nbl
         prazV/KQEEwl/k0z/shFknNViyilj0mCRwE2ds0e9yc3rrggnjTyu/2mxsKM1wwzqmwd
         u2oK3Af3koLA1Ljh/OLcov/ujPG9/N/6uZAmeezXpV4q/+KlVTUYcJdScmN5OhMIGio4
         nFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQ+WFkdZwE9CtNgM9j7g9M5KPCWqo/rsOlSZBVBeyVQ=;
        b=dW7yGd6LE2vigBmKT0jCK+mPgryKCJ/1/iQQUOxaADYB+pF0KNaqQtqzkDgKKeBgr7
         MRK53AfnQnnVbnJ2CFjOf6Kzc8dbpNCF7eDZT51hQOWgqCJhRSHR1p50oWUPRLHgS9XI
         yKr3CJ0bSZpwt8PXyCcZ9PY+YnFppXBia6kVwwGYkZT0vTl3xv26R46A3MndpkgLI9Nb
         SSUXgdwgIQEfjiaBTIS2mjAonrJDQuhnLO7j29Rh9SQ7jPSVcFiMlGtWDONu6ZLoaU/g
         lvPzYk6oGheIqjjOMbzytQv2VvY2OjOXIPV0a57XhBVYVG2qCR3neUiOpUY9z7oXstiD
         4gQg==
X-Gm-Message-State: AA+aEWYzZ4DoOREuQ68N95KsDJEuvECwC6nWp8nB9/OtevC18Yy4xzhl
        KETRYmmuzRbXK0xlgnjR5+3y3355ZdhzBvFrB3A=
X-Google-Smtp-Source: AFSGD/VFoEKK4gWpOWU+kQzAWkq4jtzGR1deHfy8sR+HAmXFQHBuimwJCw9vI5DepR1ieSggZ9eXpXhaegvIPCESgZ0=
X-Received: by 2002:a6b:9156:: with SMTP id t83mr2863627iod.248.1543533894125;
 Thu, 29 Nov 2018 15:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129163826.178670-1-swboyd@chromium.org> <20181129223600.GC32306@hector.attlocal.net>
In-Reply-To: <20181129223600.GC32306@hector.attlocal.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 18:24:41 -0500
Message-ID: <CAF6AEGvWekbG6WsB_7Ux9FAdcci8xrHUZLcCd0rw05CNLNqQRQ@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@intel.com,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:36 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:
> > We need to check the call to cmd_db_read_aux_data() for the error case,
> > so that we don't continue and use potentially uninitialized values for
> > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > warnings:
> >
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
> >      pri_count >>= 1;
> >                ^~~
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> > [-Wmaybe-uninitialized]
> >      sec_count >>= 1;
> >                ^~~
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Thanks for the patch.  Queueing this up.
>

from talking to agross on IRC, seems like this becomes an issue w/
other patches he has queued up for 4.21, and I don't think this should
conflict w/ other stuff I have, so

Acked-by: Rob Clark <robdclark@gmail.com>

for Andy picking up this one

BR,
-R

>
> Andy
