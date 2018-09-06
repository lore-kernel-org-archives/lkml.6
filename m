Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049EEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTzghy+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeIFN4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:56:13 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39744 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeIFN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:56:13 -0400
Received: by mail-it0-f52.google.com with SMTP id h1-v6so13250925itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAC5g786jXAzkgPDVOMEFKwLTdpe+IQiz/vV9rnVBnU=;
        b=LTzghy+ZqwMb65NTjATFP27YnAES8tuKd3Hi1ATAxQ+H8ZecH8Wwt/K+dfjMzJN2jV
         dSW/VOSpICB4qzSDoOXnWHUGbOKtR7EbSv9hkzeWnP9NcP7+RVVUhanfiWauzd61nkYi
         j/1+y7ZHiEM65Od9m5BHbTNuOXT3nU3zzWiMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAC5g786jXAzkgPDVOMEFKwLTdpe+IQiz/vV9rnVBnU=;
        b=AtBuWX6dzcloWTNR4gjpW7zJ7LJ8mBKdV91hBDsNmFgudyot7zpJMTrIU8KiyOfHde
         Nj/qqEkx9TagyGjjrxcSvCDDU7mS4BOshj+4iBm8NJ3/U67K7zTQUIjT+pgKygESu7A8
         +hBqbWPPT/bWSZHH/JUKYzBxp6gCSSMrsPETu0UF8eskpJefMF5pNvCgk8SmZBE6zsjz
         qyNd/cEw/Pw5//DAixbVEksrHOZOBvW42hLEKqaJyS9P3b8Hx2e9EeLmgFNqxwomlRJb
         IctErb6aOfiWuwQXRQ3O9oOAP06JlsgBhHFPfFt5ttFfvu7KUqq+S764T/5nzqhHfHev
         TmHg==
X-Gm-Message-State: APzg51CDmAttnPocqsb4pHz9Ltrl+mbH0YLbIqTYB8eWTC02BGKN5t/j
        vZgXpSNUgwInQCw0knve/bst0CKZHs0Fd1AJMmSe7Q==
X-Google-Smtp-Source: ANB0VdYJJqlyqt++X2kWiI3B/1tKTwRwpdQ0OoFkN0hdFRqcM74qUoRrjEPhz+wlEDQm9/ymBNX/BzQ/V47rII+VGJY=
X-Received: by 2002:a24:e00e:: with SMTP id c14-v6mr1908430ith.108.1536225700132;
 Thu, 06 Sep 2018 02:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com> <20180904093626.GA23936@linaro.org>
 <20180904103742.GC61288@linux.vnet.ibm.com> <CAKfTPtBVLWgtRJpP0nTOVpkwJse6BwrGa28o4qat0T3kOvEAfw@mail.gmail.com>
 <20180905085029.GA57420@linux.vnet.ibm.com> <CAKfTPtCzznnkR-DDw5DkHYef0nLtB+Yt9UHYMMaJdKD043H7XA@mail.gmail.com>
 <20180905111436.GB57420@linux.vnet.ibm.com>
In-Reply-To: <20180905111436.GB57420@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 6 Sep 2018 11:21:29 +0200
Message-ID: <CAKfTPtBHvRWzWj_CdB064YssDu05SijnZnTPzWovE-43sdeWZg@mail.gmail.com>
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

On Wed, 5 Sep 2018 at 13:14, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2018-09-05 11:11:35]:
>
> > On Wed, 5 Sep 2018 at 10:50, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > * Vincent Guittot <vincent.guittot@linaro.org> [2018-09-05 09:36:42]:
> > >
> > > > >
> > > > > I dont know of any systems that have come with single threaded and
> > > > > multithreaded. However some user can still offline few threads in a core
> > > > > while leaving other cores untouched. I dont really know why somebody
> > > > > would want to do it.  For example, some customer was toying with SMT 3
> > > > > mode in a SMT 8 power8 box.
> > > >
> > > > In this case, it means that we have the same core capacity whatever
> > > > the number of CPUs
> > > > and a core with SMT 3 will be set with the same compute capacity as
> > > > the core with SMT 8.
> > > > Does it still make sense ?
> > > >
> > >
> > > To me it make sense atleast from  a power 8 perspective, because SMT 1 >
> > > SMT 2 > SMT 4 > SMT8. So if one core is configured for SMT 2 and other
> > > core is configured for SMT4; all threads being busy, the  individual
> > > threads running on SMT2 core will complete more work than SMT 4 core
> > > threads.
> >
> > I agree for individual thread capacity but at core group level, the
> > core SMT 1 will have the same capacity as core group SMT 8 so load
> > balance will try to balance evenly the tasks between the 2 cores
> > whereas core SMT 8 > core SMT1 , isn't it ?
> >
>
> I believe that Core capacity irrespective of the number of threads
> should be similar. We wanted to give a small benefit if the core has
> multiple threads and that was smt_gain. Lets say we have 8 equal sw
> threads running on 2 cores; one being SMT 2 and other being SMT4.
> then 4 threads should be spread to each core. So that we would be fair
> to each of the 8 SW threads.

Do you mean that it would be the same with SMT 2 and SMT 8 ?
evenly spread the 8 SW threads between the 2 cores would be better
than 2 SW threads on core SMT 2 and 6 on core SMT8

>
> --
> Thanks and Regards
> Srikar Dronamraju
>
