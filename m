Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011A3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B435F223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lAiJKmKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435F223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKNFCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:02:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32949 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNFCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:02:09 -0500
Received: by mail-it1-f196.google.com with SMTP id p11-v6so14187635itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OGeR/mBHRWElO7aVF1pt0plRFgA+At++QguLz/mh9U=;
        b=lAiJKmKXYtSKF0eUbar7QCCUZDgIUH+Hj54wp9X6/hhKGzW6D4jy6QZx3ye+Mhxo4q
         Ap6DRpdttBzN3mQhjU7gqM4dH8Y5yd+28vUo3M5xtDtmtZMyPqpk9K+fE+Q8hMCFZumr
         2H9MDEspmFSTQ9n2TDefTrw9qKpR67whVVi+ZcojDpMBtQZg3W4+aljgc/Otb9zWFgVy
         r9ayil480WrtnLOVpki3eMYqbWQZwug92hzW5f6im7w6Z9EoEDOxu7pfFxjJB8uEHUZy
         /LgcDRG7B2zlCfmjQzWIl3jmi4vceE/a3YF4VnvBA0ind2D3gEbaghooWBMwA20UAoYz
         wSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OGeR/mBHRWElO7aVF1pt0plRFgA+At++QguLz/mh9U=;
        b=pQxvMLXsjwaePQTSDJixPkyc+Kl/FwMWf6v9JWpq/MQ0Ws6VY7HKV1avxOENrCAR3y
         nUNUmWlPev736NarSiQmwK8qOR9+Zs1EkiKlkYwT9EpDLzPhW5+EtE7Zy+NqOSChFLBx
         tkQWZD+8GjaUMgPgFGYRc0f3iyd2+fqjhmsaddpcqODwx/SJ8t/EXq7K6eOj126iKKc/
         Hih9xurh5zrdnUQzW1Oj018Y2C/JeZ/gwTv3QbQzvPp6ZiJYbLz+fjyzwNh5f54NRXOx
         iYzZbK1r5SYneXFQ5gvUFb4OHMqwTH9Q7qCyeLleKY9vE6iGD8AC6i0X+6CWSieogP2b
         Rr+A==
X-Gm-Message-State: AGRZ1gLZu3wDEF42XM9nNpXwq0Un9hRTnxcu1Fq1okIVhglGan6js8R5
        HKk7xEH5sx03TWuQlTVI/WLuVCuP+1cue/fi/Y17aw==
X-Google-Smtp-Source: AJdET5eeM1q1LGT/S47TXYyW/10dSnNj2IxSPgqSPMQ5hAHvHPcGg2o9gyUc2a2Q9pgzHc9rud0RMUYv4PzADEuhzTQ=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr5520803jak.11.1542135762759;
 Tue, 13 Nov 2018 11:02:42 -0800 (PST)
MIME-Version: 1.0
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com> <20181112182236.s7cs6dol4dmxkp7u@localhost>
 <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com> <20181113092422.GJ30658@n2100.armlinux.org.uk>
 <94666165-f206-5472-c848-499ba52cd354@st.com>
In-Reply-To: <94666165-f206-5472-c848-499ba52cd354@st.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 13 Nov 2018 11:02:30 -0800
Message-ID: <CAOesGMgBdzYthdoWzzSFqOHOfCyY_9jZBkDSpLtkWeVdOkLkTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: stm32: debug: add low-level debug support
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at the patch I merged, and please follow up with any patch
to fixup any issue you find with it.

As mentioned in my original email, I tried to consolidate the two
versions, so a look-through and follow up with fixes would be
appreciated. Thanks!


-Olof

On Tue, Nov 13, 2018 at 2:17 AM Bich HEMON <bich.hemon@st.com> wrote:
>
>
>
> On 11/13/18 10:24 AM, Russell King - ARM Linux wrote:
> > On Tue, Nov 13, 2018 at 09:16:16AM +0000, Bich HEMON wrote:
> >>
> >> On 11/12/18 7:22 PM, Olof Johansson wrote:
> >>> On Thu, Jul 27, 2017 at 04:50:20PM +0000, Bich HEMON wrote:
> >>>> From: Gerald Baeza <gerald.baeza@st.com>
> >>>>
> >>>> This adds low-level debug support on USART1 for STM32F4
> >>>> and STM32F7.
> >>>> Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
> >>>> Enabled via 'earlyprintk' in bootargs.
> >>>>
> >>>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> >>>> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> >>>
> >>> Hi,
> >>>
> >>> This had fallen between the chairs it seems. I have applied it to arm-soc
> >>> next/soc now, for 4.21 merge window.
> >>>
> >>> It ended up being patched up manually to consolidate the version in
> >>> Russell's patch tracker with this posted version, and I tweaked whitespace
> >>> a bit. Let me know if I missed something.
> >>>
> >>>
> >>> Thanks,
> >>>
> >>> -Olof
> >>>
> >>
> >> Hi Olof,
> >>
> >> Please note that this patch has to be abandoned as Ludovic BARRE pushed
> >> a new version of this change:
> >> https://patchwork.codeaurora.org/patch/400563/
> >>
> >> You can find it in Russell's tracker here:
> >> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8803/1
> >
> > And I'm not going to merge that because:
> >
> > 1) it's not for me to merge - it doesn't go through my tree, but through
> >     arm-soc, which Olof and Arnd manage.
> > 2) it's not been on the mailing list as per normal submission process.
> >
> > Sorry.
> >
>
> Ok, thank you for the feedback.
>
> So Olof, can you please ignore my previous email and merge my patch as
> you proposed it for 4.21. Ludovic's patch will be abandoned instead.
>
> Thanks,
>
> Bich
