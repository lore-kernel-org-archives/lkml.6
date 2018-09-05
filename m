Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E08C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC26E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xq1DyZ6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC26E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeIENlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:41:03 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36635 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIENlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:41:02 -0400
Received: by mail-io0-f177.google.com with SMTP id q5-v6so5386881iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ODv8hk1dFKeFgmpydpsBgEkNER0NAuijChGnsK5t8U=;
        b=Xq1DyZ6qXF0N/sHoXyXzUj2WtRRQkxwmmD5BC4RS31XwmTc+JAe6YIk3CTOVNLfaG7
         63RqdsYjPa7OcPLR9FnxeyMCF6ih0g86lvcnqWmBpHqDFk8rcSAsCkxvj1zqf3ufDobE
         Rpy7PfssBGgVmCA6JzzLhRR2fjadlxPzLzmfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ODv8hk1dFKeFgmpydpsBgEkNER0NAuijChGnsK5t8U=;
        b=Y3QRCOPz73t3np+T34qtcZLVMR4I3FV7Q63BtyoqgM7LbPb0hG1lApaJAobA2xMCNA
         XGWlCN/InXIwok6WAtQu6YOvNfYL7lujoGN1sRV9Y5fRUno8m3KuptifzbKkHkBvuYzM
         xqafXzkwrYRI8ikApndVLM8mgLSmsNjBXmkrNhJrCB5/wC9KWsHG51TrihhFYiVDS2dP
         y+TMmOyq2qzS6Spz7++5U0b+hv39pmPg2kAhDRBWogaCvq7n4F3F2s2UkNmUljVeU8/+
         FYCdrtjRc8P8ZY8ouIwBb/1ogUR4BAmX7a2yiiF54qHE64yPUFbHp2QLl5Dw2vmjKybE
         GoIA==
X-Gm-Message-State: APzg51BXH/s9c2zhXiP63ZExmsb4neuFIhzXY6RAuICI5PcRPdlSj33q
        bz8x6KRKY6Qb0paGG0hfqflPof2t1TsGaQLNAizF8++Q
X-Google-Smtp-Source: ANB0VdYdgsnnMEqRocx0r9preJsVUfPxR7M9oPW7IURWGy2bZHqygTqAGaPuZyl0CH3tOO3zcgb0fYvbfUi3mDP2Qrg=
X-Received: by 2002:a6b:e51a:: with SMTP id y26-v6mr24069728ioc.42.1536138706476;
 Wed, 05 Sep 2018 02:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com> <20180904093626.GA23936@linaro.org>
 <20180904103742.GC61288@linux.vnet.ibm.com> <CAKfTPtBVLWgtRJpP0nTOVpkwJse6BwrGa28o4qat0T3kOvEAfw@mail.gmail.com>
 <20180905085029.GA57420@linux.vnet.ibm.com>
In-Reply-To: <20180905085029.GA57420@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 5 Sep 2018 11:11:35 +0200
Message-ID: <CAKfTPtCzznnkR-DDw5DkHYef0nLtB+Yt9UHYMMaJdKD043H7XA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 at 10:50, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2018-09-05 09:36:42]:
>
> > >
> > > I dont know of any systems that have come with single threaded and
> > > multithreaded. However some user can still offline few threads in a core
> > > while leaving other cores untouched. I dont really know why somebody
> > > would want to do it.  For example, some customer was toying with SMT 3
> > > mode in a SMT 8 power8 box.
> >
> > In this case, it means that we have the same core capacity whatever
> > the number of CPUs
> > and a core with SMT 3 will be set with the same compute capacity as
> > the core with SMT 8.
> > Does it still make sense ?
> >
>
> To me it make sense atleast from  a power 8 perspective, because SMT 1 >
> SMT 2 > SMT 4 > SMT8. So if one core is configured for SMT 2 and other
> core is configured for SMT4; all threads being busy, the  individual
> threads running on SMT2 core will complete more work than SMT 4 core
> threads.

I agree for individual thread capacity but at core group level, the
core SMT 1 will have the same capacity as core group SMT 8 so load
balance will try to balance evenly the tasks between the 2 cores
whereas core SMT 8 > core SMT1 , isn't it ?

>
> --
> Thanks and Regards
> Srikar Dronamraju
>
