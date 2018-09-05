Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC12C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F292077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqtjKR7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F292077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIEMFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:05:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33601 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:05:47 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so16149665ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PUTpX283WSV2xlMjVWEQoDPysdmDpsAv/Kj2BDFxlOE=;
        b=YqtjKR7Pn76g8kE8ITIe5TOCSmoHayik/V9Eb3E2tj/cqiD54pW6xCLWC6oA2k/b3u
         69fqGH7qQ5ymQTXHEKZ12IW5l3ax1tqM5ur3DfVtZhe3+GYdrPp4K6zbZszIGQ9qV5JO
         EAq8MryONRpAfpnI9AfCEtcSfeOBSqR0XQJ2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUTpX283WSV2xlMjVWEQoDPysdmDpsAv/Kj2BDFxlOE=;
        b=lo+KE1wbIAVp8uJHT64ueqdG42NU0HGtvcvTO2CyBMh712lHJ55kqKWGXGI3kfUOBe
         47b8BtE2n7X+4NSU1nUlOR7bpL6CDBr0fvj/Y5hxqPhIyh/v9rjhGF9uX2/iO0TTT7Jl
         G5/ZnKZZuQWEy4EHJQfQZPByGMJdNo8ehZDAza8P5GLqfZMUiYtcGAWHYzpbtd21UCnF
         mZsLhMWU7lWGrOhOCNFs9VMt+JeYAU74w2Y5HDIH2zR1RrVjE2z+vCvrdx1SlFI9OhQY
         7uq48bkg480khZbus4EjJahE16UkY+YnSz/dvtXJTYrVz2CzzLwj1nHPIf5egoaa+uM/
         mNnA==
X-Gm-Message-State: APzg51D85fgNFTcRlNPM7YuxS6yMRrMF7GkE4nN5Zi4JQzdcj/nbbDyY
        mhKBoplDR//QONKi6w+Uuo4GArpNfSffwclsn+PvVg==
X-Google-Smtp-Source: ANB0VdZwQCIhuMVzpn3j5gErfsm6c4QBzSjvIJd0xnuYpQluDSt32hudqJUYXgRmPMIOH4S8AvB1ezikXAwQR5eiHFs=
X-Received: by 2002:a02:b804:: with SMTP id o4-v6mr11369715jam.12.1536133013512;
 Wed, 05 Sep 2018 00:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com> <20180904093626.GA23936@linaro.org>
 <20180904103742.GC61288@linux.vnet.ibm.com>
In-Reply-To: <20180904103742.GC61288@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 5 Sep 2018 09:36:42 +0200
Message-ID: <CAKfTPtBVLWgtRJpP0nTOVpkwJse6BwrGa28o4qat0T3kOvEAfw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 at 12:37, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2018-09-04 11:36:26]:
>
> > Hi Srikar,
> >
> > Le Tuesday 04 Sep 2018 =C3=A0 01:24:24 (-0700), Srikar Dronamraju a =C3=
=A9crit :
> > > However after this change, capacity_orig of each SMT thread would be
> > > 1024. For example SMT 8 core capacity_orig would now be 8192.
> > >
> > > smt_gain was suppose to make a multi threaded core was slightly more
> > > powerful than a single threaded core. I suspect if that sometimes hur=
t
> >
> > Is there system with both single threaded and multi threaded core ?
> > That was the main open point for me (and for Qais too)
> >
>
> I dont know of any systems that have come with single threaded and
> multithreaded. However some user can still offline few threads in a core
> while leaving other cores untouched. I dont really know why somebody
> would want to do it.  For example, some customer was toying with SMT 3
> mode in a SMT 8 power8 box.

In this case, it means that we have the same core capacity whatever
the number of CPUs
and a core with SMT 3 will be set with the same compute capacity as
the core with SMT 8.
Does it still make sense ?

>
> >
> > > us when doing load balance between 2 cores i.e at MC or DIE sched
> > > domain. Even with 2 threads running on a core, the core might look
> > > lightly loaded 2048/8192. Hence might dissuade movement to a idle cor=
e.
> >
> > Then, there is the sibling flag at SMT level that normally ensures 1 ta=
sk per
> > core for such UC
> >
>
> Agree.
>
> > >
> > > I always wonder why arch_scale_cpu_capacity() is called with NULL
> > > sched_domain, in scale_rt_capacity(). This way capacity might actuall=
y
> >
> > Probably because until this v4.19-rcxx version, the rt scaling was done
> > relatively to local cpu capacity:
> >   capacity  =3D arch_scale_cpu() * scale_rt_capacity / SCHED_CAPACITY_S=
CALE
> >
> > Whereas now, it directly returns the remaining capacity
> >
> > > be more than the capacity_orig. I am always under an impression that
> > > capacity_orig > capacity.  Or am I misunderstanding that?
> >
> > You are right, there is a bug for SMT and the patch below should fix it=
.
> > Nevertheless, we still have the problem in some other places in the cod=
e.
> >
> > Subject: [PATCH] sched/fair: fix scale_rt_capacity() for SMT
> >
> > Since commit:
> >   commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
> > scale_rt_capacity() returns the remaining capacity and not a scale fact=
or
> > to apply on cpu_capacity_orig. arch_scale_cpu() is directly called by
> > scale_rt_capacity() so we must take the sched_domain argument
> >
> > Fixes: 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
> > Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
