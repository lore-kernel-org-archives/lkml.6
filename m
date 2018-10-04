Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F0020652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeJDWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:42:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33880 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJDWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:42:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so10420525qtr.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxEyAP1FQzBnXc++CA05arJHRcsUYbKwfaHrJl+FtlE=;
        b=G4cmlTu84XxRIh0eTWkSCgluHlvChtoPYaRZW+1aCrHFIh4/ielqH53rAFnrF+WTEz
         QGWRicoHWvUgtVYGh/1WAJyo3q2zlm/M+DpFWYzQYehJDWTG2rNjDo/Y5D3pfJJq3M9q
         bR1YLyXHbiqE8dWyh346ZcATwdaFzkA1/hjkUp28rXTpLZ96W5o7FvUnkJ/KdYyaIGKM
         d16UsqIUKBZMBWxTJAj5/a6GZqsXRKfdazJ1QznweltR6v1V8dlr1b42YmOo5BBtIh9u
         +V8ANh6xvXUdKcaHDioOtO41FGk9QVRcASfbtk1t4kk3ZjAejxL9iQK34hkpmyMbZBcp
         Z/gQ==
X-Gm-Message-State: ABuFfoi04S1pqmQrdvSgoESJ3XNYH2IkXMpYSlBUPIHgkoIAT19UEpn2
        fBJeyoOq5Z/qtP9EGC6g5dj3917Uqds6S2TQp6I=
X-Google-Smtp-Source: ACcGV62Fo/caWoHhf5YcjQjdCO0HJkLpN61rCHKQOKyUpZT0aEJi6R9VeWmY1PaKCnuKgcbTa3VZ6XmRteS8jE2pA/E=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr5819035qtf.185.1538668139993;
 Thu, 04 Oct 2018 08:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181001225827.21946-1-leoyang.li@nxp.com> <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
In-Reply-To: <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:48:43 +0200
Message-ID: <CAK8P3a3t1oKTxPU=7_S4K=_rA=YcOpBUTs9-aHDFAJAwHGyBpw@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, arm-soc <arm@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 11:39 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver fixes for v4.19 round 2
> >
> > - Fix crash of qman_portal by deferring its probe if qman is not probed
> >
> > ----------------------------------------------------------------
> > Laurentiu Tudor (2):
> >        soc: fsl: qbman: add APIs to retrieve the probing status
> >        soc: fsl: qman_portals: defer probe after qman's probe
>
> There's a similar fix for bman portals [1]. I was under the impression
> that you plan to pick that up too.
>
> [1] "soc/fsl/bman_portals: defer probe after bman's probe", found here:
> https://lore.kernel.org/patchwork/patch/992009/

I've pulled the first two into the fixes branch for now, but it does sound
like we need the third patch as well.

The new interface seems a bit odd, since it does not pass
an instance pointer at all, but instead relies on the idea that
there is only one qman/bman instance in the system. While this
may be true in all cases, generally our driver interfaces should
be based around device objects instead of making assumptions
like this. I assume that is part of what led to the bug in the first
place.

Of course that is nothing that can be changed easily, and the
bug needs to be fixed, so I have pulled the fixes for 4.19, but
it would be good to see if the interfaces could be restructured
to behave more like other subsystems in the future.

     Arnd
