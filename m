Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC1BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689A20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E689A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIDObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:31:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33178 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:31:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so5672016oip.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eu6OCREN1PM4syjrjLQKSOLqja1ZpMYW2gkFhuueIh0=;
        b=KZ2SuR26CXJT3mkjTU9x4r4BX1Q8SANE9DVM04K0lwQVytXeWh/eQm9hocUWBEwr4u
         A/MEwQs7207/XnuP29687JqT2tRw40zaqHeeFbkA1xvN313W9pXi6dSEUe4eqwiBTJDS
         UG1e60qiJASRMkqBTpGxi1/V8XZeIu34bia25ivjNnPYKsLUVWhNseccyN0WcA2lugbM
         GRYRFhPDXoeXi3GIDqp7Xq/gMLAKlEl8drRicDB0ZmTIY3SUVyPBCtvhyODEPXrFAY+q
         AmaSZKO7oAmZLcm4YyhmCy9rIBGsc+PAFSkq0BuPngoEGXD6SeKbvRj1ElBgJzTf6Eu3
         e55g==
X-Gm-Message-State: APzg51CjmaAeoT8RSlhCYTDqGSEN7Vc01E95N30Ftm7QUPjulrdVrJul
        xysj+wqj9BruDTBq262tfu94NB4I6hx5UqZkIofw4g==
X-Google-Smtp-Source: ANB0VdaNRXzqvkJBp9/AULnzlKJjaOniHSSu5RYLHaQkIW2j9e0fiDsOHTEFRykj+xAtse3Ylh/LONbNXSS5E4Ai2os=
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr22895954oib.254.1536055646433;
 Tue, 04 Sep 2018 03:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2011:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 03:07:25 -0700 (PDT)
In-Reply-To: <20180904090053.GB1719@techsingularity.net>
References: <CAE4VaGCQV+cS-vhdLyMwzftbB-xBHPt4Y4chg_0ykLHTE9cRfw@mail.gmail.com>
 <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
 <20180627084954.73ucqvac62v5gje4@techsingularity.net> <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net> <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
 <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com> <20180904090053.GB1719@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Tue, 4 Sep 2018 12:07:25 +0200
Message-ID: <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Kamil Kolakowski <kkolakow@redhat.com>,
        Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

thanks for sharing the background information! We will check if
2d4056fafa196e1ab4e7161bae4df76f9602d56d is causing the current
regression in 4.19 rc1 and let you know the outcome.

Jirka

On Tue, Sep 4, 2018 at 11:00 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Mon, Sep 03, 2018 at 05:07:15PM +0200, Jirka Hladky wrote:
>> Resending in the plain text mode.
>>
>> > My own testing completed and the results are within expectations and I
>> > saw no red flags. Unfortunately, I consider it unlikely they'll be merged
>> > for 4.18. Srikar Dronamraju's series is likely to need another update
>> > and I would need to rebase my patches on top of that. Given the scope
>> > and complexity, I find it unlikely they would be accepted for an -rc,
>> > particularly this late of an rc. Whether we hit the 4.19 merge window or
>> > not will depend on when Srikar's series gets updated.
>>
>>
>> Hi Mel,
>>
>> we have collaborated back in July on the scheduler patch, improving
>> the performance by allowing faster memory migration. You came up with
>> the "sched-numa-fast-crossnode-v1r12" series here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
>>
>> which has shown good performance results both in your and our testing.
>>
>
> I remember.
>
>> Do you have some update on the latest status? Is there any plan to
>> merge this series into 4.19 kernel? We have just tested 4.19.0-0.rc1.1
>> and based on the results it seems that the patch is not included (and
>> I don't see it listed in  git shortlog v4.18..v4.19-rc1
>> ./kernel/sched)
>>
>
> Srikar's series that mine depended upon was only partially merged due to
> a review bottleneck. He posted a v2 but it was during the merge window
> and likely will need a v3 to avoid falling through the cracks. When it
> is merged, I'll rebase my series on top and post it. While I didn't
> check against 4.19-rc1, I did find that rebasing on top of the partial
> series in 4.18 did not have as big an improvement.
>
>> With 4.19rc1 we see performance drop
>>   * up to 40% (NAS bench) relatively to  4.18 + sched-numa-fast-crossnode-v1r12
>>   * up to 20% (NAS, Stream, SPECjbb2005, SPECjvm2008) relatively to 4.18 vanilla
>> The performance is dropping. It's quite unclear what are the next
>> steps - should we wait for "sched-numa-fast-crossnode-v1r12" to be
>> merged or should we start looking at what has caused the drop in
>> performance going from 4.19rc1 to 4.18?
>>
>
> Both are valid options. If you take the latter option, I suggest looking
> at whether 2d4056fafa196e1ab4e7161bae4df76f9602d56d is the source of the
> issue as at least one auto-bisection found that it may be problematic.
> Whether it is an issue or not depends heavily on the number of threads
> relative to a socket size.
>
> --
> Mel Gorman
> SUSE Labs
