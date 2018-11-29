Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42810C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1092120868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmLn4YTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1092120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeK3Fup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:50:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36312 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeK3Fup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:50:45 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so5324700itj.1;
        Thu, 29 Nov 2018 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWZ0Jy4wm10cazrHN79gbPbMf4L8YlLx1BaDeipyEgo=;
        b=YmLn4YTPef1uNYArnl2Y9Oxl+dhK9xyENxIMrxdZweIHZ3IKwKvTYwhPIPqM59SfEl
         7hc3OEbjJDXXnYhWcPewP0TkswVqgPvqDbaSabhHq90/Xp0l4UgFFZ2/p/bk29ae/TEv
         AdZVjss6DFqeORABChPyGdjxQFO9sJRwqFYtC3Bi7xJROWZymbQ12c9WVqdpehwM03Wf
         urXnPjgb5x89CoLBnzP+MPCnrmboSigY5jsfEVXnp9QreNgpp1WxHr/9250uQzdzG5x0
         S/O6oLn3hDunhPEPZgPj0N7ZeLlJmNxmaYMoSumboNjtv74qvjqGj4bypo8K43/KU6M/
         BrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWZ0Jy4wm10cazrHN79gbPbMf4L8YlLx1BaDeipyEgo=;
        b=gWyxqHXlGbjOgFBA3TVjZRx/Q7dZglm/JxdduV9RGLMpx35QZ06QwRn8rU38Jiz7wc
         YeiNGbq3c6T3pema1VifxkVRlOYEYy6WA7zfKPlfXjUdvM/uEzdzEx5j2oSXK6INgAg8
         DOBR0BBge5QPJH1cu7GBC83bfgQ9a3NH582qe2qEmVa7v5VXPm0wMXGtPPD99S9HhAw9
         Kivr+8DivraOtdhV3L7qEeXHnWnFvtSj8ABkerYmSp3VNFMbljL8c4htBCrwu1gtV4XP
         7f8BRVoz2tgv/UqcQ2AoBERHOTtG98Py/9JA891p+YNOHYqOYf/tKJ3WllLiPi1d537H
         m75g==
X-Gm-Message-State: AA+aEWYxo6g3+CoFP7X97lxWoVivcKE5Sq4h4PQf0E2YRJTq74L55OA9
        Y/nKu1uDXayIZgUmZD3PgMVtNhyRspacqUW19Fc=
X-Google-Smtp-Source: AFSGD/UHaS60cQObZnfkBA00Vh1rrjqdIi53yCj2ErAQrlzcbKWgOUKkc5C6GTQdXlgeGdWzUwcEW5xu59nRoM1ctNQ=
X-Received: by 2002:a02:1509:: with SMTP id j9mr2458743jad.5.1543517064184;
 Thu, 29 Nov 2018 10:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <20181129155310.GA26537@lst.de>
In-Reply-To: <20181129155310.GA26537@lst.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 13:44:11 -0500
Message-ID: <CAF6AEGvN6SCfrmfui3-wT3maPGhDYFwEzEOYp=L_ySXa7bLWgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 29, 2018 at 09:25:43AM -0500, Rob Clark wrote:
> > > As I told you before:  hell no.  If you spent the slightest amount of
> > > actually trying to understand what you are doing here you'd know this
> > > can't work.  Just turn on dma debugging and this will blow up in your
> > > face.
> >
> > you can tone it down..  we weren't the ones who created the dma/iommu
> > mess, we are just trying to find a way to work around it
>
> But you don't listen and take someone busy for a day as approval,
> which is absolutely not the case.  Please wait for a day or two for
> people to respond instead of forcing already NACKed patches again in
> an act of passive agression.

I'm not sending my pull-req to Dave tomorrow (or even the day after
;-)), so there is ofc still time for people to respond.

BR,
-R
