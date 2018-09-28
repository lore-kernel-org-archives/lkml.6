Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668AEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172D8216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DHOn3176"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172D8216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeI1ORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:17:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36427 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1ORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:17:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10-v6so5302362wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEFJc8WQhr5SEjFh/P6VhfnMJvysIXoD6PKyQWYfZm0=;
        b=DHOn3176BKjxvlD+eY/0gN6h93gFfYElXxn1kCF6KSnTXF0n+V99DI4LuWGqFzYxdN
         FvVJGglthyh+3LkfQBKQSxd/FOz8VSRAXF+tQOnEzlt2XU0+EYk14FLn0AmuZ8pMzNVa
         BvdRdwYXWIt0eZE60gls9C3kTiUsOsVWco2z8R9wSbFjkbhHji7k+h0xMvZAT52aj5Ly
         IvbQmCN4X2PfRqV9CU9B6w02TjlsvvFayGYms+7F/tblmQuSuokUZU38QRnzNKcO15f4
         NakD8x4g4eJ24CNn0XpzOru4NDwrzKUcjW15kxC65O7/vXz6ctxGj3zKcStzl8BeYarZ
         KK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEFJc8WQhr5SEjFh/P6VhfnMJvysIXoD6PKyQWYfZm0=;
        b=JS1p7xxNFLJ4vpSBJ1FYER7AFJSGbVKmblWAN/igGU8d8rEk5ZoW9upYve+vK9xV99
         q4GsGi9SVpwQIQ7rzNLsZ5NHPe8ShfEsDKaUqtMe/BMJ9IgHlDIfngUGO8sU/zFJ7AP2
         H7PivlxVkOxbfY7dib9cSDBQikUL3FGVCWosvwqkvqVc58GmffpWgUscwclHFTXoLAiI
         dz3pJHwQmlwYjumRs9kia91VDrIiciNJa0FB04a+yK3wRizyrO+RztoskN2Q7pcOj6xS
         5FJFAaV7okrhxZo7sdClq9ALrsMOAexcUq6EiBexK3pXeD2Ht9WnWHTcPA0PecaMVXKD
         a8uQ==
X-Gm-Message-State: ABuFfojovSnB4Tt6g6Vp01bE5p7C9pSX+RlaA92Rs32Hm5S1lRlcQS0Q
        Djzs6LvSaCB9p6UHiCYueQTP0ytVyepuezzGfdryog==
X-Google-Smtp-Source: ACcGV60bCcr96uhJ7RQ0+NIG1apsUdw9J/0q+qzGekXYGf922eV+8mFHtpuN4I4d63jxHY8+hU4WgOeWUXvnTukSZUM=
X-Received: by 2002:adf:8447:: with SMTP id 65-v6mr10815930wrf.251.1538121308968;
 Fri, 28 Sep 2018 00:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <CAAhSdy1SKaX+sZHGzExZVKFP9fOsYec+iiEMbxjSf_iSauasQQ@mail.gmail.com> <99dd0f89ce60402fa606245b2e8dde0c@SFHDAG7NODE2.st.com>
In-Reply-To: <99dd0f89ce60402fa606245b2e8dde0c@SFHDAG7NODE2.st.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Sep 2018 13:24:57 +0530
Message-ID: <CAAhSdy0ibJ6vY+rvZKL6PKMRFuOgQXdx60cMNtD7D7M=zJCf0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] remoteproc: add fixed memory region support
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        arnaud pouliquen <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>, s-anna@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:31 PM Loic PALLARDY <loic.pallardy@st.com> wrote:
>
> Hi Anup,
>
> > -----Original Message-----
> > From: Anup Patel <anup@brainfault.org>
> > Sent: Friday, September 21, 2018 8:05 AM
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>; Ohad Ben-Cohen
> > <ohad@wizery.com>; linux-remoteproc@vger.kernel.org; linux-
> > kernel@vger.kernel.org List <linux-kernel@vger.kernel.org>; Arnaud
> > POULIQUEN <arnaud.pouliquen@st.com>; Benjamin Gaignard
> > <benjamin.gaignard@linaro.org>; s-anna@ti.com
> > Subject: Re: [PATCH v4 00/17] remoteproc: add fixed memory region support
> >
> > Hi Loic/Bjorn,
> >
> > Can we consider this series for v4.20?
>
> I discussed with Bjorn last week at Linaro connect.
> He should review the series hopefully soon.
> >
> > I am interested in for patch "rpmsg: virtio: allocate buffer
> > from parent". This patch allows me to used VirtIO
> > RPMSG driver inside Guest/VM.
> Please send your acked-by or reviewed-by or tested-by
> It will help Bjorn to see interest for this series

Sure, I will provided Reviewed-by and Tested-by for
patch "rpmsg: virtio: allocate buffer from parent".

Thanks,
Anup
