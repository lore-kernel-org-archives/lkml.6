Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78875206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ptvuw0Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78875206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeLEGWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:22:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38575 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:22:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so11404217vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=29Tyr8SgbXSYTSPy3OCLNjyAZpm0NOHJXmRBd+lbbQA=;
        b=Ptvuw0UmjZ/YKXB9ImjECmIFYLVcKx3nGupS/jfPqfTMBYz7lnlN7aW3NtLTOkLn+M
         RalydJ9mEmwPA61QUb3RT3bQgFBH67+NK9qSSyCcXajHrhsTiLO12IBXLurjS7WaWc6O
         ArpmebgFQtFJeufPZgZdC914EpYINUgHVZIEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=29Tyr8SgbXSYTSPy3OCLNjyAZpm0NOHJXmRBd+lbbQA=;
        b=buUqkp39aUICTBYHZHptnrqeAXSch599qe87q3aJBCs97PyrP2saK4wSJe3zwVv4Op
         TklSwSfex8vDsOpOOibkM8evNqimiTWggYy7Mbkup5+d+uQ9rEqjru3eZHCmszKwF7+R
         0p+ABArEzBJnlTP3za9WWuORvuWIMLouamDxn1csI5WkrAWdxETP/rgSB4WNz7fb5hFf
         aWAuvJWicvh2nO3yQ8T0aqt5hHnb7F2sLZ7wgCDHM9wC4GITdz2jquo2A8hLeHXgw8ke
         hNKhWT9BOs+GGsE75l8LtSHYbltyCpJUhsjtFI0u/eVOCIViBKOs86Guu4krjncfg5pb
         WPbA==
X-Gm-Message-State: AA+aEWaMzLYIQUXC5N3dSwqv9EihMLS+9DBo5z7K959eUrVH5Wf5oGw1
        N4YZ9PmFOQocAUoRgDpEzELNxO/BbUA2KtgzE2EI9g==
X-Google-Smtp-Source: AFSGD/VKZwTk44mvtPOIC4KsMSpiFCckKRP1V1FZOyXXe53P77y1Ol+RC8W6IAZ0N6F8OD+S07OHEfEM70nDopkCfFY=
X-Received: by 2002:a67:a205:: with SMTP id l5mr10145874vse.9.1543990955999;
 Tue, 04 Dec 2018 22:22:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1538638640.git.amit.kucheria@linaro.org>
 <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
 <CAHLCerNFabr5-+b8U=ouLBidGJo+e+aDVW9ZyOQy9edJB3cERw@mail.gmail.com> <1543218973.2126.8.camel@intel.com>
In-Reply-To: <1543218973.2126.8.camel@intel.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 5 Dec 2018 11:52:24 +0530
Message-ID: <CAHLCerORrNvS=ibPxTwaj6xpFxpnnTdrK3cX63QVyu80mbobWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] driver: thermal: Move some drivers into subdirs
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 1:26 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On =E4=BA=94, 2018-11-23 at 00:17 +0530, Amit Kucheria wrote:
> > On Fri, Oct 26, 2018 at 2:21 PM Amit Kucheria <amit.kucheria@linaro.o
> > rg> wrote:
> > >
> > >
> > > Hi Rui,
> > >
> > > On Thu, Oct 4, 2018 at 1:22 PM Amit Kucheria <amit.kucheria@linaro.
> > > org> wrote:
> > > >
> > > >
> > > > Move the various drivers for Intel platforms into their own
> > > > subdir. Also
> > > > consolidate Qualcomm drivers into the qcom subdir.
> > > >
> > > > This cleans up the directory making it easier to find things.
> > > Any comments on these changes?
> > Rui? Eduardo?
> >
> the patches were not sent to linux-pm mailing list, and that's why I
> overlooked this patch set in patchwork.
>
> thanks,
> rui

Hi Rui,

I've sent a new version with linux-pm in cc.

Regards,
Amit
